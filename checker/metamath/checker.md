```
Matching Logic Proof Object
```

```mm
$c \bot \imp \app \ex \mu ( ) $.   
$c #Pattern #ElementVariable #SetVariable #Symbol #Variable $. 
$v ph ps ph1 ph2 ph3 ph4 ph5 ph6 x y z X Y Z sg sg1 sg2 xX yY $.

vph  $f #Pattern ph $.
vps  $f #Pattern ps $.
vph1 $f #Pattern ph1 $.
vph2 $f #Pattern ph2 $.
vph3 $f #Pattern ph3 $.
vph4 $f #Pattern ph4 $.
vph5 $f #Pattern ph5 $.
vph6 $f #Pattern ph6 $.
vx   $f #ElementVariable x $.
vy   $f #ElementVariable y $.
vz   $f #ElementVariable z $.
vX   $f #SetVariable X $.
vY   $f #SetVariable Y $.
vZ   $f #SetVariable Z $.
vsg  $f #Symbol sg $.
vsg1 $f #Symbol sg1 $.
vsg2 $f #Symbol sg2 $.
vxX  $f #Variable xX $.
vyY  $f #Variable yY $.
vev  $a #Variable x $.
vsv  $a #Variable X $.

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

```
Reachability Proof
```

```mm
$c \rewrites $.
pattern-rewrites $a #Pattern ( \rewrites ph ps ) $.

${ rewrites-transitivity.1 $e |- ( \rewrites ph1 ph2 ) $.
   rewrites-transitivity.2 $e |- ( \rewrites ph2 ph3 ) $.
   rewrites-transitivity   $a |- ( \rewrites ph1 ph3 ) $.
$}
```

```
The following reachability proof is automatically generated by `./kgenerator reachability-proof`. 
```

```mm
$c
  cfg-0
  cfg-1
  cfg-2
  cfg-3
  cfg-4
  cfg-5
  cfg-6
  cfg-7
  cfg-8
  cfg-9
  cfg-10
  cfg-11
  cfg-12
  cfg-13
  cfg-14
  cfg-15
  cfg-16
  cfg-17
  cfg-18
  cfg-19
  cfg-20
  cfg-21
  cfg-22
  cfg-23
  cfg-24
  cfg-25
  cfg-26
  cfg-27
  cfg-28
  cfg-29
  cfg-30
  cfg-31
  cfg-32
  cfg-33
  cfg-34
  cfg-35
  cfg-36
  cfg-37
  cfg-38
  cfg-39
  cfg-40
  cfg-41
  cfg-42
  cfg-43
  cfg-44
  cfg-45
  cfg-46
  cfg-47
  cfg-48
  cfg-49
  cfg-50
  cfg-51
  cfg-52
  cfg-53
  cfg-54
  cfg-55
  cfg-56
  cfg-57
  cfg-58
  cfg-59
  cfg-60
  cfg-61
  cfg-62
  cfg-63
  cfg-64
  cfg-65
  cfg-66
  cfg-67
  cfg-68
  cfg-69
  cfg-70
  cfg-71
  cfg-72
  cfg-73
  cfg-74
  cfg-75
  cfg-76
  cfg-77
  cfg-78
  cfg-79
  cfg-80
  cfg-81
  cfg-82
  cfg-83
  cfg-84
  cfg-85
  cfg-86
  cfg-87
  cfg-88
  cfg-89
  cfg-90
  cfg-91
  cfg-92
  cfg-93
  cfg-94
  cfg-95
  cfg-96
  cfg-97
  cfg-98
  cfg-99
  cfg-100
