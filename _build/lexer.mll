{

open Parser
open Error
(*type token =
  | INTLITERAL of (int)
  |	FLOATLITERAL of (float)
  | IDENTIFIER of (string)
  | ADD
  | SUB
  | TIMES
  | DIV
  | EOF
  |	INTDCL 
  | FLOATDCL
  | VARDCL
  |	READ
  |	ASSIGN
  |	PRINT
  |	COLON
  |	SEMICOLON

  raise (MinilangError (Printf.sprintf "MISSING ENDIF (%d)" ($startpos.Lexing.pos_lnum))) 
  *)



(* keyword -> token translation table *)
let keywords = [
    "var", VARDCL;"float", FLOATDCL; "int", INTDCL;"string",STRINGDCL ;"read", READ; "print", PRINT; "if", IF;
    "then", THEN; "else", ELSE; "endif", ENDIF; "while", WHILE; "do", DO; "done", DONE
]

exception Syntax_error of string
exception Eof


}

let blank = [' ' '\r' '\t']
let digit = ['0'-'9']
let intdigits = ['1'-'9'] (digit)*
let floatdigits = (((digit|intdigits)* '.' (digit)+) | ((digit|intdigits)+ '.' (digit)*))
let alpha = ['a'-'z' 'A'-'Z']
let iden = alpha (alpha | digit | '_')*
let notnewline = [^ '\n']
let comments = ('#')+ (notnewline)* '\n'
let strings = ('"') ['a'-'z' 'A'-'Z' '0'-'9' ',' ' ' '.' '!' '?' ',']* ('"')

rule mini = parse
	  | ':'	   { COLON }
    | '='      { ASSIGN }
    | '+'      { ADD }
    | '-'      { SUB }
    | '*'      { TIMES }
    | '/'      { DIV }
    | '('      { LPAREN }
    | ')'      { RPAREN }
    | ';'      { SEMICOLON }

    | iden as i {
        (* try keywords if not found then it's identifier *)
        let l = String.lowercase i in
        try List.assoc l keywords
        with Not_found -> IDENTIFIER i   
    }
    | digit as d { 
        (* parse literal *)
        INTLITERAL (int_of_char d)
    }
    | intdigits as d { 
        (* parse literal *)
        INTLITERAL (int_of_string d)
    }
    | floatdigits as f {
      FLOATLITERAL (float_of_string f)
    }
    | strings as s {
      STRINGVAR   (s)
    }
    | '\n'     { line_num:= !line_num+1; Lexing.new_line lexbuf;  mini lexbuf } (* counting new line characters and increment line num FORGOT *)
    | blank    { mini lexbuf } (* skipping blank characters *)
    | comments { mini lexbuf }
    | eof      { EOF } (* no more tokens *)
    | _        { raise (MinilangError ("unknown char "^ "on line "^(string_of_int !line_num)))}


{
}