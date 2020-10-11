module FOO

imports DOMAINS

syntax Foo ::= foo(Int)
             | id(Foo)

rule id(X:Foo) => X

endmodule
