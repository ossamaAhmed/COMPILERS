/*File parser

Without %token WHILE DO DONE


*/
%{
	open Error

(* let parse_error msg = raise Error *)
%}

%token EOF
%token INTDCL FLOATDCL
%token <string> IDENTIFIER
%token <int> INTLITERAL
%token <float> FLOATLITERAL
%token VARDCL
%token READ PRINT
%token IF THEN ELSE ENDIF 
%token WHILE DO DONE
%token ASSIGN 
%token ADD SUB TIMES DIV
%token COLON SEMICOLON 
%left ADD SUB        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%nonassoc UMINUS        /* highest precedence */

%start main
%type <unit> main

%%

main: 
| 	declarations statements EOF { () }
| 	error { raise (MinilangError (Printf.sprintf "Syntax Error at (%d)" ((!line_num))   )) }

;

declarations:
| 	{ ()}
|	declaration declarations { (()) }

;
statements:
|	{ () }
|	statement statements { () }

;
declaration:
|	VARDCL IDENTIFIER COLON FLOATDCL SEMICOLON { () }
|	VARDCL IDENTIFIER COLON INTDCL SEMICOLON { () }
;
statement:
|	IDENTIFIER ASSIGN expression SEMICOLON {  () }
|	PRINT expression SEMICOLON {  () }
|	READ IDENTIFIER SEMICOLON { () }
|	IF expression THEN statements ELSE statements ENDIF { () }
|	WHILE expression DO statements DONE { () }

;
expression:
| 	value { () }
|	expression ADD expression { () }
|	expression SUB expression { () }
|	expression TIMES expression { () }
|	expression DIV expression { () }
|   SUB expression %prec UMINUS { () }
;
value:
|	IDENTIFIER { () }
|	INTLITERAL { () }
|	FLOATLITERAL { () }
;

%%
