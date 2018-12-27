requires "smtlib2.k"

module PROVER-SYNTAX

imports DOMAINS-SYNTAX

/* FOL-Horn fragment */

syntax Var ::= "V_" Int 

syntax AtomicTerm ::= Int | Var | "emptyset"

syntax Term ::= AtomicTerm
              | Term "+" Term
              | "union" "(" Term "," Term ")"
              | "intersect" "(" Term "," Term ")"
              | Term "#" Term /* F # x means F U {x}, and that x \not\in F */
              | Term "[" Term ":=" Term "]"
              | Term "[" Term "]"
              | "(" Term ")" [bracket]

syntax Terms ::= List{Term, ","}

syntax RecursivePredicate
syntax NonRecursivePredicate
  
syntax Atom ::= "true" | "false"
              | Term "=" Term
              | Term "!=" Term
              | Term "<=" Term
              | Term "<" Term
              | "disjoint" "(" Term "," Term ")"
              | Term "in" Term
              | Term "notin" Term
              | NonRecursivePredicate "(" Terms ")"
              | RecursivePredicate "(" Terms ")"
              | "(" Atom ")" [bracket]

syntax ConjunctionForm ::= List{Atom, "/\\"}

syntax ImplicationForm ::= ConjunctionForm "->" Atom

/* prover infrastructure */

syntax DisjunctionForm ::= List{ConjunctionForm, "\\/"}
syntax DisjunctionForm ::= "unfold" "(" Atom ")" [function]

/* examples */
syntax RecursivePredicate ::= "lsegleft"
                            | "lsegright"

endmodule

module PROVER

imports DOMAINS
imports PROVER-SYNTAX
imports SMTLIB2

configuration 
  <k> $PGM </k>
  <nextVar> 4 </nextVar>


/* lsegleft */
rule <k> unfold(lsegleft(H,X,Y,F))
         => ((X=Y) /\ (F=emptyset))
            \/ (lsegleft(H,(V_ I),Y,(V_ (I+Int 1))) 
               /\ (X!=Y) /\ (X!=0) /\ H[X]=(V_ I) /\ (F=(V_ (I +Int 1)) # X))
     ...</k> 
     <nextVar> I => I +Int 2 </nextVar>

/* lsegright */
rule <k> unfold(lsegright(H,X,Y,F))
         => ((X=Y) /\ (F=emptyset))
            \/ (lsegright(H,X,(V_ I),(V_ (I+Int 1))) 
               /\ (X!=Y) /\ (X!=0) /\ H[(V_ I)]=Y /\ (F=(V_ (I +Int 1)) # (V_ I)))
     ...</k> 
     <nextVar> I => I +Int 2 </nextVar>

endmodule
