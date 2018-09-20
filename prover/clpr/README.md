# The fixpoint prover.

## Todos (in priority)
- [ ] Implement `ll(x,y) -> lr(x,y)` (as a user story);
- [X] Finish the example `ll(x,y) -> lr(x,y)` using explicit (Plugin) and (Plugout) rule, no lambda form;
- [X] Try lambda + mu;
- [ ] Finish the general KT rule (how to deal with free variables?);
- [ ] Collect other proof rules (for the fragment);
- [ ] Define the fragment of ML;

## Instruction

Before using `clpr`, add the following to your `~/.bashrc`:
```
PATH={current_path}/clpr:{current_path}/clpr/z3/bin/:$PATH
export PATH
LD_LIBRARY_PATH={current_path}/clpr/z3/lib/:/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
export CLPRLIB={current_path}/clpr
export CLPR_BASE_PATH={current_path}/clpr
```

To use `clpr`:
```
mkdir tests
cd tests
/* prepare your test files here */
../clpr test.clpr
```

## A bit(e) of theory

### Least fixpoints

Least fixpoints (lfp) are defined using the `mu` construct.
Given `x` and `e` where `x` doesn't occur negatively,
`mu x . e` denotes the lfp of `e` wrt `x`.
This means the follows.

In terms of provability, we define two axioms for `mu x . e`:
```
(Fix) mu x . e = e[(mu x . e)/x]
      e[e'/x] -> e'
(KT)  --------------
      mu x . e -> e'
```

Semantically, 
given a model with carrier set `M` and
its powerset `P(M)`,
the pattern `e` (wrt `x`) can be regarded as a 
function `Fe : P(M) -> P(M)`, defined as follows:
```
Fe(X) = \barrho[X/x](e)
```
where `\barrho[X/x](e)` means the interpretation of `e` in the
valuation `rho` where `rho(x) = X`.
This is, obviously, against the matching logic semantics,
because one cannot assign a subset to a variable.
But let's not worry about that for now and assume we can do it.

Then since `x` has no negative occurrence, 
the function `Fe : P(M) -> P(M)` is monotonic (wrt set containment
relation).
By the famous Knaster-Tarski theorem, `Fe` admits a unique lfp,
denoted as `mu Fe`, which we define as the _intended interpretation_
of the pattern `mu x . e`.
In other words, `\barrho(mu x . e) = mu Fe`.

One can easily check that the two axioms `(Fix)` and `(KT)` are sound
wrt the intended interpretation of lfp.

There remains a difficult fundenmental question:
how does one define the construct `mu` so that it admits the above
intended interpretation as one possible interpretation?
Notice that the "easy" guess `mu x . e === exists x . mu0(x, e)`,
doesn't work.
Hint: 
prove that if `Gamma |- e1 -> e2` for some `Gamma`,
then `Gamma |- mu x . e1 -> mu x . e2`,
which is unsound in the intended interpretation.
More hints: consider `mu x . x` and `mu x . (x /\ c)` where
`c` is any constant functional symbol.

We do not intend to answer this fundenmental question in the PLDI paper.
In fact, we focus on _axioms and proofs_, leaving _semantics and models_ aside,
just for now.

### Least fixpoints: from sets to relations

`mu x . e` defines a subset.
Very powerful.
It already powers us to define
linear temporal logic (LTL),
computation tree logic (CTL),
dynamic logic (DL),
and reachabiliity logic (RL),
_faithfully_ in matching logic.

But one may ask: how do I define a _recursive symbol_
`r(x,y)` using `mu`?
As an example, the `ll(x,y)` matches all heaplets that are
linked lists from `x` to `y`, which is often defined
recursively:
```
ll(x,y) =lfp (emp /\ x=y) \/ exists t . (x|->t * ll(t,y) /\ x!=y /\ x!=0)
```
The question is, can we define `ll(x,y)` using `mu`?
The answer is positive;
but we need to first introduce lambda calculus.

### Lambda calculus

Lambda calculus `lambda x . e` can be defined in matching logic.
There are also deep fundenmental questions about the semantics
and models of the definition, but that's not the focus of this work.
To subsume lambda calculus and prove all that lambda calculus can prove,
we need only two axioms
```
(alpha) lambda x . e = lambda y . e[y/x]
(beta)  app((lambda x . e), e') = e[e'/x]
```

### `mu` + `lambda`

