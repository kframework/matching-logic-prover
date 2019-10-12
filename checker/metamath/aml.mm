$( Declare metamath constants $)
$c 
    \bot \imp \app \ex \mu 
    ( ) 
    wf ev sv nf pos subst
    |- 
$.

$( Declare metamath variables $)
$v 
    P Q R x y z X Y Z 
$.

$( Specify the ranges of metamath variables $)
wfP $f wf P $.
wfQ $f wf Q $.
wfR $f wf R $.
evx $f ev x $.
evy $f ev y $.
evz $f ev z $.
svX $f sv X $.
svY $f sv Y $.
svZ $f sv Z $.

$( Define pos $)

$( Define wf $)
wfev   $a wf x $.
wfsv   $a wf X $.
wfbot  $a wf \bot $.
wfimp  $a wf ( \imp P Q ) $.
wfapp  $a wf ( \app P Q ) $.
wfex   $a wf ( \ex x P ) $.
wfmu   $a wf ( \mu X P ) $.

$( State the propositional axioms $)
PropK $a |- ( \imp P ( \imp Q P ) ) $.
PropS $a |- ( \imp ( \imp P ( \imp Q R ) )
                   ( \imp ( \imp P Q ) ( \imp P R ) ) ) $.
PropF $a |- ( ( ( \imp P \bot ) \bot ) P ) $.
${
    MPante $e |- P $.
    MPcond $e |- ( \imp P Q ) $.
    MP     $a |- Q $.
$}

$( State the FOL reasoning axioms $)

$( Prove our first (meta-)theorem:
         |- P -> (Q -> R)
    -------------------------
     |- (P -> Q) -> (P -> R)
$)

${
    InfS.1 $e |- ( \imp P ( \imp Q R ) ) $.

    InfS $p |- ( \imp ( \imp P Q ) ( \imp P R ) ) $=
      wfP wfQ wfR wfimp wfimp wfP wfQ wfimp wfP wfR wfimp wfimp InfS.1 wfP wfQ
      wfR PropS MP $.
$}
