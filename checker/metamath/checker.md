```
I bet you don't understand me.
```

```mm
$c
  #TokenSequence
$.

$v
  ts
  ts1
  ts2
  ts3
$.

vts  $f #TokenSequence ts  $.
vts1 $f #TokenSequence ts1 $.
vts2 $f #TokenSequence ts2 $.
vts3 $f #TokenSequence ts3 $.
```

```
These are predicates on `#TokenSequence`.
```

```mm
$c 
  #Pattern 
  #ElementVariable 
  #SetVariable 
  #NoNegativeOccurrence 
  #NoPositiveOccurrence 
  #NoFreeOccurrence
  #NestedInApplicationOnly 
  #Eq
  |-
$. 
```

```
We axiomatize `#Eq` to be a congruence relation on `#TokenSequence`.
```

```mm
axeqr $a #Eq ts ts $.

{
  axeqs.1 $e #Eq ts1 ts2 $.
  axeqs   $a #Eq ts2 ts1 $.
}

{
  axeqt.1 $e #Eq ts1 ts2 $.
  axeqt.2 $e #Eq ts2 ts3 $.
  axeqt   $a #Eq ts1 ts3 $.
}
```

```
We define the basic matching logic constructs as tokens, one per line.
These constructs exist in all matching logic theories.
We are not trying to be minimal here, at least for now.
Therefore, we include all the common constructs.
Note that `\mu` builds least fixpoints and `\nu` builds greatest fixpoints.
We need to define the parentheses as tokens, too. 
```

```mm
$c
  \top 
  \bottom
  \and
  \or
  \implies
  \iff
  \not
  \app
  \exists
  \forall
  \mu
  \nu 
  ( 
  ) 
$.
```

```
We define meta-variables of patterns, element variables, and set variables.
```

```mm
$v
  ph
  ph1
  ph2
  ph3
  ps
  x 
  x1 
  x2 
  x3
  y
  sx 
  sx1 
  sx2 
  sx3
  sy
$.
```

```
We define the ranges of the above meta-variables.
```

```mm
vph    $f #Pattern         ph  $.
vph1   $f #Pattern         ph1 $.
vph2   $f #Pattern         ph2 $.
vph3   $f #Pattern         ph3 $.
vps    $f #Pattern         ps  $.
vx     $f #ElementVariable x   $.
vx1    $f #ElementVariable x1  $.
vx2    $f #ElementVariable x2  $.
vx3    $f #ElementVariable x3  $.
vy     $f #ElementVariable y   $.
vsx    $f #SetVariable     sx  $.
vsx1   $f #SetVariable     sx1 $.
vsx2   $f #SetVariable     sx2 $.
vsx3   $f #SetVariable     sx3 $.
vsy    $f #SetVariable     sy  $.
```

```rest

$c #NoNegativeOccurrence #NoPositiveOccurrence #NoFreeOccurrence
   #NestedInApplicationOnly #Substitution $.    

wv $a #Pattern xX $. 
wb $a #Pattern \bot $.
wi $a #Pattern ( \imp ph ps ) $.
wa $a #Pattern ( \app ph ps ) $.
we $a #Pattern ( \ex x ph ) $.
${ wm.1 $e #NoNegativeOccurrence X ph $.
   wm   $a #Pattern ( \mu X ph ) $.
$}

wev $p #Pattern x $=
  vx vev wv $.
wsv $p #Pattern X $=
  vX vsv wv $.

nnv $a #NoNegativeOccurrence xX yY $.
nns $a #NoNegativeOccurrence xX sg $.
nnb $a #NoNegativeOccurrence xX \bot $.
${  nni.1 $e #NoPositiveOccurrence xX ph $.
    nni.2 $e #NoNegativeOccurrence xX ps $.
    nni   $a #NoNegativeOccurrence xX ( \imp ph ps ) $.
$}
${  nna.1 $e #NoNegativeOccurrence xX ph $.
    nna.2 $e #NoNegativeOccurrence xX ps $.
    nna   $a #NoNegativeOccurrence xX ( \app ph ps ) $.
$}
${  nne.1 $e #NoNegativeOccurrence xX ph $.
    nne   $a #NoNegativeOccurrence xX ( \ex x ph ) $.
$}
${  nnm.1 $e #NoNegativeOccurrence xX ph $.
    nnm   $a #NoNegativeOccurrence xX ( \mu Y ph ) $.
$}
${  $d xX yY $.
    npv $a #NoPositiveOccurrence xX yY $.
$}
nps $a #NoPositiveOccurrence xX sg $.
npb $a #NoPositiveOccurrence xX \bot $.
${  npi.1 $e #NoNegativeOccurrence xX ph $.
    npi.2 $e #NoPositiveOccurrence xX ps $.
    npi   $a #NoPositiveOccurrence xX ( \imp ph ps ) $.
$}
${  npa.1 $e #NoPositiveOccurrence xX ph $.
    npa.2 $e #NoPositiveOccurrence xX ps $.
    npa   $a #NoPositiveOccurrence xX ( \app ph ps ) $.
$}
${ npe.1 $e #NoPositiveOccurrence xX ph $.
   npe   $a #NoPositiveOccurrence xX ( \ex x ph ) $.
$}
${  npm.1 $e #NoPositiveOccurrence xX ph $.
    npm   $a #NoPositiveOccurrence xX ( \mu Y ph ) $.
$}

