%{
open Pat
%}

%token <string> ID
%token LPAREN RPAREN  
%token DECLSORT DECLSYMB DECLPART DECLFUNC ASSERT CHECKSAT GETMODEL 
%token TOP BOTTOM AND OR NOT IMPLIES IFF FORALL EXISTS EQUAL FLOOR CEIL CONTAINS 
%token EOF

%start thy
%start pat 

%type <(string list) * (Pat.sym list) * (Pat.pat list)> thy
%type <Pat.pat> pat 
%type <Pat.pat> pat_closed
%type <Pat.pat list> pats_closed
%type <(string * string) list> bindings
%type <string> sort
%type <string list> sorts
%%

thy:
  | EOF { ([], [], []) }
  | LPAREN thy_closed { $2 }

thy_closed:
  | DECLSORT ID RPAREN thy { add_sort_pat $2 $4 }
  | DECLSYMB ID sorts sort RPAREN thy { add_sym_pat (UI($2, $3, $4)) $6 }
  | DECLFUNC ID sorts sort RPAREN thy { add_sym_pat (FC($2, $3, $4)) $6 }
  | DECLPART ID sorts sort RPAREN thy { add_sym_pat (PF($2, $3, $4)) $6 }
  | ASSERT pat RPAREN thy { add_axiom_pat $2 $4 }

sort:
  | ID { $1 }

sorts:
  | LPAREN sorts_closed { $2 }

sorts_closed:
  | RPAREN { [] }
  | ID sorts_closed { $1 :: $2 }

pat:
  | TOP { Top }
  | BOTTOM { Bottom } 
  | ID { Id($1) }
  | LPAREN pat_closed { $2 }

pat_closed:
  | AND pats_closed { And($2) }
  | OR pats_closed { Or($2) }
  | NOT pat RPAREN { Not($2) }
  | IMPLIES pat pat RPAREN { Implies($2, $3) }
  | IFF pat pat RPAREN { Iff($2, $3) }
  | FORALL bindings pat RPAREN { Forall($2, $3) }
  | EXISTS bindings pat RPAREN { Exists($2, $3) }
  | EQUAL pat pat RPAREN { Equal($2, $3) }
  | CEIL pat RPAREN { Ceil($2) }
  | FLOOR pat RPAREN { Floor($2) }
  | CONTAINS pat pat RPAREN { Contains($2, $3) }
  | ID pats_closed { App($1, $2) }

pats_closed: 
  | RPAREN { [] }
  | pat pats_closed { $1 :: $2 }


bindings:
  | LPAREN bindings_closed { $2 }

bindings_closed:
  | RPAREN { [] }
  | LPAREN ID ID RPAREN bindings_closed { ($2, $3) :: $5 }


