Z3CheckSAT(SMTLIB2ScriptToString(
    ML2SMTLIB(\implies( \and( \equals(variable("a"), variable("b"))
                            , \equals(variable("c"), variable("b"))
                            , .Patterns
                            )
                      , \and( \equals(variable("a"), variable("c"))
                            , .Patterns
                            )
             )        )
))