${  $d xX yY $.
    nfv $a #NoFreeOccurrence xX yY $.
$}
nfs $a #NoFreeOccurrence xX sg $.
nfb $a #NoFreeOccurrence xX \bot $.
${  nfi.1 $e #NoFreeOccurrence xX ph $.
    nfi.2 $e #NoFreeOccurrence xX ps $.
    nfi   $a #NoFreeOccurrence xX ( \imp ph ps ) $.
$}
${  nfa.1 $e #NoFreeOccurrence xX ph $.
    nfa.2 $e #NoFreeOccurrence xX ps $.
    nfa   $a #NoFreeOccurrence xX ( \app ph ps ) $.
$}
nfe_1 $a #NoFreeOccurrence x ( \ex x ph ) $.
${  $d xX y $.
    nfe_2.1 $e #NoFreeOccurrence xX ph $.
    nfe_2   $a #NoFreeOccurrence xX ( \ex y ph ) $.
$}
nfm_1 $a #NoFreeOccurrence X ( \mu X ph ) $.
${  $d xX Y $.
    nfm_2.1 $e #NoFreeOccurrence xX ph $.
    nfm_2   $a #NoFreeOccurrence xX ( \ex Y ph ) $.
$}

ap  $a #NestedInApplicationOnly xX xX $.
${  apl.1 $e #NestedInApplicationOnly xX ph $.
    apl.2 $e #NoFreeOccurrence xX ps $.
    apl   $a #NestedInApplicationOnly xX ( \app ph ps ) $.
$}
${  apr.1 $e #NestedInApplicationOnly xX ps $.
    apr.2 $e #NoFreeOccurrence xX ph $.
    apr   $a #NestedInApplicationOnly xX ( \app ph ps ) $.
$}

sb  $a #Substitution ph xX ph xX $.
${  $d xX yY $.
    sbv $a #Substitution yY yY ph xX $.
$}
sbs $a #Substitution sg sg ph xX $.
sbb $a #Substitution \bot \bot ph xX $.
${  sbi.1 $e #Substitution ph1 ph3 ph xX $.
    sbi.2 $e #Substitution ph2 ph4 ph xX $.
    sbi   $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph xX $.
$}
${  sba.1 $e #Substitution ph1 ph3 ph xX $.
    sba.2 $e #Substitution ph2 ph4 ph xX $.
    sba   $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph xX $.
$}
sbe_1 $a #Substitution ( \ex x ps ) ( \ex x ps ) ph x $.
${  $d x xX $. $d z ph $.
    sbe_2.1 $e #Substitution ph1 ps z x $.    $( ph1 = ps[z/x] $)
    sbe_2.2 $e #Substitution ph2 ph1 ph xX $. $( ph2 = ph1[ph/xX] $)
    sbe_2   $a #Substitution ( \ex z ph2 ) ( \ex x ps ) ph xX $.
$}
sbm_1 $a #Substitution ( \mu X ps ) ( \mu X ps ) ph X $.
${  $d Y xX $. $d Z ph $.
    sbm_2.1 $e #Substitution ph1 ps Z X $.    $( ph1 = ps[Z/X] $)
    sbm_2.2 $e #Substitution ph2 ph1 ph xX $. $( ph2 = ph1[ph/xX] $)
    sbm_2   $a #Substitution ( \mu Z ph2 ) ( \mu X ps ) ph xX $.
$}

$c |- $.

pr-1 $a |- ( \imp ph1 ( \imp ph2 ph1 ) ) $.
pr-2 $a |- ( \imp ( \imp ph1 ( \imp ph2 ph3 ) )
                  ( \imp ( \imp ph1 ph2 ) ( \imp ph1 ph3 ) ) ) $.
pr-3 $a |- ( \imp ( \imp ( \imp ph \bot ) \bot ) ph ) $.
${  pr-mp.1   $e |- ps $.
    pr-mp.2   $e |- ( \imp ps ph ) $.
    pr-mp     $a |- ph $.
$}
${  pr-ei.1 $e #Substitution ph1 ph2 y x $.
    pr-ei   $a |- ( \imp ph1 ( \ex x ph2 ) ) $.
$}
${  pr-eg.1 $e |- ( \imp ph1 ph2 ) $.
    pr-eg.2 $e #NoFreeOccurrence x ph2 $.
    pr-eg   $a |- ( \imp ( \ex x ph1 ) ph2 ) $.
$}
pr-pbl $a |- ( \imp ( \app \bot ph ) \bot ) $.
pr-pbr $a |- ( \imp ( \app ph \bot ) \bot ) $.
pr-pdl $a |- ( \imp ( \app ( \imp ( \imp ph1 \bot ) ph2 ) ph3 )
               ( \imp ( \imp ( \app ph1 ph3 ) \bot ) ( \app ph2 ph3 ) ) ) $.
