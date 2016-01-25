############
OCAMLC=/usr/bin/env ocamlc
OCAMLC_FLAGS=-c
OCAMLLEX=/usr/bin/env ocamllex
OCAMLYACC=/usr/bin/env menhir
############
all: mini
parser.ml: parser.mly
	$(OCAMLYACC) -v $<

lexer.ml: lexer.mll
	$(OCAMLLEX) $<
mini: mini.ml lexer.ml parser.ml
	$(OCAMLC) $(OCAMLC_FLAGS) parser.mli
	$(OCAMLC) $(OCAMLC_FLAGS) lexer.ml
	$(OCAMLC) $(OCAMLC_FLAGS) parser.ml
	$(OCAMLC) $(OCAMLC_FLAGS) mini.ml
	$(OCAMLC) -o mini lexer.cmo parser.cmo mini.cmo

############
clean:
	rm -f lexer.ml
	rm -f lexer.cmo
	rm -f lexer.cmi
	rm -f parser.ml
	rm -f parser.mli
	rm -f parser.cmo
	rm -f parser.cmi
	rm -f mini
	rm -f mini.cmi
	rm -f mini.cmo