# What is ml2fol conversion?

It is a conversion from matching logic to first-order logic with equality that preserve satisfiability.

# Why is it useful?

Suppose you have a matching logic theory `T` given as a set of axioms and a pattern `P`. You want to decide whether `T` entails `P` or not. This is equivalent to decide whether the conjuntion of `T` and the negation of `P` is satisfiable or not. With `ml2fol` conversion, it can not be easier. You simply convert your matching logic theory `T` and the pattern `not P` to a first-order logic theory `L` and checks whether `L` is satisfiable or not. If `L` is unsatisfiable, then you know `T` entails `P` in matching logic. Checking satisbility of `L` can be done by SAT/SMT solvers, such as Z3.

# Prerequisite

``` 
sudo apt install m4 ocaml opam 
```


``` 
opam init 
```

```
opam install ounit
```

# How to use it?

* Build the converter.

  `./build`
  
* Write matching logic specification in `example.match`. See the next section for how to write specifications.

* Convert to `example.smt2`.

  `./ml2fol`

# How to write my matching logic specification?

A matching logic theory specification is written in a `smt2`-like style. See the regular grammar below.

```
SPEC ::= SORTDECL* SYMBOLDECL* ATTDECL* ASRTDECL+ CHECK-SAT GET-MODEL?

SORTDECL ::= (declare-sort ID)

SYMBOLDECL ::= (declare-symbol ID (ID*) ID)

ATTDECL ::= (declare-att ID function)
          | (declare-att ID partial-function)
          | (declare-att ID assoc)
          | (declare-att ID comm)

ASRTDECL ::= (assert PATTERN)

CHECK-SAT ::= (check-sat)

GET-MODEL ::= (get-model)

ID ::= [^0-9][a-zA-Z0-9]*

PATTERN ::= SEXPRESSION
```


