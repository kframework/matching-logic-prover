%{
open Convert
%}

%token <string> ID
%token LPAREN RPAREN DECLSORT DECLSYMB DECLFUNC ASSERT CHECKSAT GETMODEL 
%token TOP BOTTOM AND OR NOT IMPLIES IFF FORALL EXISTS EQUAL FLOOR CEIL CONTAINS 
%token EOF

%start system

%type <Convert.system> system
%type <Convert.pattern> pattern
%type <string list> sorts
%type <(string * string) list> binders
%%

system:
  | EOF { initial_system } /* the empty system */
  | LPAREN system_cont { $2 }
;

system_cont: /* expect "declare-sort", "declare-func", "declare-symb", or "assert" */
  | DECLSORT ID RPAREN system { add_sort $2 $4 }
  | DECLFUNC ID LPAREN sorts ID RPAREN system /* sorts end with RPAREN */
      { add_func $2 $4 $5 $7 }
  | DECLSYMB ID LPAREN sorts ID RPAREN system
      { add_nonfunc $2 $4 $5 $7 }
  | ASSERT pattern RPAREN system
      { add_axiom $2 $4 }
;

sorts:
  | RPAREN { [] }
  | ID sorts { $1 :: $2 }
;

pattern:
  | TOP { TopPattern }
  | BOTTOM { BottomPattern }
  | ID { AppPattern($1, []) }
  | LPAREN pattern_cont { $2 } /* pattern_cont ends with a RPAREN */
;
pattern_cont:
  | AND patterns RPAREN { AndPattern($2) }
  | OR patterns RPAREN { OrPattern($2) }
  | NOT pattern RPAREN { NotPattern($2) }
  | IMPLIES pattern pattern RPAREN { ImpliesPattern($2, $3) }
  | IFF pattern pattern RPAREN { IffPattern($2, $3) }
  | FORALL LPAREN binders pattern RPAREN /* binders end with RPAREN */
      { ForallPattern($3, (replace_constants_if_binders $4 $3)) }
  | EXISTS LPAREN binders pattern RPAREN /* binders end with RPAREN */
      { ExistsPattern($3, (replace_constants_if_binders $4 $3)) }
  | EQUAL pattern pattern RPAREN { EqualPattern($2, $3) }
  | FLOOR pattern RPAREN { FloorPattern($2) }
  | CEIL pattern RPAREN { CeilPattern($2) }
  | ID patterns RPAREN { AppPattern($1, $2) }
;
patterns:
  | pattern { [$1] }
  | pattern patterns { $1::$2 }
;

binders: /* the starting LPAREN has been consumed */
         /* expect " (ID ID) (ID ID) ... (ID ID)) " */
  | RPAREN { [] }
  | LPAREN ID ID RPAREN binders { ($2, $3) :: $5 }
;
