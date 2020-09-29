$(
    MATCHING LOGIC PROOF CHECKER
$)
$(
    Part 1
    Primitive Matching Logic Patterns
$)
$( 
    Part 1.a
    Primitive Logical Constructs
$)
$c \bot $.    $( the bottom pattern $)
$c \imp $.    $( the implication pattern ( \imp P Q ) $)
$c \app $.    $( the application pattern ( \app P Q ) $)
$c \ex $.     $( the exists quantifier ( \ex x P ) $)
$c \mu $.     $( the mu fixpoint binder ( \mu X P ) $)
$c ( $.       $( left parenthesis $)
$c ) $.       $( right parenthesis $)
$(
    Part 1.a
    Syntactic Categories
$)
$c #Pattern $. 
$c #ElementVariable $. 
$c #SetVariable $. 
$c #Symbol $.   
$c #Variable $. 
$v 
    ph ps ph1 ph2 ph3 ph4 ph5 ph6
    x y z 
    X Y Z 
    sg sg1 sg2
    xX yY
$.
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
$(
    Part 1.b
    The Essential Predicates about the Syntax - Declarations
$)
$(
    #NoNegativeOccurrence xX ph
      means xX has no negative occurrence in ph.
    #NoPositiveOccurrence xX ph
      means xX has no positive occurrence in ph.
    #NoFreeOccurrence xX ph
      means xX has no free occurrence in ph.
    #NestedInApplicationOnly xX ph
      means xX is nested only in application in ph.
    #Substitution ph1 ph2 ph3 xX
      means ph1 is the result of substituting ph3 for xX in ph2,
      i.e., pih1 = pih2[ph3/xX].
$)
$c #NoNegativeOccurrence $. 
$c #NoPositiveOccurrence $.
$c #NoFreeOccurrence $.
$c #NestedInApplicationOnly $.    
$c #Substitution $.    
$(
    Part 1.c
    Primitive Patterns
$)
wv $a #Pattern xX $.
ws $a #Pattern sg $.
wb $a #Pattern \bot $.
wi $a #Pattern ( \imp ph ps ) $.
wa $a #Pattern ( \app ph ps ) $.
we $a #Pattern ( \ex x ph ) $.
${
    wm.1 $e #NoNegativeOccurrence X ph $.
    wm   $a #Pattern ( \mu X ph ) $.
$}
wev $p #Pattern x $=
  vx vev wv $.
wsv $p #Pattern X $=
  vX vsv wv $.
