# The fixpoint prover.

## Todos
- [ ] Define the fragment of ML;
- [ ] Finish the example `ll(x,y) -> lr(x,y)` using explicit (Plugin) and (Plugout) rule;
- [ ] Finish the general KT rule (how to deal with free variables?);
- [ ] Collect other proof rules (for the fragment);
- [ ] Implement `ll(x,y) -> lr(x,y)` (as a user story);

# Instruction

To use clpr, add the following to your `~/.bashrc` and
re-open the terminal.

```
PATH={current_path}/clpr:{current_path}/clpr/z3/bin/:$PATH
export PATH
LD_LIBRARY_PATH={current_path}/clpr/z3/lib/:/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
export CLPRLIB={current_path}/clpr
export CLPR_BASE_PATH={current_path}/clpr
```

# An example: `ll(x,y) -> lr(x,y)`

## Purpose

Demonstrate a set of proof rules that power fixpoint reasoning.
Eluminate strategies in how to apply these proof rules.
Identify a fragment that is rich enough to express interesting
properties, while simple enough to implement proof rules on them.

Roughly speaking the fragment considers implication of the form
```t /\ C1 /\ ... /\ Cn -> t' /\ C'1 /\ ... /\ C'n```
where `t` and `t'` are terms (or partial terms) and
`Ci`,`C'i` are predicate patterns.

## Fixpoint definitions.

```
ll(x,y) =lfp emp /\ x=y \/ exists t . x|->t * ll(t,y) /\ x!=0 /\ x!=y
lr(x,y) =lfp emp /\ x=y \/ exists t . lr(x,t) * t|->y /\ x!=0 /\ x!=y
```

The notation `lhs =lfp =rhs` is just a compact way to declare a symbol
and define two axioms for it, (Fix) and (KT).

## Proof obligation.

```
ll(x,y) -> lr(x,y)
```

## Proof.

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

