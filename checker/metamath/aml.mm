$( 
    Declare AML pattern constructs, one per line. 
$)

$c \bot $.    $( the bottom pattern $)
$c \imp $.    $( the implication pattern ( \imp P Q ) $)
$c \app $.    $( the application pattern ( \app P Q ) $)
$c \exists $. $( the exists quantifier ( \ex x P ) $)
$c \mu $.     $( the mu fixpoint binder ( \mu X P ) $)

$(
    Declare parentheses for pattern grouping.
$)

$c ( $. $( left  parenthesis $)
$c ) $. $( right parenthesis $)


$( 
    Declare AML's syntactic categories.
$)

$c wf $.   $( wellformedness token, 
              read as "the following token sequence forms a wellformed pattern" $)
$c var $.  $( AML variables token,
              read as "the following token sequence forms a variable" $)
              
$(
    A varialbe is either an element variable or a set variable. 
$)

$c evar $. $( element variables token,
              read as "the following token sequence forms an element variable" $)
$c svar $. $( set variables token,
              read as "the following token sequence forms a set variable" $)
$c symb $. $( AML symbols token,
              read as "the following token sequence forms an AML symbol" $)

$(
    Declare AML provability relation, the token "|-",
    read as "the following token sequence forms a provable pattern".
$)

$c |- $. $( the provability token $)

$(
    We declare some auxiliary stuffs of AML's metalevel.
$)

$c npositive $. $( non-positive occurrence token, whose expected form is "npositive X P",
                   read as "the set variable X does not occur positively in P". $)
                   
$c nnegative $. $( non-negative occurrence token, whose expected form is "nnegative X P",
                   read as "the set variable X does not occur negatively in P". $)

$c nfree $. $( not-occur-free token, whose expected form is "nfree xx P",
               read as "the variable xx does not occur free in P". $)
               
$c subst $. $( capture-avoiding substitution, whose expected form is "subst P Q R xx",
               read as "P is the result of substituting R for xx in Q". $)
               
$c appctx $. $( application context token, whose expected form is "appctx P xx",
                read as "P is an application context wrt variable xx". $)

$( 
    Declare metamath variables 
$)

$v 
    P Q R P' Q' R' 
    x y z 
    X Y Z 
    f g h 
    xx yy
$.

$( 
    State the ranges of the above metamath variables.
$)

wfP   $f wf P $.
wfPp  $f wf P' $.
wfQ   $f wf Q $.
wfQp  $f wf Q' $.
wfRp  $f wf R' $.
wfR   $f wf R $.

evarx $f evar x $.
evary $f evar y $.
evarz $f evar z $.

svarX $f svar X $.
svarY $f svar Y $.
svarZ $f svar Z $.

symbf $f symb f $.
symbg $f symb g $.
symbh $f symb h $.

varxx $f var xx $.
varyy $f var yy $.

$(
    State that element/set variables are variables.
$)

varevar $a var x $.
varsvar $a var X $.

$(
    Define wellformedness token "wf ...". 
$)

wfvar    $a wf xx $. 
wfbot    $a wf \bot $.
wfimp    $a wf ( \imp P Q ) $.
wfapp    $a wf ( \app P Q ) $.
wfexists $a wf ( \exists x P ) $.
${
    wfmu.nnegative $e nnegative X P $.
    wfmu           $a wf ( \mu X P ) $.
$}

$(
    Prove that element/set variables are wellformed patterns,
    (because they are variables and variables are wellformed patterns).
$)

${
    wfevar $p wf x $=
      evarx varevar wfvar $.
$}

${
    wfsvar $p wf X $=
      svarX varsvar wfvar $.
$}

$( 
    Define nfree token "nfree xx P".
$)

${
    $d xx yy $.
	nfree-var $a nfree xx yy $.
$}

nfree-symb $a nfree xx f $.
nfree-bot  $a nfree xx \bot $.

${
    nfree-imp.1 $e nfree xx P $.
    nfree-imp.2 $e nfree xx Q $.
    nfree-imp   $a nfree xx ( \imp P Q ) $.
$}

${
    nfree-app.1 $e nfree xx P $.
    nfree-app.2 $e nfree xx Q $.
    nfree-app   $a nfree xx ( \app P Q ) $.
$}

nfree-exists-binding $a nfree x ( \exists x P ) $.

${
    $d xx y $.
    nfree-exists-body.1 $e nfree xx P $.
    nfree-exists-body   $a nfree xx ( \exists y P ) $.
$}

nfree-mu-binding $a nfree X ( \mu X P ) $.

