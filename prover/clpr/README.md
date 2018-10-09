# The fixpoint prover.

## Todos (in priority)
- [X] Implement `[](P -> o P) /\ P -> [] P` (as a user story);
- [ ] Implement `ll(x,y) -> lr(x,y)` (as a user story);
- [X] Finish the example `ll(x,y) -> lr(x,y)` using explicit (Plugin) and (Plugout) rule, no lambda form;
- [X] Try lambda + mu;
- [X] ~~Identify a nice fragment of ML (for implementation convenience);~~
- [X] Define the general KT rule (lfp in a context; question: how to deal with free variables?);
- [X] Collect other proof rules (for the fragment);

## Instruction

All is in `fix.maude`. 
To run it, do
```
sudo apt install maude
maude fix.maude
```

To run `clpr` files:

```
./run-clpr test.clpr
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
lr = mu f lambda x lambda y . (emp /\ x=y) \/ exists t . (f@(x,t) * t|->y /\ x!=y /\ x!=0)
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
ll = mu f lambda x y . (emp /\ x=y) \/ exists t . (x|->t * f@(t,y) /\ x!=y /\ x!=0)
lr = mu f lambda x y . (emp /\ x=y) \/ exists t . (f@(x,t) * t|->y /\ x!=y /\ x!=0)

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

(G-4) lambda x y . (emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)
   -> forall x y . F

apply (UG) on (G-5). /* universal generalization */

(G-5) lambda x y . (emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)
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

(G-6-10) lambda x y . (emp /\ x=y) \/ exists t' . ((forall x y t . G)@(x,t') * t'|->y /\ x!=y /\ x!=0)
      -> forall x y t . G

apply (UG) on (G-6-10).

(G-6-11) lambda x y . (emp /\ x=y) \/ exists t' . ((forall x y t . G)@(x,t') * t'|->y /\ x!=y /\ x!=0)
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

## More examples

### (LTL Ind) `[] (P -> o P) /\ P -> [] P`

This is the famous induction proof rule in LTL.
It is valid and can be proved with (KT) in matching logic.
To do that, we need to define LTL in matching logic.

It is known how to define LTL in matching logic.
Here shows the definition.
We let `*` be a unary matching logic symbol, called "strong next".
Let `o P = not * not P` called "weak next".
Let `[] P` be a greatest fixpoint defined as
```
[] P =gfp P /\ o [] P
```
We need two axioms to capture LTL.
They are
```
(Lin) * P -> o P for any pattern P
(Inf) * top
```

The following axiom schema is provable from the above two axioms.
```
(Propagation o) o(P /\ Q) = o P /\ o Q
```

_Proof tree_

```
(G) [] (P -> o P) /\ P -> [] P

apply (KT) on (G).  /* we don't need (Plugin) and (Plugout) */

(G-1) [] (P -> o P) /\ P -> [] (P -> o P) /\ P /\ o ([] (P -> o P) /\ P)

apply (Split) on (G-1).

(G-2-1) [] (P -> o P) /\ P -> [] (P -> o P)
(G-2-2) [] (P -> o P) /\ P -> P
(G-2-3) [] (P -> o P) /\ P -> o ([] (P -> o P) /\ P)

apply (DP) on (G-2-1). 

done

apply (DP) on (G-2-2).

done

apply (Propagation o) on (G-2-3).

(G-2-4) [] (P -> o P) /\ P -> o [] (P -> o P) /\ o P

apply (Split) on (G-2-4)

(G-2-5-1) [] (P -> o P) /\ P -> o [] (P -> o P)
(G-2-5-2) [] (P -> o P) /\ P -> o P

apply (Fix) on (G-2-5-1)

(G-2-5-1-1) (P -> o P) /\ o [] (P -> o P) /\ P -> o [] (P -> o P)

apply (DP) on (G-2-5-1-1).

done

apply (Fix) on (G-2-5-2).

(G-2-5-2-1) (P -> o P) /\ o [] (P -> o P) /\ P -> o P

apply (DP) on (G-2-5-2-1).

