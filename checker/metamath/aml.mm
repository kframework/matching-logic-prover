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
    P Q R P' Q' R' x y z X Y Z f g h xx yy
$.

$( Specify the ranges of metamath variables $)
wfP $f wf P $.
wfPp $f wf P' $.
wfQ $f wf Q $.
wfQp $f wf Q' $.
wfRp $f wf R' $.
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
varxx $f var xx $.
varyy $f var yy $.

$( Variables = Element variables + Set variables. $)
evar $a var x $.
svar $a var X $.

$( Define wellformedness patterns: wf $)
wfev   $a wf x $. $( this shouldn't be needed $)
wfsv   $a wf X $. $( this shuoldn't be needed $)
wfvar  $a wf xx $. 
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
    $d xx yy $.
	fresh-var $a fresh xx yy $.
$}

fresh-sy  $a fresh xx f $.
fresh-bot $a fresh xx \bot $.

${
    fresh-imp.1 $e fresh xx P $.
    fresh-imp.2 $e fresh xx Q $.
    fresh-imp   $a fresh xx ( \imp P Q ) $.
$}

${
    fresh-app.1 $e fresh xx P $.
    fresh-app.2 $e fresh xx Q $.
    fresh-app   $a fresh xx ( \app P Q ) $.
$}

fresh-exbinding $a fresh x ( \ex x P ) $.

${
    $d xx y $.
    fresh-exbody.1 $e fresh xx P $.
    fresh-exbody   $a fresh xx ( \ex y P ) $.
$}

fresh-mubinding $a fresh X ( \mu X P ) $.

${
    $d xx Y $.
    fresh-mubody.1 $e fresh xx P $.
    fresh-mubody   $a fresh xx ( \ex Y P ) $.
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

subst-varsame $a subst R xx R xx $.

${
    $d xx yy $.
    subst-vardiff $a subst x xx R yy $.
$}

subst-sy  $a subst f f R yy $.
substev-bot $a subst \bot \bot R yy $.

${
    subst-imp.1 $e subst P' P R yy $.
    subst-imp.2 $e subst Q' Q R yy $.
    subst-imp   $a subst ( \imp P' Q' ) ( \imp P Q ) R yy $.
$}

${
    subst-app.1 $e subst P' P R yy $.
    subst-app.2 $e subst Q' Q R yy $.
    subst-app   $a subst ( \app P' Q' ) ( \app P Q ) R yy $.
$}

subst-exbinding $a subst ( \ex y P ) ( \ex y P ) R y $.

${
    $d x yy z $.
    subst-exbody.1 $e subst Q P z x $.
    subst-exbody.2 $e subst Q' Q R yy $.
    subst-exbody   $a subst ( \ex z Q' ) ( \ex x P ) R yy $.
$}

subst-mubinding $a subst ( \mu Y P ) ( \mu Y P ) R Y $.

${
    $d X yy Z $.
    subst-mubody.1 $e subst Q P Z X $.
    subst-mubody.2 $e subst Q' Q R yy $.
    subst-mubody   $a subst ( \mu Z Q' ) ( \mu X P ) R yy $.
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

$( State the metalevel equality: me $)

$c me $.

$( Define metalevel equality over patterns $)

df-me-var $a me xx xx $.
df-me-sy  $a me f f $.
df-me-bot $a me \bot \bot $.
${
    df-me-imp.1 $e me P P' $.
	df-me-imp.2 $e me Q Q' $.
	df-me-imp $a me ( \imp P Q ) ( \imp P' Q' ) $.
$}
${
    df-me-app.1 $e me P P' $.
	df-me-app.2 $e me Q Q' $.
	df-me-app $a me ( \app P Q ) ( \app P' Q' ) $.
$}
${
    df-me-ex.1 $e me x y $.
	df-me-ex.2 $e me P Q $.
	df-me-ex   $a me ( \ex x P ) ( \ex y Q ) $.
$}
${
    df-me-mu.1 $e me x y $.
	df-me-mu.2 $e me P Q $.
	df-me-mu   $a me ( \mu x P ) ( \mu y Q ) $.
$}

$( Propagate metalevel equality everywhere $)

$(
	me-wf.1 $e wf Q $.
	me-wf.2 $e me P Q $.
	me-wf   $a wf P $.
$)
${ 
	me-var.1 $e var yy $.
	me-var.2 $e me xx yy $.
	me-var   $a var xx $.
$}
${ 
	me-ev.1 $e ev y $.
	me-ev.2 $e me x y $.
	me-ev   $a ev x $.
$}
${ 
	me-sv.1 $e sv Y $.
	me-sv.2 $e me X Y $.
	me-sv   $a sv X $.
$}
${ 
	me-sy.1 $e sy g $.
	me-sy.2 $e me f g $.
	me-sy   $a sy f $.
$}
${  
	me-fresh.1 $e fresh yy Q $.
    me-fresh.2 $e me xx yy $.
	me-fresh.3 $e me P Q $.
    me-fresh $a fresh xx P $.
$}
${
	me-subst.1 $e subst P' Q' R' xx $.
	me-subst.2 $e me P P' $.
	me-subst.3 $e me Q Q' $.
	me-subst.4 $e me R R' $.
	me-subst.5 $e me yy xx $.
	me-subst $a subst P Q R yy $.
$}
${
    me-nno.1 $e nno Y Q $.
	me-nno.2 $e me X Y $.
	me-nno.3 $e me P Q $.
    me-nno   $a nno X P $.
$}
${
    me-npo.1 $e npo Y Q $.
	me-npo.2 $e me X Y $.
	me-npo.3 $e me P Q $.
    me-npo   $a npo X P $.
$}
${
    me-appctx.1 $e appctx y Q $.
	me-appctx.2 $e me x y $.
	me-appctx.3 $e me P Q $.
    me-appctx $a appctx x P $.
$}
${
    me-thm.1 $e |- Q $.
	me-thm.2 $e me P Q $.
    me-thm   $a |- P $.
$}

$( State the propositional rules $)

ax1 $a |- ( \imp P ( \imp Q P ) ) $.

ax2 $a |- ( \imp ( \imp P ( \imp Q R ) )
                   ( \imp ( \imp P Q ) ( \imp P R ) ) ) $.
				   
ax3 $a |- ( ( ( \imp P \bot ) \bot ) P ) $.

${
    mp.1   $e |- P $.
    mp.2   $e |- ( \imp P Q ) $.
    mp     $a |- Q $.
$}

$( State the FOL reasoning rules $)

${
	ax4.1 $e subst P' P y x $.
	ax4   $a |- ( \imp P' ( \ex x P ) ) $.
$}

${
	ug.1 $e fresh x P $.
	ug   $a |- ( \imp P ( \ex x Q ) ) $.
$}

$( State the frame reasoning rules $)
$( ... $)

$( State the fixpoint reasoning rules $)
$( ... $)

$( State technical rules $)
$( ... $)

$( Our first theorem:
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

$( Deifne negation ( \neg P ) === ( \imp P \bot ) $)
$c \neg $.
wfneg  $a wf ( \neg P ) $. $( We don't even need this one $)
df-neg $a me ( \neg P ) ( \imp P \bot ) $.

$( Prove metalevel properties about negations $)
${
	fresh-neg.1 $e fresh xx P $.
	fresh-neg   $p fresh xx ( \neg P ) $=
  wfP wfneg wfP wfbot wfimp varxx varxx wfP wfbot varxx fresh-neg.1 varxx
  fresh-bot fresh-imp varxx df-me-var wfP df-neg me-fresh $.
$}