$(
    Part 1.d
    The Essential Predicates about the Syntax - Definitions
$)
$(
    #NoNegativeOccurrence xX ph
      means xX has no negative occurrence in ph.
$)
nnv $a #NoNegativeOccurrence xX yY $.
nns $a #NoNegativeOccurrence xX sg $.
nnb $a #NoNegativeOccurrence xX \bot $.
${
    nni.1 $e #NoPositiveOccurrence xX ph $.
    nni.2 $e #NoNegativeOccurrence xX ps $.
    nni   $a #NoNegativeOccurrence xX ( \imp ph ps ) $.
$}
${
    nna.1 $e #NoNegativeOccurrence xX ph $.
    nna.2 $e #NoNegativeOccurrence xX ps $.
    nna   $a #NoNegativeOccurrence xX ( \app ph ps ) $.
$}
${
    nne.1 $e #NoNegativeOccurrence xX ph $.
    nne   $a #NoNegativeOccurrence xX ( \ex x ph ) $.
$}
${
    nnm.1 $e #NoNegativeOccurrence xX ph $.
    nnm   $a #NoNegativeOccurrence xX ( \mu Y ph ) $.
$}
$(
    #NoPositiveOccurrence xX ph
      means xX has no positive occurrence in ph.
$)
${
    $d xX yY $.
    npv $a #NoPositiveOccurrence xX yY $.
$}
nps $a #NoPositiveOccurrence xX sg $.
npb $a #NoPositiveOccurrence xX \bot $.
${
    npi.1 $e #NoNegativeOccurrence xX ph $.
    npi.2 $e #NoPositiveOccurrence xX ps $.
    npi   $a #NoPositiveOccurrence xX ( \imp ph ps ) $.
$}
${
    npa.1 $e #NoPositiveOccurrence xX ph $.
    npa.2 $e #NoPositiveOccurrence xX ps $.
    npa   $a #NoPositiveOccurrence xX ( \app ph ps ) $.
$}
${
   npe.1 $e #NoPositiveOccurrence xX ph $.
   npe   $a #NoPositiveOccurrence xX ( \ex x ph ) $.
$}
${
    npm.1 $e #NoPositiveOccurrence xX ph $.
    npm   $a #NoPositiveOccurrence xX ( \mu Y ph ) $.
$}
$( 
    #NoFreeOccurrence xX ph
      means xX has no free occurrence in ph.
$)
${
    $d xX yY $.
    nfv $a #NoFreeOccurrence xX yY $.
$}
nfs $a #NoFreeOccurrence xX sg $.
nfb $a #NoFreeOccurrence xX \bot $.
${
    nfi.1 $e #NoFreeOccurrence xX ph $.
    nfi.2 $e #NoFreeOccurrence xX ps $.
    nfi   $a #NoFreeOccurrence xX ( \imp ph ps ) $.
$}
${
    nfa.1 $e #NoFreeOccurrence xX ph $.
    nfa.2 $e #NoFreeOccurrence xX ps $.
    nfa   $a #NoFreeOccurrence xX ( \app ph ps ) $.
$}
nfe_1 $a #NoFreeOccurrence x ( \ex x ph ) $.
${
    $d xX y $.
    nfe_2.1 $e #NoFreeOccurrence xX ph $.
    nfe_2   $a #NoFreeOccurrence xX ( \ex y ph ) $.
$}
nfm_1 $a #NoFreeOccurrence X ( \mu X ph ) $.
${
    $d xX Y $.
    nfm_2.1 $e #NoFreeOccurrence xX ph $.
    nfm_2   $a #NoFreeOccurrence xX ( \ex Y ph ) $.
$}
$(
    #NestedInApplicationOnly xX ph
      means xX is nested only in application in ph.
$)
ap  $a #NestedInApplicationOnly xX xX $.
${
    apl.1 $e #NestedInApplicationOnly xX ph $.
    apl.2 $e #NoFreeOccurrence xX ps $.
    apl   $a #NestedInApplicationOnly xX ( \app ph ps ) $.
$}
${
    apr.1 $e #NestedInApplicationOnly xX ps $.
    apr.2 $e #NoFreeOccurrence xX ph $.
    apr   $a #NestedInApplicationOnly xX ( \app ph ps ) $.
$}
$( 
    #Substitution ph1 ph2 ph3 xX
      means ph1 = ph2[ph3/xX].
$)
sb  $a #Substitution ph xX ph xX $.
${
    $d xX yY $.
    sbv $a #Substitution yY yY ph xX $.
$}
sbs $a #Substitution sg sg ph xX $.
sbb $a #Substitution \bot \bot ph xX $.
${
    sbi.1 $e #Substitution ph1 ph3 ph xX $.
    sbi.2 $e #Substitution ph2 ph4 ph xX $.
    sbi   $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph xX $.
$}
${
    sba.1 $e #Substitution ph1 ph3 ph xX $.
    sba.2 $e #Substitution ph2 ph4 ph xX $.
    sba   $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph xX $.
$}
sbe_1 $a #Substitution ( \ex x ps ) ( \ex x ps ) ph x $.
$( 
    See http://fsl.cs.illinois.edu/FSL/papers/2017/rosu-2017-lmcs/rosu-2017-lmcs-public.pdf,
    Page 8, Lines 3-4.
$)
${
    $d x xX $. $d z ph $.
    sbe_2.1 $e #Substitution ph1 ps z x $.    $( ph1 = ps[z/x] $)
    sbe_2.2 $e #Substitution ph2 ph1 ph xX $. $( ph2 = ph1[ph/xX] $)
    sbe_2   $a #Substitution ( \ex z ph2 ) ( \ex x ps ) ph xX $.
$}
sbm_1 $a #Substitution ( \mu X ps ) ( \mu X ps ) ph X $.
${
    $d Y xX $. $d Z ph $.
    sbm_2.1 $e #Substitution ph1 ps Z X $.    $( ph1 = ps[Z/X] $)
    sbm_2.2 $e #Substitution ph2 ph1 ph xX $. $( ph2 = ph1[ph/xX] $)
    sbm_2   $a #Substitution ( \mu Z ph2 ) ( \mu X ps ) ph xX $.
$}
$(
    Part 2
    Matching Logic Proof System
$)
$c |- $.
$( 
    Part 2.a
    Propositional and FOL Proof Rules
$)
$(
    pr-1, pr-2, pr-3 form the Church's proof system of
    propositional logic.
    https://en.wikipedia.org/wiki/List_of_Hilbert_systems
$)
pr-1 $a |- ( \imp ph1 ( \imp ph2 ph1 ) ) $.
pr-2 $a |- ( \imp ( \imp ph1 ( \imp ph2 ph3 ) )
                  ( \imp ( \imp ph1 ph2 ) ( \imp ph1 ph3 ) ) ) $.
