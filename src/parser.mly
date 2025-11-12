%{
open Ast
%}

%token <int> INT
%token <float> FLOAT
%token <string> ID
%token TRUE
%token FALSE
%token LEQ
%token GEQ
%token PLUS
%token MINUS
%token TIMES
%token DIVIDED_BY
%token PLUS_FLOAT
%token MINUS_FLOAT
%token TIMES_FLOAT
%token DIVIDED_BY_FLOAT
%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token COLON
%token INT_TYPE
%token BOOL_TYPE
%token FLOAT_TYPE
%token EOF

%nonassoc IN
%nonassoc ELSE
%left LEQ
%left GEQ
%left PLUS MINUS PLUS_FLOAT MINUS_FLOAT
%left TIMES DIVIDED_BY TIMES_FLOAT DIVIDED_BY_FLOAT

%start <Ast.expr> prog

%%

prog:
	| e = expr; EOF { e }
	;

expr:
	  | i = INT { Int i }
		| f = FLOAT { Float f }
  	| x = ID { Var x }
  	| TRUE { Bool true }
  	| FALSE { Bool false }
  	| e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
    | e1 = expr; GEQ; e2 = expr { Binop (Geq, e1, e2) }
  	| e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }
    | e1 = expr; MINUS; e2 = expr { Binop (Sub, e1, e2) }
    | e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2) }
    | e1 = expr; DIVIDED_BY; e2 = expr { Binop (Div, e1, e2) }
    | e1 = expr; PLUS_FLOAT; e2 = expr { Binop (Addf, e1, e2) }
    | e1 = expr; MINUS_FLOAT; e2 = expr { Binop (Subf, e1, e2) }
    | e1 = expr; TIMES_FLOAT; e2 = expr { Binop (Multf, e1, e2) }
    | e1 = expr; DIVIDED_BY_FLOAT; e2 = expr { Binop (Divf, e1, e2) }
  	| LET; x = ID; COLON; t = typ; EQUALS; e1 = expr; IN; e2 = expr
		{ Let (x, t, e1, e2) }
  	| IF; e1 = expr; THEN; e2 = expr; ELSE; e3 = expr { If (e1, e2, e3) }
  	| LPAREN; e=expr; RPAREN {e}
	;

typ:
	| INT_TYPE { TInt }
	| FLOAT_TYPE { TFloat }
	| BOOL_TYPE { TBool }
