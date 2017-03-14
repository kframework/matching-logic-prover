%{ open Convert %}

%token <string> ID
%token LPAREN RPAREN DECLSORT DECLSYMB DECLFUNC ASSERT CHECKSAT GETMODEL 
%token TOP BOTTOM AND OR NOT IMPLIES IFF FORALL EXISTS EQUAL FLOOR CEIL CONTAINS 
%token EOF

%start main
%type <Convert.system> main
%%

main:
  | system EOF { $1 }
;

system:
  | sortdecls symboldecls assertions LPAREN CHECKSAT RPAREN LPAREN GETMODEL RPAREN
      { let (nonfuncsigs, funcsigs) = $2 in ($1, nonfuncsigs, funcsigs, $3) }
  | sortdecls symboldecls assertions LPAREN CHECKSAT RPAREN
      { let (nonfuncsigs, funcsigs) = $2 in ($1, nonfuncsigs, funcsigs, $3) }
  | sortdecls symboldecls assertions  
      { let (nonfuncsigs, funcsigs) = $2 in ($1, nonfuncsigs, funcsigs, $3) }
;
sortdecls:
  | sortdecl { [$1] }
  | sortdecl sortdecls { $1::$2 }
;
sortdecl:
  | LPAREN DECLSORT ID RPAREN { $3 }
;
symboldecls:
  | nonfuncdecl { ([$1], []) }
  | funcdecl { ([], [$1]) }
  | nonfuncdecl symboldecls
      { let (nonfuncsigs, funcsigs) = $2 in 
          ($1::nonfuncsigs, funcsigs) }
  | funcdecl symboldecls
      { let (nonfuncsigs, funcsigs) = $2 in 
          (nonfuncsigs, $1::funcsigs) }
;
nonfuncdecl:
  | LPAREN DECLSYMB ID LPAREN RPAREN ID RPAREN
      { ($3, [], $6) }
  | LPAREN DECLSYMB ID LPAREN sorts RPAREN ID RPAREN
      { ($3, $5, $7) }
;
funcdecl:
  | LPAREN DECLFUNC ID LPAREN RPAREN ID RPAREN
      { ($3, [], $6) }
  | LPAREN DECLFUNC ID LPAREN sorts RPAREN ID RPAREN
      { ($3, $5, $7) }
;
sorts:
  | ID { [$1] }
  | ID sorts { $1::$2 }
;
assertions:
  | assertion { [$1] }
  | assertion assertions { $1::$2 }
;
assertion:
  | LPAREN ASSERT pattern RPAREN { $3 }
;
pattern:
  | TOP { TopPattern }
  | BOTTOM { BottomPattern }
  | ID { AppPattern($1, []) }
  | LPAREN AND patterns RPAREN { AndPattern($3) }
  | LPAREN OR patterns RPAREN { OrPattern($3) }
  | LPAREN NOT pattern RPAREN { NotPattern($3) }
  | LPAREN IMPLIES pattern pattern RPAREN { ImpliesPattern($3, $4) }
  | LPAREN IFF pattern pattern RPAREN { IffPattern($3, $4) }
  | LPAREN FORALL LPAREN binders RPAREN pattern RPAREN
      { ForallPattern($4, $6) }
  | LPAREN EXISTS LPAREN binders RPAREN pattern RPAREN
      { ExistsPattern($4, $6) }
  | LPAREN EQUAL pattern pattern RPAREN { EqualPattern($3, $4) }
  | LPAREN FLOOR pattern RPAREN { FloorPattern($3) }
  | LPAREN CEIL pattern RPAREN { CeilPattern($3) }
  | LPAREN ID patterns RPAREN { AppPattern($2, $3) }
;
patterns:
  | pattern { [$1] }
  | pattern patterns { $1::$2 }
;
binders:
  | LPAREN ID ID RPAREN { [($2, $3)] }
  | LPAREN ID ID RPAREN binders { ($2, $3) :: $5 }
;