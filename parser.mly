/*File parser

Without %token WHILE DO DONE


*/
%{
	open Error

(* let parse_error msg = raise Error *)
%}

%token EOF
%token INTDCL FLOATDCL STRINGDCL
%token <string> STRINGVAR
%token <string> IDENTIFIER
%token <int> INTLITERAL
%token <float> FLOATLITERAL
%token VARDCL
%token READ PRINT
%token IF THEN ELSE ENDIF 
%token WHILE DO DONE
%token ASSIGN 
%token ADD SUB TIMES DIV
%token LPAREN RPAREN
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
|	VARDCL IDENTIFIER COLON STRINGDCL SEMICOLON { () }
|	VARDCL COLON INTDCL SEMICOLON { raise (MinilangError (Printf.sprintf "Missing identifier at (%d)" ((!line_num)))) }
|   VARDCL IDENTIFIER INTDCL SEMICOLON 
			{ raise (MinilangError (Printf.sprintf "Missing colon at (%d)" ((!line_num)))) }
|   VARDCL IDENTIFIER COLON SEMICOLON 
			{ raise (MinilangError (Printf.sprintf "Missing type declaration keyword at (%d)" ((!line_num)))) }

;
statement:
|	IDENTIFIER ASSIGN expression SEMICOLON {  () }
|	PRINT expression SEMICOLON {  () }
|	READ IDENTIFIER SEMICOLON { () }
|	IF expression THEN statements ELSE statements ENDIF { () }
|	WHILE expression DO statements DONE { () }
|	IDENTIFIER expression SEMICOLON 
		{  raise (MinilangError (Printf.sprintf "Missing assignment sign at (%d)" ((!line_num)))) }
|	IDENTIFIER  SEMICOLON 
		{  raise (MinilangError (Printf.sprintf "Missing assignment sign and expression at (%d)" ((!line_num)))) }
|	IDENTIFIER ASSIGN SEMICOLON 
		{  raise (MinilangError (Printf.sprintf "Missing expression at (%d)" ((!line_num)))) }
|	PRINT SEMICOLON
		{  raise (MinilangError (Printf.sprintf "Missing print expression at (%d)" ((!line_num)))) }
|	READ SEMICOLON
		{  raise (MinilangError (Printf.sprintf "Missing identifier to read at (%d)" ((!line_num)))) }
|	IF expression  statements ELSE statements ENDIF
		{  raise (MinilangError (Printf.sprintf "Missing then for the if specifed at (%d)" ((!line_num)))) }
|	IF expression THEN  statements ENDIF
		{  raise (MinilangError (Printf.sprintf "Missing else for the if specifed at (%d)" ((!line_num)))) }
|	WHILE expression  statements DONE
		{  raise (MinilangError (Printf.sprintf "Missing do for the while statement specifed at (%d)" ((!line_num)))) }


;
expression:
| 	value { () }
| 	LPAREN expression RPAREN      { () }
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
|   STRINGVAR   {()}
;

%%
