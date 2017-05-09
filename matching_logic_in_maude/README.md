# Objective
Try to define a matching logic theory as maude modules.

# The theory
The matching logic theory that is defined here is a theory (called IMP) for simple imperative programs. We will introduce the theory IMP in details in the following sections.

## Sorts
The theory IMP the following sorts. 
* Nat: natural numbers.
* Bool: Boolean values.
* Pgm: programs.
* Map: heap memory.
* Cfg: configuration of a program.

## Symbols
```
symbol zero : -> Nat [functional] .
symbol succ : Nat -> Nat [functional] .
symbol plus : Nat Nat -> Nat [functional assoc comm] .
symbol ge : Nat Nat -> Bool [functional] .
symbol and : Bool Bool -> Bool [functional assoc comm] .
symbol not : Bool -> Bool [functional] .
symbol emp : -> Map [functional] .
symbol mapsto : Nat Nat -> Map [functional] .
symbol merge : Map Map -> Map [partial assoc comm] .
symbol asng : Nat Nat -> Pgm [label assoc] .
symbol seq : Pgm Pgm -> Pgm [label assoc] .
symbol ite : Bool Pgm Pgm -> Pgm [label] .
symbol skip : -> Pgm [label] .
symbol cfg : Pgm Map -> Cfg [label] .
```



