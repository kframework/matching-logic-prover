$( 
    Declare AML pattern constructs, one per line. 
$)

$c \bot $.    $( the bottom pattern $)
$c \imp $.    $( the implication pattern ( \imp P Q ) $)
$c \app $.    $( the application pattern ( \app P Q ) $)
$c \exists $. $( the exists quantifier ( \exists x P ) $)
$c \mu $.     $( the mu fixpoint binder ( \mu X P ) $)

$(
    Declare parentheses for pattern grouping.
$)

$c ( $. $( left  parenthesis $)
$c ) $. $( right parenthesis $)


$( 
    Declare AML's syntactic categories.
$)

$c #wf $.     $( wellformedness token, 
                 read as "the following token sequence forms a wellformed pattern" $)
$c #var $.    $( AML variables token,
                 read as "the following token sequence forms a variable" $)
$c #symb $.   $( AML symbols token,
                 read as "the following token sequence forms an AML symbol" $)
              
$(
    A varialbe is either an element variable or a set variable. 
$)

$c #evar $. $( element variables token,
              read as "the following token sequence forms an element variable" $)
$c #svar $. $( set variables token,
              read as "the following token sequence forms a set variable" $)

$(
    Declare AML provability relation, the token "|-",
    read as "the following token sequence forms a provable pattern".
$)

$c |- $. $( the provability token $)

$( 
    Declare metamath variables 
$)

$v 
	P Q R P' Q' R' 
    x y z 
    X Y Z 
    f g h 
    xX yY
$.

$( 
    State the ranges of the above metamath variables.
$)

wfP   $f #wf P $.
wfQ   $f #wf Q $.
wfR   $f #wf R $.
wfPp  $f #wf P' $.
wfQp  $f #wf Q' $.
wfRp  $f #wf R' $.

evarx $f #evar x $.
evary $f #evar y $.
evarz $f #evar z $.

svarX $f #svar X $.
svarY $f #svar Y $.
svarZ $f #svar Z $.

symbf $f #symb f $.
symbg $f #symb g $.
symbh $f #symb h $.

varxX $f #var xX $.
varyY $f #var yY $.

$(
    State that element/set variables are variables.
$)

varevar $a #var x $.
varsvar $a #var X $.

$(
    We declare some auxiliary stuffs of AML's metalevel.
$)

$c #npositive $. $( non-positive occurrence token, whose expected form is "#npositive X P",
                    read as "the set variable X does not occur positively in P". $)
                   
$c #nnegative $. $( non-negative occurrence token, whose expected form is "#nnegative X P",
                    read as "the set variable X does not occur negatively in P". $)

$c #nfree $. $( not-occur-free token, whose expected form is "#nfree xX P",
                read as "the variable xX does not occur free in P". $)
            
$c \subst $. $( capture-avoiding substitution, whose expected form is "\subst P Q xx",
                denoting the result of substitution. $)
               
$c #appctx $. $( application context token, whose expected form is "#appctx P xx",
                read as "P is an application context wrt variable xx". $)
				
$c #subst $.  $( TO BE REMOVED $)

$(
    Define wellformedness token "wf ...". 
$)

wfvar    $a #wf xX $. 
wfbot    $a #wf \bot $.
wfimp    $a #wf ( \imp P Q ) $.
wfapp    $a #wf ( \app P Q ) $.
wfexists $a #wf ( \exists x P ) $.
${
    wfmu.nnegative $e #nnegative X P $.
    wfmu           $a #wf ( \mu X P ) $.
$}

$(
    Prove that element/set variables are wellformed patterns,
    (because they are variables and variables are wellformed patterns).
$)

${
    wfevar $p #wf x $=
      evarx varevar wfvar $.
$}

${
    wfsvar $p #wf X $=
      svarX varsvar wfvar $.
$}

$( 
    Define #nfree token "#nfree xX P".
$)

${
    $d xX yY $.
    nfree-var $a #nfree xX yY $.
$}

nfree-symb $a #nfree xX f $.
nfree-bot  $a #nfree xX \bot $.

${
    nfree-imp.1 $e #nfree xX P $.
    nfree-imp.2 $e #nfree xX Q $.
    nfree-imp   $a #nfree xX ( \imp P Q ) $.
$}

${
    nfree-app.1 $e #nfree xX P $.
    nfree-app.2 $e #nfree xX Q $.
    nfree-app   $a #nfree xX ( \app P Q ) $.
$}

