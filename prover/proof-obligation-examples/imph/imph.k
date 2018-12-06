/*
 * The K semantics of a simple imperative program
 * that manipulates heaps (IMPH).
 *
 * Created in 2018 by Xiaohong Chen (xc3@illinois.edu)
 */

/*
 * The syntax module
 */
module IMPH-SYNTAX

  imports DOMAINS-SYNTAX // import built-in sorts Id and Int

  syntax Exp ::= Int | Id
               | Exp "+" Exp  [strict]
	       | Exp "!=" Exp [strict]
               | "[" Exp "]"  [strict]    // de-reference
	       | "(" Exp ")"  [bracket]   // use parentheses for grouping

  syntax Stmt ::= Id ":=" Exp ";"                       [strict(2)]
                | "[" Exp "]" ":=" Exp ";"              [strict]
                | "if" Exp "then" Stmt "else" Stmt "fi" [strict(1)]
                | "while" Exp "do" Stmt "od"
		| "skip"
                > Stmt Stmt [left]

  syntax Pgm ::= "int" Ids ";" Stmt // declare a list of program variables
  syntax Ids ::= List{Id, ","} // Ids is a comma-separated list of Id's

endmodule


/*
 * The semantics module that imports the syntax module.
 */
module IMPH

  imports DOMAINS
  imports IMPH-SYNTAX

  syntax KResult ::= Int 

  configuration 
    <T>
      <k> $PGM:Pgm </k>
      <state> .Map </state>
      <heap> .Map </heap>
    </T>

  /*
   * State assignment rule.
   */
  rule <k> X:Id := I:Int; => .K ... </k>
       <state> ... X |-> (_ => I) ... </state>

  /*
   * Heap assignment rule (when L has a value).
   */
  rule <k> [L:Int] := I:Int; => .K ... </k>
       <heap> ... L |-> (_ => I) ... </heap>

  /*
   * Heap assignment rule (when L doesn't have a value).
   */
  rule <k> [L:Int] := I:Int; => .K ... </k>
       <heap> H (.Map => L |-> I) </heap>
  requires notBool (L in keys(H))


  /*
   * State lookup rule.
   */
  rule <k> X:Id => I ... </k>
       <state> ... X |-> I ... </state>

  /*
   * Heap lookup rule.
   */
  rule <k> [L:Int] => I ... </k>
       <heap> ... L |-> I ... </heap>

  /*
   * Boring rules.
   */
  rule I1:Int + I2:Int => I1 +Int I2
  rule I:Int != I:Int => 0
  rule I1:Int != I2:Int => 1 requires I1 =/=Int I2
  rule if 0 then S1 else S2 fi => S2
  rule if I then S1 else S2 fi => S1 requires I =/=Int 0
  rule while I do S:Stmt od => if I then S (while I do S od) else skip fi
  rule S1:Stmt S2:Stmt => S1:Stmt ~> S2:Stmt
  rule skip => .K

  /*
   * Initialize declared program variables to zero.
   */
  rule <k> int (X:Id,Xs:Ids => Xs) ; S:Stmt </k>
       <state> Rho:Map (.Map => X |-> 0) </state>
  requires notBool (X in keys(Rho))
  
  rule int .Ids ; S:Stmt => S:Stmt
  
endmodule
