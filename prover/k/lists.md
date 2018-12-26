We'd like to define the theory of Lists in Kore. To do so, we start by writing
out a K definition, kompiling to kore, and then cleaning it up.

We begin with this K (non-executable) definition:

```k
module LISTS
  imports INT-SYNTAX
  imports BOOL

  syntax Array
  syntax Set ::= ".Set" [symbol(set_empty)]
  syntax Bool ::= Set "==Set" Set [symbol(set_eq), klabel(set_eq)]

  syntax Bool ::= Int ">Int" Int   [symbol(int_gt), klabel(int_gt)]
                | Int "=/=Int" Int [symbol(int_ne), klabel(int_ne)]

  syntax Int  ::= select(Array, Int)                      [symbol(array_select), klabel(array_select)]
  syntax Bool ::= isMember(Int, Set)                      [symbol(set_isMember ), klabel(set_isMember )]
  syntax Set  ::= add(Set, Int)                           [symbol(set_add ), klabel(set_add )]
  syntax Bool ::= isListSegmentleft(Array, Int, Int, Set) [function, symbol(isListSegmentleft), klabel(isListSegmentleft)]

  rule isListSegmentleft(H, X, Y, F) => true
    requires X >Int Y
     andBool F ==Set .Set
  rule isListSegmentleft(H, X, Y, F) => true
    requires X =/=Int Y
     andBool X   >Int 0
     andBool isListSegmentleft(H, select(H, X), Y, F)
     andBool notBool(isMember(X, ?F1))
     andBool F ==Set add(?F1, X)
endmodule
```

That generates these axioms:
----------------------------

```
  axiom{R} \implies{R} (
    \equals{SortBool{},R}(
        Lbl'Unds'andBool'Unds'{}(Lblint'Unds'gt{}(VarX:SortInt{},VarY:SortInt{}),Lblset'Unds'eq{}(VarF:SortSet{},Lbl'Stop'Set{}())),
        \dv{SortBool{}}("true")),
    \and{R} (
      \equals{SortBool{},R} (
        LblisListSegmentleft{}(VarH:SortArray{},VarX:SortInt{},VarY:SortInt{},VarF:SortSet{}),
        \dv{SortBool{}}("true")),
      \top{R}()))
```

```
    Lbl'Unds'andBool'Unds'{}(Lbl'Unds'andBool'Unds'{}(Lbl'Unds'andBool'Unds'{}(Lbl'Unds'andBool'Unds'{}(Lblint'Unds'ne{}(VarX:SortInt{},VarY:SortInt{}),Lblint'Unds'gt{}(VarX:SortInt{},\dv{SortInt{}}("0"))),LblisListSegmentleft{}(VarH:SortArray{},Lblarray'Unds'select{}(VarH:SortArray{},VarX:SortInt{}),VarY:SortInt{},VarF:SortSet{})),LblnotBool'Unds'{}(Lblset'Unds'isMember{}(VarX:SortInt{},Var'Ques'F1:SortSet{}))),Lblset'Unds'eq{}(VarF:SortSet{},Lblset'Unds'add{}(Var'Ques'F1:SortSet{},VarX:SortInt{}))),
        \dv{SortBool{}}("true")),
    \and{R} (
      \equals{SortBool{},R} (
        LblisListSegmentleft{}(VarH:SortArray{},VarX:SortInt{},VarY:SortInt{},VarF:SortSet{}),
        \dv{SortBool{}}("true")),
      \top{R}()))
```

And then clean them up by
-------------------------

* Use nicer symbol names
* Don't use SortBool, instead use `\and` `\not` etc
* The kore converter doesn't seem to support `?VNAME`. Manually convert this into `\exists`

```
  axiom{R} \implies{R} ( \and{R} ( int_ge{}(X:Int{},Y:Int{})
                                 , set_eq{}(F:Set{}, set_empty{}())
                                 )
                       , isListSegmentleft{}(H:Array{},X:Int{},Y:Int{}, F:Set{})
                       )
```

```
  axiom{R}
    \exists {R} (F1:Set{},
    \implies{R} ( \and{R} (\and{R} (\and{R} (\and{R}
                         ( int_ne{}(X:Int{}, Y:Int{})
                         , int_ge{}(X:Int{}, \dv{Int{}}("0"))
                        ), isListSegmentleft{}(H:Array{}, array_select{}(H:Array{}, X:Int{}), Y:Int{}, F:Set{})
                        ), \not{R}(set_isMember{}(X:Int{}, F1:Set{}))
                        ), set_eq{}(F:Set{}, set_add{}(F1:Set{}, X:Int{}))
                         )
                , isListSegmentleft { } (H:Array{}, X:Int{}, Y:Int{}, F:Set{})
                )
                )
```
