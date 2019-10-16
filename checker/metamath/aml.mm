$( Declare AML pattern constructs, one per line. $)
$c 
    \bot
	\imp
	\app 
	\ex 
	\mu 
	( 
	)
$.

$( Declare AML's "syntactic categories":
   Wellformedness:          wf
   AML variables:           var
     Element AML variables: ev
     Set AML variables:     sv
   Symbols:                 sy
$)
$c
    wf var ev sv sy
$.

$( Declare AML provability relation. $)
$c 
    |- 
$.

$( Auxiliary stuffs:
     non-positive occurrence of a variable: npo
     non-negative occurrence of a variable: nno  
     variable not occur free in a pattern:  fresh
     substitution:                          subst
     application context:                   appctx
$)
$c
    fresh subst npo nno appctx
$.



$( Declare metamath variables $)
$v 
    P Q R P' Q' x y z X Y Z f g h
$.

$( Specify the ranges of metamath variables $)
wfP $f wf P $.
wfPp $f wf P' $.
wfQ $f wf Q $.
wfQp $f wf Q' $.
wfR $f wf R $.
evx $f ev x $.
evy $f ev y $.
evz $f ev z $.
svX $f sv X $.
svY $f sv Y $.
svZ $f sv Z $.
syf $f sv f $.
syg $f sv g $.
syh $f sv h $.

$( Variables = Element variables + Set variables. $)
evar $a var x $.
svar $a var X $.

$( Define wellformedness patterns: wf $)
wfev   $a wf x $.
wfsv   $a wf X $.
wfbot  $a wf \bot $.
wfimp  $a wf ( \imp P Q ) $.
wfapp  $a wf ( \app P Q ) $.
wfex   $a wf ( \ex x P ) $.
${
    wfmu.nno $e nno X P $.
    wfmu     $a wf ( \mu X P ) $.
$}

$( Define fresh-ness of variables: fresh $)
${
    $v xx $.
	$v yy $.
    $d xx yy $.
    fresh-var.1 $f var xx $.
	fresh-var.2 $f var yy $.
	fresh-var $a fresh xx yy $.
$}

$( Define freshness (not-occur-free): fresh $)
${
    $d x y $.
    freshev-ev $a fresh x y $.
$}
freshev-sv  $a fresh x X $.
freshev-sy  $a fresh x f $.
freshev-bot $a fresh x \bot $.
${
    freshev-imp.1 $e fresh x P $.
    freshev-imp.2 $e fresh x Q $.
    freshev-imp   $a fresh x ( \imp P Q ) $.
$}
${
    freshev-app.1 $e fresh x P $.
    freshev-app.2 $e fresh x Q $.
    freshev-app   $a fresh x ( \app P Q ) $.
$}
freshev-ex-binding $a fresh x ( \ex x P ) $.
${
    $d x y $.
    freshev-body.1 $a fresh x P $.
    freshev-body   $a fresh x ( \ex y P ) $.
$}
${
    freshev-mu.1 $a fresh x P $.
    freshev-mu   $a fresh x ( \mu X P ) $.
$}

freshsv-ev  $a fresh X x $.
${
    $d X Y $.
    freshsv-sv $a fresh X Y $.
$}
freshsv-sy  $a fresh X f $.
freshsv-bot $a fresh X \bot $.
${
    freshsv-imp.1 $e fresh X P $.
    freshsv-imp.2 $e fresh X Q $.
    freshsv-imp   $a fresh X ( \imp P Q ) $.
$}
${
    freshsv-app.1 $e fresh X P $.
    freshsv-app.2 $e fresh X Q $.
    freshsv-app   $a fresh X ( \app P Q ) $.
$}
${
    freshsv-ex.1 $a fresh X P $.
    freshsv-ex   $a fresh X ( \ex x P ) $.
$}
freshsv-mu-binding $a fresh X ( \mu X P ) $.
${
    $d X Y $.
    freshsv-body.1 $a fresh X P $.
    freshsv-body   $a fresh X ( \mu Y P ) $.
$}

