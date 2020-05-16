module TEST-DNF
  imports UNIT-TEST
  imports KORE-HELPERS

  syntax LowerName ::= "c" [token]
                     | "f" [token]

  syntax SharpName ::= "#X0"   [token]
                     | "#PHI1" [token] | "#PHI2" [token]

  rule test("dnf", 0)
    => assert( \or(\and(.Patterns))
            == #nnf(\not(\and(\or(.Patterns))))
             )
       .Declarations
  rule test("dnf", 1)
    => assert( \and(\or(\not(c(f, f)), \or(c, f)))
            == #nnf(\not(\or(\and(c(f, f), \not(\or(c, f))))))
             )
       .Declarations

  rule test("dnf", 2)
    => assert( \or(\and(.Patterns))
            == #dnf(\not(\and(\or(.Patterns))))
             )
       .Declarations
  rule test("dnf", 3)
    => assert( \or(\and(\not(c(f, f))), \and(c), \and(f))
            == #dnf(\not(\or(\and(c(f, f), \not(\or(c, f))))))
             )
       .Declarations

  rule test("dnf", 4)
    => assert( \or(\and((c(f, f)), \not(c), \not(f)))
            == #dnf(\or(\and(\and(c(\or(f), \and(\and(f))), \not(\or(c, f))))))
             )
       .Declarations

  rule test("dnf", 5)
    => assert( \or(\and(f)) == #dnf(\or(f)))
       .Declarations

  rule test("dnf", 6)
    => assert( \or(\and(sep(f), sep(c)))
            == #dnf(\or(sep(\and(f, c))))
             )
       .Declarations

//          sep(\and(sep(H), \equals(x, y)))
//  => \and(sep(H), sep(\equal(x, y)))

  rule test("dnf", 7)
    => assert( \or(\and(sep(f), sep(\equals(1, 2))))
            == #dnf(\or(sep(\and(f, \equals(1, 2)))))
             )
       .Declarations

  rule test("dnf", 8)
    => assert( \or(\and(c(\mu #X0 . \or(\and(#PHI2), \and(c(#X0)))), #PHI1))
            == #dnf(\and(c(\and(\mu #X0 . \or(\and(#PHI2), \and(c(#X0))))), #PHI1))
             )
       .Declarations

  rule test("dnf", 9)
    => assert( \or(\and(c(#PHI1), c(#PHI2)))
            == #dnf(\and(c(\and(#PHI1, #PHI2))))
             )
       .Declarations

  rule test("dnf", 10)
    => assert( \or(\and(c(\and(.Patterns))))
            == #dnf(c(\and(.Patterns)))
             )
       .Declarations

//  rule test("dnf", 4)
//    => assert( 
//            == #flattenAnds(\and(\and(\or(\and(\and(\not(c(f, \and(\and(f)))))), \and(c), \and(f)))))
//             )
//       .Declarations
endmodule