done
```

### CTL and its proof rules.

The key CTL operators are defined in matching logic as:
```
AX P === o P // strong next
EX P === * P // weak next
P AU Q === mu f . (Q \/ (P /\ o f)) // all-path until
P EU Q === mu f . (Q \/ (P /\ * f)) // one-path until
EF P === mu f . P \/ * f // one-path eventually
AG P === nu f . P /\ o f // all-path always
AF P === mu f . P \/ o f // all-path eventually
EG P === nu f . P \/ * f // one-path always
```

CTL assumes infinite traces, and thus requires the following domain specific axiom
```
(Inf) * top
```

We **may** need a few domain specific axioms to help the prover.
For example,
```
(DualWNext) ! * ! P = o P
(DualSNext) ! o ! P = * P
(Next) o P /\ * Q -> *(P /\ Q)
```

We **may** need two duality rules for fixpoints.
```
(NegLFP) ! (mu f . P) = nu f . ! P [!f / f]
(NegGFP) ! (nu f . P) = mu f . ! P [!f / f]
```

We **may** need a few propositional rules (i.e., (DP)), to canonicalize the patterns. 
```
(DeMorgen) !(P \/ Q) = !P /\ !Q
(DeMorgen) !(P /\ Q) = !P \/ !Q

      Q -> R           /* more generally it should be (P -> Q) /\ P /\ Q -> R
(MP) ------------------------
     (P -> Q) /\ P -> R

           P /\ Q -> R
(NegCase) --------------
           P -> (!Q \/ R)
```

The above rules will help make the proof _human readable_.
But maybe they are not really necessary. 
I used them in my proof, though.

#### (CTL6) `AG(R -> (!Q /\ * R)) /\ R -> !(P AU Q)`

_Proof._

```
(G) AG(R -> (!Q /\ * R)) /\ R -> !(P AU Q)

by definition of P AU Q, this is the same as

(G) AG(R -> (!Q /\ * R)) /\ R -> !(mu f . (Q \/ (P /\ o f)))

apply (NegLFP) on (G).

(G-1) AG(R -> (!Q /\ * R)) /\ R -> nu f . !(Q \/ (P /\ o ! f))

apply (DeMongen) on (G-1).

(G-2) AG(R -> (!Q /\ * R)) /\ R -> nu f . (!Q /\ (!P \/ ! o ! f))

apply (DualWNext) on (G-2).

(G-3) AG(R -> (!Q /\ * R)) /\ R -> nu f . (!Q /\ (!P \/ * f))

apply (KT) on (G-3).

(G-4) AG(R -> (!Q /\ * R)) /\ R
   -> !Q /\ (!P \/ * (AG(R -> (!Q /\ * R)) /\ R)))
   
apply (Split) on (G-4).

(G-4-1) AG(R -> (!Q /\ * R)) /\ R -> !Q
(G-4-2) AG(R -> (!Q /\ * R)) /\ R -> (!P \/ * (AG(R -> (!Q /\ * R)) /\ R)))

apply (Fix) on (G-4-1).

(G-4-1-1) (R -> (!Q /\ *R)) /\ (o AG(R -> (!Q /\ * R))) /\ R -> !Q

apply (DP) on (G-4-1-1).

done

apply (Fix) on (G-4-2).

(G-4-2-1) (R -> (!Q /\ *R)) /\ (o AG(R -> (!Q /\ * R))) /\ R -> (!P \/ * (AG(R -> (!Q /\ * R)) /\ R)))

apply (MP) on (G-4-2-1).

(G-4-2-2) !Q /\ *R /\ (o AG(R -> (!Q /\ * R))) -> (!P \/ * (AG(R -> (!Q /\ * R)) /\ R)))

apply (Next) on (G-4-2-2).

(G-4-2-3) * (R /\ AG(R -> (!Q /\ * R))) -> (!P \/ * (AG(R -> (!Q /\ * R)) /\ R)))

apply (DP) on (G-4-2-3).

done
```

#### (CTL7) `AG(R -> (!Q /\ (P -> o R))) /\ R -> !(P EU Q)`

_Proof_.

```
(G) AG(R -> (!Q /\ (P -> o R))) /\ R -> !(P EU Q)

(G) AG(R -> (!Q /\ (P -> o R))) /\ R -> !(mu f . (Q \/ (P /\ * f)))

apply (NegLFP) on (G).

(G-1) AG(R -> (!Q /\ (P -> o R))) /\ R
   -> nu f . !(Q \/ (P /\ * ! f))
   
apply (DeMongen) on (G-1).

(G-2) AG(R -> (!Q /\ (P -> o R))) /\ R
   -> nu f . (!Q /\ (!P \/ ! * ! f)))
   
apply (NegSNext) on (G-2).

(G-3) AG(R -> (!Q /\ (P -> o R))) /\ R
   -> nu f . (!Q /\ (!P \/ o f)))
   
apply (KT) on (G-1).

(G-2) AG(R -> (!Q /\ (P -> o R))) /\ R
   -> !Q /\ (!P \/ o(AG(R -> (!Q /\ (P -> o R))) /\ R))

apply (Split) on (G-2).

(G-2-1) AG(R -> (!Q /\ (P -> o R))) /\ R -> !Q
(G-2-2) AG(R -> (!Q /\ (P -> o R))) /\ R -> (!P \/ o(AG(R -> (!Q /\ (P -> o R))) /\ R))

apply (Fix) on (G-2-1).

(G-2-1-1) (R -> (!Q /\ (P -> o R))) /\ (o AG(R -> (!Q /\ (P -> o R)))) /\ R -> !Q

apply (DP) on (G-2-1-1).

done

apply (Fix) on (G-2-2).

(G-2-2-1) (R -> (!Q /\ (P -> o R))) /\ (o AG(R -> (!Q /\ (P -> o R)))) /\ R
       -> (!P \/ o(AG(R -> (!Q /\ (P -> o R))) /\ R))
       
apply (MP) on (G-2-2-1).

(G-2-2-2) !Q /\ (P -> o R) /\ (o AG(R -> (!Q /\ (P -> o R))))
       -> (!P \/ o(AG(R -> (!Q /\ (P -> o R))) /\ R))

apply (NegCase) on (G-2-2-2).
(G-2-2-3) !Q /\ (P -> o R) /\ (o AG(R -> (!Q /\ (P -> o R)))) /\ P
       -> o(AG(R -> (!Q /\ (P -> o R))) /\ R)

apply (MP) on (G-2-2-3).

(G-2-2-4) !Q /\ o R /\ (o AG(R -> (!Q /\ (P -> o R))))
       -> o(AG(R -> (!Q /\ (P -> o R))) /\ R)
       
apply (Propagation o) on (G-2-2-4).

(G-2-2-5) !Q /\ o R /\ (o AG(R -> (!Q /\ (P -> o R))))
       -> o(AG(R -> (!Q /\ (P -> o R)))) /\ o R
       
apply (DP).

done
```

### SL `ll@(x,y) * list@(y) -> list@(x)`

_Definitions._

```
ll = mu f . lambda x y . (emp /\ x=y) \/ exists t . (x|->t * f@(t,y) /\ x!=y /\ x!=0)
list = mu f . lambda x . (emp /\ x=0) \/ exists t . (x|->t * f@(t) /\ x!=0)
```

_Propagation rules._

```
(P \/ Q) * H = P * H \/ Q * H, where * is the merge
```

_Proof._
```
(G) ll@(x,y) * list@(y) -> list@(x)

apply (Plugout) on (G).

(G-1) ll -> exists h . h /\ floor(h@(x,y) * list@(y) -> list@(x))

let F === exists h . h /\ floor(h@(x,y) * list@(y) -> list@(x))

apply (Forall) on (G-1).

(G-2) ll -> forall x y . F

apply (KT) on (G-1).

(G-2) lambda x y . (emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)
   -> forall x y . exists h . h /\ floor(h@(x,y) * list@(y) -> list@(x))
   
apply (UG) on (G-2).

(G-3) lambda x y . (emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)
   -> exists h . h /\ floor(h@(x,y) * list@(y) -> list@(x))

apply (Plugin) on (G-3).

(G-4) ((emp /\ x=y) \/ exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)) * list@(y) -> list@(x)

apply (Propagation) on (G-4).

(G-5) ((emp /\ x=y) * list@(y)) \/ (exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)) * list@(y) -> list@(x)

apply (Split) on (G-5).

(G-5-1) list@(y) /\ x=y -> list@(x)
(G-5-2) (exists t . (x|->t * (forall x y . F)@(t,y) /\ x!=y /\ x!=0)) * list@(y) -> list@(x)

apply (DP) on (G-5-1).

done

apply (Exists) on (G-5-2).

(G-5-3) x|->t * (forall x y . F)@(t,y) * list@(y) /\ x!=y /\ x!=0  -> list@(x)

apply (Inst, forall x y . F, x=t, y=y) on (G-5-3).

(G-5-4) x|->t * (F[t/x][y/y])@(t,y) * list@(y) /\ x!=y /\ x!=0  -> list@(x)

expand F.

(G-5-4) x|->t * (exists h . h /\ floor(h@(t,y) * list@(y) -> list@(t)))@(t,y) * list@(y) /\ x!=y /\ x!=0  -> list@(x)

apply (Collapse) on (G-5-4).

(G-5-5) x|->t * list@(t) /\ x!=y /\ x!=0 -> list@(x)

apply (Fix) on (G-5-5). 

...
```

## Some coinduction examples

_TODO._

## Some program verification examples

_TODO._

## Proof rules

### The fragment, the syntax

The following syntax is chosen so that a very wide range of
interesting problems, including `ll@(x,y) -> lr@(x,y)` and
`[] (P -> o P) /\ P -> [] P`, can be encoded using the syntax.

**Please see `fix.maude` for all definitions.**

```
Variable ::= x | y | z | ...
Pattern  ::= Variable
           | Pattern "/\" Pattern
           | Pattern "\/" Pattern
           | Pattern "->" Pattern
           | "not" Pattern
           | forall VariableList "." Pattern
           | exists VariableList "." Pattern
           | lambda VariableList "." Pattern     /* lambda abstraction */
           | Pattern "@" "(" PatternList ")"     /* function application */
           | mu Variable "." Pattern             /* lfp */
           | nu Variable "." Pattern             /* gfp */
           | floor "(" Pattern ")"               /* totality */
           /* extendable user-defined domain specific syntax (known as the shallow embedding) */
           /* for infinite-trace LTL */
           | "o" Pattern         /* next */
           | "[]" Pattern        /* always */
           | "<>" Pattern        /* eventually */
           | Pattern "U" Pattern /* until */
           /* for separation logic */
           | "emp"
           | Pattern "|->" Pattern
           | Pattern "*" Pattern
           | "ll"
           | "lr"
