Define a subset of the smtlib language:

```k
module SMTLIB
  syntax Bool ::= "true" | "false"
                | "(" "not" Bool ")"
                | "(" "=>"  Bool Bool ")"
                | "(" "and" Bool Bool ")"
                | "(" "or"  Bool Bool ")"
                // For any sort A
                | "(" "="        K K ")"
                | "(" "distinct" K K ")"
```

http://smtlib.cs.uiowa.edu/theories-Ints.shtml

```k
  syntax Int
  syntax Int  ::= "0"
                | "(" "-"   Int ")"
                | "(" "+"   Int Int ")"
                | "(" "*"   Int Int ")"
                | "(" "*"   Int Int ")"
  syntax Bool ::= "(" "<="  Int Int ")"
                | "(" "<"   Int Int ")"
                | "(" ">="  Int Int ")"
                | "(" ">"   Int Int ")"
```

Extensional Arrays (from Ints to Ints)
--------------------------------------

```k
// http://smtlib.cs.uiowa.edu/papers/smt-lib-reference-v2.6-r2017-07-18.pdf pg 39

  syntax Array // Int -> Int Arrays
  syntax Int ::= "(" "select" Array ")"
  syntax Array ::= "(" "store" Array Int Int ")"
  
// (forall ((a (Array s1 s2)) (i s1) (e s2))
//  (= (select (store a i e) i) e))
  rule (select (store A I E) I) => E

// (forall ((a (Array s1 s2)) (i s1) (j s1) (e s2))
// (=> (distinct i j) (= (select (store a i e) j) (select a j))))
  rule (select (store A I E) J)
    => (select A J)
    if I =/=Int J  

// (forall ((a (Array s1 s2)) (b (Array s1 s2)))
//   (=> 
//     (forall ((i s1)) (= (select a i) (select b i))) (= a b)))
// Extensionality should fall out of the definition of ==K?
```

Sets
----

```k
  syntax Set ::= "emptySet" 
  syntax Set ::= "(" "union"  Set Set ")"
  syntax Set ::= "(" "inters" Set Set ")"
  syntax Set ::= "(" "in" Int Set ")"
```

```k
endmodule
```

These are various definitions we use to test lists:

```k
module LISTS
  imports SMTLIB

  syntax Array
  syntax Bool ::= isListSegmentleft(Array, Int, Int, Set) [function]
  rule isListSegmentleft(H, X, Y, .emptySet) => true
    if X >Int Y

  rule isListSegmentleft(H, X, Y, F) => true
    requires X =/=Int Y
     andBool X   >Int 0
     andBool isListSegmentleft(H, (select H X), Y. F)
     andBool notBool(isMember(X, F1))
     andBool F ==K add(F1, X)
endmodule
```

Tests
=====

```k
module LIST-SPEC
endmodule
```
