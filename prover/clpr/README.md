# The fixpoint prover.

## Todos
- [ ] Define the fragment of ML
- [ ] Finish the example `ll(x,y) -> lr(x,y)`
- [ ] Finish the general KT rule (how to deal with free variables?)
- [ ] Collect other proof rules (for the fragment)
- [ ] Implement `ll(x,y) -> lr(x,y)` (as a user story)

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

Recursive definitions.

```
ll(x,y) =lfp emp /\ x=y \/ exists t . x|->t * ll(t,y) /\ x!=0 /\ x!=y
lr(x,y) =lfp emp /\ x=y \/ exists t . lr(x,t) * t|->y /\ x!=0 /\ x!=y
```

Proof.

```
(G). ll(x,y) -> lr(x,y)

apply (KT) on (G).

(G-1). emp /\ x=y -> lr(x,y)
(G-2). x|->t * lr(t,y) /\ x!=0 /\ x!=y -> lr(x,y)

apply(RU, case=1) on (G-1).

(G-1-1). emp /\ x=y -> emp /\ x=y

apply (DP) on (G-1-1).

done

apply (KT) on (G-2).

/* this might be wrong. double-check! */

(G-2-1). x|->t * (emp /\ t=y) /\ x!=0 /\ x!=y -> lr(x,y)
(G-2-2). x|->t * (lr(t,t') * t'|->y /\ t!=0 /\ t!=y) /\ x!=0 /\ x!=y -> lr(x,y)

apply (Simplification) on (G-2-1).

(G-2-1-1). x|->t /\ t=y /\ x!=0 /\ x!=y -> lr(x,y)

apply (RU, case=2) on (G-2-1-1).

(G-2-1-2). x|->t /\ t=y /\ x!=0 /\ x!=y -> lr(x,t') * t'|->y /\ x!=0 /\ x!=y

apply (RU, case=1) on (G-2-1-2).

(G-2-1-3). x|->t /\ t=y /\ x!=0 /\ x!=y -> (emp /\ x=t') * t'|->y /\ x!=0 /\ x!=y

apply (Simplification) on (G-2-1-3).

(G-2-1-4). x|->t /\ t=y /\ x!=0 /\ x!=y -> emp * t'|->y /\ x!=0 /\ x!=y /\ x=t'

apply (DP) on (G-2-1-4).

done

apply (Simplification) on (G-2-2).

(G-2-2-1). x|->t * lr(t,t') * t'|->y /\ t!=0 /\ t!=y /\ x!=0 /\ x!=y -> lr(x,y)

apply (RU, case=2) on (G-2-2-1).

(G-2-2-1). x|->t * lr(t,t') * t'|->y /\ t!=0 /\ t!=y /\ x!=0 /\ x!=y -> lr(x,t'') * t''|->y /\ x!=0 /\ x!=y

apply (RU



```

