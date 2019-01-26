Z3CheckSAT(SMTLIB2ScriptToString(
    ML2SMTLIB(\implies( \and( \equals(variable("a") { Int } , variable("b") { Int } )
                            , \equals(variable("c") { Int } , variable("b") { Int } )
                            , .Patterns
                            )
                      , \and( \equals(variable("a") { Int } , variable("c") { Int } )
                            , .Patterns
                            )
             )        )
))