${
    $d xx Y $.
    nfree-mu-body.1 $e nfree xx P $.
    nfree-mu-body   $a nfree xx ( \exists Y P ) $.
$}

$(
    Define non-negative occurrence token "nnegative X P".
$)

nnegative-var  $a nnegative X xx $.
nnegative-symb $a nnegative X f $.
nnegative-bot  $a nnegative X \bot $.
${
    nnegative-imp.1 $e npositive X P $.
    nnegative-imp.2 $e nnegative X Q $.
    nnegative-imp   $a nnegative X ( \imp P Q ) $.
$}

${
    nnegative-app.1 $e nnegative X P $.
    nnegative-app.2 $e nnegative X Q $.
    nnegative-app   $a nnegative X ( \app P Q ) $.
$}

${
   nnegative-exists.1 $e nnegative X P $.
   nnegative-exists   $a nnegative X ( \exists x P ) $.
$}

nnegative-mu-binding $a nnegative X ( \mu X P ) $.

${
    $d X Y $.
    nnegative-mu-body.1 $e nnegative X P $.
    nnegative-mu-body   $a nnegative X ( \mu Y P ) $.
$}

$(
    Define non-positive occurrence token "npositive X P".
$)

npositive-evar  $a npositive X x $.
${
    $d X Y $.
    npositive-svar  $a npositive X Y $.
$}
npositive-symb $a npositive X f $.
npositive-bot  $a npositive X \bot $.
${
    npositive-imp.1 $e nnegative X P $.
    npositive-imp.2 $e npositive X Q $.
    npositive-imp   $a npositive X ( \imp P Q ) $.
$}

${
    npositive-app.1 $e npositive X P $.
    npositive-app.2 $e npositive X Q $.
    npositive-app   $a npositive X ( \app P Q ) $.
$}

${
   npositive-exists.1 $e npositive X P $.
   npositive-exists   $a npositive X ( \exists x P ) $.
$}

npositive-mu-binding $a npositive X ( \mu X P ) $.

${
    $d X Y $.
    npositive-mu-body.1 $e npositive X P $.
    npositive-mu-body   $a npositive X ( \mu Y P ) $.
$}

$( 
    Define capture-avoiding substitution "subst P Q R xx",
    meaning that P is the result of substituting R for xx in Q.
    Note that xx can be either element variable or set variable.
$)

subst-var-same $a subst R xx R xx $.

${
    $d xx yy $.
    subst-var-diff $a subst yy yy R xx $.
$}

subst-symb  $a subst f f R xx $.
subst-bot $a subst \bot \bot R xx $.

${
    subst-imp.1 $e subst P  Q  R xx $.
    subst-imp.2 $e subst P' Q' R xx $.
    subst-imp   $a subst ( \imp P P' ) ( \imp Q Q' ) R xx $.
$}

${
    subst-app.1 $e subst P  Q  R xx $.
    subst-app.2 $e subst P' Q' R xx $.
    subst-app   $a subst ( \app P P' ) ( \app Q Q' ) R xx $.
$}

subst-exists-binding $a subst ( \exists x Q ) ( \exists x Q ) R x $.