nfree-exists-binding $a #nfree x ( \exists x P ) $.

${
    $d xX y $.
    nfree-exists-body.1 $e #nfree xX P $.
    nfree-exists-body   $a #nfree xX ( \exists y P ) $.
$}

nfree-mu-binding $a #nfree X ( \mu X P ) $.

${
    $d xX Y $.
    nfree-mu-body.1 $e #nfree xX P $.
    nfree-mu-body   $a #nfree xX ( \exists Y P ) $.
$}

$(
    Define non-negative occurrence token "nnegative X P".
$)

nnegative-var  $a #nnegative X xX $.
nnegative-symb $a #nnegative X f $.
nnegative-bot  $a #nnegative X \bot $.
${
    nnegative-imp.1 $e #npositive X P $.
    nnegative-imp.2 $e #nnegative X Q $.
    nnegative-imp   $a #nnegative X ( \imp P Q ) $.
$}

${
    nnegative-app.1 $e #nnegative X P $.
    nnegative-app.2 $e #nnegative X Q $.
    nnegative-app   $a #nnegative X ( \app P Q ) $.
$}

${
   nnegative-exists.1 $e #nnegative X P $.
   nnegative-exists   $a #nnegative X ( \exists x P ) $.
$}

nnegative-mu-binding $a #nnegative X ( \mu X P ) $.

${
    $d X Y $.
    nnegative-mu-body.1 $e #nnegative X P $.
    nnegative-mu-body   $a #nnegative X ( \mu Y P ) $.
$}

$(
    Define non-positive occurrence token "npositive X P".
$)

npositive-evar  $a #npositive X x $.
${
    $d X Y $.
    npositive-svar  $a #npositive X Y $.
$}
npositive-symb $a #npositive X f $.
npositive-bot  $a #npositive X \bot $.
${
    npositive-imp.1 $e #nnegative X P $.
    npositive-imp.2 $e #npositive X Q $.
    npositive-imp   $a #npositive X ( \imp P Q ) $.
$}

${
    npositive-app.1 $e #npositive X P $.
    npositive-app.2 $e #npositive X Q $.
    npositive-app   $a #npositive X ( \app P Q ) $.
$}

${
   npositive-exists.1 $e #npositive X P $.
   npositive-exists   $a #npositive X ( \exists x P ) $.
$}

npositive-mu-binding $a #npositive X ( \mu X P ) $.

${
    $d X Y $.
    npositive-mu-body.1 $e #npositive X P $.
    npositive-mu-body   $a #npositive X ( \mu Y P ) $.
$}

$( 
    Define capture-avoiding substitution "subst P Q R xx",
    meaning that P is the result of substituting R for xX in Q.
    Note that xX can be either element variable or set variable.
$)

subst-var-same $a #subst R xX R xX $.

${
    $d xX yY $.
    subst-var-diff $a #subst yY yY R xX $.
$}

subst-symb  $a #subst f f R xX $.
subst-bot $a #subst \bot \bot R xX $.

${
    subst-imp.1 $e #subst P  Q  R xX $.
    subst-imp.2 $e #subst P' Q' R xX $.
    subst-imp   $a #subst ( \imp P P' ) ( \imp Q Q' ) R xX $.
$}

${
    subst-app.1 $e #subst P  Q  R xX $.
    subst-app.2 $e #subst P' Q' R xX $.
    subst-app   $a #subst ( \app P P' ) ( \app Q Q' ) R xX $.
$}

subst-exists-binding $a #subst ( \exists x Q ) ( \exists x Q ) R x $.

${
    $d y xX z $.
    subst-exists-body.1 $e #subst Q P z y $.
    subst-exists-body.2 $e #subst Q' Q R xX $.
    subst-exists-body   $a #subst ( \exists z Q' ) ( \exists y P ) R xX $.
$}

subst-mu-binding $a #subst ( \mu X P ) ( \mu X P ) R X $.

${
    $d Y xX Z $.
    subst-mu-body.1 $e #subst Q P Z Y $.
    subst-mu-body.2 $e #subst Q' Q R xX $.
    subst-mu-body   $a #subst ( \mu Z Q' ) ( \mu Y P ) R xX $.
$}

$(
    Define appliation context "appctx P xx".
$)

appctx-var $a #appctx xX xX $.

${
    appctx-app-left.1 $e #appctx P xX $.
    appctx-app-left.2 $e #nfree xX Q $.
    appctx-app-left   $a #appctx ( \app P Q ) xX $.
$}

