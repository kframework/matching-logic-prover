module FOO

imports DOMAINS

syntax Foo ::= foo(Int)
             | id(Foo)
             | bar(Foo, Foo)

rule id(X:Foo) => X
rule bar(X:Foo, Y:Foo) => X

endmodule