pr-3 $a |- ( \imp ( \imp ( \imp ph \bot ) \bot ) ph ) $.
$(
    Modus Ponens
$)
${
    pr-mp.1   $e |- ps $.
    pr-mp.2   $e |- ( \imp ps ph ) $.
    pr-mp     $a |- ph $.
$}
${
    pr-ei.1 $e #Substitution ph1 ph2 y x $.
    pr-ei   $a |- ( \imp ph1 ( \ex x ph2 ) ) $.
$}
${
    pr-eg.1 $e |- ( \imp ph1 ph2 ) $.
    pr-eg.2 $e #NoFreeOccurrence x ph2 $.
    pr-eg   $a |- ( \imp ( \ex x ph1 ) ph2 ) $.
$}
$( 
    Part 2.b
    Propagation and Frame Reasoning Proof Rules
$)
pr-pbl $a |- ( \imp ( \app \bot ph ) \bot ) $.
pr-pbr $a |- ( \imp ( \app ph \bot ) \bot ) $.
pr-pdl $a |- ( \imp ( \app ( \imp ( \imp ph1 \bot ) ph2 ) ph3 )
               ( \imp ( \imp ( \app ph1 ph3 ) \bot ) ( \app ph2 ph3 ) ) ) $.
pr-pdr $a |- ( \imp ( \app ph3 ( \imp ( \imp ph1 \bot ) ph2 ) )
               ( \imp ( \imp ( \app ph3 ph1 ) \bot ) ( \app ph3 ph2 ) ) ) $.
${
    pr-pel.1 $e #NoFreeOccurrence x ph2 $.
    pr-pel   $a |- ( \imp ( \app ( \ex x ph1 ) ph2 )
                     ( \ex x ( \app ph1 ph2 ) ) ) $.
$}
${
    pr-per.1 $e #NoFreeOccurrence x ph2 $.
    pr-per   $a |- ( \imp ( \app ph2 ( \ex x ph1 ) )
                     ( \ex x ( \app ph2 ph1 ) ) ) $.
$}
${
    pr-fml.1 $e |- ( \imp ph1 ph2 ) $.
    pr-fml   $a |- ( \imp ( \app ph1 ph3 ) ( \app ph2 ph3 ) ) $.
$}
${
    pr-fmr.1 $e |- ( \imp ph1 ph2 ) $.
    pr-fmr   $a |- ( \imp ( \app ph3 ph1 ) ( \app ph3 ph2 ) ) $.
$}
$( 
    Part 2.c
    Set Variable and Fixpoint Reasoning Proof Rules
$)
${
    pr-ss.1 $e |- ph2 $.
    pr-ss.2 $e #Substitution ph1 ph2 ph3 Y $.
    pr-ss   $a |- ph1 $.
$}
${
    pr-pf.1 $e #Substitution ph2 ph1 ( \mu X ph1 ) X $.
    pr-pf   $a |- ( \imp ph2 ( \mu X ph1 ) ) $.
$}
${
    pr-kt.1 $e |- ( \imp ph3 ph2 ) $.
    pr-kt.2 $e #Substitution ph3 ph1 ph2 X $.
    pr-kt   $a |- ( \imp ( \mu X ph1 ) ph2 ) $.
$}
$( 
    Part 2.d
    Misc Proof Rules
$)
pr-e $a |- ( \ex x x ) $.
${
    pr-s.1 $e #NestedInApplicationOnly xX ph1 $.
    pr-s.2 $e #NestedInApplicationOnly xX ph2 $.
    pr-s.3 $e #Substitution ph3 ph1 ( \imp ( \imp x ( \imp ph \bot ) ) \bot ) xX $.
    pr-s.4 $e #Substitution ph4 ph2 ( \imp ( \imp x ph               ) \bot ) xX $.
    pr-s   $a |- ( \imp ph3 ( \imp ph4 \bot ) ) $.
$}
$(
    Part 3
    Metalevel Equality for Syntactic Sugar Definitions
$)
$c #Equal $. 
eq $a #Equal ph1 ph1 $.
${
    eqi.1 $e #Equal ph1 ph3 $.
    eqi.2 $e #Equal ph2 ph4 $.
    eqi   $a #Equal ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) $.
$}
${
    eqa.1 $e #Equal ph1 ph3 $.
    eqa.2 $e #Equal ph2 ph4 $.
    eqa   $a #Equal ( \app ph1 ph2 ) ( \app ph3 ph4 ) $.
$}
${
    eqe.1 $e #Equal ph ps $.
    eqe   $a #Equal ( \ex x ph ) ( \ex x ps ) $.
$}
${
    eqm.1 $e #Equal ph ps $.
    eqm   $a #Equal ( \mu X ph ) ( \mu X ps ) $.
$}
${
    eqnn.1 $e #Equal ph ps $.
    eqnn.2 $e #NoNegativeOccurrence xX ps $.
    eqnn   $a #NoNegativeOccurrence xX ph $.
$}
${
    eqnp.1 $e #Equal ph ps $.
    eqnp.2 $e #NoPositiveOccurrence xX ps $.
    eqnp   $a #NoPositiveOccurrence xX ph $.
$}
${
    eqnf.1 $e #Equal ph ps $.
    eqnf.2 $e #NoFreeOccurrence xX ps $.
    eqnf   $a #NoFreeOccurrence xX ph $.
$}
${
    eqsb.1 $e #Equal ph1 ph3 $.
    eqsb.2 $e #Equal ph2 ph4 $.
    eqsb.3 $e #Equal ph ps $.
    eqsb.4 $e #Substitution ps ph3 ph4 xX $.
    eqsb   $a #Substitution ph ph1 ph2 xX $.
$}
${
    eqap.1 $e #Equal ph ps $.
    eqap.2 $e #NestedInApplicationOnly xX ps $.
    eqap   $a #NestedInApplicationOnly xX ph $.
$}
${
    eqp.1 $e #Equal ph ps $.
    eqp.2 $e |- ps $.
    eqp   $a |- ph $.
$}
$( 
    END OF PROOF CHECKER
$)
$(
    SOME EXAMPLES
$)
$( 
    EXAMPLE 1
$)
iid $p |- ( \imp ph ph ) $=
  vph vph wi vph vph vph wi wi vph vph pr-1 vph vph vph wi wi vph vph wi wi vph
  vph vph wi vph wi wi vph vph vph wi pr-1 vph vph vph wi vph pr-2 pr-mp pr-mp
  $.