${
    appctx-app-right.1 $e #appctx Q xX $.
    appctx-app-right.2 $e #nfree xX P $.
    appctx-app-right   $a #appctx ( \app P Q ) xX $.
$}

$(
    Define the metalevel equality token "#eqq P Q".
$)

$c #eqq $.

eqq-self $a #eqq P P $.

$( Propagate $eqq through all metalevel definitions. $)

${
    eqq-imp.1 $e #eqq P  Q $.
    eqq-imp.2 $e #eqq P' Q' $.
    eqq-imp   $a #eqq ( \imp P P' ) ( \imp Q Q' ) $.
$}

${
    eqq-app.1 $e #eqq P Q $.
    eqq-app.2 $e #eqq P' Q' $.
    eqq-app   $a #eqq ( \app P P' ) ( \app Q Q' ) $.
$}

${
    eqq-exists.1 $e #eqq x y $.
    eqq-exists.2 $e #eqq P Q $.
    eqq-exists   $a #eqq ( \exists x P ) ( \exists y Q ) $.
$}

${
    eqq-mu.1 $e #eqq x y $.
    eqq-mu.2 $e #eqq P Q $.
    eqq-mu   $a #eqq ( \mu x P ) ( \mu y Q ) $.
$}

${
    eqq-wf.1 $e #wf Q $.
    eqq-wf.2 $e #eqq P Q $.
    eqq-wf   $a #wf P $.
$}

$(  DON'T NEED THESE RIGHT NOW.
    eqq-var.1 $e #var yY $.
    eqq-var.2 $e #eqq xX yY $.
    eqq-var   $a #var xX $.
$)

$(  DON'T NEED THESE RIGHT NOW.
    eqq-evar.1 $e ev y $.
    eqq-evar.2 $e #eqq x y $.
    eqq-evar   $a ev x $.
$)

$(  DON'T NEED THESE RIGHT NOW. 
    eqq-svar.1 $e sv Y $.
    eqq-svar.2 $e #eqq X Y $.
    eqq-svar   $a sv X $.
$)

$(  DON'T NEED THESE RIGHT NOW. 
    eqq-symb.1 $e #symb g $.
    eqq-symb.2 $e #eqq f g $.
    eqq-symb   $a #symb f $.
$)

${
    eqq-nfree.1 $e #nfree yY Q $.
    eqq-nfree.2 $e #eqq xX yY $.
    eqq-nfree.3 $e #eqq P Q $.
    eqq-nfree   $a #nfree xX P $.
$}

${
    eqq-subst.1 $e #subst P' Q' R' xX $.
    eqq-subst.2 $e #eqq P P' $.
    eqq-subst.3 $e #eqq Q Q' $.
    eqq-subst.4 $e #eqq R R' $.
    eqq-subst.5 $e #eqq yY xX $.
    eqq-subst $a #subst P Q R yY $.
$}

${
    eqq-nnegative.1 $e #nnegative Y Q $.
    eqq-nnegative.2 $e #eqq X Y $.
    eqq-nnegative.3 $e #eqq P Q $.
    eqq-nnegative   $a #nnegative X P $.
$}

${
    eqq-npositive.1 $e #npositive Y Q $.
    eqq-npositive.2 $e #eqq X Y $.
    eqq-npositive.3 $e #eqq P Q $.
    eqq-npositive   $a #npositive X P $.
$}

${
    eqq-appctx.1 $e #appctx y Q $.
    eqq-appctx.2 $e #eqq x y $.
    eqq-appctx.3 $e #eqq P Q $.
    eqq-appctx   $a #appctx x P $.
$}

${
    eqq-thm.1 $e |- Q $.
    eqq-thm.2 $e #eqq P Q $.
    eqq-thm   $a |- P $.
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
    Our first theorem, "id".
$)

id $p |- ( \imp P P ) $=
  wfP wfP wfP wfimp wfimp wfP wfP wfimp wfP wfP prule-proposition-1 wfP wfP wfP
  wfimp wfP wfimp wfimp wfP wfP wfP wfimp wfimp wfP wfP wfimp wfimp wfP wfP wfP
  wfimp prule-proposition-1 wfP wfP wfP wfimp wfP prule-proposition-2 prule-mp
  prule-mp $.

$(
    AML proof rules Part B: FOL reasoning.
$)

${
    prule-exists-inst.1 $e #subst P Q y x $.
    prule-exists-inst   $a |- ( \imp P ( \exists x Q ) ) $.
$}

