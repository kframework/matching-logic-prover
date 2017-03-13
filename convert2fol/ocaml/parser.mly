%{ open Convert %}

%token <string> ID
%token LPAREN RPAREN DECLSORT DECLSYMB DECLFUNC ASSERT CHECKSAT GETMODEL 
%token TOP BOTTOM AND OR NOT IMPLIES IFF FORALL EXISTS EQUAL FLOOR CEIL CONTAINS 
%token EOF

%start pattern
%type <Convert.pattern> pattern
%%

pattern:
  | ID { TopPattern }
;

