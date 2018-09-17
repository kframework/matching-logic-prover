The fixpoint prover.

Instruction

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

An example: `ll(x,y) -> lr(x,y)`

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

wip

```

