
open Lexer
open Parser
open Lexing
open Error
(* let printtoken tokenenizer= match tokenenizer with 
					  | INTLITERAL(int) -> "INTLITERAL"
					  |	FLOATLITERAL(float) -> "FLOATLITERAL"
					  | IDENTIFIER(string) -> "IDENTIFIER"
					  | ADD -> "ADD"
					  | SUB -> "SUB"
					  | TIMES -> "TIMES"
					  | DIV -> "DIV"
					  | EOF -> "EOF"
					  |	INTDCL -> "INTDCL"
					  | FLOATDCL -> "FLOATDCL"
					  | VARDCL -> "VARDCL"
					  |	READ -> "READ"
					  |	ASSIGN -> "ASSIGN"
					  |	PRINT -> "PRINT"
					  |	COLON -> "COLON"
					  |	SEMICOLON -> "SEMICOLON"
					  | IF -> "IF"
					  | THEN -> "THEN"
					  | ELSE -> "ELSE"
					  | ENDIF -> "ENDIF" *)
(* let _ =
     try
       let lexbuf = Lexing.from_channel stdin in
          while true do
             let parse () = Parser.program Lexer.mini lexbuf in parse (); 
          done
      with Lexer.Eof ->
           exit 0
            | Lexer.Syntax_error s ->
            print_string s;
            exit 1
            | Parsing.Parse_error ->
            print_string ("bhbjbjhjhjhjh");
            exit 1 *)
       let () =
          try
            let lexbuf = Lexing.from_channel stdin in
            let result = Parser.main Lexer.mini lexbuf in
            print_endline "VALID "
          with 
            	| Parser.Error ->  print_string ("INVALID : Syntax error\n");
            	exit 0
              | MinilangError (reason) -> print_endline ("INVALID: " ^ reason)
            	|End_of_file ->
            	exit 0


(*  *)