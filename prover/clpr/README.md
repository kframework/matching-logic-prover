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

### `mu` meets `lambda`

`mu` and `lambda` give us full power of induction and recursion.
Back to `ll`, we can now define it as
```
ll = mu f lambda x lambda y . (emp /\ x=y) \/ exists t . (x|->t * app(app(f,t),y) /\ x!=y /\ x!=0)
```
Notice `ll` is a _constant symbol_ taking no argument,
and `ll(x,y)` is written as `app(app(ll,x),y)`.
To easy our notation, we abbreviate `app(app(ll,x),y)` as `ll@(x,y)`.

### Least fixpoints in a context: (Plugin) and (Plugout)

Let's look at the following example.
Define `ll` and `lr` be two lfp:
```
ll = mu f lambda x lambda y . (emp /\ x=y) \/ exists t . (x|->t * f@(t,y) /\ x!=y /\ x!=0)
lr = mu f lambda x lambda y . (emp /\ x=y) \/ exists t . (f@(x,t) * t|->y /\ x!=0 /\ x!=y)
```
How can we prove `ll@(x,y) -> lr@(x,y)`?
To be clear, how to prove `app(app(ll,x),y) -> app(app(lr,x),y)`?

Notice that (KT) is not applicable here, as `ll` occurs in a context.
One attempt is to apply (Framing) rules twice and prove `ll -> lr`,
but I failed on that approach.

Here I'm introducing a _general and systematic_ approach to deal with
the above situation, i.e., lfp occurs on the lhs within some context `C`.

Assume we have an implication `C[phi] -> psi`. 
If `C` is an _extensional_ context, which means
```
|- C[bottom] -> bottom
|- C[phi1 \/ phi2] -> C[phi1] \/ C[phi2]
|- C[exists x . phi] -> exists x . C[phi]
```
then one can prove that
```
|- C[phi] -> psi if and only if |- phi -> exists x . x /\ floor(C[x] -> psi)
```

Let `C'[HOLE] === exists x . x /\ floor(C[x] -> HOLE)`, called the _implication context_
of `C`, then `|- C[phi] -> psi` if and only if `|- phi -> C'[psi]`.
In particular, `|- C[C'[psi]] -> psi`.
Using this new notation of implication context, we have
```
                 ----(Plugout)--->
|- C[phi] -> psi   if and only if  |- phi -> C'[psi]          /* if C is extensional */
                 <---(Plugin)-----

As a special case,

|- C[C'[psi]]    ----(Collapse)--> |- psi                     /* if C is extensional */

|- D[C[C'[psi]]] ----(Collapse)--> |- D[psi]                  /* if C and D are extensional */
```

### The full example: `ll@(x,y) -> lr@(x,y)`

We work out the example `ll@(x,y) -> lr@(x,y)` and present
the entire proof here.
The purpose is two-fold: 
(1) to demonstrate (Plugin) and (Plugout);
and (2) to eluminate good proving strategy.

Again, we emphasize that proving `ll -> lr` **will not work**.
(Or, let me know if you prove me wrong).

Proof.