$(
    EXAMPLE 2
$)
${
    mp2.1 $e |- ph1 $.
    mp2.2 $e |- ph2 $.
    mp2.3 $e |- ( \imp ph1 ( \imp ph2 ph3 ) ) $.
    mp2 $p |- ph3 $= vph3 vph2 mp2.2 vph2 vph3 wi vph1 mp2.1 mp2.3 pr-mp pr-mp $.
$}
$(
    EXAMPLE 3
$)
$c \neg $.
wneg   $a #Pattern ( \neg ph ) $.
df-neg $a #Equal ( \neg ph ) ( \imp ph \bot ) $.
${
    nnneg.1 $e #NoPositiveOccurrence xX ph $.
    nnneg   $p #NoNegativeOccurrence xX ( \neg ph ) $=
      vph wneg vph wb wi vxX vph df-neg vph wb vxX nnneg.1 vxX nnb nni eqnn $.
$}
${
    npneg.1 $e #NoNegativeOccurrence xX ph $.
    npneg   $p #NoPositiveOccurrence xX ( \neg ph ) $=
      vph wneg vph wb wi vxX vph df-neg vph wb vxX npneg.1 vxX npb npi eqnp $.
$}
${
    nfneg.1 $e #NoFreeOccurrence xX ph $.
    nfneg   $p #NoFreeOccurrence xX ( \neg ph ) $=
      vph wneg vph wb wi vxX vph df-neg vph wb vxX nfneg.1 vxX nfb nfi eqnf $.
$}
${
    sbneg.1 $e #Substitution ph2 ph1 ph xX $.
    sbneg   $p #Substitution ( \neg ph2 ) ( \neg ph1 ) ph xX $=
      vph2 wneg vph2 wb wi vph1 wneg vph vph1 wb wi vph vxX vph1 df-neg vph eq
      vph2 df-neg vph vph2 wb vph1 wb vxX sbneg.1 vph vxX sbb sbi eqsb $.
$}
dn $p |- ( \imp ( \neg ( \neg ph ) ) ph ) $=
  vph wneg wneg vph wi vph wneg wb wi vph wi vph wneg wneg vph vph wneg wb wi
  vph vph wneg df-neg vph eq eqi vph wneg wb wi vph wi vph wb wi wb wi vph wi
  vph wneg wb wi vph vph wb wi wb wi vph vph wneg wb vph wb wi wb vph df-neg wb
  eq eqi vph eq eqi vph pr-3 eqp eqp $.
