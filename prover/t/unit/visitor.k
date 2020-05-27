requires "drivers/unit-tests.k"

module UNIT-TEST
  imports DRIVER-UNIT-TEST

  /* -------- \subseteq ------ */

  rule test(1)
    => assert( 3
            == TestVisitorSubseteqResult(
                 visitTopDown(
                   TestVisitorSubseteq(0),
                   \subseteq(10, 20)
                 )
               )
             )
       .Declarations

  syntax Visitor ::= TestVisitorSubseteq(Int)

  syntax Int ::= TestVisitorSubseteqResult(VisitorResult) [function]

  rule TestVisitorSubseteqResult(visitorResult(TestVisitorSubseteq(N), _))
    => N

  // first call
  rule visit(TestVisitorSubseteq(0), \subseteq(10, 20) #as P)
    => visitorResult(TestVisitorSubseteq(1), P)

  // second call
  rule visit(TestVisitorSubseteq(1), 10 #as P)
    => visitorResult(TestVisitorSubseteq(2), P)

  // third call
  rule visit(TestVisitorSubseteq(2), 20 #as P)
    => visitorResult(TestVisitorSubseteq(3), P)
  
  /* -------- \member ------ */

  rule test(2)
    => assert( 3
            == TestVisitorMemberResult(
                 visitTopDown(
                   TestVisitorMember(0),
                   \member(30, 40)
                 )
               )
             )
       .Declarations

  syntax Visitor ::= TestVisitorMember(Int)

  syntax Int ::= TestVisitorMemberResult(VisitorResult) [function]

  rule TestVisitorMemberResult(visitorResult(TestVisitorMember(N), _))
    => N

  // first call
  rule visit(TestVisitorMember(0), \member(30, 40) #as P)
    => visitorResult(TestVisitorMember(1), P)

  // second call
  rule visit(TestVisitorMember(1), 30 #as P)
    => visitorResult(TestVisitorMember(2), P)

  // third call
  rule visit(TestVisitorMember(2), 40 #as P)
    => visitorResult(TestVisitorMember(3), P)

endmodule