pr-pdr $a |- ( \imp ( \app ph3 ( \imp ( \imp ph1 \bot ) ph2 ) )
               ( \imp ( \imp ( \app ph3 ph1 ) \bot ) ( \app ph3 ph2 ) ) ) $.
${  pr-pel.1 $e #NoFreeOccurrence x ph2 $.
    pr-pel   $a |- ( \imp ( \app ( \ex x ph1 ) ph2 )
                     ( \ex x ( \app ph1 ph2 ) ) ) $.
$}
${  pr-per.1 $e #NoFreeOccurrence x ph2 $.
    pr-per   $a |- ( \imp ( \app ph2 ( \ex x ph1 ) )
                     ( \ex x ( \app ph2 ph1 ) ) ) $.
$}
${  pr-fml.1 $e |- ( \imp ph1 ph2 ) $.
    pr-fml   $a |- ( \imp ( \app ph1 ph3 ) ( \app ph2 ph3 ) ) $.
$}
${  pr-fmr.1 $e |- ( \imp ph1 ph2 ) $.
    pr-fmr   $a |- ( \imp ( \app ph3 ph1 ) ( \app ph3 ph2 ) ) $.
$}
${  pr-ss.1 $e |- ph2 $.
    pr-ss.2 $e #Substitution ph1 ph2 ph3 Y $.
    pr-ss   $a |- ph1 $.
$}
${  pr-pf.1 $e #Substitution ph2 ph1 ( \mu X ph1 ) X $.
    pr-pf   $a |- ( \imp ph2 ( \mu X ph1 ) ) $.
$}
${  pr-kt.1 $e |- ( \imp ph3 ph2 ) $.
    pr-kt.2 $e #Substitution ph3 ph1 ph2 X $.
    pr-kt   $a |- ( \imp ( \mu X ph1 ) ph2 ) $.
$}

pr-e $a |- ( \ex x x ) $.
${  pr-s.1 $e #NestedInApplicationOnly xX ph1 $.
    pr-s.2 $e #NestedInApplicationOnly xX ph2 $.
    pr-s.3 $e #Substitution ph3 ph1 ( \imp ( \imp x ( \imp ph \bot ) ) \bot ) xX $.
    pr-s.4 $e #Substitution ph4 ph2 ( \imp ( \imp x ph               ) \bot ) xX $.
    pr-s   $a |- ( \imp ph3 ( \imp ph4 \bot ) ) $.
$}

$c #Equal $. 

eq $a #Equal ph1 ph1 $.
${  eqi.1 $e #Equal ph1 ph3 $.
    eqi.2 $e #Equal ph2 ph4 $.
    eqi   $a #Equal ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) $.
$}
${  eqa.1 $e #Equal ph1 ph3 $.
    eqa.2 $e #Equal ph2 ph4 $.
    eqa   $a #Equal ( \app ph1 ph2 ) ( \app ph3 ph4 ) $.
$}
${  eqe.1 $e #Equal ph ps $.
    eqe   $a #Equal ( \ex x ph ) ( \ex x ps ) $.
$}
${  eqm.1 $e #Equal ph ps $.
    eqm   $a #Equal ( \mu X ph ) ( \mu X ps ) $.
$}
${  eqnn.1 $e #Equal ph ps $.
    eqnn.2 $e #NoNegativeOccurrence xX ps $.
    eqnn   $a #NoNegativeOccurrence xX ph $.
$}
${  eqnp.1 $e #Equal ph ps $.
    eqnp.2 $e #NoPositiveOccurrence xX ps $.
    eqnp   $a #NoPositiveOccurrence xX ph $.
$}
${  eqnf.1 $e #Equal ph ps $.
    eqnf.2 $e #NoFreeOccurrence xX ps $.
    eqnf   $a #NoFreeOccurrence xX ph $.
$}
${  eqsb.1 $e #Equal ph1 ph3 $.
    eqsb.2 $e #Equal ph2 ph4 $.
    eqsb.3 $e #Equal ph ps $.
    eqsb.4 $e #Substitution ps ph3 ph4 xX $.
    eqsb   $a #Substitution ph ph1 ph2 xX $.
$}
${  eqap.1 $e #Equal ph ps $.
    eqap.2 $e #NestedInApplicationOnly xX ps $.
    eqap   $a #NestedInApplicationOnly xX ph $.
$}
${  eqp.1 $e #Equal ph ps $.
    eqp.2 $e |- ps $.
    eqp   $a |- ph $.
$}

$( 
    END OF PROOF CHECKER
$)
```