$.
pattern-cfg-0 $a #Pattern cfg-0 $.
pattern-cfg-1 $a #Pattern cfg-1 $.
pattern-cfg-2 $a #Pattern cfg-2 $.
pattern-cfg-3 $a #Pattern cfg-3 $.
pattern-cfg-4 $a #Pattern cfg-4 $.
pattern-cfg-5 $a #Pattern cfg-5 $.
pattern-cfg-6 $a #Pattern cfg-6 $.
pattern-cfg-7 $a #Pattern cfg-7 $.
pattern-cfg-8 $a #Pattern cfg-8 $.
pattern-cfg-9 $a #Pattern cfg-9 $.
pattern-cfg-10 $a #Pattern cfg-10 $.
pattern-cfg-11 $a #Pattern cfg-11 $.
pattern-cfg-12 $a #Pattern cfg-12 $.
pattern-cfg-13 $a #Pattern cfg-13 $.
pattern-cfg-14 $a #Pattern cfg-14 $.
pattern-cfg-15 $a #Pattern cfg-15 $.
pattern-cfg-16 $a #Pattern cfg-16 $.
pattern-cfg-17 $a #Pattern cfg-17 $.
pattern-cfg-18 $a #Pattern cfg-18 $.
pattern-cfg-19 $a #Pattern cfg-19 $.
pattern-cfg-20 $a #Pattern cfg-20 $.
pattern-cfg-21 $a #Pattern cfg-21 $.
pattern-cfg-22 $a #Pattern cfg-22 $.
pattern-cfg-23 $a #Pattern cfg-23 $.
pattern-cfg-24 $a #Pattern cfg-24 $.
pattern-cfg-25 $a #Pattern cfg-25 $.
pattern-cfg-26 $a #Pattern cfg-26 $.
pattern-cfg-27 $a #Pattern cfg-27 $.
pattern-cfg-28 $a #Pattern cfg-28 $.
pattern-cfg-29 $a #Pattern cfg-29 $.
pattern-cfg-30 $a #Pattern cfg-30 $.
pattern-cfg-31 $a #Pattern cfg-31 $.
pattern-cfg-32 $a #Pattern cfg-32 $.
pattern-cfg-33 $a #Pattern cfg-33 $.
pattern-cfg-34 $a #Pattern cfg-34 $.
pattern-cfg-35 $a #Pattern cfg-35 $.
pattern-cfg-36 $a #Pattern cfg-36 $.
pattern-cfg-37 $a #Pattern cfg-37 $.
pattern-cfg-38 $a #Pattern cfg-38 $.
pattern-cfg-39 $a #Pattern cfg-39 $.
pattern-cfg-40 $a #Pattern cfg-40 $.
pattern-cfg-41 $a #Pattern cfg-41 $.
pattern-cfg-42 $a #Pattern cfg-42 $.
pattern-cfg-43 $a #Pattern cfg-43 $.
pattern-cfg-44 $a #Pattern cfg-44 $.
pattern-cfg-45 $a #Pattern cfg-45 $.
pattern-cfg-46 $a #Pattern cfg-46 $.
pattern-cfg-47 $a #Pattern cfg-47 $.
pattern-cfg-48 $a #Pattern cfg-48 $.
pattern-cfg-49 $a #Pattern cfg-49 $.
pattern-cfg-50 $a #Pattern cfg-50 $.
pattern-cfg-51 $a #Pattern cfg-51 $.
pattern-cfg-52 $a #Pattern cfg-52 $.
pattern-cfg-53 $a #Pattern cfg-53 $.
pattern-cfg-54 $a #Pattern cfg-54 $.
pattern-cfg-55 $a #Pattern cfg-55 $.
pattern-cfg-56 $a #Pattern cfg-56 $.
pattern-cfg-57 $a #Pattern cfg-57 $.
pattern-cfg-58 $a #Pattern cfg-58 $.
pattern-cfg-59 $a #Pattern cfg-59 $.
pattern-cfg-60 $a #Pattern cfg-60 $.
pattern-cfg-61 $a #Pattern cfg-61 $.
pattern-cfg-62 $a #Pattern cfg-62 $.
pattern-cfg-63 $a #Pattern cfg-63 $.
pattern-cfg-64 $a #Pattern cfg-64 $.
pattern-cfg-65 $a #Pattern cfg-65 $.
pattern-cfg-66 $a #Pattern cfg-66 $.
pattern-cfg-67 $a #Pattern cfg-67 $.
pattern-cfg-68 $a #Pattern cfg-68 $.
pattern-cfg-69 $a #Pattern cfg-69 $.
pattern-cfg-70 $a #Pattern cfg-70 $.
pattern-cfg-71 $a #Pattern cfg-71 $.
pattern-cfg-72 $a #Pattern cfg-72 $.
pattern-cfg-73 $a #Pattern cfg-73 $.
pattern-cfg-74 $a #Pattern cfg-74 $.
pattern-cfg-75 $a #Pattern cfg-75 $.
pattern-cfg-76 $a #Pattern cfg-76 $.
pattern-cfg-77 $a #Pattern cfg-77 $.
pattern-cfg-78 $a #Pattern cfg-78 $.
pattern-cfg-79 $a #Pattern cfg-79 $.
pattern-cfg-80 $a #Pattern cfg-80 $.
pattern-cfg-81 $a #Pattern cfg-81 $.
pattern-cfg-82 $a #Pattern cfg-82 $.
pattern-cfg-83 $a #Pattern cfg-83 $.
pattern-cfg-84 $a #Pattern cfg-84 $.
pattern-cfg-85 $a #Pattern cfg-85 $.
pattern-cfg-86 $a #Pattern cfg-86 $.
pattern-cfg-87 $a #Pattern cfg-87 $.
pattern-cfg-88 $a #Pattern cfg-88 $.
pattern-cfg-89 $a #Pattern cfg-89 $.
pattern-cfg-90 $a #Pattern cfg-90 $.
pattern-cfg-91 $a #Pattern cfg-91 $.
pattern-cfg-92 $a #Pattern cfg-92 $.
pattern-cfg-93 $a #Pattern cfg-93 $.
pattern-cfg-94 $a #Pattern cfg-94 $.
pattern-cfg-95 $a #Pattern cfg-95 $.
pattern-cfg-96 $a #Pattern cfg-96 $.
pattern-cfg-97 $a #Pattern cfg-97 $.
pattern-cfg-98 $a #Pattern cfg-98 $.
pattern-cfg-99 $a #Pattern cfg-99 $.
pattern-cfg-100 $a #Pattern cfg-100 $.
cfg-rewrites-0-1 $p |- ( \rewrites cfg-0 cfg-1 ) $= ? $.
cfg-rewrites-1-2 $p |- ( \rewrites cfg-1 cfg-2 ) $= ? $.
cfg-rewrites-2-3 $p |- ( \rewrites cfg-2 cfg-3 ) $= ? $.
cfg-rewrites-3-4 $p |- ( \rewrites cfg-3 cfg-4 ) $= ? $.
cfg-rewrites-4-5 $p |- ( \rewrites cfg-4 cfg-5 ) $= ? $.
cfg-rewrites-5-6 $p |- ( \rewrites cfg-5 cfg-6 ) $= ? $.
cfg-rewrites-6-7 $p |- ( \rewrites cfg-6 cfg-7 ) $= ? $.
cfg-rewrites-7-8 $p |- ( \rewrites cfg-7 cfg-8 ) $= ? $.
cfg-rewrites-8-9 $p |- ( \rewrites cfg-8 cfg-9 ) $= ? $.
cfg-rewrites-9-10 $p |- ( \rewrites cfg-9 cfg-10 ) $= ? $.
cfg-rewrites-10-11 $p |- ( \rewrites cfg-10 cfg-11 ) $= ? $.
cfg-rewrites-11-12 $p |- ( \rewrites cfg-11 cfg-12 ) $= ? $.
cfg-rewrites-12-13 $p |- ( \rewrites cfg-12 cfg-13 ) $= ? $.
cfg-rewrites-13-14 $p |- ( \rewrites cfg-13 cfg-14 ) $= ? $.
cfg-rewrites-14-15 $p |- ( \rewrites cfg-14 cfg-15 ) $= ? $.
cfg-rewrites-15-16 $p |- ( \rewrites cfg-15 cfg-16 ) $= ? $.
cfg-rewrites-16-17 $p |- ( \rewrites cfg-16 cfg-17 ) $= ? $.
cfg-rewrites-17-18 $p |- ( \rewrites cfg-17 cfg-18 ) $= ? $.
cfg-rewrites-18-19 $p |- ( \rewrites cfg-18 cfg-19 ) $= ? $.
cfg-rewrites-19-20 $p |- ( \rewrites cfg-19 cfg-20 ) $= ? $.
cfg-rewrites-20-21 $p |- ( \rewrites cfg-20 cfg-21 ) $= ? $.
cfg-rewrites-21-22 $p |- ( \rewrites cfg-21 cfg-22 ) $= ? $.
cfg-rewrites-22-23 $p |- ( \rewrites cfg-22 cfg-23 ) $= ? $.
cfg-rewrites-23-24 $p |- ( \rewrites cfg-23 cfg-24 ) $= ? $.
cfg-rewrites-24-25 $p |- ( \rewrites cfg-24 cfg-25 ) $= ? $.
cfg-rewrites-25-26 $p |- ( \rewrites cfg-25 cfg-26 ) $= ? $.
cfg-rewrites-26-27 $p |- ( \rewrites cfg-26 cfg-27 ) $= ? $.
cfg-rewrites-27-28 $p |- ( \rewrites cfg-27 cfg-28 ) $= ? $.
cfg-rewrites-28-29 $p |- ( \rewrites cfg-28 cfg-29 ) $= ? $.
cfg-rewrites-29-30 $p |- ( \rewrites cfg-29 cfg-30 ) $= ? $.
cfg-rewrites-30-31 $p |- ( \rewrites cfg-30 cfg-31 ) $= ? $.
cfg-rewrites-31-32 $p |- ( \rewrites cfg-31 cfg-32 ) $= ? $.
cfg-rewrites-32-33 $p |- ( \rewrites cfg-32 cfg-33 ) $= ? $.
cfg-rewrites-33-34 $p |- ( \rewrites cfg-33 cfg-34 ) $= ? $.
cfg-rewrites-34-35 $p |- ( \rewrites cfg-34 cfg-35 ) $= ? $.
cfg-rewrites-35-36 $p |- ( \rewrites cfg-35 cfg-36 ) $= ? $.
cfg-rewrites-36-37 $p |- ( \rewrites cfg-36 cfg-37 ) $= ? $.
cfg-rewrites-37-38 $p |- ( \rewrites cfg-37 cfg-38 ) $= ? $.
cfg-rewrites-38-39 $p |- ( \rewrites cfg-38 cfg-39 ) $= ? $.
cfg-rewrites-39-40 $p |- ( \rewrites cfg-39 cfg-40 ) $= ? $.
cfg-rewrites-40-41 $p |- ( \rewrites cfg-40 cfg-41 ) $= ? $.
cfg-rewrites-41-42 $p |- ( \rewrites cfg-41 cfg-42 ) $= ? $.
cfg-rewrites-42-43 $p |- ( \rewrites cfg-42 cfg-43 ) $= ? $.
cfg-rewrites-43-44 $p |- ( \rewrites cfg-43 cfg-44 ) $= ? $.
cfg-rewrites-44-45 $p |- ( \rewrites cfg-44 cfg-45 ) $= ? $.
cfg-rewrites-45-46 $p |- ( \rewrites cfg-45 cfg-46 ) $= ? $.
cfg-rewrites-46-47 $p |- ( \rewrites cfg-46 cfg-47 ) $= ? $.
cfg-rewrites-47-48 $p |- ( \rewrites cfg-47 cfg-48 ) $= ? $.
cfg-rewrites-48-49 $p |- ( \rewrites cfg-48 cfg-49 ) $= ? $.
cfg-rewrites-49-50 $p |- ( \rewrites cfg-49 cfg-50 ) $= ? $.
cfg-rewrites-50-51 $p |- ( \rewrites cfg-50 cfg-51 ) $= ? $.
cfg-rewrites-51-52 $p |- ( \rewrites cfg-51 cfg-52 ) $= ? $.
cfg-rewrites-52-53 $p |- ( \rewrites cfg-52 cfg-53 ) $= ? $.
cfg-rewrites-53-54 $p |- ( \rewrites cfg-53 cfg-54 ) $= ? $.
cfg-rewrites-54-55 $p |- ( \rewrites cfg-54 cfg-55 ) $= ? $.
cfg-rewrites-55-56 $p |- ( \rewrites cfg-55 cfg-56 ) $= ? $.
cfg-rewrites-56-57 $p |- ( \rewrites cfg-56 cfg-57 ) $= ? $.
cfg-rewrites-57-58 $p |- ( \rewrites cfg-57 cfg-58 ) $= ? $.
cfg-rewrites-58-59 $p |- ( \rewrites cfg-58 cfg-59 ) $= ? $.
cfg-rewrites-59-60 $p |- ( \rewrites cfg-59 cfg-60 ) $= ? $.
cfg-rewrites-60-61 $p |- ( \rewrites cfg-60 cfg-61 ) $= ? $.
cfg-rewrites-61-62 $p |- ( \rewrites cfg-61 cfg-62 ) $= ? $.
cfg-rewrites-62-63 $p |- ( \rewrites cfg-62 cfg-63 ) $= ? $.
cfg-rewrites-63-64 $p |- ( \rewrites cfg-63 cfg-64 ) $= ? $.
cfg-rewrites-64-65 $p |- ( \rewrites cfg-64 cfg-65 ) $= ? $.
cfg-rewrites-65-66 $p |- ( \rewrites cfg-65 cfg-66 ) $= ? $.
cfg-rewrites-66-67 $p |- ( \rewrites cfg-66 cfg-67 ) $= ? $.
cfg-rewrites-67-68 $p |- ( \rewrites cfg-67 cfg-68 ) $= ? $.
cfg-rewrites-68-69 $p |- ( \rewrites cfg-68 cfg-69 ) $= ? $.
cfg-rewrites-69-70 $p |- ( \rewrites cfg-69 cfg-70 ) $= ? $.
cfg-rewrites-70-71 $p |- ( \rewrites cfg-70 cfg-71 ) $= ? $.
cfg-rewrites-71-72 $p |- ( \rewrites cfg-71 cfg-72 ) $= ? $.
cfg-rewrites-72-73 $p |- ( \rewrites cfg-72 cfg-73 ) $= ? $.
cfg-rewrites-73-74 $p |- ( \rewrites cfg-73 cfg-74 ) $= ? $.
cfg-rewrites-74-75 $p |- ( \rewrites cfg-74 cfg-75 ) $= ? $.
cfg-rewrites-75-76 $p |- ( \rewrites cfg-75 cfg-76 ) $= ? $.
cfg-rewrites-76-77 $p |- ( \rewrites cfg-76 cfg-77 ) $= ? $.
cfg-rewrites-77-78 $p |- ( \rewrites cfg-77 cfg-78 ) $= ? $.
cfg-rewrites-78-79 $p |- ( \rewrites cfg-78 cfg-79 ) $= ? $.
cfg-rewrites-79-80 $p |- ( \rewrites cfg-79 cfg-80 ) $= ? $.
cfg-rewrites-80-81 $p |- ( \rewrites cfg-80 cfg-81 ) $= ? $.
cfg-rewrites-81-82 $p |- ( \rewrites cfg-81 cfg-82 ) $= ? $.
cfg-rewrites-82-83 $p |- ( \rewrites cfg-82 cfg-83 ) $= ? $.
cfg-rewrites-83-84 $p |- ( \rewrites cfg-83 cfg-84 ) $= ? $.
cfg-rewrites-84-85 $p |- ( \rewrites cfg-84 cfg-85 ) $= ? $.
cfg-rewrites-85-86 $p |- ( \rewrites cfg-85 cfg-86 ) $= ? $.
cfg-rewrites-86-87 $p |- ( \rewrites cfg-86 cfg-87 ) $= ? $.
cfg-rewrites-87-88 $p |- ( \rewrites cfg-87 cfg-88 ) $= ? $.
cfg-rewrites-88-89 $p |- ( \rewrites cfg-88 cfg-89 ) $= ? $.
cfg-rewrites-89-90 $p |- ( \rewrites cfg-89 cfg-90 ) $= ? $.
cfg-rewrites-90-91 $p |- ( \rewrites cfg-90 cfg-91 ) $= ? $.
cfg-rewrites-91-92 $p |- ( \rewrites cfg-91 cfg-92 ) $= ? $.
cfg-rewrites-92-93 $p |- ( \rewrites cfg-92 cfg-93 ) $= ? $.
cfg-rewrites-93-94 $p |- ( \rewrites cfg-93 cfg-94 ) $= ? $.
cfg-rewrites-94-95 $p |- ( \rewrites cfg-94 cfg-95 ) $= ? $.
cfg-rewrites-95-96 $p |- ( \rewrites cfg-95 cfg-96 ) $= ? $.
cfg-rewrites-96-97 $p |- ( \rewrites cfg-96 cfg-97 ) $= ? $.
cfg-rewrites-97-98 $p |- ( \rewrites cfg-97 cfg-98 ) $= ? $.
cfg-rewrites-98-99 $p |- ( \rewrites cfg-98 cfg-99 ) $= ? $.
cfg-rewrites-99-100 $p |- ( \rewrites cfg-99 cfg-100 ) $= ? $.
cfg-rewrites-0-2 $p |- ( \rewrites cfg-0 cfg-2 ) $= pattern-cfg-0 pattern-cfg-1 pattern-cfg-2 cfg-rewrites-0-1 cfg-rewrites-1-2 rewrites-transitivity $.
cfg-rewrites-0-3 $p |- ( \rewrites cfg-0 cfg-3 ) $= pattern-cfg-0 pattern-cfg-2 pattern-cfg-3 cfg-rewrites-0-2 cfg-rewrites-2-3 rewrites-transitivity $.
cfg-rewrites-0-4 $p |- ( \rewrites cfg-0 cfg-4 ) $= pattern-cfg-0 pattern-cfg-3 pattern-cfg-4 cfg-rewrites-0-3 cfg-rewrites-3-4 rewrites-transitivity $.
cfg-rewrites-0-5 $p |- ( \rewrites cfg-0 cfg-5 ) $= pattern-cfg-0 pattern-cfg-4 pattern-cfg-5 cfg-rewrites-0-4 cfg-rewrites-4-5 rewrites-transitivity $.
cfg-rewrites-0-6 $p |- ( \rewrites cfg-0 cfg-6 ) $= pattern-cfg-0 pattern-cfg-5 pattern-cfg-6 cfg-rewrites-0-5 cfg-rewrites-5-6 rewrites-transitivity $.
cfg-rewrites-0-7 $p |- ( \rewrites cfg-0 cfg-7 ) $= pattern-cfg-0 pattern-cfg-6 pattern-cfg-7 cfg-rewrites-0-6 cfg-rewrites-6-7 rewrites-transitivity $.
cfg-rewrites-0-8 $p |- ( \rewrites cfg-0 cfg-8 ) $= pattern-cfg-0 pattern-cfg-7 pattern-cfg-8 cfg-rewrites-0-7 cfg-rewrites-7-8 rewrites-transitivity $.
cfg-rewrites-0-9 $p |- ( \rewrites cfg-0 cfg-9 ) $= pattern-cfg-0 pattern-cfg-8 pattern-cfg-9 cfg-rewrites-0-8 cfg-rewrites-8-9 rewrites-transitivity $.
cfg-rewrites-0-10 $p |- ( \rewrites cfg-0 cfg-10 ) $= pattern-cfg-0 pattern-cfg-9 pattern-cfg-10 cfg-rewrites-0-9 cfg-rewrites-9-10 rewrites-transitivity $.
cfg-rewrites-0-11 $p |- ( \rewrites cfg-0 cfg-11 ) $= pattern-cfg-0 pattern-cfg-10 pattern-cfg-11 cfg-rewrites-0-10 cfg-rewrites-10-11 rewrites-transitivity $.
cfg-rewrites-0-12 $p |- ( \rewrites cfg-0 cfg-12 ) $= pattern-cfg-0 pattern-cfg-11 pattern-cfg-12 cfg-rewrites-0-11 cfg-rewrites-11-12 rewrites-transitivity $.
cfg-rewrites-0-13 $p |- ( \rewrites cfg-0 cfg-13 ) $= pattern-cfg-0 pattern-cfg-12 pattern-cfg-13 cfg-rewrites-0-12 cfg-rewrites-12-13 rewrites-transitivity $.
cfg-rewrites-0-14 $p |- ( \rewrites cfg-0 cfg-14 ) $= pattern-cfg-0 pattern-cfg-13 pattern-cfg-14 cfg-rewrites-0-13 cfg-rewrites-13-14 rewrites-transitivity $.
cfg-rewrites-0-15 $p |- ( \rewrites cfg-0 cfg-15 ) $= pattern-cfg-0 pattern-cfg-14 pattern-cfg-15 cfg-rewrites-0-14 cfg-rewrites-14-15 rewrites-transitivity $.
cfg-rewrites-0-16 $p |- ( \rewrites cfg-0 cfg-16 ) $= pattern-cfg-0 pattern-cfg-15 pattern-cfg-16 cfg-rewrites-0-15 cfg-rewrites-15-16 rewrites-transitivity $.
cfg-rewrites-0-17 $p |- ( \rewrites cfg-0 cfg-17 ) $= pattern-cfg-0 pattern-cfg-16 pattern-cfg-17 cfg-rewrites-0-16 cfg-rewrites-16-17 rewrites-transitivity $.
cfg-rewrites-0-18 $p |- ( \rewrites cfg-0 cfg-18 ) $= pattern-cfg-0 pattern-cfg-17 pattern-cfg-18 cfg-rewrites-0-17 cfg-rewrites-17-18 rewrites-transitivity $.
cfg-rewrites-0-19 $p |- ( \rewrites cfg-0 cfg-19 ) $= pattern-cfg-0 pattern-cfg-18 pattern-cfg-19 cfg-rewrites-0-18 cfg-rewrites-18-19 rewrites-transitivity $.
cfg-rewrites-0-20 $p |- ( \rewrites cfg-0 cfg-20 ) $= pattern-cfg-0 pattern-cfg-19 pattern-cfg-20 cfg-rewrites-0-19 cfg-rewrites-19-20 rewrites-transitivity $.
cfg-rewrites-0-21 $p |- ( \rewrites cfg-0 cfg-21 ) $= pattern-cfg-0 pattern-cfg-20 pattern-cfg-21 cfg-rewrites-0-20 cfg-rewrites-20-21 rewrites-transitivity $.
cfg-rewrites-0-22 $p |- ( \rewrites cfg-0 cfg-22 ) $= pattern-cfg-0 pattern-cfg-21 pattern-cfg-22 cfg-rewrites-0-21 cfg-rewrites-21-22 rewrites-transitivity $.
cfg-rewrites-0-23 $p |- ( \rewrites cfg-0 cfg-23 ) $= pattern-cfg-0 pattern-cfg-22 pattern-cfg-23 cfg-rewrites-0-22 cfg-rewrites-22-23 rewrites-transitivity $.
cfg-rewrites-0-24 $p |- ( \rewrites cfg-0 cfg-24 ) $= pattern-cfg-0 pattern-cfg-23 pattern-cfg-24 cfg-rewrites-0-23 cfg-rewrites-23-24 rewrites-transitivity $.
cfg-rewrites-0-25 $p |- ( \rewrites cfg-0 cfg-25 ) $= pattern-cfg-0 pattern-cfg-24 pattern-cfg-25 cfg-rewrites-0-24 cfg-rewrites-24-25 rewrites-transitivity $.
cfg-rewrites-0-26 $p |- ( \rewrites cfg-0 cfg-26 ) $= pattern-cfg-0 pattern-cfg-25 pattern-cfg-26 cfg-rewrites-0-25 cfg-rewrites-25-26 rewrites-transitivity $.
cfg-rewrites-0-27 $p |- ( \rewrites cfg-0 cfg-27 ) $= pattern-cfg-0 pattern-cfg-26 pattern-cfg-27 cfg-rewrites-0-26 cfg-rewrites-26-27 rewrites-transitivity $.
cfg-rewrites-0-28 $p |- ( \rewrites cfg-0 cfg-28 ) $= pattern-cfg-0 pattern-cfg-27 pattern-cfg-28 cfg-rewrites-0-27 cfg-rewrites-27-28 rewrites-transitivity $.
cfg-rewrites-0-29 $p |- ( \rewrites cfg-0 cfg-29 ) $= pattern-cfg-0 pattern-cfg-28 pattern-cfg-29 cfg-rewrites-0-28 cfg-rewrites-28-29 rewrites-transitivity $.
cfg-rewrites-0-30 $p |- ( \rewrites cfg-0 cfg-30 ) $= pattern-cfg-0 pattern-cfg-29 pattern-cfg-30 cfg-rewrites-0-29 cfg-rewrites-29-30 rewrites-transitivity $.
cfg-rewrites-0-31 $p |- ( \rewrites cfg-0 cfg-31 ) $= pattern-cfg-0 pattern-cfg-30 pattern-cfg-31 cfg-rewrites-0-30 cfg-rewrites-30-31 rewrites-transitivity $.
cfg-rewrites-0-32 $p |- ( \rewrites cfg-0 cfg-32 ) $= pattern-cfg-0 pattern-cfg-31 pattern-cfg-32 cfg-rewrites-0-31 cfg-rewrites-31-32 rewrites-transitivity $.
cfg-rewrites-0-33 $p |- ( \rewrites cfg-0 cfg-33 ) $= pattern-cfg-0 pattern-cfg-32 pattern-cfg-33 cfg-rewrites-0-32 cfg-rewrites-32-33 rewrites-transitivity $.
cfg-rewrites-0-34 $p |- ( \rewrites cfg-0 cfg-34 ) $= pattern-cfg-0 pattern-cfg-33 pattern-cfg-34 cfg-rewrites-0-33 cfg-rewrites-33-34 rewrites-transitivity $.
cfg-rewrites-0-35 $p |- ( \rewrites cfg-0 cfg-35 ) $= pattern-cfg-0 pattern-cfg-34 pattern-cfg-35 cfg-rewrites-0-34 cfg-rewrites-34-35 rewrites-transitivity $.
cfg-rewrites-0-36 $p |- ( \rewrites cfg-0 cfg-36 ) $= pattern-cfg-0 pattern-cfg-35 pattern-cfg-36 cfg-rewrites-0-35 cfg-rewrites-35-36 rewrites-transitivity $.
cfg-rewrites-0-37 $p |- ( \rewrites cfg-0 cfg-37 ) $= pattern-cfg-0 pattern-cfg-36 pattern-cfg-37 cfg-rewrites-0-36 cfg-rewrites-36-37 rewrites-transitivity $.
cfg-rewrites-0-38 $p |- ( \rewrites cfg-0 cfg-38 ) $= pattern-cfg-0 pattern-cfg-37 pattern-cfg-38 cfg-rewrites-0-37 cfg-rewrites-37-38 rewrites-transitivity $.
cfg-rewrites-0-39 $p |- ( \rewrites cfg-0 cfg-39 ) $= pattern-cfg-0 pattern-cfg-38 pattern-cfg-39 cfg-rewrites-0-38 cfg-rewrites-38-39 rewrites-transitivity $.
cfg-rewrites-0-40 $p |- ( \rewrites cfg-0 cfg-40 ) $= pattern-cfg-0 pattern-cfg-39 pattern-cfg-40 cfg-rewrites-0-39 cfg-rewrites-39-40 rewrites-transitivity $.
cfg-rewrites-0-41 $p |- ( \rewrites cfg-0 cfg-41 ) $= pattern-cfg-0 pattern-cfg-40 pattern-cfg-41 cfg-rewrites-0-40 cfg-rewrites-40-41 rewrites-transitivity $.
cfg-rewrites-0-42 $p |- ( \rewrites cfg-0 cfg-42 ) $= pattern-cfg-0 pattern-cfg-41 pattern-cfg-42 cfg-rewrites-0-41 cfg-rewrites-41-42 rewrites-transitivity $.
cfg-rewrites-0-43 $p |- ( \rewrites cfg-0 cfg-43 ) $= pattern-cfg-0 pattern-cfg-42 pattern-cfg-43 cfg-rewrites-0-42 cfg-rewrites-42-43 rewrites-transitivity $.
cfg-rewrites-0-44 $p |- ( \rewrites cfg-0 cfg-44 ) $= pattern-cfg-0 pattern-cfg-43 pattern-cfg-44 cfg-rewrites-0-43 cfg-rewrites-43-44 rewrites-transitivity $.
cfg-rewrites-0-45 $p |- ( \rewrites cfg-0 cfg-45 ) $= pattern-cfg-0 pattern-cfg-44 pattern-cfg-45 cfg-rewrites-0-44 cfg-rewrites-44-45 rewrites-transitivity $.
cfg-rewrites-0-46 $p |- ( \rewrites cfg-0 cfg-46 ) $= pattern-cfg-0 pattern-cfg-45 pattern-cfg-46 cfg-rewrites-0-45 cfg-rewrites-45-46 rewrites-transitivity $.
cfg-rewrites-0-47 $p |- ( \rewrites cfg-0 cfg-47 ) $= pattern-cfg-0 pattern-cfg-46 pattern-cfg-47 cfg-rewrites-0-46 cfg-rewrites-46-47 rewrites-transitivity $.
cfg-rewrites-0-48 $p |- ( \rewrites cfg-0 cfg-48 ) $= pattern-cfg-0 pattern-cfg-47 pattern-cfg-48 cfg-rewrites-0-47 cfg-rewrites-47-48 rewrites-transitivity $.
cfg-rewrites-0-49 $p |- ( \rewrites cfg-0 cfg-49 ) $= pattern-cfg-0 pattern-cfg-48 pattern-cfg-49 cfg-rewrites-0-48 cfg-rewrites-48-49 rewrites-transitivity $.
cfg-rewrites-0-50 $p |- ( \rewrites cfg-0 cfg-50 ) $= pattern-cfg-0 pattern-cfg-49 pattern-cfg-50 cfg-rewrites-0-49 cfg-rewrites-49-50 rewrites-transitivity $.
cfg-rewrites-0-51 $p |- ( \rewrites cfg-0 cfg-51 ) $= pattern-cfg-0 pattern-cfg-50 pattern-cfg-51 cfg-rewrites-0-50 cfg-rewrites-50-51 rewrites-transitivity $.
cfg-rewrites-0-52 $p |- ( \rewrites cfg-0 cfg-52 ) $= pattern-cfg-0 pattern-cfg-51 pattern-cfg-52 cfg-rewrites-0-51 cfg-rewrites-51-52 rewrites-transitivity $.
cfg-rewrites-0-53 $p |- ( \rewrites cfg-0 cfg-53 ) $= pattern-cfg-0 pattern-cfg-52 pattern-cfg-53 cfg-rewrites-0-52 cfg-rewrites-52-53 rewrites-transitivity $.
cfg-rewrites-0-54 $p |- ( \rewrites cfg-0 cfg-54 ) $= pattern-cfg-0 pattern-cfg-53 pattern-cfg-54 cfg-rewrites-0-53 cfg-rewrites-53-54 rewrites-transitivity $.
cfg-rewrites-0-55 $p |- ( \rewrites cfg-0 cfg-55 ) $= pattern-cfg-0 pattern-cfg-54 pattern-cfg-55 cfg-rewrites-0-54 cfg-rewrites-54-55 rewrites-transitivity $.
cfg-rewrites-0-56 $p |- ( \rewrites cfg-0 cfg-56 ) $= pattern-cfg-0 pattern-cfg-55 pattern-cfg-56 cfg-rewrites-0-55 cfg-rewrites-55-56 rewrites-transitivity $.
cfg-rewrites-0-57 $p |- ( \rewrites cfg-0 cfg-57 ) $= pattern-cfg-0 pattern-cfg-56 pattern-cfg-57 cfg-rewrites-0-56 cfg-rewrites-56-57 rewrites-transitivity $.
cfg-rewrites-0-58 $p |- ( \rewrites cfg-0 cfg-58 ) $= pattern-cfg-0 pattern-cfg-57 pattern-cfg-58 cfg-rewrites-0-57 cfg-rewrites-57-58 rewrites-transitivity $.
cfg-rewrites-0-59 $p |- ( \rewrites cfg-0 cfg-59 ) $= pattern-cfg-0 pattern-cfg-58 pattern-cfg-59 cfg-rewrites-0-58 cfg-rewrites-58-59 rewrites-transitivity $.
cfg-rewrites-0-60 $p |- ( \rewrites cfg-0 cfg-60 ) $= pattern-cfg-0 pattern-cfg-59 pattern-cfg-60 cfg-rewrites-0-59 cfg-rewrites-59-60 rewrites-transitivity $.
cfg-rewrites-0-61 $p |- ( \rewrites cfg-0 cfg-61 ) $= pattern-cfg-0 pattern-cfg-60 pattern-cfg-61 cfg-rewrites-0-60 cfg-rewrites-60-61 rewrites-transitivity $.
cfg-rewrites-0-62 $p |- ( \rewrites cfg-0 cfg-62 ) $= pattern-cfg-0 pattern-cfg-61 pattern-cfg-62 cfg-rewrites-0-61 cfg-rewrites-61-62 rewrites-transitivity $.
cfg-rewrites-0-63 $p |- ( \rewrites cfg-0 cfg-63 ) $= pattern-cfg-0 pattern-cfg-62 pattern-cfg-63 cfg-rewrites-0-62 cfg-rewrites-62-63 rewrites-transitivity $.
cfg-rewrites-0-64 $p |- ( \rewrites cfg-0 cfg-64 ) $= pattern-cfg-0 pattern-cfg-63 pattern-cfg-64 cfg-rewrites-0-63 cfg-rewrites-63-64 rewrites-transitivity $.
cfg-rewrites-0-65 $p |- ( \rewrites cfg-0 cfg-65 ) $= pattern-cfg-0 pattern-cfg-64 pattern-cfg-65 cfg-rewrites-0-64 cfg-rewrites-64-65 rewrites-transitivity $.
cfg-rewrites-0-66 $p |- ( \rewrites cfg-0 cfg-66 ) $= pattern-cfg-0 pattern-cfg-65 pattern-cfg-66 cfg-rewrites-0-65 cfg-rewrites-65-66 rewrites-transitivity $.
cfg-rewrites-0-67 $p |- ( \rewrites cfg-0 cfg-67 ) $= pattern-cfg-0 pattern-cfg-66 pattern-cfg-67 cfg-rewrites-0-66 cfg-rewrites-66-67 rewrites-transitivity $.
cfg-rewrites-0-68 $p |- ( \rewrites cfg-0 cfg-68 ) $= pattern-cfg-0 pattern-cfg-67 pattern-cfg-68 cfg-rewrites-0-67 cfg-rewrites-67-68 rewrites-transitivity $.
cfg-rewrites-0-69 $p |- ( \rewrites cfg-0 cfg-69 ) $= pattern-cfg-0 pattern-cfg-68 pattern-cfg-69 cfg-rewrites-0-68 cfg-rewrites-68-69 rewrites-transitivity $.
cfg-rewrites-0-70 $p |- ( \rewrites cfg-0 cfg-70 ) $= pattern-cfg-0 pattern-cfg-69 pattern-cfg-70 cfg-rewrites-0-69 cfg-rewrites-69-70 rewrites-transitivity $.
cfg-rewrites-0-71 $p |- ( \rewrites cfg-0 cfg-71 ) $= pattern-cfg-0 pattern-cfg-70 pattern-cfg-71 cfg-rewrites-0-70 cfg-rewrites-70-71 rewrites-transitivity $.
cfg-rewrites-0-72 $p |- ( \rewrites cfg-0 cfg-72 ) $= pattern-cfg-0 pattern-cfg-71 pattern-cfg-72 cfg-rewrites-0-71 cfg-rewrites-71-72 rewrites-transitivity $.
cfg-rewrites-0-73 $p |- ( \rewrites cfg-0 cfg-73 ) $= pattern-cfg-0 pattern-cfg-72 pattern-cfg-73 cfg-rewrites-0-72 cfg-rewrites-72-73 rewrites-transitivity $.
cfg-rewrites-0-74 $p |- ( \rewrites cfg-0 cfg-74 ) $= pattern-cfg-0 pattern-cfg-73 pattern-cfg-74 cfg-rewrites-0-73 cfg-rewrites-73-74 rewrites-transitivity $.
cfg-rewrites-0-75 $p |- ( \rewrites cfg-0 cfg-75 ) $= pattern-cfg-0 pattern-cfg-74 pattern-cfg-75 cfg-rewrites-0-74 cfg-rewrites-74-75 rewrites-transitivity $.
cfg-rewrites-0-76 $p |- ( \rewrites cfg-0 cfg-76 ) $= pattern-cfg-0 pattern-cfg-75 pattern-cfg-76 cfg-rewrites-0-75 cfg-rewrites-75-76 rewrites-transitivity $.
cfg-rewrites-0-77 $p |- ( \rewrites cfg-0 cfg-77 ) $= pattern-cfg-0 pattern-cfg-76 pattern-cfg-77 cfg-rewrites-0-76 cfg-rewrites-76-77 rewrites-transitivity $.
cfg-rewrites-0-78 $p |- ( \rewrites cfg-0 cfg-78 ) $= pattern-cfg-0 pattern-cfg-77 pattern-cfg-78 cfg-rewrites-0-77 cfg-rewrites-77-78 rewrites-transitivity $.
cfg-rewrites-0-79 $p |- ( \rewrites cfg-0 cfg-79 ) $= pattern-cfg-0 pattern-cfg-78 pattern-cfg-79 cfg-rewrites-0-78 cfg-rewrites-78-79 rewrites-transitivity $.
cfg-rewrites-0-80 $p |- ( \rewrites cfg-0 cfg-80 ) $= pattern-cfg-0 pattern-cfg-79 pattern-cfg-80 cfg-rewrites-0-79 cfg-rewrites-79-80 rewrites-transitivity $.
cfg-rewrites-0-81 $p |- ( \rewrites cfg-0 cfg-81 ) $= pattern-cfg-0 pattern-cfg-80 pattern-cfg-81 cfg-rewrites-0-80 cfg-rewrites-80-81 rewrites-transitivity $.
cfg-rewrites-0-82 $p |- ( \rewrites cfg-0 cfg-82 ) $= pattern-cfg-0 pattern-cfg-81 pattern-cfg-82 cfg-rewrites-0-81 cfg-rewrites-81-82 rewrites-transitivity $.
cfg-rewrites-0-83 $p |- ( \rewrites cfg-0 cfg-83 ) $= pattern-cfg-0 pattern-cfg-82 pattern-cfg-83 cfg-rewrites-0-82 cfg-rewrites-82-83 rewrites-transitivity $.
cfg-rewrites-0-84 $p |- ( \rewrites cfg-0 cfg-84 ) $= pattern-cfg-0 pattern-cfg-83 pattern-cfg-84 cfg-rewrites-0-83 cfg-rewrites-83-84 rewrites-transitivity $.
cfg-rewrites-0-85 $p |- ( \rewrites cfg-0 cfg-85 ) $= pattern-cfg-0 pattern-cfg-84 pattern-cfg-85 cfg-rewrites-0-84 cfg-rewrites-84-85 rewrites-transitivity $.
cfg-rewrites-0-86 $p |- ( \rewrites cfg-0 cfg-86 ) $= pattern-cfg-0 pattern-cfg-85 pattern-cfg-86 cfg-rewrites-0-85 cfg-rewrites-85-86 rewrites-transitivity $.
cfg-rewrites-0-87 $p |- ( \rewrites cfg-0 cfg-87 ) $= pattern-cfg-0 pattern-cfg-86 pattern-cfg-87 cfg-rewrites-0-86 cfg-rewrites-86-87 rewrites-transitivity $.
cfg-rewrites-0-88 $p |- ( \rewrites cfg-0 cfg-88 ) $= pattern-cfg-0 pattern-cfg-87 pattern-cfg-88 cfg-rewrites-0-87 cfg-rewrites-87-88 rewrites-transitivity $.
cfg-rewrites-0-89 $p |- ( \rewrites cfg-0 cfg-89 ) $= pattern-cfg-0 pattern-cfg-88 pattern-cfg-89 cfg-rewrites-0-88 cfg-rewrites-88-89 rewrites-transitivity $.
cfg-rewrites-0-90 $p |- ( \rewrites cfg-0 cfg-90 ) $= pattern-cfg-0 pattern-cfg-89 pattern-cfg-90 cfg-rewrites-0-89 cfg-rewrites-89-90 rewrites-transitivity $.
cfg-rewrites-0-91 $p |- ( \rewrites cfg-0 cfg-91 ) $= pattern-cfg-0 pattern-cfg-90 pattern-cfg-91 cfg-rewrites-0-90 cfg-rewrites-90-91 rewrites-transitivity $.
cfg-rewrites-0-92 $p |- ( \rewrites cfg-0 cfg-92 ) $= pattern-cfg-0 pattern-cfg-91 pattern-cfg-92 cfg-rewrites-0-91 cfg-rewrites-91-92 rewrites-transitivity $.
cfg-rewrites-0-93 $p |- ( \rewrites cfg-0 cfg-93 ) $= pattern-cfg-0 pattern-cfg-92 pattern-cfg-93 cfg-rewrites-0-92 cfg-rewrites-92-93 rewrites-transitivity $.
cfg-rewrites-0-94 $p |- ( \rewrites cfg-0 cfg-94 ) $= pattern-cfg-0 pattern-cfg-93 pattern-cfg-94 cfg-rewrites-0-93 cfg-rewrites-93-94 rewrites-transitivity $.
cfg-rewrites-0-95 $p |- ( \rewrites cfg-0 cfg-95 ) $= pattern-cfg-0 pattern-cfg-94 pattern-cfg-95 cfg-rewrites-0-94 cfg-rewrites-94-95 rewrites-transitivity $.
cfg-rewrites-0-96 $p |- ( \rewrites cfg-0 cfg-96 ) $= pattern-cfg-0 pattern-cfg-95 pattern-cfg-96 cfg-rewrites-0-95 cfg-rewrites-95-96 rewrites-transitivity $.
cfg-rewrites-0-97 $p |- ( \rewrites cfg-0 cfg-97 ) $= pattern-cfg-0 pattern-cfg-96 pattern-cfg-97 cfg-rewrites-0-96 cfg-rewrites-96-97 rewrites-transitivity $.
cfg-rewrites-0-98 $p |- ( \rewrites cfg-0 cfg-98 ) $= pattern-cfg-0 pattern-cfg-97 pattern-cfg-98 cfg-rewrites-0-97 cfg-rewrites-97-98 rewrites-transitivity $.
cfg-rewrites-0-99 $p |- ( \rewrites cfg-0 cfg-99 ) $= pattern-cfg-0 pattern-cfg-98 pattern-cfg-99 cfg-rewrites-0-98 cfg-rewrites-98-99 rewrites-transitivity $.
cfg-rewrites-0-100 $p |- ( \rewrites cfg-0 cfg-100 ) $= pattern-cfg-0 pattern-cfg-99 pattern-cfg-100 cfg-rewrites-0-99 cfg-rewrites-99-100 rewrites-transitivity $.
```
