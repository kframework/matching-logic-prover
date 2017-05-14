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
  
* Write matching logic specification in `example.match`.

* Convert to `example.smt2`.

  `./ml2fol`
