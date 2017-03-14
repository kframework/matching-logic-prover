%{ open Convert %}

%token <string> ID
%token LPAREN RPAREN DECLSORT DECLSYMB DECLFUNC ASSERT CHECKSAT GETMODEL 
%token TOP BOTTOM AND OR NOT IMPLIES IFF FORALL EXISTS EQUAL FLOOR CEIL CONTAINS 
%token EOF

%start main
%type <Convert.system> main
%type <Convert.system> system
%type <Convert.pattern> pattern
%type <string list> sorts
%%

main:
  | EOF { initial_system } /* the empty system */
  | system { $1 }
;

system:
  | EOF { initial_system }
  | LPAREN stmt_begin { $1 }
;

stmt_begin: /* a statement begins with declare-sort, declare-func, declare-symb, or assert */
  | DECLSORT ID RPAREN stmt_end { add_sort $2 $3 }
  | DECLFUNC ID LPAREN sorts ID RPAREN stmt_end /* binders end with RPAREN */
      { add_func $2 $4 $5 $7 }
  | DECLSYMB ID LPAREN sorts ID RPAREN stmt_end
      { add_symb $2 $4 $5 $7 }
  | ASSERT pattern RPAREN stmt_end
      { add_axiom $2 $4 }
;

stmt_end:
  | EOF { initial_system }
  | system { $1 }
;

sorts:
  | RPAREN { [] }
  | ID sorts { $1 :: $2 }
;

pattern:
  | TOP { TopPattern }
  | BOTTOM { BottomPattern }
  | ID { AppPattern($1, []) }
  | LPAREN pattern_begin { $1 } /* pattern_begin ends with a RPAREN */
;
pattern_begin:
  | AND patterns RPAREN { AndPattern($2) }
  | OR patterns RPAREN { OrPattern($2) }
  | NOT pattern RPAREN { NotPattern($2) }
  | IMPLIES pattern pattern RPAREN { ImpliesPattern($2, $3) }
  | IFF pattern pattern RPAREN { IffPattern($2, $3) }
  | FORALL LPAREN binders pattern RPAREN /* binders end with RPAREN */
      { ForallPattern($3, $4) }
  | EXISTS LPAREN binders pattern RPAREN /* binders end with RPAREN */
      { ExistsPattern($3, $4) }
  | EQUAL pattern pattern RPAREN { EqualPattern($2, $3) }
  | FLOOR pattern RPAREN { FloorPattern($2) }
  | CEIL pattern RPAREN { CeilPattern($2) }
  | ID patterns RPAREN { AppPattern($1, $2) }
;
patterns:
  | pattern { [$1] }
  | pattern patterns { $1::$2 }
;
binders:
  | LPAREN ID ID RPAREN { [($2, $3)] }
  | LPAREN ID ID RPAREN binders { ($2, $3) :: $5 }
;