${
    prule-exists-gen.1 $e |- ( \imp P Q ) $.
    prule-exists-gen.2 $e #nfree x P $.
    prule-exists-gen   $a |- ( \imp P ( \exists x Q ) ) $.
$}

$(
    AML proof rules Part C: Frame reasoning.
$)

prule-propagation-bot-left  $a |- ( \imp ( \app \bot P ) \bot ) $.
prule-propagation-bot-right $a |- ( \imp ( \app P \bot ) \bot ) $.
prule-propagation-or-left 
  $a |- ( \imp ( \app ( \imp ( \imp P \bot ) Q ) R )
               ( \imp ( \imp ( \app P R ) \bot ) ( \app Q R ) ) ) $.
prule-propagation-or-right 
  $a |- ( \imp ( \app R ( \imp ( \imp P \bot ) Q ) )
               ( \imp ( \imp ( \app R P ) \bot ) ( \app R Q ) ) ) $.
${
    prule-propagation-exists-left.1
      $e #nfree x Q $.
    prule-propagation-exists-left
      $a |- ( \imp ( \app ( \exists x P ) Q )
                   ( \exists x ( \app P Q ) ) ) $.
$}

${
    prule-propagation-exists-right.1
      $e #nfree x Q $.
    prule-propagation-exists-right
      $a |- ( \imp ( \app Q ( \exists x P ) )
                   ( \exists x ( \app Q P ) ) ) $.
$}

${
    prule-framing-left.1 $e |- ( \imp P Q ) $.
    prule-framing-left   $a |- ( \imp ( \app P R ) ( \app Q R ) ) $.
$}

${
    prule-framing-right.1 $e |- ( \imp P Q ) $.
    prule-framing-right   $a |- ( \imp ( \app R P ) ( \app R Q ) ) $.
$}

$(
    AML proof rules Part D: Fixpoint reasoning.
$)

${
    prule-svar-subst.1 $e |- Q $.
    prule-svar-subst.2 $e #subst P Q R Y $.
    prule-svar-subst $a |- P $.
$}

${
    prule-prefixpoint.1 $e #subst Q P ( \mu X P ) X $.
    prule-prefixpoint   $a |- ( \imp Q ( \mu X P ) ) $.
$}

${
    prule-kt.1 $e |- ( \imp R Q ) $.
    prule-kt.2 $e #subst R P Q X $.
    prule-kt   $a |- ( \imp ( \mu X P ) Q ) $.
$}

$(
    AML proof rules Part E: Misc technical proof rules.
$)

prule-existence $a |- ( \exists x x ) $.

${
    p2inf.1 $e |- ( \imp P ( \imp Q R ) ) $.
    p2inf   $p |- ( \imp ( \imp P Q ) ( \imp P R ) ) $=
      wfP wfQ wfR wfimp wfimp wfP wfQ wfimp wfP wfR wfimp wfimp p2inf.1 wfP
      wfQ wfR prule-proposition-2 prule-mp $.
$}

$(
    Singelton Variables.
$)

${
    nflipb $p |- ( \imp ( \imp ( \imp P \bot ) ( \imp Q \bot ) ) ( \imp Q P ) ) $= ? $.
$}

$( 
    Our first definition: negation.
    ( \neg P ) === ( \imp P \bot ) 
$)

$c \neg $.

wfneg  $a #wf ( \neg P ) $. $( Ideally we do not even need this one. $)

df-neg $a #eqq ( \neg P ) ( \imp P \bot ) $.

$( 
    Prove metalevel properties about negations.
$)

${
    nfree-neg.1 $e #nfree xX P $.
    nfree-neg   $p #nfree xX ( \neg P ) $=
  wfP wfneg wfP wfbot wfimp varxX varxX wfP wfbot varxX nfree-neg.1 varxX
  nfree-bot nfree-imp varxX wfvar eqq-self wfP df-neg eqq-nfree $.
$}

${
    subst-neg.1 $e #subst P' P R yY $.
    subst-neg   $p #subst ( \neg P' ) ( \neg P ) R yY $=
      wfPp wfneg wfP wfneg wfR wfPp wfbot wfimp wfP wfbot wfimp wfR varyY varyY
      wfPp wfP wfR wfbot wfbot varyY subst-neg.1 wfR varyY subst-bot subst-imp
      wfPp df-neg wfP df-neg wfR eqq-self varyY wfvar eqq-self eqq-subst $.
$}