`mu` and `lambda` give us full power of induction and recursion.
Back to `ll`, we can now define it as
```
ll = mu f lambda x lambda y . (emp /\ x=y) \/ exists t . (x|->t * app(app(f,t),y) /\ x!=y /\ x!=0)
```
Notice `ll` is a _constant symbol_ taking no argument,
and `ll(x,y)` is written as `app(app(ll,x),y)`.
To easy our notation, we abbreviate `app(app(ll,x),y)` as `ll@(x,y)`.

## An example: `ll(x,y) -> lr(x,y)`

### Purpose

* Demonstrate a set of proof rules that power fixpoint reasoning.
* Eluminate strategies in how to apply these proof rules.
* Identify a fragment that is rich enough to express interesting
  properties, while simple enough to implement proof rules on them.

Roughly speaking the fragment considers implication of the form
```t /\ C1 /\ ... /\ Cn -> t' /\ C'1 /\ ... /\ C'n```
where `t` and `t'` are terms (or partial terms) and
`Ci`,`C'i` are predicate patterns.

### Fixpoint definitions.

```
ll(x,y) =lfp emp /\ x=y \/ exists t . x|->t * ll(t,y) /\ x!=0 /\ x!=y
lr(x,y) =lfp emp /\ x=y \/ exists t . lr(x,t) * t|->y /\ x!=0 /\ x!=y
```

The notation `lhs =lfp =rhs` is just a compact way to declare a symbol
and define two axioms for it, (Fix) and (KT).

### Proof obligation.

```
ll(x,y) -> lr(x,y)
```

### Proof.

```
(G). ll(x,y) -> lr(x,y)

apply (KT) on (G).

(G-1). emp /\ x=y -> lr(x,y)
(G-2). x|->t * lr(t,y) /\ x!=0 /\ x!=y -> lr(x,y)

apply (RU, case=1) on (G-1).

(G-1-1). emp /\ x=y -> emp /\ x=y

apply (DP) on (G-1-1). /* direct proof. or in general any simplification rules. */

done on (G-1-1).

/* lr(t,y) is in a context. First plug it out. */

apply (Plugout) on (G-2).

(G-3). lr(t,y) -> exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=y -> lr(x,y))

apply (KT) on (G-3). /* notice how we substitute t' for y in the premise according to (KT). */

(G-3-1). emp /\ t=y -> exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=y -> lr(x,y))
(G-3-2). exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) * t'|-> y /\ t!=y /\ t!=0 
      -> exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=y -> lr(x,y))

/* proving (G-3-1) ... done. */

apply (Plugin) on (G-3-2).

(G-3-2). x|->t * exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) * t'|-> y /\ t!=y /\ t!=0 /\ x!=0 /\ x!=y 
      -> lr(x,y)

apply (UnfoldRight) on (G-3-2).

(G-3-3). x|->t * exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) * t'|-> y /\ t!=y /\ t!=0 /\ x!=0 /\ x!=y
      -> exists t'' . lr(x,t'') * t''|->y /\ x!=y /\ x!=0

/* By unification(magic), we instantiate t'' to be t'. */

apply (Inst, t''=t') on (G-3-3).

(G-3-4). x|->t * exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) * t'|-> y /\ t!=y /\ t!=0 /\ x!=0 /\ x!=y
      -> lr(x,t') * t'|->y /\ x!=y /\ x!=0

apply (Simp) on (G-3-4). /* get rid of x!=y and x!=0 in the last */

(G-3-4). x|->t * exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) * t'|-> y /\ t!=y /\ t!=0 /\ x!=0 /\ x!=y
      -> lr(x,t') * t'|->y

/* the following step may look like magic, but be patient and see how it is needed.
 * we must make it less magical to make implementation even possible.
 */
apply (CaseAnalysis, x=t') on (G-3-4). 

(G-3-4-1). x|->t * exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) * t'|-> y /\ t!=y /\ t!=0 /\ x!=0 /\ x!=y /\ x=t'
        -> lr(x,t') * t'|->y
(G-3-4-2). x|->t * exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) * t'|-> y /\ t!=y /\ t!=0 /\ x!=0 /\ x!=y /\ x!=t'
        -> lr(x,t') * t'|->y

/* x|->t * t'|->y /\ t!=y /\ x=t' are inconsistent, so we have unsat lhs. */

apply (UnsatL) on (G-3-4-1).

done.

apply (Framing) on (G-3-4-2). /* get rid of t'|->y on both sides. */

(G-3-4-2). x|->t * exists h . h /\ floor(x|->t * h /\ x!=0 /\ x!=t' -> lr(x,t')) /\ t!=y /\ t!=0 /\ x!=0 /\ x!=y /\ x!=t'
        -> lr(x,t')

apply (DP) on (G-3-4-2).

```