```

### Proof rules

```
/* Basic Propositional reasoning */

P -> P1  P -> P2  ...  P -> Pn
------------------------------- (/\-IntroR)
P -> P1 /\ P2 /\ ... /\ Pn

P -> Pi
-------------------------------- (\/-IntroR)
P -> P1 \/ P2 \/ ... \/ Pn

P1 -> P ... Pn -> P
-------------------------------- (\/-IntroL)
P1 \/ ... \/ Pn -> P


Pi -> P
-------------------------------- (/\-IntroL)
P1 /\ ... /\ Pn -> P

/* Basic FOL reasoning */

P -> Q                 if x not in FV(P)
---------------------- (UG) // universal generalization
P -> forall x . Q

P -> Q[t/x]            if x not in FV(P) and t is a term
---------------------- (exists-IntroR) // t is often obtained from unifying P and Q
P -> exists x . Q

forall x . P /\ P[t/x] -> Q   if t is a term
----------------------------  (forall-InstL) // instantiate forall x . P
forall x . P -> Q

/* Equations */

An equation lhs = rhs means that one can substitute lhs
for rhs in any context. 

(Fix-LFP) mu x . e = e[mu x . e / x]  // least fixpoint

(Fix-GFP) nu x . e = e[nu x . e / x]  // greatest fixpoint

