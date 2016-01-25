(* The type of tokens. *)
type token = 
  | WHILE
  | VARDCL
  | TIMES
  | THEN
  | SUB
  | SEMICOLON
  | READ
  | PRINT
  | INTLITERAL of (int)
  | INTDCL
  | IF
  | IDENTIFIER of (string)
  | FLOATLITERAL of (float)
  | FLOATDCL
  | EOF
  | ENDIF
  | ELSE
  | DONE
  | DO
  | DIV
  | COLON
  | ASSIGN
  | ADD

(* This exception is raised by the monolithic API functions. *)
exception Error

(* The monolithic API. *)
val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit)