```
Fixpoint definitions.
ll = mu f lambda x lambda y . (emp /\ x=y) \/ exists t . (x|->t * f@(t,y) /\ x!=y /\ x!=0)
lr = mu f lambda x lambda y . (emp /\ x=y) \/ exists t . (f@(x,t) * t|->y /\ x!=0 /\ x!=y)

Proof obligation.
(G) ll@(x,y) -> lr@(x,y)

Proof.

apply (Plugout) on (G). /* !!!HOT SPOT!!! */

(G-1) ll -> exists f . (f /\ floor(f@(x,y) -> lr@(x,y)))

let F === exists f . (f /\ floor(f@(x,y) -> lr@(x,y))) in (G-1).

(G-2) ll -> F

apply (Forall) on (G-2). /* |- A -> forall x . B implies |- A -> B */

(G-3) ll -> forall x y . F

apply (KT) on (G-3).

(G-4) lambda x lambda y . (emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)
   -> forall x y . F

apply (UG) on (G-5). /* universal generalization */

(G-5) lambda x lambda y . (emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)
   -> F

apply (Plugin) on (G-5). /* !!!HOT SPOT!!! you may want to go back to (G-1) and check what F is */

(G-6) (emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0) 
   -> lr@(x,y)

apply (SplitLeft) on (G-6).

(G-6-1) emp /\ x=y -> lr@(x,y) /* whose proof we omit (for now) */

(G-6-2) exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0) -> lr@(x,y)

apply (Exists) on (G-6-2). /* |- A(t) -> B implies |- (exists t . A(t)) -> B if t not in FV(B) */

(G-6-3) x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0 -> lr@(x,y)

apply (Inst, (forall x y . F), x=t, y=y) on (G-6-3).

(G-6-4) x|->t * (F[t/x][y/y])@(t,y) /\ x!=y /\ x!=0 -> lr@(x,y)

expand F[t/x][y/y] in (G-6-4).

(G-6-5) x|->t * (exists f . f /\ floor(f@(t,y) -> lr@(t,y)))@(t,y) /\ x!=y /\ x!=0 -> lr@(x,y)

apply (Collapse) on (G-6-5). /* !!!HOT SPOT!!! */

(G-6-6) x|->t * lr@(t,y) /\ x!=y /\ x!=0 -> lr@(x,y)

apply (Plugout) on (G-6-6).

(G-6-7) lr -> exists f . (f /\ floor(x|->t * f@(t,y) /\ x!=y /\ x!=0 -> lr@(x,y)))

let G = exists f . (f /\ floor(x|->t * f@(t,y) /\ x!=y /\ x!=0 -> lr@(x,y))) in (G-6-7).

(G-6-8) lr -> G

apply (Forall) on (G-6-8).

(G-6-9) lr -> forall x y t . G

apply (KT) on (G-6-10).

(G-6-10) lambda x lambda y . (emp /\ x=y) \/ exists t' . ((forall x y t . G)@(x,t') * t'|->y /\ x!=y /\ x!=0)
      -> forall x y t . G

apply (UG) on (G-6-10).

(G-6-11) lambda x lambda y . (emp /\ x=y) \/ exists t' . ((forall x y t . G)@(x,t') * t'|->y /\ x!=y /\ x!=0)
      -> G

apply (Plugin) on (G-6-11).

(G-6-12) x|->t * (emp /\ t=y \/ exists t' . ((forall x y t . G)@(t,t') * t'|-> y /\ t!=y /\ t!=0)) /\ x!=y /\ x!=0 
      -> lr@(x,y)

apply (Propataion) on (G-6-12).

(G-6-13) x|->t * emp /\ t=y /\ x!=y /\ x!=0
      \/ x|->t * exists t' . ((forall x y t . G)@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
      -> lr@(x,y)

apply (SplitLeft) on (G-6-13).

(G-6-13-1) x|->t * emp /\ t=y /\ x!=y /\ x!=0 -> lr@(x,y) /* whose proof we omit (for now) */

(G-6-13-2) x|->t * exists t' . ((forall x y t . G)@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
        -> lr@(x,y)

apply (Exists) on (G-6-13-2).

(G-6-13-3) x|->t * ((forall x y t . G)@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
        -> lr@(x,y)

apply (RightUnfold,case=2) on (G-6-13-3).

(G-6-13-4) x|->t * ((forall x y t . G)@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
        -> exists t'' . lr@(x,t'') * t''|->y /\ x!=y /\ x!=0

apply (Inst, t''=t') on (G-6-13-4).

(G-6-13-5) x|->t * ((forall x y t . G)@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
        -> lr@(x,t') * t'|->y /\ x!=y /\ x!=0

apply (Inst, (forall x y t . G), x=x,y=t',t=t) on (G-6-13-5).

(G-6-13-6) x|->t * ((G[x/x][t'/y][t/t])@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
        -> lr@(x,t') * t'|->y /\ x!=y /\ x!=0

expand G[x/x][t'/y][t/t] on (G-6-13-6).

(G-6-13-7) x|->t * ((exists f . (f /\ floor(x|->t * f@(t,t') /\ x!=t' /\ x!=0 -> lr@(x,t'))))@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
        -> lr@(x,t') * t'|->y /\ x!=y /\ x!=0

apply (CaseAnalysis, x=t') on (G-6-13-7). /* this may look like magic. why case analysis here? see later. */

(G-6-13-7-1) x|->t * ((exists f . (f /\ floor(x|->t * f@(t,t') /\ x!=t' /\ x!=0 -> lr@(x,t'))))@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
          /\ x=t'
          -> lr@(x,t') * t'|->y /\ x!=y /\ x!=0 /* notice that lhs is unsat: x|->t * ... * t'|->y /\ x=t' /\ t!=y /\ ... */

(G-6-13-7-2) x|->t * ((exists f . (f /\ floor(x|->t * f@(t,t') /\ x!=t' /\ x!=0 -> lr@(x,t'))))@(t,t') * t'|-> y /\ t!=y /\ t!=0) /\ x!=y /\ x!=0
          /\ x!=t'
          -> lr@(x,t') * t'|->y /\ x!=y /\ x!=0

apply (LeftUnsat) on (G-6-13-7-1).

done

apply (Collapse) on (G-6-13-7-2). /* thanks to CaseAnalysis, we have x!=t' in the context, so Collaspe can be applied */

(G-6-13-7-2) lr@(x,t') * t'|->y /\ t!=y /\ t!=0 /\ x!=y /\ x!=0
          -> lr@(x,t') * t'|->y /\ x!=y /\ x!=0

apply (DirectProof) on (G-6-13-7-2).

done

qed.
```