$( Define non-negative/non-positive occurrence checking: nno/npo $)
$( nno/npo takes 2 arguments: a set variable and a pattern $)
nno-ev  $a nno X x $.
nno-sv  $a nno X Y $.
nno-sy  $a nno X f $.
nno-bot $a nno X \bot $.
${
    nno-imp.1 $e npo X P $.
    nno-imp.2 $e nno X Q $.
    nno-imp   $a nno X ( \imp P Q ) $.
$}

${
    nno-app.1 $e nno X P $.
    nno-app.2 $e nno X Q $.
    nno-app   $a nno X ( \app P Q ) $.
$}

${
   nno-ex.1 $e nno X P $.
   nno-ex   $a nno X ( \ex x P ) $.
$}

nno-mu-binding $a nno X ( \mu X P ) $.

${
    $d X Y $.
    nno-mu-body.1 $e nno X P $.
    nno-mu-body   $a nno X ( \mu X P ) $.
$}

npo-ev  $a npo X x $.
npo-sv  $a npo X Y $.
npo-sy  $a npo X f $.
npo-bot $a npo X \bot $.
${
    npo-imp.1 $e nno X P $.
    npo-imp.2 $e npo X Q $.
    npo-imp   $a npo X ( \imp P Q ) $.
$}

${
    npo-app.1 $e npo X P $.
    npo-app.2 $e npo X Q $.
    npo-app   $a npo X ( \app P Q ) $.
$}

${
   npo-ex.1 $e npo X P $.
   npo-ex   $a npo X ( \ex x P ) $.
$}

npo-mu-binding $a npo X ( \mu X P ) $.

${
    $d X Y $.
    npo-mu-body.1 $e npo X P $.
    npo-mu-body   $a npo X ( \mu X P ) $.
$}

$( Define substitution: subst result origin replacer variable $)