${
    nnegative-neg.1 $e #npositive X P $.
    nnegative-neg   $p #nnegative X ( \neg P ) $=
      wfP wfneg wfP wfbot wfimp svarX svarX wfP wfbot svarX nnegative-neg.1 
      svarX nnegative-bot nnegative-imp svarX wfsvar eqq-self wfP df-neg 
      eqq-nnegative $.
$}

${
    npositive-neg.1 $e #nnegative X P $.
    npositive-neg   $p #npositive X ( \neg P ) $=
      wfP wfneg wfP wfbot wfimp svarX svarX wfP wfbot svarX npositive-neg.1 
      svarX npositive-bot npositive-imp svarX wfsvar eqq-self wfP df-neg 
      eqq-npositive $.
$}

$( 
    Prove some metatheorems about negations. 
$)

${
    nn $p |- ( \imp ( \neg ( \neg P ) ) P ) $=
      wfP wfneg wfneg wfP wfimp wfP wfneg wfbot wfimp wfP wfimp wfP wfneg wfbot
      wfimp wfP wfimp wfP wfbot wfimp wfbot wfimp wfP wfimp wfP
      prule-proposition-3 wfP wfneg wfbot wfimp wfP wfbot wfimp wfbot wfimp wfP
      wfP wfP wfneg wfP wfbot wfimp wfbot wfbot wfP df-neg wfbot eqq-self
      eqq-imp wfP eqq-self eqq-imp eqq-thm wfP wfneg wfneg wfP wfneg wfbot
      wfimp wfP wfP wfP wfneg df-neg wfP eqq-self eqq-imp eqq-thm $.
$}

${
    nflip $p |- ( \imp ( \imp ( \neg P ) ( \neg Q ) ) ( \imp Q P ) ) $=
      wfP wfneg wfQ wfneg wfimp wfQ wfP wfimp wfimp wfP wfbot wfimp wfQ wfbot
      wfimp wfimp wfQ wfP wfimp wfimp wfP wfQ nflipb wfP wfneg wfQ wfneg wfimp
      wfP wfbot wfimp wfQ wfbot wfimp wfimp wfQ wfP wfimp wfQ wfP wfimp wfP
      wfneg wfP wfbot wfimp wfQ wfneg wfQ wfbot wfimp wfP df-neg wfQ df-neg
      eqq-imp wfQ wfP wfimp eqq-self eqq-imp eqq-thm $.
$}



$(
    Defind \forall x P === \neg ( \exists x ( \neg P ) )
$)

$c \forall $.

wfforall $a \forall x P $.

df-forall $a #eqq ( \forall x P ) ( \neg ( \exists x ( \neg P ) ) ) $.

$( IMP Definitions $)

$(

module IMP-SYNTAX
  imports DOMAINS-SYNTAX
  syntax Exp ::= Int
               | Id
               | Exp "+" Exp
               | Exp "-" Exp
               | "(" Exp ")" [bracket]

  syntax Stmt ::= Id "=" Exp ";" [strict(2)]
                | "if" "(" Exp ")" Stmt Stmt [strict(1)]
                | "while" "(" Exp ")" Stmt
                | "{" Stmt "}" [bracket]
                | "{" "}"
                > Stmt Stmt [left]

  syntax Pgm ::= "int" Ids ";" Stmt
  syntax Ids ::= List{Id, ","}
endmodule

module IMP imports IMP-SYNTAX
  imports DOMAINS
  syntax KResult ::= Int
  configuration
  <T> <k> $PGM:Pgm </k> <state> .Map </state> </T>
  rule <k> X:Id => I ...</k>
       <state>... X |-> I ...</state>
  rule I1 + I2 => I1 +Int I2
  rule I1 - I2 => I1 -Int I2
  rule <k> X = I:Int; => . ...</k>
       <state>... X |-> (_ => I) ...</state>
  rule S1:Stmt S2:Stmt => S1 ~> S2
  rule if (I) S _ => S requires I =/=Int 0
  rule if (0) _ S => S
  rule while(B) S => if(B) {S while(B) S} {}
  rule {} => .
  rule <k> int (X, Xs => Xs); S </k>
       <state>... (. => X |-> 0) </state>
  rule int .Ids; S => S
endmodule

$)

$( Define all K sorts. $)

$c Int Id KResult K List Map $.

$c Exp Stmt Pgm Ids $.

$c KCell StateCell TopCell $.





