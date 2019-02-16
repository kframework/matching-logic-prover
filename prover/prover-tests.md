```k
module PROVER-TESTS-SPEC
    imports PROVER

    rule <prover>
           <goal>
             <k> \implies( \and( \equals(variable("X") {Int}, 3), .Patterns )
                         , \and( \equals(variable("Y") {Int}, 5)
                               , \equals(variable("Z") {Int}, 5)
                               , .Patterns
                               )
                         )
              => \implies( \and( \equals(variable("X") {Int}, 3)
                               , \equals(variable("Y") {Int}, 5)
                               , \equals(variable("Z") {Int}, 5)
                               , .Patterns
                               )
                         , \and( .Patterns )
                         )
             </k>
             <strategy> instantiate-existentials => noop </strategy>
             ...
           </goal>
         </prover>

    rule <prover>
           <goal>
             <k> \implies( \and( \equals(variable("X") {Int}, 3), .Patterns )
                         , \and( \equals(variable("Y") {Int}, 5)
                               , \equals(variable("Y") {Int}, 6)
                               , .Patterns
                               )
                         )
              => \implies( \and( \equals(variable("X") {Int}, 3)
                               , \equals(variable("Y") {Int}, 5)
                               , .Patterns
                               )
                         , \and( \equals(variable("Y") {Int}, 6)
                               , .Patterns
                               )
                         )
             </k>
             <strategy> instantiate-existentials => noop </strategy>
             ...
           </goal>
         </prover>
         
endmodule
```