${
    $d y xx z $.
    subst-exists-body.1 $e subst Q P z y $.
    subst-exists-body.2 $e subst Q' Q R xx $.
    subst-exists-body   $a subst ( \exists z Q' ) ( \exists y P ) R xx $.
$}

subst-mu-binding $a subst ( \mu X P ) ( \mu X P ) R X $.

${
    $d Y xx Z $.
    subst-mu-body.1 $e subst Q P Z Y $.
    subst-mu-body.2 $e subst Q' Q R xx $.
    subst-mu-body   $a subst ( \mu Z Q' ) ( \mu Y P ) R xx $.
$}

$(
    Define appliation context "appctx P xx".
$)

appctx-var $a appctx xx xx $.

${
    appctx-app-left.1 $e appctx P xx $.
    appctx-app-left.2 $e nfree xx Q $.
    appctx-app-left   $a appctx ( \app P Q ) xx $.
$}

${
    appctx-app-right.1 $e appctx Q xx $.
    appctx-app-right.2 $e nfree xx P $.
    appctx-app-right   $a appctx ( \app P Q ) xx $.
$}

$(
    Define the metalevel equality token "me".
$)

$c metaeq $.

metaeq-self $a metaeq P P $.

${
    metaeq-imp.1 $e metaeq P  Q $.
	metaeq-imp.2 $e metaeq P' Q' $.
	metaeq-imp   $a metaeq ( \imp P P' ) ( \imp Q Q' ) $.
$}

${
    metaeq-app.1 $e metaeq P Q $.
	metaeq-app.2 $e metaeq P' Q' $.
	metaeq-app   $a metaeq ( \app P P' ) ( \app Q Q' ) $.
$}

${
    metaeq-exists.1 $e metaeq x y $.
	metaeq-exists.2 $e metaeq P Q $.
	metaeq-exists   $a metaeq ( \exists x P ) ( \exists y Q ) $.
$}

${
    metaeq-mu.1 $e metaeq x y $.
	metaeq-mu.2 $e metaeq P Q $.
	metaeq-mu   $a metaeq ( \mu x P ) ( \mu y Q ) $.
$}

$(
    Propagate metalevel equality "metaeq" everywhere.
$)

$(  DON'T NEED THESE RIGHT NOW.
	metaeq-wf.1 $e wf Q $.
	metaeq-wf.2 $e metaeq P Q $.
	metaeq-wf   $a wf P $.
$)

$(  DON'T NEED THESE RIGHT NOW.
	metaeq-var.1 $e var yy $.
	metaeq-var.2 $e metaeq xx yy $.
	metaeq-var   $a var xx $.
$)

$(  DON'T NEED THESE RIGHT NOW.
	metaeq-evar.1 $e ev y $.
	metaeq-evar.2 $e metaeq x y $.
	metaeq-evar   $a ev x $.
$)

$(  DON'T NEED THESE RIGHT NOW. 
	metaeq-svar.1 $e sv Y $.
	metaeq-svar.2 $e metaeq X Y $.
	metaeq-svar   $a sv X $.
$)

$(  DON'T NEED THESE RIGHT NOW. 
	metaeq-symb.1 $e symb g $.
	metaeq-symb.2 $e metaeq f g $.
	metaeq-symb   $a symb f $.
$)

${
    metaeq-nfree.1 $e nfree yy Q $.
    metaeq-nfree.2 $e metaeq xx yy $.
	metaeq-nfree.3 $e metaeq P Q $.
    metaeq-nfree   $a nfree xx P $.
$}

${
	metaeq-subst.1 $e subst P' Q' R' xx $.
	metaeq-subst.2 $e metaeq P P' $.
	metaeq-subst.3 $e metaeq Q Q' $.
	metaeq-subst.4 $e metaeq R R' $.
	metaeq-subst.5 $e metaeq yy xx $.
	metaeq-subst $a subst P Q R yy $.
$}

${
    metaeq-nnegative.1 $e nnegative Y Q $.
	metaeq-nnegative.2 $e metaeq X Y $.
	metaeq-nnegative.3 $e metaeq P Q $.
    metaeq-nnegative   $a nnegative X P $.
$}

${
    metaeq-npositive.1 $e npositive Y Q $.
	metaeq-npositive.2 $e metaeq X Y $.
	metaeq-npositive.3 $e metaeq P Q $.
    metaeq-npositive   $a npositive X P $.
$}

${
    metaeq-appctx.1 $e appctx y Q $.
	metaeq-appctx.2 $e metaeq x y $.
	metaeq-appctx.3 $e metaeq P Q $.
    metaeq-appctx   $a appctx x P $.
$}

${
    metaeq-thm.1 $e |- Q $.
	metaeq-thm.2 $e metaeq P Q $.
    metaeq-thm   $a |- P $.
$}

$(
    State AML proof rules (prule).
$)

$(
    AML proof rules Part A: Propositional reasoning.
$)

prule-proposition-1 $a |- ( \imp P ( \imp Q P ) ) $.

prule-proposition-2 $a |- ( \imp ( \imp P ( \imp Q R ) )
                                 ( \imp ( \imp P Q ) ( \imp P R ) ) ) $.
				   
prule-proposition-3 $a |- ( \imp ( \imp ( \imp P \bot ) \bot ) P ) $.

${
    prule-mp.1   $e |- P $.
    prule-mp.2   $e |- ( \imp P Q ) $.
    prule-mp     $a |- Q $.
$}

$(
    AML proof rules Part B: FOL reasoning.
$)

${
	prule-exists-inst.1 $e subst P Q y x $.
	prule-exists-inst   $a |- ( \imp P ( \exists x Q ) ) $.
$}

${
    prule-exists-gen.1 $e |- ( \imp P Q ) $.
	prule-exists-gen.2 $e nfree x P $.
	prule-exists-gen   $a |- ( \imp P ( \exists x Q ) ) $.
$}

$(
    AML proof rules Part C: Frame reasoning.
$)

$( ... $)

$(
    AML proof rules Part D: Fixpoint reasoning.
$)

$( ... $)

$(
    AML proof rules Part E: Misc technical proof rules.
$)

$( ... $)

$( 
    Our first theorem.
$)

${
    p2inf.1 $e |- ( \imp P ( \imp Q R ) ) $.
    p2inf   $p |- ( \imp ( \imp P Q ) ( \imp P R ) ) $=
      wfP wfQ wfR wfimp wfimp wfP wfQ wfimp wfP wfR wfimp wfimp p2inf.1 wfP
      wfQ wfR prule-proposition-2 prule-mp $.
$}

${
    nflipb $p |- ( \imp ( \imp ( \imp P \bot ) ( \imp Q \bot ) ) ( \imp Q P ) ) $= ? $.
$}

$( 
    Our first definition: negation.
    ( \neg P ) === ( \imp P \bot ) 
$)

$c \neg $.

wfneg  $a wf ( \neg P ) $. $( Ideally we do not even need this one. $)

df-neg $a metaeq ( \neg P ) ( \imp P \bot ) $.

$( 
    Prove metalevel properties about negations.
$)

${
	nfree-neg.1 $e nfree xx P $.
	nfree-neg   $p nfree xx ( \neg P ) $=
  wfP wfneg wfP wfbot wfimp varxx varxx wfP wfbot varxx nfree-neg.1 varxx
  nfree-bot nfree-imp varxx wfvar metaeq-self wfP df-neg metaeq-nfree $.
$}

${
    subst-neg.1 $e subst P' P R yy $.
    subst-neg   $p subst ( \neg P' ) ( \neg P ) R yy $=
      wfPp wfneg wfPp wfbot wfimp wfP wfneg wfP wfbot wfimp wfR wfR varyy varyy
      wfPp wfbot wfP wfbot wfR varyy subst-neg.1 wfR varyy subst-bot subst-imp
      wfPp df-neg wfP df-neg wfR metaeq-self varyy wfvar metaeq-self
      metaeq-subst $.
$}

${
    nnegative-neg.1 $e npositive X P $.
    nnegative-neg   $p nnegative X ( \neg P ) $=
      wfP wfneg wfP wfbot wfimp svarX svarX wfP wfbot svarX nnegative-neg.1 
      svarX nnegative-bot nnegative-imp svarX wfsvar metaeq-self wfP df-neg 
      metaeq-nnegative $.
$}

${
    npositive-neg.1 $e nnegative X P $.
    npositive-neg   $p npositive X ( \neg P ) $=
      wfP wfneg wfP wfbot wfimp svarX svarX wfP wfbot svarX npositive-neg.1 
      svarX npositive-bot npositive-imp svarX wfsvar metaeq-self wfP df-neg 
      metaeq-npositive $.
$}

$( 
    Prove some metatheorems about negations. 
$)

${
    nn $p |- ( \imp ( \neg ( \neg P ) ) P ) $=
      wfP wfneg wfneg wfP wfimp wfP wfneg wfbot wfimp wfP wfimp wfP wfneg wfbot
      wfimp wfP wfimp wfP wfbot wfimp wfbot wfimp wfP wfimp wfP
      prule-proposition-3 wfP wfneg wfbot wfimp wfP wfP wfbot wfimp wfbot wfimp
      wfP wfP wfneg wfbot wfP wfbot wfimp wfbot wfP df-neg wfbot metaeq-self
      metaeq-imp wfP metaeq-self metaeq-imp metaeq-thm wfP wfneg wfneg wfP wfP
      wfneg wfbot wfimp wfP wfP wfneg df-neg wfP metaeq-self metaeq-imp
      metaeq-thm $.
$}

${
    nflip $p |- ( \imp ( \imp ( \neg P ) ( \neg Q ) ) ( \imp Q P ) ) $=
      wfP wfneg wfQ wfneg wfimp wfQ wfP wfimp wfimp wfP wfbot wfimp wfQ wfbot
      wfimp wfimp wfQ wfP wfimp wfimp wfP wfQ nflipb wfP wfneg wfQ wfneg wfimp
      wfQ wfP wfimp wfP wfbot wfimp wfQ wfbot wfimp wfimp wfQ wfP wfimp wfP
      wfneg wfQ wfneg wfP wfbot wfimp wfQ wfbot wfimp wfP df-neg wfQ df-neg
      metaeq-imp wfQ wfP wfimp metaeq-self metaeq-imp metaeq-thm $.
$}

$(
    Defind \forall x P === \neg ( \exists x ( \neg P ) )
$)

$c \forall $.

wfforall $a \forall x P $.

df-forall $a metaeq ( \forall x P ) ( \neg ( \exists x ( \neg P ) ) ) $.