$(
    EXAMPLE 4 Define Forall using Exists
$)
$c \fa $.
wfa   $a #Pattern ( \fa x ph ) $.
df-fa $a #Equal ( \fa x ph ) ( \neg ( \ex x ( \neg ph ) ) ) $.
${
    nnfa.1 $e #NoNegativeOccurrence xX ph $.
    nnfa   $p #NoNegativeOccurrence xX ( \fa x ph ) $=
      vph vx wfa vph wneg vx we wneg vxX vph vx df-fa vph wneg vx we vxX vph
      wneg vx vxX vph vxX nnfa.1 npneg npe nnneg eqnn $.
$}
${
    npfa.1 $e #NoPositiveOccurrence xX ph $.
    npfa   $p #NoPositiveOccurrence xX ( \fa x ph ) $=
      vph vx wfa vph wneg vx we wneg vxX vph vx df-fa vph wneg vx we vxX vph
      wneg vx vxX vph vxX npfa.1 nnneg nne npneg eqnp $.
$}
nffa_1 $p #NoFreeOccurrence x ( \fa x ph ) $=
  vph vx wfa vph wneg vx we wneg vx vev vph vx df-fa vph wneg vx we vx vev vph
  wneg vx nfe_1 nfneg eqnf $.
${
    $d xX x $.
    nffa_2.1 $e #NoFreeOccurrence xX ph $.
    nffa_2   $p #NoFreeOccurrence xX ( \fa x ph ) $=
      vph vx wfa vph wneg vx we wneg vxX vph vx df-fa vph wneg vx we vxX vph
      wneg vx vxX vph vxX nffa_2.1 nfneg nfe_2 nfneg eqnf $.
$}
sbfa_1 $p #Substitution ( \fa x ps ) ( \fa x ps ) ph x $=
  vps vx wfa vps wneg vx we wneg vps vx wfa vph vps wneg vx we wneg vph vx vev
  vps vx df-fa vph eq vps vx df-fa vph vps wneg vx we vps wneg vx we vx vev vph
  vps wneg vx sbe_1 sbneg eqsb $.
${
    $d x xX $. $d z ph $.
    sbfa_2.1 $e #Substitution ph1 ps z x $.    $( ph1 = ps[z/x] $)
    sbfa_2.2 $e #Substitution ph2 ph1 ph xX $. $( ph2 = ph1[ph/xX] $)
    sbfa_2   $p #Substitution ( \fa z ph2 ) ( \fa x ps ) ph xX $=
      vph2 vz wfa vph2 wneg vz we wneg vps vx wfa vph vps wneg vx we wneg vph
      vxX vps vx df-fa vph eq vph2 vz df-fa vph vps wneg vx we vph2 wneg vz we
      vxX vph vps wneg vph1 wneg vph2 wneg vx vz vxX vz wev vps vph1 vx vev
      sbfa_2.1 sbneg vph vph1 vph2 vxX sbfa_2.2 sbneg sbe_2 sbneg eqsb $.
$}

$( -------------------------------------------------------------------------- $)

$(
    Derived and sorted constructs
$)

$c \bot-s \top-s \not-s \and-s \or-s \ex-s \fa-s $.
$c \ceil \floor \eq \member \subset \domain \rewrites \dv \sort $.

ex-s-pattern $a #Pattern ( \ex-s ph x ps ) $.
fa-s-pattern $a #Pattern ( \fa-s ph x ps ) $.

bot-s-pattern $a #Pattern ( \bot-s ph ) $.
top-s-pattern $a #Pattern ( \top-s ph ) $.
not-s-pattern $a #Pattern ( \not-s ph1 ph2 ) $.
and-s-pattern $a #Pattern ( \and-s ph1 ph2 ph3 ) $.
or-s-pattern $a #Pattern ( \or-s ph1 ph2 ph3 ) $.

ceil-pattern   $a #Pattern ( \ceil ph1 ph2 ph3 ) $.
floor-pattern  $a #Pattern ( \floor ph1 ph2 ph3 ) $.
eq-pattern     $a #Pattern ( \eq ph1 ph2 ph3 ph3 ) $.
member-pattern $a #Pattern ( \member ph1 ph2 ph3 ph3 ) $.
subset-pattern $a #Pattern ( \subset ph1 ph2 ph3 ph3 ) $.
domain-pattern $a #Pattern ( \domain ph ) $.
rewrites-pattern $a #Pattern ( \rewrites ph1 ph2 ph3 ) $.

dv-pattern $a #Pattern ( \dv ph ps ) $.

sort-symbol $a #Symbol \sort $.