substev-ev-same $a subst R y R y $.
${
    $d x y $.
    substev-ev-diff $a subst x x R y $.
$}
substev-sv  $a subst X X R y $.
substev-sy  $a subst f f R y $.
substev-bot $a subst \bot \bot R y $.
${
    substev-imp.1 $e subst P' P R y $.
    substev-imp.2 $e subst Q' Q R y $.
    substev-imp   $a subst ( \imp P' Q' ) ( \imp P Q ) R y $.
$}
${
    substev-app.1 $e subst P' P R y $.
    substev-app.2 $e subst Q' Q R y $.
    substev-app   $a subst ( \app P' Q' ) ( \app P Q ) R y $.
$}
substev-ex-binding $a subst ( \ex y P ) ( \ex y P ) R y $.
${
    $d x y z $.
    substev-ex-body.1 $e subst Q P z x $.
    substev-ex-body.2 $e subst Q' Q R y $.
    substev-ex-body   $a subst ( \ex z Q' ) ( \ex x P ) R y $.
$}
${
    substev-mu.1 $e subst P' P R y $.
    substev-mu   $a subst ( \mu X P' ) ( \mu X P ) R y $.
$}

substsv-sv-same $a subst R Y R Y $.
${
    $d X Y $.
    substsv-sv-diff $a subst X X R Y $.
$}
substsv-ev  $a subst x x R Y $.
substsv-sY  $a subst f f R Y $.
substsv-bot $a subst \bot \bot R Y $.
${
    substsv-imp.1 $e subst P' P R Y $.
    substsv-imp.2 $e subst Q' Q R Y $.
    substsv-imp   $a subst ( \imp P' Q' ) ( \imp P Q ) R Y $.
$}
${
    substsv-app.1 $e subst P' P R Y $.
    substsv-app.2 $e subst Q' Q R Y $.
    substsv-app   $a subst ( \app P' Q' ) ( \app P Q ) R Y $.
$}
${
    substsv-ex.1 $e subst P' P R Y $.
    substsv-ex   $a subst ( \ex x P' ) ( \ex x P ) R Y $.
$}
substsv-mu-binding $a subst ( \ex Y P ) ( \ex Y P ) R Y $.
${
    $d X Y Z $.
    substsv-mu-body.1 $e subst Q P Z X $.
    substsv-mu-body.2 $e subst Q' Q R Y $.
    substsv-mu-body   $a subst ( \mu Z Q' ) ( \mu X P ) R Y $.
$}

$( Define appliation context checking: appctx $)

appctx-ini $a appctx x x $.
${
    appctx-app-left.1 $e appctx P x $.
    appctx-app-left.2 $e fresh x Q $.
    appctx-app-left   $a appctx ( \app P Q ) x $.
$}
${
    appctx-app-right.1 $e appctx Q x $.
    appctx-app-right.2 $e fresh x P $.
    appctx-app-right   $a appctx ( \app P Q ) x $.
$}

$(  ######### Proof Rules ############### $)



$( State the propositional axioms $)
ax1 $a |- ( \imp P ( \imp Q P ) ) $.
ax2 $a |- ( \imp ( \imp P ( \imp Q R ) )
                   ( \imp ( \imp P Q ) ( \imp P R ) ) ) $.
ax3 $a |- ( ( ( \imp P \bot ) \bot ) P ) $.
${
    mp.1   $e |- P $.
    mp.2   $e |- ( \imp P Q ) $.
    mp     $a |- Q $.
$}

$( State the FOL reasoning axioms $)




$(  ######### Derive metatheorems ############### $)

$( Prove our first (meta-)theorem:
         |- P -> (Q -> R)
    -------------------------
     |- (P -> Q) -> (P -> R)
$)

${
    ax2-inf.1 $e |- ( \imp P ( \imp Q R ) ) $.
    ax2-inf   $p |- ( \imp ( \imp P Q ) ( \imp P R ) ) $=
      wfP wfQ wfR wfimp wfimp wfP wfQ wfimp wfP wfR wfimp wfimp ax2-inf.1 wfP
      wfQ wfR ax2 mp $.
$}

$( When defining an additional logic construct (syntactic sugar):
   1. Add metamath constant declaration;
   2. Define wellformedness: wf;
   3. Define fresh, subst, nno, npo
$)

$( Deifne negation as alias $)
$c \neg $.
wfneg $a wf ( \neg P ) $.
${
   freshev-neg.1 $e fresh x P $.
   freshev-neg   $a fresh x ( \neg P ) $.
$}
${
   freshsv-neg.1 $e fresh X P $.
   freshsv-neg   $a fresh X ( \neg P ) $.
$}
${
   substev-neg.1 $e subst P P R y $.
   substev-neg   $a subst ( \neg P' ) ( \neg P ) R y $.
$}
${
   substsv-neg.1 $e subst P P R Y $.
   substsv-neg   $a subst ( \neg P' ) ( \neg P ) R Y $.
$}
${
   nno-neg.1 $e npo X P $.
   nno-neg   $a nno X ( \neg P ) $.
$}
${
   npo-neg.1 $e nno X P $.
   npo-neg   $a npo X ( \neg P ) $.
$}




$( Define double implication as alias $)
$c \dimp $.
wfdimp $a wf ( \dimp P Q ) $.
${
   freshev-dimp.1 $e fresh x ( \imp P Q ) $.
   freshev-dimp   $a fresh x ( \dimp P Q ) $.
$}
${
   freshsv-dimp.1 $e fresh X ( \imp P Q ) $.
   freshsv-dimp   $a fresh X ( \dimp P Q ) $.
$}
${
   substev-dimp.1 $e subst ( \imp P' Q' ) ( \imp P Q ) R y $.
   substev-dimp   $a subst ( \dimp P' Q' ) ( \dimp P Q ) R y $.
$}
${
   substsv-dimp.1 $e subst ( \imp P' Q' ) ( \imp P Q ) R Y $.
   substsv-dimp   $a subst ( \dimp P' Q' ) ( \dimp P Q ) R Y $.
$}
${
   nno-dimp.1 $e fresh X P $.
   nno-dimp.2 $e fresh X Q $.
   nno-dimp   $a nno X ( \dimp P Q ) $.
$}
${
   npo-dimp.1 $e fresh X P $.
   npo-dimp.2 $e fresh X Q $.
   npo-dimp   $a npo X ( \dimp P Q ) $.
$}