e[e'/x] -> e'
--------------- (KT-LFP)
mu x . e -> e'

e' -> e[e'/x]
--------------- (KT-GFP)
e' -> nu x . e

P -> C'[Q]   where C'[Q] === exists x . x /\ floor(C[x] -> Q)
-------------(PlugoutL)
C[P] -> Q

C[P] -> Q    where C'[Q] === exists x . x /\ floor(C[x] -> Q)
-------------(PluginL)
P -> C'[Q]

C[C'[P]] -> Q where C'[Q] === exists x . x /\ floor(C[x] -> Q)
------------- (CollapseL)
P -> Q

C'[P] -> Q   where C'[P] === exists x . x /\ floor(P -> C[x])
-------------(PlugoutR)
P -> C[Q]

P -> C[Q]    where C'[P] === exists x . x /\ floor(P -> C[x])
-------------(PluginR)
C'[P] -> Q

P -> C[C'[Q]] where C'[P] === exists x . x /\ floor(P -> C[x])
------------- (CollapseR)
P -> Q

```

# All in CLPR

## Main rules: (WRAP), (KT), (UNWRAP)

```
========   All proof rules for LFP (flag=false) =======
 (QE) Quantifier elimination
 (DP) Direct proof
 (PM) Pattern matching
(FIX) Right unfold only
(LFP) A compound rule
========   All proof rules for GFP (flag=true) =========
 (QE) Quantifier elimination
 (DP) Direct proof
 (PM) Pattern matching
(FIX) Left unfold only
(GFP) A compound rule
========== An application of LFP rule in the search tree =========
Given LHS |= RHS
Given P(y1,yn) ≡ B \/ ∃z1,zn: P(z1,zn)/\...
               ≡ B \/ R (for short)
foreach recursive predicate P on the lhs:
    (WRAP)             to have P |= ∃F:  F & floor(LHS[F/P] => RHS)
                               P |= G (for short)                                    
    (RIGHT-STRENGTHEN) to have P |= forall x1,xn: G   // Choose such x1,xn that after (QE) we have G
    (KT)               to have B \/ R[forall x1,xn: G / P] |= forall x1,xn: G
    (QE)               to have B \/ R[forall x1,xn: G / P] |= G
    (UNWRAP)           to have LHS[B \/ R[forall x1,xn: G / P] /P] |= RHS
    
    prove for all disjuncts on the lhs
```

## How to apply (KT) in clpr syntax?

```
Given a proof obligation p(x) /\ C(x,y) -> psi(x,y).
Here x and y are vectors of variables
and p is a recursive predicate.
C(x,y) is whatever left on the lhs, and psi(x,y) is the rhs.

What's important is that here all formulas are in fact FOL formulas
(either true or false).
In other words, they are predicate patterns in matching logic
(either the empty set or the total set).
This greatly simplifies the application of KT.
In particular, it simplifies (Plugin) and (Plugout) A LOT.

Given the definition of P:
  p(x) ≡ ... \/ exists z . D(x,z) /\ p(z) \/ ....
Here z is a vector of variables. Notice that x and z 
may not be disjoint. 

Here's how we apply KT in matching logic.

(1) p(x) /\ C(x,y) -> psi(x,y)

/* (Plugout) and (Forall) */

(2) p(x) -> forall y . (C(x,y) -> psi(x,y))

/* apply KT */

(3) ... \/ exists z . D(x,z) /\ forall y . (C(z,y) -> psi(z,y)) \/ ...
  -> forall y . (C(x,y) -> psi(x,y))
  
/* this is just one case */

(4) exists z . D(x,z) /\ forall y . (C(z,y) -> psi(z,y))
  -> forall y . (C(x,y) -> psi(x,y))

/* (Plugin) and (UG) */

(5) D(x,z) /\ forall y . (C(z,y) -> psi(z,y)) /\ C(x,y) -> psi(x,y)

QUESTION: HOW TO DEAL WITH (5)?

IDEA: move forall y . (C(z,y) -> psi(z,y)) to the axiom set:

(6) { forall y . (C(z,y) -> psi(z,y)) }
    |- D(x,z) /\ C(x,y) -> psi(x,y)

The effect of the axiom forall y . (C(z,y) -> psi(z,y)) is that
whenever we see C(z,y0) on the lhs, for some y0,
we can strengthen the lhs by adding psi(z,y0) to it.

@Thai: How similar is this to the LU+Ind rules? And is the above
idea reasonably implementable?
```


## Some examples of using the clpr syntax

### `mul4(X) -> even(X)`

_Definitions._

```
unfold(mul4(X),
  [
  body([], [eq(X, 0)]),
  body([mul4(Y)],
       [gt(X, 0), eq(X, plus(Y, 4))])
  ]).

unfold(even(X),
  [
  body([], [eq(X, 0)]),
  body([even(Y)],
       [gt(X, 0), eq(X, plus(Y, 2))])
  ]).
```

_Proof._

```

(1) mul4(X) -> even(X)

apply (KT) on (1) /* no need for (Plugin) and (Plugout) for this example */

proof rule (KT) is
  goto the definition of mult4
  for every body B in the definition of mult4:
    let B' = substitute mult4(Y) for even(Y) in B
    generate a new obligation B' -> even(X)

(2-1) X=0 -> even(X)
(2-2) even(Y) /\ X>0 /\ X=Y+4 -> even(X)

apply (RU) on (2-1). done.

apply (RU) on (2-2).

(3) even(Y) /\ X>0 /\ X=Y+4 -> even(Y') /\ X>0 /\ X=Y'+2

apply (RU) on (3).

(4) even(Y) /\ X>0 /\ X=Y+4 -> even(Y'') /\ Y'>0 /\ Y''=Y'+2 /\ X>0 /\ X=Y'+2

apply (DP) on (4).
```


### `ll(H,X,Y,F) -> lr(H,X,Y,F)`

_Definitions._
```
unfold(ll(H,X,Y,F),
  [
  body([], [eq(X,Y), eqset(F,emptyset)]),
  body([ll(H,T,Y,F1)],
       [gt(X, 0),
        z3_not(eq(X, Y)),
        eq(T, ref(H, X)),
        z3_not(mem(X, F1)),
        eqset(F, add(F1, X))])
  ]).

% list segment recursively defined from the right
unfold(lr(H,X,Y,F),
  [
  body([], [eq(X,Y), eqset(F,emptyset)]),
  body([lr(H,X,T,F1)],
       [gt(X, 0),
        z3_not(eq(X, Y)),
        eq(Y, ref(H, T)),
        z3_not(mem(T, F1)),
        eqset(F, add(F1, T))])
  ]).
```

_Proof._
```
(1) ll(H,X,Y,F) -> lr(H,X,Y,F)

/* apply KT */

KT Step 1. Identify the unfoldable on the LHS.
  In this case, it's ll(H,X,Y,F).
KT Step 2. Unfold it.
  In this case, we obtain two bodies.
  body A. X=Y /\ F=emptyset
  body B. ll(H,T,Y,F1) /\ X!=0 /\ X!=Y /\ T=H[X] /\ F1=F\{X}
  Notice that in body B, T and F1 must be fresh.
KT Step 3. If a body contains no ll, generate a new proof obligation.
  In this case, we obtain a new proof obligation for body A.
  X=Y /\ F=emptyset -> lr(H,X,Y,F)
KT Step 4. If a body contains ll, carry out substitution.
  Identify the ll formula in the body. In this case, it's ll(H,T,Y,F1).
  Construct the substitution
    sigma = { (H,H), (X,T), (Y,Y), (F,F1) }.
  Apply sigma on the RHS. We obtain
    lr(H,T,Y,F1).
  Generate proof obligation
    lr(H,T,Y,F1) /\ X!=0 /\ X!=Y /\ T=H[X] /\ F1=F\{X} -> lr(H,X,Y,F) 

/* KT application finished. */

(2) X=Y /\ F=emptyset -> lr(H,X,Y,F)  /* can be proved by RU */

(3) lr(H,T,Y,F1) /\ X!=0 /\ X!=Y /\ T=H[X] /\ F1=F\{X} -> lr(H,X,Y,F) 

apply RU on (3).

(4) lr(H,T,Y,F1) /\ X!=0 /\ X!=Y /\ T=H[X] /\ F1=F\{X} 
 -> lr(H,X,T',F1') /\ X!=0 /\ X!=Y /\ Y=H[T'] /\ F1'=F\{T}

simplify (4).

(5) lr(H,T,Y,F1) /\ X!=0 /\ X!=Y /\ T=H[X] /\ F1=F\{X} 
 -> lr(H,X,T',F1') /\ Y=H[T'] /\ F1'=F\{T}

/* apply KT */

KT Step 1. Identify the unfoldable on the LHS.
  In this case, it's lr(H,T,Y,F1).
KT Step 2. Unfold it.
  In this case, we obtain two bodies.
  body A. T=Y /\ F1=emptyset
  body B. lr(H,T,T'',F1'') /\ T!=0 /\ T!=Y /\ Y=H[T''] /\ F1''=F1\{T''}
  Notice that in body B, T'' and F1'' must be fresh.
KT Step 3. If a body contains no ll, generate a new proof obligation.
  In this case, we obtain a new proof obligation for body A.
  T=Y /\ F1=emptyset /\ X!=0 /\ X!=Y /\ T=H[X] /\ F1=F\{X}
  -> lr(H,X,T',F1') /\ Y=H[T'] /\ F1'=F\{T}
KT Step 4. If a body contains ll, carry out substitution.
  Identify the ll formula in the body. In this case, it's ll(H,T,Y,F1).
  Construct the substitution
    sigma = { (H,H), (X,T), (Y,Y), (F,F1) }.
  Apply sigma on the RHS. We obtain
    lr(H,T,Y,F1).
  Generate proof obligation
    lr(H,T,Y,F1) /\ X!=0 /\ X!=Y /\ T=H[X] /\ F1=F\{X} -> lr(H,X,Y,F) 



```
