$c \bot $.
$c \imp $.
$c \app $.
$c \ex $.
$c \mu $.
$c ( $.
$c ) $.
$c #Pattern $.
$c #ElementVariable $.
$c #SetVariable $.
$c #Symbol $.
$c #Variable $.
$v ph ps ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 ph9 x y z w X Y Z sg sg1 sg2 xX yY $.
vph $f #Pattern ph $.
vps $f #Pattern ps $.
vph1 $f #Pattern ph1 $.
vph2 $f #Pattern ph2 $.
vph3 $f #Pattern ph3 $.
vph4 $f #Pattern ph4 $.
vph5 $f #Pattern ph5 $.
vph6 $f #Pattern ph6 $.
vph7 $f #Pattern ph7 $.
vph8 $f #Pattern ph8 $.
vph9 $f #Pattern ph9 $.
vx $f #ElementVariable x $.
vy $f #ElementVariable y $.
vz $f #ElementVariable z $.
vw $f #ElementVariable w $.
vX $f #SetVariable X $.
vY $f #SetVariable Y $.
vZ $f #SetVariable Z $.
vsg $f #Symbol sg $.
vsg1 $f #Symbol sg1 $.
vsg2 $f #Symbol sg2 $.
vxX $f #Variable xX $.
vyY $f #Variable yY $.
vev $a #Variable x $.
vsv $a #Variable X $.
$c #NoNegativeOccurrence $.
$c #NoPositiveOccurrence $.
$c #NoFreeOccurrence $.
$c #NestedInApplicationOnly $.
$c #Substitution $.
wv $a #Pattern xX $.
ws $a #Pattern sg $.
wb $a #Pattern \bot $.
wi $a #Pattern ( \imp ph ps ) $.
wa $a #Pattern ( \app ph ps ) $.
we $a #Pattern ( \ex x ph ) $.
${
wm.1 $e #NoNegativeOccurrence X ph $.
wm $a #Pattern ( \mu X ph ) $.
$}
wev $p #Pattern x $= vx vev wv $.
wsv $p #Pattern X $= vX vsv wv $.
nnv $a #NoNegativeOccurrence xX yY $.
nns $a #NoNegativeOccurrence xX sg $.
nnb $a #NoNegativeOccurrence xX \bot $.
${
nni.1 $e #NoPositiveOccurrence xX ph $.
nni.2 $e #NoNegativeOccurrence xX ps $.
nni $a #NoNegativeOccurrence xX ( \imp ph ps ) $.
$}
${
nna.1 $e #NoNegativeOccurrence xX ph $.
nna.2 $e #NoNegativeOccurrence xX ps $.
nna $a #NoNegativeOccurrence xX ( \app ph ps ) $.
$}
${
nne.1 $e #NoNegativeOccurrence xX ph $.
nne $a #NoNegativeOccurrence xX ( \ex x ph ) $.
$}
${
nnm.1 $e #NoNegativeOccurrence xX ph $.
nnm $a #NoNegativeOccurrence xX ( \mu Y ph ) $.
$}
${
$d xX yY $.
npv $a #NoPositiveOccurrence xX yY $.
$}
nps $a #NoPositiveOccurrence xX sg $.
npb $a #NoPositiveOccurrence xX \bot $.
${
npi.1 $e #NoNegativeOccurrence xX ph $.
npi.2 $e #NoPositiveOccurrence xX ps $.
npi $a #NoPositiveOccurrence xX ( \imp ph ps ) $.
$}
${
npa.1 $e #NoPositiveOccurrence xX ph $.
npa.2 $e #NoPositiveOccurrence xX ps $.
npa $a #NoPositiveOccurrence xX ( \app ph ps ) $.
$}
${
npe.1 $e #NoPositiveOccurrence xX ph $.
npe $a #NoPositiveOccurrence xX ( \ex x ph ) $.
$}
${
npm.1 $e #NoPositiveOccurrence xX ph $.
npm $a #NoPositiveOccurrence xX ( \mu Y ph ) $.
$}
${
$d xX yY $.
nfv $a #NoFreeOccurrence xX yY $.
$}
nfs $a #NoFreeOccurrence xX sg $.
nfb $a #NoFreeOccurrence xX \bot $.
${
nfi.1 $e #NoFreeOccurrence xX ph $.
nfi.2 $e #NoFreeOccurrence xX ps $.
nfi $a #NoFreeOccurrence xX ( \imp ph ps ) $.
$}
${
nfa.1 $e #NoFreeOccurrence xX ph $.
nfa.2 $e #NoFreeOccurrence xX ps $.
nfa $a #NoFreeOccurrence xX ( \app ph ps ) $.
$}
nfe_1 $a #NoFreeOccurrence x ( \ex x ph ) $.
${
$d xX y $.
nfe_2.1 $e #NoFreeOccurrence xX ph $.
nfe_2 $a #NoFreeOccurrence xX ( \ex y ph ) $.
$}
nfm_1 $a #NoFreeOccurrence X ( \mu X ph ) $.
${
$d xX Y $.
nfm_2.1 $e #NoFreeOccurrence xX ph $.
nfm_2 $a #NoFreeOccurrence xX ( \ex Y ph ) $.
$}
ap $a #NestedInApplicationOnly xX xX $.
${
apl.1 $e #NestedInApplicationOnly xX ph $.
apl.2 $e #NoFreeOccurrence xX ps $.
apl $a #NestedInApplicationOnly xX ( \app ph ps ) $.
$}
${
apr.1 $e #NestedInApplicationOnly xX ps $.
apr.2 $e #NoFreeOccurrence xX ph $.
apr $a #NestedInApplicationOnly xX ( \app ph ps ) $.
$}
sb $a #Substitution ph xX ph xX $.
${
$d xX yY $.
sbv $a #Substitution yY yY ph xX $.
$}
sbs $a #Substitution sg sg ph xX $.
sbb $a #Substitution \bot \bot ph xX $.
${
sbi.1 $e #Substitution ph1 ph3 ph xX $.
sbi.2 $e #Substitution ph2 ph4 ph xX $.
sbi $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph xX $.
$}
${
sba.1 $e #Substitution ph1 ph3 ph xX $.
sba.2 $e #Substitution ph2 ph4 ph xX $.
sba $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph xX $.
$}
sbe_1 $a #Substitution ( \ex x ps ) ( \ex x ps ) ph x $.
${
$d x xX $.
$d z ph $.
sbe_2.1 $e #Substitution ph1 ps z x $.
sbe_2.2 $e #Substitution ph2 ph1 ph xX $.
sbe_2 $a #Substitution ( \ex z ph2 ) ( \ex x ps ) ph xX $.
$}
sbm_1 $a #Substitution ( \mu X ps ) ( \mu X ps ) ph X $.
${
$d Y xX $.
$d Z ph $.
sbm_2.1 $e #Substitution ph1 ps Z X $.
sbm_2.2 $e #Substitution ph2 ph1 ph xX $.
sbm_2 $a #Substitution ( \mu Z ph2 ) ( \mu X ps ) ph xX $.
$}
$c |- $.
pr-1 $a |- ( \imp ph1 ( \imp ph2 ph1 ) ) $.
pr-2 $a |- ( \imp ( \imp ph1 ( \imp ph2 ph3 ) ) ( \imp ( \imp ph1 ph2 ) ( \imp ph1 ph3 ) ) ) $.
pr-3 $a |- ( \imp ( \imp ( \imp ph \bot ) \bot ) ph ) $.
${
pr-mp.1 $e |- ps $.
pr-mp.2 $e |- ( \imp ps ph ) $.
pr-mp $a |- ph $.
$}
${
pr-ei.1 $e #Substitution ph1 ph2 y x $.
pr-ei $a |- ( \imp ph1 ( \ex x ph2 ) ) $.
$}
${
pr-eg.1 $e |- ( \imp ph1 ph2 ) $.
pr-eg.2 $e #NoFreeOccurrence x ph2 $.
pr-eg $a |- ( \imp ( \ex x ph1 ) ph2 ) $.
$}
pr-pbl $a |- ( \imp ( \app \bot ph ) \bot ) $.
pr-pbr $a |- ( \imp ( \app ph \bot ) \bot ) $.
pr-pdl $a |- ( \imp ( \app ( \imp ( \imp ph1 \bot ) ph2 ) ph3 ) ( \imp ( \imp ( \app ph1 ph3 ) \bot ) ( \app ph2 ph3 ) ) ) $.
pr-pdr $a |- ( \imp ( \app ph3 ( \imp ( \imp ph1 \bot ) ph2 ) ) ( \imp ( \imp ( \app ph3 ph1 ) \bot ) ( \app ph3 ph2 ) ) ) $.
${
pr-pel.1 $e #NoFreeOccurrence x ph2 $.
pr-pel $a |- ( \imp ( \app ( \ex x ph1 ) ph2 ) ( \ex x ( \app ph1 ph2 ) ) ) $.
$}
${
pr-per.1 $e #NoFreeOccurrence x ph2 $.
pr-per $a |- ( \imp ( \app ph2 ( \ex x ph1 ) ) ( \ex x ( \app ph2 ph1 ) ) ) $.
$}
${
pr-fml.1 $e |- ( \imp ph1 ph2 ) $.
pr-fml $a |- ( \imp ( \app ph1 ph3 ) ( \app ph2 ph3 ) ) $.
$}
${
pr-fmr.1 $e |- ( \imp ph1 ph2 ) $.
pr-fmr $a |- ( \imp ( \app ph3 ph1 ) ( \app ph3 ph2 ) ) $.
$}
${
pr-ss.1 $e |- ph2 $.
pr-ss.2 $e #Substitution ph1 ph2 ph3 Y $.
pr-ss $a |- ph1 $.
$}
${
pr-pf.1 $e #Substitution ph2 ph1 ( \mu X ph1 ) X $.
pr-pf $a |- ( \imp ph2 ( \mu X ph1 ) ) $.
$}
${
pr-kt.1 $e |- ( \imp ph3 ph2 ) $.
pr-kt.2 $e #Substitution ph3 ph1 ph2 X $.
pr-kt $a |- ( \imp ( \mu X ph1 ) ph2 ) $.
$}
pr-e $a |- ( \ex x x ) $.
${
pr-s.1 $e #NestedInApplicationOnly xX ph1 $.
pr-s.2 $e #NestedInApplicationOnly xX ph2 $.
pr-s.3 $e #Substitution ph3 ph1 ( \imp ( \imp x ( \imp ph \bot ) ) \bot ) xX $.
pr-s.4 $e #Substitution ph4 ph2 ( \imp ( \imp x ph ) \bot ) xX $.
pr-s $a |- ( \imp ph3 ( \imp ph4 \bot ) ) $.
$}
$c #Equal $.
eq $a #Equal ph1 ph1 $.
${
eqi.1 $e #Equal ph1 ph3 $.
eqi.2 $e #Equal ph2 ph4 $.
eqi $a #Equal ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) $.
$}
${
eqa.1 $e #Equal ph1 ph3 $.
eqa.2 $e #Equal ph2 ph4 $.
eqa $a #Equal ( \app ph1 ph2 ) ( \app ph3 ph4 ) $.
$}
${
eqe.1 $e #Equal ph ps $.
eqe $a #Equal ( \ex x ph ) ( \ex x ps ) $.
$}
${
eqm.1 $e #Equal ph ps $.
eqm $a #Equal ( \mu X ph ) ( \mu X ps ) $.
$}
${
eqnn.1 $e #Equal ph ps $.
eqnn.2 $e #NoNegativeOccurrence xX ps $.
eqnn $a #NoNegativeOccurrence xX ph $.
$}
${
eqnp.1 $e #Equal ph ps $.
eqnp.2 $e #NoPositiveOccurrence xX ps $.
eqnp $a #NoPositiveOccurrence xX ph $.
$}
${
eqnf.1 $e #Equal ph ps $.
eqnf.2 $e #NoFreeOccurrence xX ps $.
eqnf $a #NoFreeOccurrence xX ph $.
$}
${
eqsb.1 $e #Equal ph1 ph3 $.
eqsb.2 $e #Equal ph2 ph4 $.
eqsb.3 $e #Equal ph ps $.
eqsb.4 $e #Substitution ps ph3 ph4 xX $.
eqsb $a #Substitution ph ph1 ph2 xX $.
$}
${
eqap.1 $e #Equal ph ps $.
eqap.2 $e #NestedInApplicationOnly xX ps $.
eqap $a #NestedInApplicationOnly xX ph $.
$}
${
eqp.1 $e #Equal ph ps $.
eqp.2 $e |- ps $.
eqp $a |- ph $.
$}
iid $p |- ( \imp ph ph ) $= vph vph wi vph vph vph wi wi vph vph pr-1 vph vph vph wi wi vph vph wi wi vph vph vph wi vph wi wi vph vph vph wi pr-1 vph vph vph wi vph pr-2 pr-mp pr-mp $.
${
mp2.1 $e |- ph1 $.
mp2.2 $e |- ph2 $.
mp2.3 $e |- ( \imp ph1 ( \imp ph2 ph3 ) ) $.
mp2 $p |- ph3 $= vph3 vph2 mp2.2 vph2 vph3 wi vph1 mp2.1 mp2.3 pr-mp pr-mp $.
$}
$c \neg $.
wneg $a #Pattern ( \neg ph ) $.
df-neg $a #Equal ( \neg ph ) ( \imp ph \bot ) $.
${
nnneg.1 $e #NoPositiveOccurrence xX ph $.
nnneg $p #NoNegativeOccurrence xX ( \neg ph ) $= vph wneg vph wb wi vxX vph df-neg vph wb vxX nnneg.1 vxX nnb nni eqnn $.
$}
${
npneg.1 $e #NoNegativeOccurrence xX ph $.
npneg $p #NoPositiveOccurrence xX ( \neg ph ) $= vph wneg vph wb wi vxX vph df-neg vph wb vxX npneg.1 vxX npb npi eqnp $.
$}
${
nfneg.1 $e #NoFreeOccurrence xX ph $.
nfneg $p #NoFreeOccurrence xX ( \neg ph ) $= vph wneg vph wb wi vxX vph df-neg vph wb vxX nfneg.1 vxX nfb nfi eqnf $.
$}
${
sbneg.1 $e #Substitution ph2 ph1 ph xX $.
sbneg $p #Substitution ( \neg ph2 ) ( \neg ph1 ) ph xX $= vph2 wneg vph2 wb wi vph1 wneg vph vph1 wb wi vph vxX vph1 df-neg vph eq vph2 df-neg vph vph2 wb vph1 wb vxX sbneg.1 vph vxX sbb sbi eqsb $.
$}
dn $p |- ( \imp ( \neg ( \neg ph ) ) ph ) $= vph wneg wneg vph wi vph wneg wb wi vph wi vph wneg wneg vph vph wneg wb wi vph vph wneg df-neg vph eq eqi vph wneg wb wi vph wi vph wb wi wb wi vph wi vph wneg wb wi vph vph wb wi wb wi vph vph wneg wb vph wb wi wb vph df-neg wb eq eqi vph eq eqi vph pr-3 eqp eqp $.
$c \fa $.
wfa $a #Pattern ( \fa x ph ) $.
df-fa $a #Equal ( \fa x ph ) ( \neg ( \ex x ( \neg ph ) ) ) $.
${
nnfa.1 $e #NoNegativeOccurrence xX ph $.
nnfa $p #NoNegativeOccurrence xX ( \fa x ph ) $= vph vx wfa vph wneg vx we wneg vxX vph vx df-fa vph wneg vx we vxX vph wneg vx vxX vph vxX nnfa.1 npneg npe nnneg eqnn $.
$}
${
npfa.1 $e #NoPositiveOccurrence xX ph $.
npfa $p #NoPositiveOccurrence xX ( \fa x ph ) $= vph vx wfa vph wneg vx we wneg vxX vph vx df-fa vph wneg vx we vxX vph wneg vx vxX vph vxX npfa.1 nnneg nne npneg eqnp $.
$}
nffa_1 $p #NoFreeOccurrence x ( \fa x ph ) $= vph vx wfa vph wneg vx we wneg vx vev vph vx df-fa vph wneg vx we vx vev vph wneg vx nfe_1 nfneg eqnf $.
${
$d xX x $.
nffa_2.1 $e #NoFreeOccurrence xX ph $.
nffa_2 $p #NoFreeOccurrence xX ( \fa x ph ) $= vph vx wfa vph wneg vx we wneg vxX vph vx df-fa vph wneg vx we vxX vph wneg vx vxX vph vxX nffa_2.1 nfneg nfe_2 nfneg eqnf $.
$}
sbfa_1 $p #Substitution ( \fa x ps ) ( \fa x ps ) ph x $= vps vx wfa vps wneg vx we wneg vps vx wfa vph vps wneg vx we wneg vph vx vev vps vx df-fa vph eq vps vx df-fa vph vps wneg vx we vps wneg vx we vx vev vph vps wneg vx sbe_1 sbneg eqsb $.
${
$d x xX $.
$d z ph $.
sbfa_2.1 $e #Substitution ph1 ps z x $.
sbfa_2.2 $e #Substitution ph2 ph1 ph xX $.
sbfa_2 $p #Substitution ( \fa z ph2 ) ( \fa x ps ) ph xX $= vph2 vz wfa vph2 wneg vz we wneg vps vx wfa vph vps wneg vx we wneg vph vxX vps vx df-fa vph eq vph2 vz df-fa vph vps wneg vx we vph2 wneg vz we vxX vph vps wneg vph1 wneg vph2 wneg vx vz vxX vz wev vps vph1 vx vev sbfa_2.1 sbneg vph vph1 vph2 vxX sbfa_2.2 sbneg sbe_2 sbneg eqsb $.
$}
$c \kore-bot \kore-top \kore-not \kore-and \kore-or \kore-implies \kore-exists \kore-forall $.
$c \kore-ceil \kore-floor \kore-equals \kore-in \kore-rewrites \kore-dv \kore-sort $.
kore-exists-pattern $a #Pattern ( \kore-exists ph1 x ph2 ) $.
kore-forall-pattern $a #Pattern ( \kore-forall ph1 x ph2 ) $.
kore-bot-pattern $a #Pattern ( \kore-bot ph1 ) $.
kore-top-pattern $a #Pattern ( \kore-top ph1 ) $.
kore-not-pattern $a #Pattern ( \kore-not ph1 ph2 ) $.
kore-and-pattern $a #Pattern ( \kore-and ph1 ph2 ph3 ) $.
kore-or-pattern $a #Pattern ( \kore-or ph1 ph2 ph3 ) $.
kore-implies-pattern $a #Pattern ( \kore-implies ph1 ph2 ph3 ) $.
kore-ceil-pattern $a #Pattern ( \kore-ceil ph1 ph2 ph3 ) $.
kore-floor-pattern $a #Pattern ( \kore-floor ph1 ph2 ph3 ) $.
kore-equals-pattern $a #Pattern ( \kore-equals ph1 ph2 ph3 ph4 ) $.
kore-in-pattern $a #Pattern ( \kore-in ph1 ph2 ph3 ph4 ) $.
kore-rewrites-pattern $a #Pattern ( \kore-rewrites ph1 ph2 ph3 ) $.
kore-dv-pattern $a #Pattern ( \kore-dv ph1 ph2 ) $.
kore-sort-pattern $a #Pattern \kore-sort $.
${
$d xX y $.
$d y ph5 $.
kore-exists-substitution.1 $e #Substitution ph1 ph3 ph5 xX $.
kore-exists-substitution.2 $e #Substitution ph2 ph4 ph5 xX $.
kore-exists-substitution $a #Substitution ( \kore-exists ph1 y ph2 ) ( \kore-exists ph3 y ph4 ) ph5 xX $.
$}
${
kore-exists-substitution-shadowed.1 $e #Substitution ph1 ph3 ph4 x $.
kore-exists-substitution-shadowed $a #Substitution ( \kore-exists ph1 x ph2 ) ( \kore-exists ph3 x ph2 ) ph4 x $.
$}
${
$d xX y $.
$d y ph5 $.
kore-forall-substitution.1 $e #Substitution ph1 ph3 ph5 xX $.
kore-forall-substitution.2 $e #Substitution ph2 ph4 ph5 xX $.
kore-forall-substitution $a #Substitution ( \kore-forall ph1 y ph2 ) ( \kore-forall ph3 y ph4 ) ph5 xX $.
$}
${
kore-forall-substitution-shadowed.1 $e #Substitution ph1 ph3 ph4 x $.
kore-forall-substitution-shadowed $a #Substitution ( \kore-forall ph1 x ph2 ) ( \kore-forall ph3 x ph2 ) ph4 x $.
$}
${
kore-bot-substitution.1 $e #Substitution ph1 ph2 ph3 xX $.
kore-bot-substitution $a #Substitution ( \kore-bot ph1 ) ( \kore-bot ph2 ) ph3 xX $.
$}
${
kore-top-substitution.1 $e #Substitution ph1 ph2 ph3 xX $.
kore-top-substitution $a #Substitution ( \kore-top ph1 ) ( \kore-top ph2 ) ph3 xX $.
$}
${
kore-not-substitution.1 $e #Substitution ph1 ph3 ph5 xX $.
kore-not-substitution.2 $e #Substitution ph2 ph4 ph5 xX $.
kore-not-substitution $a #Substitution ( \kore-not ph1 ph2 ) ( \kore-not ph3 ph4 ) ph5 xX $.
$}
${
kore-and-substitution.1 $e #Substitution ph1 ph4 ph7 xX $.
kore-and-substitution.2 $e #Substitution ph2 ph5 ph7 xX $.
kore-and-substitution.3 $e #Substitution ph3 ph6 ph7 xX $.
kore-and-substitution $a #Substitution ( \kore-and ph1 ph2 ph3 ) ( \kore-and ph4 ph5 ph6 ) ph7 xX $.
$}
${
kore-or-substitution.1 $e #Substitution ph1 ph4 ph7 xX $.
kore-or-substitution.2 $e #Substitution ph2 ph5 ph7 xX $.
kore-or-substitution.3 $e #Substitution ph3 ph6 ph7 xX $.
kore-or-substitution $a #Substitution ( \kore-or ph1 ph2 ph3 ) ( \kore-or ph4 ph5 ph6 ) ph7 xX $.
$}
${
kore-implies-substitution.1 $e #Substitution ph1 ph4 ph7 xX $.
kore-implies-substitution.2 $e #Substitution ph2 ph5 ph7 xX $.
kore-implies-substitution.3 $e #Substitution ph3 ph6 ph7 xX $.
kore-implies-substitution $a #Substitution ( \kore-implies ph1 ph2 ph3 ) ( \kore-implies ph4 ph5 ph6 ) ph7 xX $.
$}
${
kore-ceil-substitution.1 $e #Substitution ph1 ph4 ph7 xX $.
kore-ceil-substitution.2 $e #Substitution ph2 ph5 ph7 xX $.
kore-ceil-substitution.3 $e #Substitution ph3 ph6 ph7 xX $.
kore-ceil-substitution $a #Substitution ( \kore-ceil ph1 ph2 ph3 ) ( \kore-ceil ph4 ph5 ph6 ) ph7 xX $.
$}
${
kore-floor-substitution.1 $e #Substitution ph1 ph4 ph7 xX $.
kore-floor-substitution.2 $e #Substitution ph2 ph5 ph7 xX $.
kore-floor-substitution.3 $e #Substitution ph3 ph6 ph7 xX $.
kore-floor-substitution $a #Substitution ( \kore-floor ph1 ph2 ph3 ) ( \kore-floor ph4 ph5 ph6 ) ph7 xX $.
$}
${
kore-equals-substitution.1 $e #Substitution ph1 ph5 ph9 xX $.
kore-equals-substitution.2 $e #Substitution ph2 ph6 ph9 xX $.
kore-equals-substitution.3 $e #Substitution ph3 ph7 ph9 xX $.
kore-equals-substitution.4 $e #Substitution ph4 ph8 ph9 xX $.
kore-equals-substitution $a #Substitution ( \kore-equals ph1 ph2 ph3 ph4 ) ( \kore-equals ph5 ph6 ph7 ph8 ) ph9 xX $.
$}
${
kore-in-substitution.1 $e #Substitution ph1 ph5 ph9 xX $.
kore-in-substitution.2 $e #Substitution ph2 ph6 ph9 xX $.
kore-in-substitution.3 $e #Substitution ph3 ph7 ph9 xX $.
kore-in-substitution.4 $e #Substitution ph4 ph8 ph9 xX $.
kore-in-substitution $a #Substitution ( \kore-in ph1 ph2 ph3 ph4 ) ( \kore-in ph5 ph6 ph7 ph8 ) ph9 xX $.
$}
${
kore-rewrites-substitution.1 $e #Substitution ph1 ph4 ph7 xX $.
kore-rewrites-substitution.2 $e #Substitution ph2 ph5 ph7 xX $.
kore-rewrites-substitution.3 $e #Substitution ph3 ph6 ph7 xX $.
kore-rewrites-substitution $a #Substitution ( \kore-rewrites ph1 ph2 ph3 ) ( \kore-rewrites ph4 ph5 ph6 ) ph7 xX $.
$}
${
kore-dv-substitution.1 $e #Substitution ph1 ph3 ph5 xX $.
kore-dv-substitution.2 $e #Substitution ph2 ph4 ph5 xX $.
kore-dv-substitution $a #Substitution ( \kore-dv ph1 ph2 ) ( \kore-dv ph3 ph4 ) ph5 xX $.
$}
kore-sort-substitution $a #Substitution \kore-sort \kore-sort ph1 xX $.
kore-top-valid $p |- ( \kore-top ph ) $= ? $.
${
kore-rewrites-conditional.1 $e |- ( \kore-rewrites ph1 ( \kore-and ph1 ph2 ph3 ) ( \kore-and ph1 ph4 ph5 ) ) $.
kore-rewrites-conditional.2 $e |- ph2 $.
kore-rewrites-conditional.3 $e |- ph4 $.
kore-rewrites-conditional $p |- ( \kore-rewrites ph1 ph3 ph5 ) $= ? $.
$}
${
$d z y $.
$d y ph3 $.
$d y ph1 $.
$d z ph3 $.
$d z ph1 $.
kore-forall-elim.1 $e |- ( \kore-forall ph1 x ph2 ) $.
kore-forall-elim.2 $e |- ( \kore-forall \kore-sort z ( \kore-exists ph1 y ( \kore-equals ph1 z y ph3 ) ) ) $.
kore-forall-elim.3 $e #Substitution ph4 ph2 ph3 x $.
kore-forall-elim $p |- ph4 $= ? $.
$}
${
$d w x $.
$d z y $.
$d w ph1 $.
$d y ph3 $.
$d y ph1 $.
$d z ph3 $.
$d z ph1 $.
kore-forall-elim-variant.1 $e |- ( \kore-forall \kore-sort w ( \kore-forall ph1 x ph2 ) ) $.
kore-forall-elim-variant.2 $e |- ( \kore-forall \kore-sort z ( \kore-exists ph1 y ( \kore-equals ph1 z y ph3 ) ) ) $.
kore-forall-elim-variant.3 $e #Substitution ph4 ph2 ph3 x $.
kore-forall-elim-variant $p |- ( \kore-forall \kore-sort w ph4 ) $= ? $.
$}
${
kore-implies-elim.1 $e |- ( \kore-forall \kore-sort z ( \kore-implies ph1 ph2 ph3 ) ) $.
kore-implies-elim.2 $e |- ( \kore-forall \kore-sort z ph2 ) $.
kore-implies-elim $p |- ( \kore-forall \kore-sort z ph3 ) $= ? $.
$}
${
kore-equality.1 $e |- ( \kore-forall \kore-sort z ( \kore-equals ph1 z ph2 ph3 ) ) $.
kore-equality.2 $e |- ph4 $.
kore-equality.3 $e #Substitution ph4 ph5 ph2 x $.
kore-equality.4 $e #Substitution ph6 ph5 ph3 x $.
kore-equality $p |- ph6 $= ? $.
$}
$v K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap VarSet VarStream VarString VarK0 VarReplacement VarToReplace VarCount var-pattern-0 var-pattern-1 var-pattern-2 var-pattern-3 var-elementvariable-0 var-elementvariable-1 var-variable-0 var-pattern-4 var-pattern-5 var-pattern-6 var-pattern-7 var-pattern-8 $.
variable-0-type $f #ElementVariable K2 $.
variable-1-type $f #ElementVariable K1 $.
variable-2-type $f #ElementVariable Val $.
variable-3-type $f #ElementVariable R $.
variable-4-type $f #ElementVariable From $.
variable-5-type $f #ElementVariable K0 $.
variable-6-type $f #ElementVariable SortSort $.
variable-7-type $f #ElementVariable Var'Unds'0 $.
variable-8-type $f #ElementVariable VarB1 $.
variable-9-type $f #ElementVariable VarC $.
variable-10-type $f #ElementVariable VarB2 $.
variable-11-type $f #ElementVariable VarS $.
variable-12-type $f #ElementVariable Var'Unds'DotVar0 $.
variable-13-type $f #ElementVariable Var'Unds'DotVar1 $.
variable-14-type $f #ElementVariable VarY $.
variable-15-type $f #ElementVariable VarX $.
variable-16-type $f #ElementVariable VarS2 $.
variable-17-type $f #ElementVariable VarS1 $.
variable-18-type $f #ElementVariable VarI2 $.
variable-19-type $f #ElementVariable VarI1 $.
variable-20-type $f #ElementVariable VarK2 $.
variable-21-type $f #ElementVariable VarK1 $.
variable-22-type $f #ElementVariable Var'Unds'1 $.
variable-23-type $f #ElementVariable VarB $.
variable-24-type $f #ElementVariable VarK $.
variable-25-type $f #ElementVariable VarLEN $.
variable-26-type $f #ElementVariable VarIDX $.
variable-27-type $f #ElementVariable VarI $.
variable-28-type $f #ElementVariable VarToCount $.
variable-29-type $f #ElementVariable VarSource $.
variable-30-type $f #ElementVariable VarCell $.
variable-31-type $f #ElementVariable VarInit $.
variable-32-type $f #ElementVariable VarBool $.
variable-33-type $f #ElementVariable VarFloat $.
variable-34-type $f #ElementVariable VarFoo $.
variable-35-type $f #ElementVariable VarGeneratedCounterCell $.
variable-36-type $f #ElementVariable VarGeneratedCounterCellOpt $.
variable-37-type $f #ElementVariable VarGeneratedTopCell $.
variable-38-type $f #ElementVariable VarGeneratedTopCellFragment $.
variable-39-type $f #ElementVariable VarIOError $.
variable-40-type $f #ElementVariable VarIOFile $.
variable-41-type $f #ElementVariable VarIOInt $.
variable-42-type $f #ElementVariable VarIOString $.
variable-43-type $f #ElementVariable VarId $.
variable-44-type $f #ElementVariable VarInt $.
variable-45-type $f #ElementVariable VarKCell $.
variable-46-type $f #ElementVariable VarKCellOpt $.
variable-47-type $f #ElementVariable VarKConfigVar $.
variable-48-type $f #ElementVariable VarKItem $.
variable-49-type $f #ElementVariable VarList $.
variable-50-type $f #ElementVariable VarMap $.
variable-51-type $f #ElementVariable VarSet $.
variable-52-type $f #ElementVariable VarStream $.
variable-53-type $f #ElementVariable VarString $.
variable-54-type $f #ElementVariable VarK0 $.
variable-55-type $f #ElementVariable VarReplacement $.
variable-56-type $f #ElementVariable VarToReplace $.
variable-57-type $f #ElementVariable VarCount $.
variable-58-type $f #Pattern var-pattern-0 $.
variable-59-type $f #Pattern var-pattern-1 $.
variable-60-type $f #Pattern var-pattern-2 $.
variable-61-type $f #Pattern var-pattern-3 $.
variable-62-type $f #ElementVariable var-elementvariable-0 $.
variable-63-type $f #ElementVariable var-elementvariable-1 $.
variable-64-type $f #Variable var-variable-0 $.
variable-65-type $f #Pattern var-pattern-4 $.
variable-66-type $f #Pattern var-pattern-5 $.
variable-67-type $f #Pattern var-pattern-6 $.
variable-68-type $f #Pattern var-pattern-7 $.
variable-69-type $f #Pattern var-pattern-8 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap VarSet VarStream VarString VarK0 VarReplacement VarToReplace VarCount var-elementvariable-0 var-elementvariable-1 $.
$c inj SortGeneratedTopCell SortKItem Lbl'-LT-'generatedTop'-GT-' Lbl'-LT-'k'-GT-' kseq SortFoo Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int SortInt "13" "12" dotk Lbl'-LT-'generatedCounter'-GT-' "0" SortK SortCell SortIOString SortString SortKCellOpt SortGeneratedCounterCellOpt SortGeneratedCounterCell SortKCell SortIOError SortIOInt SortSet SortStream SortIOFile SortList SortId SortFloat SortBool SortGeneratedTopCellFragment SortMap Lbl'Hash'E2BIG Lbl'Hash'EACCES Lbl'Hash'EADDRINUSE Lbl'Hash'EADDRNOTAVAIL Lbl'Hash'EAFNOSUPPORT Lbl'Hash'EAGAIN Lbl'Hash'EALREADY Lbl'Hash'EBADF Lbl'Hash'EBUSY Lbl'Hash'ECHILD Lbl'Hash'ECONNABORTED Lbl'Hash'ECONNREFUSED Lbl'Hash'ECONNRESET Lbl'Hash'EDEADLK Lbl'Hash'EDESTADDRREQ Lbl'Hash'EDOM Lbl'Hash'EEXIST Lbl'Hash'EFAULT Lbl'Hash'EFBIG Lbl'Hash'EHOSTDOWN Lbl'Hash'EHOSTUNREACH Lbl'Hash'EINPROGRESS Lbl'Hash'EINTR Lbl'Hash'EINVAL Lbl'Hash'EIO Lbl'Hash'EISCONN Lbl'Hash'EISDIR Lbl'Hash'ELOOP Lbl'Hash'EMFILE Lbl'Hash'EMLINK Lbl'Hash'EMSGSIZE Lbl'Hash'ENAMETOOLONG Lbl'Hash'ENETDOWN Lbl'Hash'ENETRESET Lbl'Hash'ENETUNREACH Lbl'Hash'ENFILE Lbl'Hash'ENOBUFS Lbl'Hash'ENODEV Lbl'Hash'ENOENT Lbl'Hash'ENOEXEC Lbl'Hash'ENOLCK Lbl'Hash'ENOMEM Lbl'Hash'ENOPROTOOPT Lbl'Hash'ENOSPC Lbl'Hash'ENOSYS Lbl'Hash'ENOTCONN Lbl'Hash'ENOTDIR Lbl'Hash'ENOTEMPTY Lbl'Hash'ENOTSOCK Lbl'Hash'ENOTTY Lbl'Hash'ENXIO Lbl'Hash'EOF Lbl'Hash'EOPNOTSUPP Lbl'Hash'EOVERFLOW Lbl'Hash'EPERM Lbl'Hash'EPFNOSUPPORT Lbl'Hash'EPIPE Lbl'Hash'EPROTONOSUPPORT Lbl'Hash'EPROTOTYPE Lbl'Hash'ERANGE Lbl'Hash'EROFS Lbl'Hash'ESHUTDOWN Lbl'Hash'ESOCKTNOSUPPORT Lbl'Hash'ESPIPE Lbl'Hash'ESRCH Lbl'Hash'ETIMEDOUT Lbl'Hash'ETOOMANYREFS Lbl'Hash'EWOULDBLOCK Lbl'Hash'EXDEV Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort Lbl'Hash'logToFile Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String Lbl'Hash'stderr'Unds'K-IO'Unds'Int Lbl'Hash'stdin'Unds'K-IO'Unds'Int Lbl'Hash'stdout'Unds'K-IO'Unds'Int Lbl'Hash'systemResult Lbl'Hash'tempFile Lbl'Hash'unknownIOError Lbl'Stop'List Lbl'Stop'Map Lbl'Stop'Set Lbl'-LT-'generatedTop'-GT-'-fragment LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int LblListItem LblMap'Coln'update LblSet'Coln'difference LblSet'Coln'in LblSetItem LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String Lbl'UndsAnd-'Int'Unds' Lbl'UndsStar'Int'Unds' Lbl'UndsPlus'Int'Unds' Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String Lbl'Unds'-Int'Unds' Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map Lbl'Unds-LT-Eqls'Int'Unds' Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String Lbl'Unds-LT-'Int'Unds' Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String Lbl'UndsEqlsSlshEqls'Bool'Unds' Lbl'UndsEqlsSlshEqls'Int'Unds' Lbl'UndsEqlsSlshEqls'K'Unds' Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String Lbl'UndsEqlsEqls'Bool'Unds' Lbl'UndsEqlsEqls'Int'Unds' Lbl'UndsEqlsEqls'K'Unds' Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String Lbl'Unds-GT-Eqls'Int'Unds' Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String Lbl'Unds-GT-'Int'Unds' Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String Lbl'Unds'List'Unds' Lbl'Unds'Set'Unds' Lbl'UndsLSqBUnds-LT-'-undef'RSqB' Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem Lbl'Unds'andBool'Unds' Lbl'Unds'andThenBool'Unds' Lbl'Unds'impliesBool'Unds' Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool Lbl'Unds'orElseBool'Unds' Lbl'Unds'xorBool'Unds' Lbl'Unds'xorInt'Unds' Lbl'UndsPipe'-'-GT-Unds' Lbl'UndsPipe'Int'Unds' Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int LblnoGeneratedCounterCell LblnoKCell LblnotBool'Unds' LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map Lbl'Tild'Int'Unds' "true" Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String "r%2B" "2" "1" "false" Lbl'Unds'divInt'Unds' Lbl'UndsSlsh'Int'Unds' Lbl'Unds'modInt'Unds' Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int Lbl'UndsPerc'Int'Unds' LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int Lbl'Unds-GT--GT-'Int'Unds' Lbl'Unds-LT--LT-'Int'Unds' LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int "" LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int "-1" "_" LblgetGeneratedCounterCell LblinitGeneratedCounterCell LblinitGeneratedTopCell LblinitKCell Lblproject'Coln'KItem LblMap'Coln'lookup SortKConfigVar "%24PGM" LblisBool LblisCell LblisFloat LblisFoo LblisGeneratedCounterCell LblisGeneratedCounterCellOpt LblisGeneratedTopCell LblisGeneratedTopCellFragment LblisIOError LblisIOFile LblisIOInt LblisIOString LblisId LblisInt LblisK LblisKCell LblisKCellOpt LblisKConfigVar LblisKItem LblisList LblisMap LblisSet LblisStream LblisString Lblproject'ColnHash'tempFile'Coln'fd Lblproject'ColnHash'tempFile'Coln'path Lblproject'ColnHash'unknownIOError'Coln'errno Lblproject'Coln'Bool Lblproject'Coln'Cell Lblproject'Coln'Float Lblproject'Coln'Foo Lblproject'Coln'GeneratedCounterCell Lblproject'Coln'GeneratedCounterCellOpt Lblproject'Coln'GeneratedTopCell Lblproject'Coln'GeneratedTopCellFragment Lblproject'Coln'IOError Lblproject'Coln'IOFile Lblproject'Coln'IOInt Lblproject'Coln'IOString Lblproject'Coln'Id Lblproject'Coln'Int Lblproject'Coln'K Lblproject'Coln'KCell Lblproject'Coln'KCellOpt Lblproject'Coln'List Lblproject'Coln'Map Lblproject'Coln'Set Lblproject'Coln'Stream Lblproject'Coln'String Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int $.
constant-symbol-0-pattern $a #Pattern ( inj var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-1-pattern $a #Pattern SortGeneratedTopCell $.
constant-symbol-2-pattern $a #Pattern SortKItem $.
constant-symbol-3-pattern $a #Pattern ( Lbl'-LT-'generatedTop'-GT-' var-pattern-0 var-pattern-1 ) $.
constant-symbol-4-pattern $a #Pattern ( Lbl'-LT-'k'-GT-' var-pattern-0 ) $.
constant-symbol-5-pattern $a #Pattern ( kseq var-pattern-0 var-pattern-1 ) $.
constant-symbol-6-pattern $a #Pattern SortFoo $.
constant-symbol-7-pattern $a #Pattern ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo var-pattern-0 var-pattern-1 ) $.
constant-symbol-8-pattern $a #Pattern ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo var-pattern-0 ) $.
constant-symbol-9-pattern $a #Pattern ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int var-pattern-0 ) $.
constant-symbol-10-pattern $a #Pattern SortInt $.
constant-symbol-11-pattern $a #Pattern "13" $.
constant-symbol-12-pattern $a #Pattern "12" $.
constant-symbol-13-pattern $a #Pattern dotk $.
constant-symbol-14-pattern $a #Pattern ( Lbl'-LT-'generatedCounter'-GT-' var-pattern-0 ) $.
constant-symbol-15-pattern $a #Pattern "0" $.
constant-symbol-16-pattern $a #Pattern SortK $.
constant-symbol-17-pattern $a #Pattern SortCell $.
constant-symbol-18-pattern $a #Pattern SortIOString $.
constant-symbol-19-pattern $a #Pattern SortString $.
constant-symbol-20-pattern $a #Pattern SortKCellOpt $.
constant-symbol-21-pattern $a #Pattern SortGeneratedCounterCellOpt $.
constant-symbol-22-pattern $a #Pattern SortGeneratedCounterCell $.
constant-symbol-23-pattern $a #Pattern SortKCell $.
constant-symbol-24-pattern $a #Pattern SortIOError $.
constant-symbol-25-pattern $a #Pattern SortIOInt $.
constant-symbol-26-pattern $a #Pattern SortSet $.
constant-symbol-27-pattern $a #Pattern SortStream $.
constant-symbol-28-pattern $a #Pattern SortIOFile $.
constant-symbol-29-pattern $a #Pattern SortList $.
constant-symbol-30-pattern $a #Pattern SortId $.
constant-symbol-31-pattern $a #Pattern SortFloat $.
constant-symbol-32-pattern $a #Pattern SortBool $.
constant-symbol-33-pattern $a #Pattern SortGeneratedTopCellFragment $.
constant-symbol-34-pattern $a #Pattern SortMap $.
constant-symbol-35-pattern $a #Pattern Lbl'Hash'E2BIG $.
constant-symbol-36-pattern $a #Pattern Lbl'Hash'EACCES $.
constant-symbol-37-pattern $a #Pattern Lbl'Hash'EADDRINUSE $.
constant-symbol-38-pattern $a #Pattern Lbl'Hash'EADDRNOTAVAIL $.
constant-symbol-39-pattern $a #Pattern Lbl'Hash'EAFNOSUPPORT $.
constant-symbol-40-pattern $a #Pattern Lbl'Hash'EAGAIN $.
constant-symbol-41-pattern $a #Pattern Lbl'Hash'EALREADY $.
constant-symbol-42-pattern $a #Pattern Lbl'Hash'EBADF $.
constant-symbol-43-pattern $a #Pattern Lbl'Hash'EBUSY $.
constant-symbol-44-pattern $a #Pattern Lbl'Hash'ECHILD $.
constant-symbol-45-pattern $a #Pattern Lbl'Hash'ECONNABORTED $.
constant-symbol-46-pattern $a #Pattern Lbl'Hash'ECONNREFUSED $.
constant-symbol-47-pattern $a #Pattern Lbl'Hash'ECONNRESET $.
constant-symbol-48-pattern $a #Pattern Lbl'Hash'EDEADLK $.
constant-symbol-49-pattern $a #Pattern Lbl'Hash'EDESTADDRREQ $.
constant-symbol-50-pattern $a #Pattern Lbl'Hash'EDOM $.
constant-symbol-51-pattern $a #Pattern Lbl'Hash'EEXIST $.
constant-symbol-52-pattern $a #Pattern Lbl'Hash'EFAULT $.
constant-symbol-53-pattern $a #Pattern Lbl'Hash'EFBIG $.
constant-symbol-54-pattern $a #Pattern Lbl'Hash'EHOSTDOWN $.
constant-symbol-55-pattern $a #Pattern Lbl'Hash'EHOSTUNREACH $.
constant-symbol-56-pattern $a #Pattern Lbl'Hash'EINPROGRESS $.
constant-symbol-57-pattern $a #Pattern Lbl'Hash'EINTR $.
constant-symbol-58-pattern $a #Pattern Lbl'Hash'EINVAL $.
constant-symbol-59-pattern $a #Pattern Lbl'Hash'EIO $.
constant-symbol-60-pattern $a #Pattern Lbl'Hash'EISCONN $.
constant-symbol-61-pattern $a #Pattern Lbl'Hash'EISDIR $.
constant-symbol-62-pattern $a #Pattern Lbl'Hash'ELOOP $.
constant-symbol-63-pattern $a #Pattern Lbl'Hash'EMFILE $.
constant-symbol-64-pattern $a #Pattern Lbl'Hash'EMLINK $.
constant-symbol-65-pattern $a #Pattern Lbl'Hash'EMSGSIZE $.
constant-symbol-66-pattern $a #Pattern Lbl'Hash'ENAMETOOLONG $.
constant-symbol-67-pattern $a #Pattern Lbl'Hash'ENETDOWN $.
constant-symbol-68-pattern $a #Pattern Lbl'Hash'ENETRESET $.
constant-symbol-69-pattern $a #Pattern Lbl'Hash'ENETUNREACH $.
constant-symbol-70-pattern $a #Pattern Lbl'Hash'ENFILE $.
constant-symbol-71-pattern $a #Pattern Lbl'Hash'ENOBUFS $.
constant-symbol-72-pattern $a #Pattern Lbl'Hash'ENODEV $.
constant-symbol-73-pattern $a #Pattern Lbl'Hash'ENOENT $.
constant-symbol-74-pattern $a #Pattern Lbl'Hash'ENOEXEC $.
constant-symbol-75-pattern $a #Pattern Lbl'Hash'ENOLCK $.
constant-symbol-76-pattern $a #Pattern Lbl'Hash'ENOMEM $.
constant-symbol-77-pattern $a #Pattern Lbl'Hash'ENOPROTOOPT $.
constant-symbol-78-pattern $a #Pattern Lbl'Hash'ENOSPC $.
constant-symbol-79-pattern $a #Pattern Lbl'Hash'ENOSYS $.
constant-symbol-80-pattern $a #Pattern Lbl'Hash'ENOTCONN $.
constant-symbol-81-pattern $a #Pattern Lbl'Hash'ENOTDIR $.
constant-symbol-82-pattern $a #Pattern Lbl'Hash'ENOTEMPTY $.
constant-symbol-83-pattern $a #Pattern Lbl'Hash'ENOTSOCK $.
constant-symbol-84-pattern $a #Pattern Lbl'Hash'ENOTTY $.
constant-symbol-85-pattern $a #Pattern Lbl'Hash'ENXIO $.
constant-symbol-86-pattern $a #Pattern Lbl'Hash'EOF $.
constant-symbol-87-pattern $a #Pattern Lbl'Hash'EOPNOTSUPP $.
constant-symbol-88-pattern $a #Pattern Lbl'Hash'EOVERFLOW $.
constant-symbol-89-pattern $a #Pattern Lbl'Hash'EPERM $.
constant-symbol-90-pattern $a #Pattern Lbl'Hash'EPFNOSUPPORT $.
constant-symbol-91-pattern $a #Pattern Lbl'Hash'EPIPE $.
constant-symbol-92-pattern $a #Pattern Lbl'Hash'EPROTONOSUPPORT $.
constant-symbol-93-pattern $a #Pattern Lbl'Hash'EPROTOTYPE $.
constant-symbol-94-pattern $a #Pattern Lbl'Hash'ERANGE $.
constant-symbol-95-pattern $a #Pattern Lbl'Hash'EROFS $.
constant-symbol-96-pattern $a #Pattern Lbl'Hash'ESHUTDOWN $.
constant-symbol-97-pattern $a #Pattern Lbl'Hash'ESOCKTNOSUPPORT $.
constant-symbol-98-pattern $a #Pattern Lbl'Hash'ESPIPE $.
constant-symbol-99-pattern $a #Pattern Lbl'Hash'ESRCH $.
constant-symbol-100-pattern $a #Pattern Lbl'Hash'ETIMEDOUT $.
constant-symbol-101-pattern $a #Pattern Lbl'Hash'ETOOMANYREFS $.
constant-symbol-102-pattern $a #Pattern Lbl'Hash'EWOULDBLOCK $.
constant-symbol-103-pattern $a #Pattern Lbl'Hash'EXDEV $.
constant-symbol-104-pattern $a #Pattern ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K var-pattern-0 ) $.
constant-symbol-105-pattern $a #Pattern ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort var-pattern-0 var-pattern-1 var-pattern-2 var-pattern-3 ) $.
constant-symbol-106-pattern $a #Pattern ( Lbl'Hash'logToFile var-pattern-0 var-pattern-1 ) $.
constant-symbol-107-pattern $a #Pattern ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String var-pattern-0 ) $.
constant-symbol-108-pattern $a #Pattern Lbl'Hash'stderr'Unds'K-IO'Unds'Int $.
constant-symbol-109-pattern $a #Pattern Lbl'Hash'stdin'Unds'K-IO'Unds'Int $.
constant-symbol-110-pattern $a #Pattern Lbl'Hash'stdout'Unds'K-IO'Unds'Int $.
constant-symbol-111-pattern $a #Pattern ( Lbl'Hash'systemResult var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-112-pattern $a #Pattern ( Lbl'Hash'tempFile var-pattern-0 var-pattern-1 ) $.
constant-symbol-113-pattern $a #Pattern ( Lbl'Hash'unknownIOError var-pattern-0 ) $.
constant-symbol-114-pattern $a #Pattern Lbl'Stop'List $.
constant-symbol-115-pattern $a #Pattern Lbl'Stop'Map $.
constant-symbol-116-pattern $a #Pattern Lbl'Stop'Set $.
constant-symbol-117-pattern $a #Pattern ( Lbl'-LT-'generatedTop'-GT-'-fragment var-pattern-0 var-pattern-1 ) $.
constant-symbol-118-pattern $a #Pattern ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float var-pattern-0 ) $.
constant-symbol-119-pattern $a #Pattern ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id var-pattern-0 ) $.
constant-symbol-120-pattern $a #Pattern ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-0 ) $.
constant-symbol-121-pattern $a #Pattern ( LblListItem var-pattern-0 ) $.
constant-symbol-122-pattern $a #Pattern ( LblMap'Coln'update var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-123-pattern $a #Pattern ( LblSet'Coln'difference var-pattern-0 var-pattern-1 ) $.
constant-symbol-124-pattern $a #Pattern ( LblSet'Coln'in var-pattern-0 var-pattern-1 ) $.
constant-symbol-125-pattern $a #Pattern ( LblSetItem var-pattern-0 ) $.
constant-symbol-126-pattern $a #Pattern ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String var-pattern-0 ) $.
constant-symbol-127-pattern $a #Pattern ( Lbl'UndsAnd-'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-128-pattern $a #Pattern ( Lbl'UndsStar'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-129-pattern $a #Pattern ( Lbl'UndsPlus'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-130-pattern $a #Pattern ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-131-pattern $a #Pattern ( Lbl'Unds'-Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-132-pattern $a #Pattern ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-0 var-pattern-1 ) $.
constant-symbol-133-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-134-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map var-pattern-0 var-pattern-1 ) $.
constant-symbol-135-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set var-pattern-0 var-pattern-1 ) $.
constant-symbol-136-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-137-pattern $a #Pattern ( Lbl'Unds-LT-'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-138-pattern $a #Pattern ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-139-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'Bool'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-140-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-141-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'K'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-142-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-143-pattern $a #Pattern ( Lbl'UndsEqlsEqls'Bool'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-144-pattern $a #Pattern ( Lbl'UndsEqlsEqls'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-145-pattern $a #Pattern ( Lbl'UndsEqlsEqls'K'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-146-pattern $a #Pattern ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-147-pattern $a #Pattern ( Lbl'Unds-GT-Eqls'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-148-pattern $a #Pattern ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-149-pattern $a #Pattern ( Lbl'Unds-GT-'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-150-pattern $a #Pattern ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-151-pattern $a #Pattern ( Lbl'Unds'List'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-152-pattern $a #Pattern ( Lbl'Unds'Set'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-153-pattern $a #Pattern ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' var-pattern-0 var-pattern-1 ) $.
constant-symbol-154-pattern $a #Pattern ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-155-pattern $a #Pattern ( Lbl'Unds'andBool'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-156-pattern $a #Pattern ( Lbl'Unds'andThenBool'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-157-pattern $a #Pattern ( Lbl'Unds'impliesBool'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-158-pattern $a #Pattern ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List var-pattern-0 var-pattern-1 ) $.
constant-symbol-159-pattern $a #Pattern ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map var-pattern-0 var-pattern-1 ) $.
constant-symbol-160-pattern $a #Pattern ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool var-pattern-0 var-pattern-1 ) $.
constant-symbol-161-pattern $a #Pattern ( Lbl'Unds'orElseBool'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-162-pattern $a #Pattern ( Lbl'Unds'xorBool'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-163-pattern $a #Pattern ( Lbl'Unds'xorInt'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-164-pattern $a #Pattern ( Lbl'UndsPipe'-'-GT-Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-165-pattern $a #Pattern ( Lbl'UndsPipe'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-166-pattern $a #Pattern ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-0 var-pattern-1 ) $.
constant-symbol-167-pattern $a #Pattern ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-0 ) $.
constant-symbol-168-pattern $a #Pattern ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-169-pattern $a #Pattern ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int var-pattern-0 ) $.
constant-symbol-170-pattern $a #Pattern ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-0 ) $.
constant-symbol-171-pattern $a #Pattern ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-0 var-pattern-1 ) $.
constant-symbol-172-pattern $a #Pattern ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map var-pattern-0 ) $.
constant-symbol-173-pattern $a #Pattern ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-0 ) $.
constant-symbol-174-pattern $a #Pattern ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-0 var-pattern-1 ) $.
constant-symbol-175-pattern $a #Pattern ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-0 var-pattern-1 ) $.
constant-symbol-176-pattern $a #Pattern LblnoGeneratedCounterCell $.
constant-symbol-177-pattern $a #Pattern LblnoKCell $.
constant-symbol-178-pattern $a #Pattern ( LblnotBool'Unds' var-pattern-0 ) $.
constant-symbol-179-pattern $a #Pattern ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set var-pattern-0 var-pattern-1 ) $.
constant-symbol-180-pattern $a #Pattern ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-181-pattern $a #Pattern ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-182-pattern $a #Pattern ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List var-pattern-0 ) $.
constant-symbol-183-pattern $a #Pattern ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map var-pattern-0 ) $.
constant-symbol-184-pattern $a #Pattern ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set var-pattern-0 ) $.
constant-symbol-185-pattern $a #Pattern ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-186-pattern $a #Pattern ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-0 var-pattern-1 ) $.
constant-symbol-187-pattern $a #Pattern ( Lbl'Tild'Int'Unds' var-pattern-0 ) $.
constant-symbol-188-pattern $a #Pattern "true" $.
constant-symbol-189-pattern $a #Pattern ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String var-pattern-0 ) $.
constant-symbol-190-pattern $a #Pattern ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String var-pattern-0 var-pattern-1 ) $.
constant-symbol-191-pattern $a #Pattern "r%2B" $.
constant-symbol-192-pattern $a #Pattern "2" $.
constant-symbol-193-pattern $a #Pattern "1" $.
constant-symbol-194-pattern $a #Pattern "false" $.
constant-symbol-195-pattern $a #Pattern ( Lbl'Unds'divInt'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-196-pattern $a #Pattern ( Lbl'UndsSlsh'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-197-pattern $a #Pattern ( Lbl'Unds'modInt'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-198-pattern $a #Pattern ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int var-pattern-0 var-pattern-1 ) $.
constant-symbol-199-pattern $a #Pattern ( Lbl'UndsPerc'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-200-pattern $a #Pattern ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-201-pattern $a #Pattern ( Lbl'Unds-GT--GT-'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-202-pattern $a #Pattern ( Lbl'Unds-LT--LT-'Int'Unds' var-pattern-0 var-pattern-1 ) $.
constant-symbol-203-pattern $a #Pattern ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-204-pattern $a #Pattern "" $.
constant-symbol-205-pattern $a #Pattern ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-206-pattern $a #Pattern "-1" $.
constant-symbol-207-pattern $a #Pattern "_" $.
constant-symbol-208-pattern $a #Pattern ( LblgetGeneratedCounterCell var-pattern-0 ) $.
constant-symbol-209-pattern $a #Pattern LblinitGeneratedCounterCell $.
constant-symbol-210-pattern $a #Pattern ( LblinitGeneratedTopCell var-pattern-0 ) $.
constant-symbol-211-pattern $a #Pattern ( LblinitKCell var-pattern-0 ) $.
constant-symbol-212-pattern $a #Pattern ( Lblproject'Coln'KItem var-pattern-0 ) $.
constant-symbol-213-pattern $a #Pattern ( LblMap'Coln'lookup var-pattern-0 var-pattern-1 ) $.
constant-symbol-214-pattern $a #Pattern SortKConfigVar $.
constant-symbol-215-pattern $a #Pattern "%24PGM" $.
constant-symbol-216-pattern $a #Pattern ( LblisBool var-pattern-0 ) $.
constant-symbol-217-pattern $a #Pattern ( LblisCell var-pattern-0 ) $.
constant-symbol-218-pattern $a #Pattern ( LblisFloat var-pattern-0 ) $.
constant-symbol-219-pattern $a #Pattern ( LblisFoo var-pattern-0 ) $.
constant-symbol-220-pattern $a #Pattern ( LblisGeneratedCounterCell var-pattern-0 ) $.
constant-symbol-221-pattern $a #Pattern ( LblisGeneratedCounterCellOpt var-pattern-0 ) $.
constant-symbol-222-pattern $a #Pattern ( LblisGeneratedTopCell var-pattern-0 ) $.
constant-symbol-223-pattern $a #Pattern ( LblisGeneratedTopCellFragment var-pattern-0 ) $.
constant-symbol-224-pattern $a #Pattern ( LblisIOError var-pattern-0 ) $.
constant-symbol-225-pattern $a #Pattern ( LblisIOFile var-pattern-0 ) $.
constant-symbol-226-pattern $a #Pattern ( LblisIOInt var-pattern-0 ) $.
constant-symbol-227-pattern $a #Pattern ( LblisIOString var-pattern-0 ) $.
constant-symbol-228-pattern $a #Pattern ( LblisId var-pattern-0 ) $.
constant-symbol-229-pattern $a #Pattern ( LblisInt var-pattern-0 ) $.
constant-symbol-230-pattern $a #Pattern ( LblisK var-pattern-0 ) $.
constant-symbol-231-pattern $a #Pattern ( LblisKCell var-pattern-0 ) $.
constant-symbol-232-pattern $a #Pattern ( LblisKCellOpt var-pattern-0 ) $.
constant-symbol-233-pattern $a #Pattern ( LblisKConfigVar var-pattern-0 ) $.
constant-symbol-234-pattern $a #Pattern ( LblisKItem var-pattern-0 ) $.
constant-symbol-235-pattern $a #Pattern ( LblisList var-pattern-0 ) $.
constant-symbol-236-pattern $a #Pattern ( LblisMap var-pattern-0 ) $.
constant-symbol-237-pattern $a #Pattern ( LblisSet var-pattern-0 ) $.
constant-symbol-238-pattern $a #Pattern ( LblisStream var-pattern-0 ) $.
constant-symbol-239-pattern $a #Pattern ( LblisString var-pattern-0 ) $.
constant-symbol-240-pattern $a #Pattern ( Lblproject'ColnHash'tempFile'Coln'fd var-pattern-0 ) $.
constant-symbol-241-pattern $a #Pattern ( Lblproject'ColnHash'tempFile'Coln'path var-pattern-0 ) $.
constant-symbol-242-pattern $a #Pattern ( Lblproject'ColnHash'unknownIOError'Coln'errno var-pattern-0 ) $.
constant-symbol-243-pattern $a #Pattern ( Lblproject'Coln'Bool var-pattern-0 ) $.
constant-symbol-244-pattern $a #Pattern ( Lblproject'Coln'Cell var-pattern-0 ) $.
constant-symbol-245-pattern $a #Pattern ( Lblproject'Coln'Float var-pattern-0 ) $.
constant-symbol-246-pattern $a #Pattern ( Lblproject'Coln'Foo var-pattern-0 ) $.
constant-symbol-247-pattern $a #Pattern ( Lblproject'Coln'GeneratedCounterCell var-pattern-0 ) $.
constant-symbol-248-pattern $a #Pattern ( Lblproject'Coln'GeneratedCounterCellOpt var-pattern-0 ) $.
constant-symbol-249-pattern $a #Pattern ( Lblproject'Coln'GeneratedTopCell var-pattern-0 ) $.
constant-symbol-250-pattern $a #Pattern ( Lblproject'Coln'GeneratedTopCellFragment var-pattern-0 ) $.
constant-symbol-251-pattern $a #Pattern ( Lblproject'Coln'IOError var-pattern-0 ) $.
constant-symbol-252-pattern $a #Pattern ( Lblproject'Coln'IOFile var-pattern-0 ) $.
constant-symbol-253-pattern $a #Pattern ( Lblproject'Coln'IOInt var-pattern-0 ) $.
constant-symbol-254-pattern $a #Pattern ( Lblproject'Coln'IOString var-pattern-0 ) $.
constant-symbol-255-pattern $a #Pattern ( Lblproject'Coln'Id var-pattern-0 ) $.
constant-symbol-256-pattern $a #Pattern ( Lblproject'Coln'Int var-pattern-0 ) $.
constant-symbol-257-pattern $a #Pattern ( Lblproject'Coln'K var-pattern-0 ) $.
constant-symbol-258-pattern $a #Pattern ( Lblproject'Coln'KCell var-pattern-0 ) $.
constant-symbol-259-pattern $a #Pattern ( Lblproject'Coln'KCellOpt var-pattern-0 ) $.
constant-symbol-260-pattern $a #Pattern ( Lblproject'Coln'List var-pattern-0 ) $.
constant-symbol-261-pattern $a #Pattern ( Lblproject'Coln'Map var-pattern-0 ) $.
constant-symbol-262-pattern $a #Pattern ( Lblproject'Coln'Set var-pattern-0 ) $.
constant-symbol-263-pattern $a #Pattern ( Lblproject'Coln'Stream var-pattern-0 ) $.
constant-symbol-264-pattern $a #Pattern ( Lblproject'Coln'String var-pattern-0 ) $.
constant-symbol-265-pattern $a #Pattern ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 var-pattern-3 ) $.
constant-symbol-266-pattern $a #Pattern ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-267-pattern $a #Pattern ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 ) $.
constant-symbol-268-pattern $a #Pattern ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-0 var-pattern-1 var-pattern-2 ) $.
domain-value-0-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "13" ) ) ) ) $.
domain-value-1-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "12" ) ) ) ) $.
domain-value-2-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "0" ) ) ) ) $.
domain-value-3-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortBool var-elementvariable-1 ( \kore-equals SortBool var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortBool "true" ) ) ) ) $.
domain-value-4-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortString var-elementvariable-1 ( \kore-equals SortString var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortString "r%2B" ) ) ) ) $.
domain-value-5-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "2" ) ) ) ) $.
domain-value-6-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "1" ) ) ) ) $.
domain-value-7-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortBool var-elementvariable-1 ( \kore-equals SortBool var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortBool "false" ) ) ) ) $.
domain-value-8-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortString var-elementvariable-1 ( \kore-equals SortString var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortString "" ) ) ) ) $.
domain-value-9-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "-1" ) ) ) ) $.
domain-value-10-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortString var-elementvariable-1 ( \kore-equals SortString var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortString "_" ) ) ) ) $.
domain-value-11-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortKConfigVar var-elementvariable-1 ( \kore-equals SortKConfigVar var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortKConfigVar "%24PGM" ) ) ) ) $.
${
constant-symbol-0-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-0-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-0-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-0-substitution $a #Substitution ( inj var-pattern-1 var-pattern-2 var-pattern-3 ) ( inj var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-1-substitution $a #Substitution SortGeneratedTopCell SortGeneratedTopCell var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-2-substitution $a #Substitution SortKItem SortKItem var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-3-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-3-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-3-substitution $a #Substitution ( Lbl'-LT-'generatedTop'-GT-' var-pattern-1 var-pattern-2 ) ( Lbl'-LT-'generatedTop'-GT-' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-4-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-4-substitution $a #Substitution ( Lbl'-LT-'k'-GT-' var-pattern-1 ) ( Lbl'-LT-'k'-GT-' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-5-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-5-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-5-substitution $a #Substitution ( kseq var-pattern-1 var-pattern-2 ) ( kseq var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-6-substitution $a #Substitution SortFoo SortFoo var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-7-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-7-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-7-substitution $a #Substitution ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo var-pattern-1 var-pattern-2 ) ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-8-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-8-substitution $a #Substitution ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo var-pattern-1 ) ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-9-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-9-substitution $a #Substitution ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int var-pattern-1 ) ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-10-substitution $a #Substitution SortInt SortInt var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-11-substitution $a #Substitution "13" "13" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-12-substitution $a #Substitution "12" "12" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-13-substitution $a #Substitution dotk dotk var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-14-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-14-substitution $a #Substitution ( Lbl'-LT-'generatedCounter'-GT-' var-pattern-1 ) ( Lbl'-LT-'generatedCounter'-GT-' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-15-substitution $a #Substitution "0" "0" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-16-substitution $a #Substitution SortK SortK var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-17-substitution $a #Substitution SortCell SortCell var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-18-substitution $a #Substitution SortIOString SortIOString var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-19-substitution $a #Substitution SortString SortString var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-20-substitution $a #Substitution SortKCellOpt SortKCellOpt var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-21-substitution $a #Substitution SortGeneratedCounterCellOpt SortGeneratedCounterCellOpt var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-22-substitution $a #Substitution SortGeneratedCounterCell SortGeneratedCounterCell var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-23-substitution $a #Substitution SortKCell SortKCell var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-24-substitution $a #Substitution SortIOError SortIOError var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-25-substitution $a #Substitution SortIOInt SortIOInt var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-26-substitution $a #Substitution SortSet SortSet var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-27-substitution $a #Substitution SortStream SortStream var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-28-substitution $a #Substitution SortIOFile SortIOFile var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-29-substitution $a #Substitution SortList SortList var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-30-substitution $a #Substitution SortId SortId var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-31-substitution $a #Substitution SortFloat SortFloat var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-32-substitution $a #Substitution SortBool SortBool var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-33-substitution $a #Substitution SortGeneratedTopCellFragment SortGeneratedTopCellFragment var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-34-substitution $a #Substitution SortMap SortMap var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-35-substitution $a #Substitution Lbl'Hash'E2BIG Lbl'Hash'E2BIG var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-36-substitution $a #Substitution Lbl'Hash'EACCES Lbl'Hash'EACCES var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-37-substitution $a #Substitution Lbl'Hash'EADDRINUSE Lbl'Hash'EADDRINUSE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-38-substitution $a #Substitution Lbl'Hash'EADDRNOTAVAIL Lbl'Hash'EADDRNOTAVAIL var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-39-substitution $a #Substitution Lbl'Hash'EAFNOSUPPORT Lbl'Hash'EAFNOSUPPORT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-40-substitution $a #Substitution Lbl'Hash'EAGAIN Lbl'Hash'EAGAIN var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-41-substitution $a #Substitution Lbl'Hash'EALREADY Lbl'Hash'EALREADY var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-42-substitution $a #Substitution Lbl'Hash'EBADF Lbl'Hash'EBADF var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-43-substitution $a #Substitution Lbl'Hash'EBUSY Lbl'Hash'EBUSY var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-44-substitution $a #Substitution Lbl'Hash'ECHILD Lbl'Hash'ECHILD var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-45-substitution $a #Substitution Lbl'Hash'ECONNABORTED Lbl'Hash'ECONNABORTED var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-46-substitution $a #Substitution Lbl'Hash'ECONNREFUSED Lbl'Hash'ECONNREFUSED var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-47-substitution $a #Substitution Lbl'Hash'ECONNRESET Lbl'Hash'ECONNRESET var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-48-substitution $a #Substitution Lbl'Hash'EDEADLK Lbl'Hash'EDEADLK var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-49-substitution $a #Substitution Lbl'Hash'EDESTADDRREQ Lbl'Hash'EDESTADDRREQ var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-50-substitution $a #Substitution Lbl'Hash'EDOM Lbl'Hash'EDOM var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-51-substitution $a #Substitution Lbl'Hash'EEXIST Lbl'Hash'EEXIST var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-52-substitution $a #Substitution Lbl'Hash'EFAULT Lbl'Hash'EFAULT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-53-substitution $a #Substitution Lbl'Hash'EFBIG Lbl'Hash'EFBIG var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-54-substitution $a #Substitution Lbl'Hash'EHOSTDOWN Lbl'Hash'EHOSTDOWN var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-55-substitution $a #Substitution Lbl'Hash'EHOSTUNREACH Lbl'Hash'EHOSTUNREACH var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-56-substitution $a #Substitution Lbl'Hash'EINPROGRESS Lbl'Hash'EINPROGRESS var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-57-substitution $a #Substitution Lbl'Hash'EINTR Lbl'Hash'EINTR var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-58-substitution $a #Substitution Lbl'Hash'EINVAL Lbl'Hash'EINVAL var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-59-substitution $a #Substitution Lbl'Hash'EIO Lbl'Hash'EIO var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-60-substitution $a #Substitution Lbl'Hash'EISCONN Lbl'Hash'EISCONN var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-61-substitution $a #Substitution Lbl'Hash'EISDIR Lbl'Hash'EISDIR var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-62-substitution $a #Substitution Lbl'Hash'ELOOP Lbl'Hash'ELOOP var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-63-substitution $a #Substitution Lbl'Hash'EMFILE Lbl'Hash'EMFILE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-64-substitution $a #Substitution Lbl'Hash'EMLINK Lbl'Hash'EMLINK var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-65-substitution $a #Substitution Lbl'Hash'EMSGSIZE Lbl'Hash'EMSGSIZE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-66-substitution $a #Substitution Lbl'Hash'ENAMETOOLONG Lbl'Hash'ENAMETOOLONG var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-67-substitution $a #Substitution Lbl'Hash'ENETDOWN Lbl'Hash'ENETDOWN var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-68-substitution $a #Substitution Lbl'Hash'ENETRESET Lbl'Hash'ENETRESET var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-69-substitution $a #Substitution Lbl'Hash'ENETUNREACH Lbl'Hash'ENETUNREACH var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-70-substitution $a #Substitution Lbl'Hash'ENFILE Lbl'Hash'ENFILE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-71-substitution $a #Substitution Lbl'Hash'ENOBUFS Lbl'Hash'ENOBUFS var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-72-substitution $a #Substitution Lbl'Hash'ENODEV Lbl'Hash'ENODEV var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-73-substitution $a #Substitution Lbl'Hash'ENOENT Lbl'Hash'ENOENT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-74-substitution $a #Substitution Lbl'Hash'ENOEXEC Lbl'Hash'ENOEXEC var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-75-substitution $a #Substitution Lbl'Hash'ENOLCK Lbl'Hash'ENOLCK var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-76-substitution $a #Substitution Lbl'Hash'ENOMEM Lbl'Hash'ENOMEM var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-77-substitution $a #Substitution Lbl'Hash'ENOPROTOOPT Lbl'Hash'ENOPROTOOPT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-78-substitution $a #Substitution Lbl'Hash'ENOSPC Lbl'Hash'ENOSPC var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-79-substitution $a #Substitution Lbl'Hash'ENOSYS Lbl'Hash'ENOSYS var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-80-substitution $a #Substitution Lbl'Hash'ENOTCONN Lbl'Hash'ENOTCONN var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-81-substitution $a #Substitution Lbl'Hash'ENOTDIR Lbl'Hash'ENOTDIR var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-82-substitution $a #Substitution Lbl'Hash'ENOTEMPTY Lbl'Hash'ENOTEMPTY var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-83-substitution $a #Substitution Lbl'Hash'ENOTSOCK Lbl'Hash'ENOTSOCK var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-84-substitution $a #Substitution Lbl'Hash'ENOTTY Lbl'Hash'ENOTTY var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-85-substitution $a #Substitution Lbl'Hash'ENXIO Lbl'Hash'ENXIO var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-86-substitution $a #Substitution Lbl'Hash'EOF Lbl'Hash'EOF var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-87-substitution $a #Substitution Lbl'Hash'EOPNOTSUPP Lbl'Hash'EOPNOTSUPP var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-88-substitution $a #Substitution Lbl'Hash'EOVERFLOW Lbl'Hash'EOVERFLOW var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-89-substitution $a #Substitution Lbl'Hash'EPERM Lbl'Hash'EPERM var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-90-substitution $a #Substitution Lbl'Hash'EPFNOSUPPORT Lbl'Hash'EPFNOSUPPORT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-91-substitution $a #Substitution Lbl'Hash'EPIPE Lbl'Hash'EPIPE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-92-substitution $a #Substitution Lbl'Hash'EPROTONOSUPPORT Lbl'Hash'EPROTONOSUPPORT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-93-substitution $a #Substitution Lbl'Hash'EPROTOTYPE Lbl'Hash'EPROTOTYPE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-94-substitution $a #Substitution Lbl'Hash'ERANGE Lbl'Hash'ERANGE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-95-substitution $a #Substitution Lbl'Hash'EROFS Lbl'Hash'EROFS var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-96-substitution $a #Substitution Lbl'Hash'ESHUTDOWN Lbl'Hash'ESHUTDOWN var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-97-substitution $a #Substitution Lbl'Hash'ESOCKTNOSUPPORT Lbl'Hash'ESOCKTNOSUPPORT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-98-substitution $a #Substitution Lbl'Hash'ESPIPE Lbl'Hash'ESPIPE var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-99-substitution $a #Substitution Lbl'Hash'ESRCH Lbl'Hash'ESRCH var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-100-substitution $a #Substitution Lbl'Hash'ETIMEDOUT Lbl'Hash'ETIMEDOUT var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-101-substitution $a #Substitution Lbl'Hash'ETOOMANYREFS Lbl'Hash'ETOOMANYREFS var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-102-substitution $a #Substitution Lbl'Hash'EWOULDBLOCK Lbl'Hash'EWOULDBLOCK var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-103-substitution $a #Substitution Lbl'Hash'EXDEV Lbl'Hash'EXDEV var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-104-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-104-substitution $a #Substitution ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K var-pattern-1 ) ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-105-substitution.0 $e #Substitution var-pattern-1 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-105-substitution.1 $e #Substitution var-pattern-2 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-105-substitution.2 $e #Substitution var-pattern-3 var-pattern-7 var-pattern-0 var-variable-0 $.
constant-symbol-105-substitution.3 $e #Substitution var-pattern-4 var-pattern-8 var-pattern-0 var-variable-0 $.
constant-symbol-105-substitution $a #Substitution ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort var-pattern-5 var-pattern-6 var-pattern-7 var-pattern-8 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-106-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-106-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-106-substitution $a #Substitution ( Lbl'Hash'logToFile var-pattern-1 var-pattern-2 ) ( Lbl'Hash'logToFile var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-107-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-107-substitution $a #Substitution ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String var-pattern-1 ) ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-108-substitution $a #Substitution Lbl'Hash'stderr'Unds'K-IO'Unds'Int Lbl'Hash'stderr'Unds'K-IO'Unds'Int var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-109-substitution $a #Substitution Lbl'Hash'stdin'Unds'K-IO'Unds'Int Lbl'Hash'stdin'Unds'K-IO'Unds'Int var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-110-substitution $a #Substitution Lbl'Hash'stdout'Unds'K-IO'Unds'Int Lbl'Hash'stdout'Unds'K-IO'Unds'Int var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-111-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-111-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-111-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-111-substitution $a #Substitution ( Lbl'Hash'systemResult var-pattern-1 var-pattern-2 var-pattern-3 ) ( Lbl'Hash'systemResult var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-112-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-112-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-112-substitution $a #Substitution ( Lbl'Hash'tempFile var-pattern-1 var-pattern-2 ) ( Lbl'Hash'tempFile var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-113-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-113-substitution $a #Substitution ( Lbl'Hash'unknownIOError var-pattern-1 ) ( Lbl'Hash'unknownIOError var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-114-substitution $a #Substitution Lbl'Stop'List Lbl'Stop'List var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-115-substitution $a #Substitution Lbl'Stop'Map Lbl'Stop'Map var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-116-substitution $a #Substitution Lbl'Stop'Set Lbl'Stop'Set var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-117-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-117-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-117-substitution $a #Substitution ( Lbl'-LT-'generatedTop'-GT-'-fragment var-pattern-1 var-pattern-2 ) ( Lbl'-LT-'generatedTop'-GT-'-fragment var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-118-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-118-substitution $a #Substitution ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float var-pattern-1 ) ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-119-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-119-substitution $a #Substitution ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id var-pattern-1 ) ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-120-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-120-substitution $a #Substitution ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-1 ) ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-121-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-121-substitution $a #Substitution ( LblListItem var-pattern-1 ) ( LblListItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-122-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-122-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-122-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-122-substitution $a #Substitution ( LblMap'Coln'update var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblMap'Coln'update var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-123-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-123-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-123-substitution $a #Substitution ( LblSet'Coln'difference var-pattern-1 var-pattern-2 ) ( LblSet'Coln'difference var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-124-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-124-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-124-substitution $a #Substitution ( LblSet'Coln'in var-pattern-1 var-pattern-2 ) ( LblSet'Coln'in var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-125-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-125-substitution $a #Substitution ( LblSetItem var-pattern-1 ) ( LblSetItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-126-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-126-substitution $a #Substitution ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String var-pattern-1 ) ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-127-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-127-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-127-substitution $a #Substitution ( Lbl'UndsAnd-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsAnd-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-128-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-128-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-128-substitution $a #Substitution ( Lbl'UndsStar'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsStar'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-129-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-129-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-129-substitution $a #Substitution ( Lbl'UndsPlus'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPlus'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-130-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-130-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-130-substitution $a #Substitution ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-131-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-131-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-131-substitution $a #Substitution ( Lbl'Unds'-Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'-Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-132-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-132-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-132-substitution $a #Substitution ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-133-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-133-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-133-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-134-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-134-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-134-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-135-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-135-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-135-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-136-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-136-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-136-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-137-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-137-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-137-substitution $a #Substitution ( Lbl'Unds-LT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-138-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-138-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-138-substitution $a #Substitution ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-139-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-139-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-139-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'Bool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'Bool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-140-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-140-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-140-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-141-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-141-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-141-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'K'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'K'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-142-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-142-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-142-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-143-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-143-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-143-substitution $a #Substitution ( Lbl'UndsEqlsEqls'Bool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'Bool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-144-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-144-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-144-substitution $a #Substitution ( Lbl'UndsEqlsEqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-145-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-145-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-145-substitution $a #Substitution ( Lbl'UndsEqlsEqls'K'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'K'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-146-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-146-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-146-substitution $a #Substitution ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-147-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-147-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-147-substitution $a #Substitution ( Lbl'Unds-GT-Eqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-Eqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-148-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-148-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-148-substitution $a #Substitution ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-149-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-149-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-149-substitution $a #Substitution ( Lbl'Unds-GT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-150-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-150-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-150-substitution $a #Substitution ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-151-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-151-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-151-substitution $a #Substitution ( Lbl'Unds'List'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'List'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-152-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-152-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-152-substitution $a #Substitution ( Lbl'Unds'Set'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'Set'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-153-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-153-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-153-substitution $a #Substitution ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' var-pattern-1 var-pattern-2 ) ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-154-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-154-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-154-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-154-substitution $a #Substitution ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem var-pattern-1 var-pattern-2 var-pattern-3 ) ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-155-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-155-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-155-substitution $a #Substitution ( Lbl'Unds'andBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'andBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-156-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-156-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-156-substitution $a #Substitution ( Lbl'Unds'andThenBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'andThenBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-157-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-157-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-157-substitution $a #Substitution ( Lbl'Unds'impliesBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'impliesBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-158-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-158-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-158-substitution $a #Substitution ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List var-pattern-1 var-pattern-2 ) ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-159-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-159-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-159-substitution $a #Substitution ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map var-pattern-1 var-pattern-2 ) ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-160-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-160-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-160-substitution $a #Substitution ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool var-pattern-1 var-pattern-2 ) ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-161-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-161-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-161-substitution $a #Substitution ( Lbl'Unds'orElseBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'orElseBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-162-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-162-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-162-substitution $a #Substitution ( Lbl'Unds'xorBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'xorBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-163-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-163-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-163-substitution $a #Substitution ( Lbl'Unds'xorInt'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'xorInt'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-164-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-164-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-164-substitution $a #Substitution ( Lbl'UndsPipe'-'-GT-Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPipe'-'-GT-Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-165-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-165-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-165-substitution $a #Substitution ( Lbl'UndsPipe'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPipe'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-166-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-166-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-166-substitution $a #Substitution ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-167-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-167-substitution $a #Substitution ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-1 ) ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-168-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-168-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-168-substitution $a #Substitution ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-169-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-169-substitution $a #Substitution ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int var-pattern-1 ) ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-170-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-170-substitution $a #Substitution ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-1 ) ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-171-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-171-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-171-substitution $a #Substitution ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-172-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-172-substitution $a #Substitution ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map var-pattern-1 ) ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-173-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-173-substitution $a #Substitution ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-1 ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-174-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-174-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-174-substitution $a #Substitution ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-175-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-175-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-175-substitution $a #Substitution ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-176-substitution $a #Substitution LblnoGeneratedCounterCell LblnoGeneratedCounterCell var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-177-substitution $a #Substitution LblnoKCell LblnoKCell var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-178-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-178-substitution $a #Substitution ( LblnotBool'Unds' var-pattern-1 ) ( LblnotBool'Unds' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-179-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-179-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-179-substitution $a #Substitution ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set var-pattern-1 var-pattern-2 ) ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-180-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-180-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-180-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-180-substitution $a #Substitution ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-181-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-181-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-181-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-181-substitution $a #Substitution ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-182-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-182-substitution $a #Substitution ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List var-pattern-1 ) ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-183-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-183-substitution $a #Substitution ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map var-pattern-1 ) ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-184-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-184-substitution $a #Substitution ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set var-pattern-1 ) ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-185-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-185-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-185-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-185-substitution $a #Substitution ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-186-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-186-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-186-substitution $a #Substitution ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-187-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-187-substitution $a #Substitution ( Lbl'Tild'Int'Unds' var-pattern-1 ) ( Lbl'Tild'Int'Unds' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-188-substitution $a #Substitution "true" "true" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-189-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-189-substitution $a #Substitution ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String var-pattern-1 ) ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-190-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-190-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-190-substitution $a #Substitution ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-191-substitution $a #Substitution "r%2B" "r%2B" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-192-substitution $a #Substitution "2" "2" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-193-substitution $a #Substitution "1" "1" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-194-substitution $a #Substitution "false" "false" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-195-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-195-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-195-substitution $a #Substitution ( Lbl'Unds'divInt'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'divInt'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-196-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-196-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-196-substitution $a #Substitution ( Lbl'UndsSlsh'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsSlsh'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-197-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-197-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-197-substitution $a #Substitution ( Lbl'Unds'modInt'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'modInt'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-198-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-198-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-198-substitution $a #Substitution ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-199-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-199-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-199-substitution $a #Substitution ( Lbl'UndsPerc'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPerc'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-200-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-200-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-200-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-200-substitution $a #Substitution ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-201-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-201-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-201-substitution $a #Substitution ( Lbl'Unds-GT--GT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT--GT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-202-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-202-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-202-substitution $a #Substitution ( Lbl'Unds-LT--LT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT--LT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-203-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-203-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-203-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-203-substitution $a #Substitution ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-204-substitution $a #Substitution "" "" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-205-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-205-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-205-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-205-substitution $a #Substitution ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-206-substitution $a #Substitution "-1" "-1" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-207-substitution $a #Substitution "_" "_" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-208-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-208-substitution $a #Substitution ( LblgetGeneratedCounterCell var-pattern-1 ) ( LblgetGeneratedCounterCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-209-substitution $a #Substitution LblinitGeneratedCounterCell LblinitGeneratedCounterCell var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-210-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-210-substitution $a #Substitution ( LblinitGeneratedTopCell var-pattern-1 ) ( LblinitGeneratedTopCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-211-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-211-substitution $a #Substitution ( LblinitKCell var-pattern-1 ) ( LblinitKCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-212-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-212-substitution $a #Substitution ( Lblproject'Coln'KItem var-pattern-1 ) ( Lblproject'Coln'KItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-213-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
constant-symbol-213-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-213-substitution $a #Substitution ( LblMap'Coln'lookup var-pattern-1 var-pattern-2 ) ( LblMap'Coln'lookup var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-214-substitution $a #Substitution SortKConfigVar SortKConfigVar var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-215-substitution $a #Substitution "%24PGM" "%24PGM" var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-216-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-216-substitution $a #Substitution ( LblisBool var-pattern-1 ) ( LblisBool var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-217-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-217-substitution $a #Substitution ( LblisCell var-pattern-1 ) ( LblisCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-218-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-218-substitution $a #Substitution ( LblisFloat var-pattern-1 ) ( LblisFloat var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-219-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-219-substitution $a #Substitution ( LblisFoo var-pattern-1 ) ( LblisFoo var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-220-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-220-substitution $a #Substitution ( LblisGeneratedCounterCell var-pattern-1 ) ( LblisGeneratedCounterCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-221-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-221-substitution $a #Substitution ( LblisGeneratedCounterCellOpt var-pattern-1 ) ( LblisGeneratedCounterCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-222-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-222-substitution $a #Substitution ( LblisGeneratedTopCell var-pattern-1 ) ( LblisGeneratedTopCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-223-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-223-substitution $a #Substitution ( LblisGeneratedTopCellFragment var-pattern-1 ) ( LblisGeneratedTopCellFragment var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-224-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-224-substitution $a #Substitution ( LblisIOError var-pattern-1 ) ( LblisIOError var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-225-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-225-substitution $a #Substitution ( LblisIOFile var-pattern-1 ) ( LblisIOFile var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-226-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-226-substitution $a #Substitution ( LblisIOInt var-pattern-1 ) ( LblisIOInt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-227-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-227-substitution $a #Substitution ( LblisIOString var-pattern-1 ) ( LblisIOString var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-228-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-228-substitution $a #Substitution ( LblisId var-pattern-1 ) ( LblisId var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-229-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-229-substitution $a #Substitution ( LblisInt var-pattern-1 ) ( LblisInt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-230-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-230-substitution $a #Substitution ( LblisK var-pattern-1 ) ( LblisK var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-231-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-231-substitution $a #Substitution ( LblisKCell var-pattern-1 ) ( LblisKCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-232-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-232-substitution $a #Substitution ( LblisKCellOpt var-pattern-1 ) ( LblisKCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-233-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-233-substitution $a #Substitution ( LblisKConfigVar var-pattern-1 ) ( LblisKConfigVar var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-234-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-234-substitution $a #Substitution ( LblisKItem var-pattern-1 ) ( LblisKItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-235-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-235-substitution $a #Substitution ( LblisList var-pattern-1 ) ( LblisList var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-236-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-236-substitution $a #Substitution ( LblisMap var-pattern-1 ) ( LblisMap var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-237-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-237-substitution $a #Substitution ( LblisSet var-pattern-1 ) ( LblisSet var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-238-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-238-substitution $a #Substitution ( LblisStream var-pattern-1 ) ( LblisStream var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-239-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-239-substitution $a #Substitution ( LblisString var-pattern-1 ) ( LblisString var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-240-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-240-substitution $a #Substitution ( Lblproject'ColnHash'tempFile'Coln'fd var-pattern-1 ) ( Lblproject'ColnHash'tempFile'Coln'fd var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-241-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-241-substitution $a #Substitution ( Lblproject'ColnHash'tempFile'Coln'path var-pattern-1 ) ( Lblproject'ColnHash'tempFile'Coln'path var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-242-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-242-substitution $a #Substitution ( Lblproject'ColnHash'unknownIOError'Coln'errno var-pattern-1 ) ( Lblproject'ColnHash'unknownIOError'Coln'errno var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-243-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-243-substitution $a #Substitution ( Lblproject'Coln'Bool var-pattern-1 ) ( Lblproject'Coln'Bool var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-244-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-244-substitution $a #Substitution ( Lblproject'Coln'Cell var-pattern-1 ) ( Lblproject'Coln'Cell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-245-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-245-substitution $a #Substitution ( Lblproject'Coln'Float var-pattern-1 ) ( Lblproject'Coln'Float var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-246-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-246-substitution $a #Substitution ( Lblproject'Coln'Foo var-pattern-1 ) ( Lblproject'Coln'Foo var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-247-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-247-substitution $a #Substitution ( Lblproject'Coln'GeneratedCounterCell var-pattern-1 ) ( Lblproject'Coln'GeneratedCounterCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-248-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-248-substitution $a #Substitution ( Lblproject'Coln'GeneratedCounterCellOpt var-pattern-1 ) ( Lblproject'Coln'GeneratedCounterCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-249-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-249-substitution $a #Substitution ( Lblproject'Coln'GeneratedTopCell var-pattern-1 ) ( Lblproject'Coln'GeneratedTopCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-250-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-250-substitution $a #Substitution ( Lblproject'Coln'GeneratedTopCellFragment var-pattern-1 ) ( Lblproject'Coln'GeneratedTopCellFragment var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-251-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-251-substitution $a #Substitution ( Lblproject'Coln'IOError var-pattern-1 ) ( Lblproject'Coln'IOError var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-252-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-252-substitution $a #Substitution ( Lblproject'Coln'IOFile var-pattern-1 ) ( Lblproject'Coln'IOFile var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-253-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-253-substitution $a #Substitution ( Lblproject'Coln'IOInt var-pattern-1 ) ( Lblproject'Coln'IOInt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-254-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-254-substitution $a #Substitution ( Lblproject'Coln'IOString var-pattern-1 ) ( Lblproject'Coln'IOString var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-255-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-255-substitution $a #Substitution ( Lblproject'Coln'Id var-pattern-1 ) ( Lblproject'Coln'Id var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-256-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-256-substitution $a #Substitution ( Lblproject'Coln'Int var-pattern-1 ) ( Lblproject'Coln'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-257-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-257-substitution $a #Substitution ( Lblproject'Coln'K var-pattern-1 ) ( Lblproject'Coln'K var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-258-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-258-substitution $a #Substitution ( Lblproject'Coln'KCell var-pattern-1 ) ( Lblproject'Coln'KCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-259-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-259-substitution $a #Substitution ( Lblproject'Coln'KCellOpt var-pattern-1 ) ( Lblproject'Coln'KCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-260-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-260-substitution $a #Substitution ( Lblproject'Coln'List var-pattern-1 ) ( Lblproject'Coln'List var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-261-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-261-substitution $a #Substitution ( Lblproject'Coln'Map var-pattern-1 ) ( Lblproject'Coln'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-262-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-262-substitution $a #Substitution ( Lblproject'Coln'Set var-pattern-1 ) ( Lblproject'Coln'Set var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-263-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-263-substitution $a #Substitution ( Lblproject'Coln'Stream var-pattern-1 ) ( Lblproject'Coln'Stream var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-264-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
constant-symbol-264-substitution $a #Substitution ( Lblproject'Coln'String var-pattern-1 ) ( Lblproject'Coln'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-265-substitution.0 $e #Substitution var-pattern-1 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-265-substitution.1 $e #Substitution var-pattern-2 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-265-substitution.2 $e #Substitution var-pattern-3 var-pattern-7 var-pattern-0 var-variable-0 $.
constant-symbol-265-substitution.3 $e #Substitution var-pattern-4 var-pattern-8 var-pattern-0 var-variable-0 $.
constant-symbol-265-substitution $a #Substitution ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int var-pattern-5 var-pattern-6 var-pattern-7 var-pattern-8 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-266-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-266-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-266-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-266-substitution $a #Substitution ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-267-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-267-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-267-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-267-substitution $a #Substitution ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
${
constant-symbol-268-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
constant-symbol-268-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
constant-symbol-268-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
constant-symbol-268-substitution $a #Substitution ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}
KSEQ-axiom-2 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K2 ( \kore-forall SortKItem K1 ( \kore-exists SortK Val ( \kore-equals SortK R Val ( kseq K1 K2 ) ) ) ) ) ) $.
KSEQ-axiom-3 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortK Val ( \kore-equals SortK R Val dotk ) ) ) $.
FOO-axiom-0 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortCell SortKItem From ) ) ) ) ) $.
FOO-axiom-1 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOString From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOString SortKItem From ) ) ) ) ) $.
FOO-axiom-2 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortString SortKItem From ) ) ) ) ) $.
FOO-axiom-3 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCellOpt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortKCellOpt SortKItem From ) ) ) ) ) $.
FOO-axiom-4 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedCounterCellOpt SortKItem From ) ) ) ) ) $.
FOO-axiom-5 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell From ( \kore-exists SortGeneratedCounterCellOpt Val ( \kore-equals SortGeneratedCounterCellOpt R Val ( inj SortGeneratedCounterCell SortGeneratedCounterCellOpt From ) ) ) ) ) $.
FOO-axiom-6 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortKCell SortKItem From ) ) ) ) ) $.
FOO-axiom-7 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortIOInt Val ( \kore-equals SortIOInt R Val ( inj SortIOError SortIOInt From ) ) ) ) ) $.
FOO-axiom-8 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell From ( \kore-exists SortKCellOpt Val ( \kore-equals SortKCellOpt R Val ( inj SortKCell SortKCellOpt From ) ) ) ) ) $.
FOO-axiom-9 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortSet SortKItem From ) ) ) ) ) $.
FOO-axiom-10 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOError SortKItem From ) ) ) ) ) $.
FOO-axiom-11 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedCounterCell SortKItem From ) ) ) ) ) $.
FOO-axiom-12 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt From ( \kore-exists SortIOInt Val ( \kore-equals SortIOInt R Val ( inj SortInt SortIOInt From ) ) ) ) ) $.
FOO-axiom-13 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortFoo SortKItem From ) ) ) ) ) $.
FOO-axiom-14 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortStream From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortStream SortKItem From ) ) ) ) ) $.
FOO-axiom-15 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOFile From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOFile SortKItem From ) ) ) ) ) $.
FOO-axiom-16 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedTopCell SortKItem From ) ) ) ) ) $.
FOO-axiom-17 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOInt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOInt SortKItem From ) ) ) ) ) $.
FOO-axiom-18 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortList SortKItem From ) ) ) ) ) $.
FOO-axiom-19 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString From ( \kore-exists SortIOString Val ( \kore-equals SortIOString R Val ( inj SortString SortIOString From ) ) ) ) ) $.
FOO-axiom-20 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortId SortKItem From ) ) ) ) ) $.
FOO-axiom-21 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortFloat SortKItem From ) ) ) ) ) $.
FOO-axiom-22 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortBool SortKItem From ) ) ) ) ) $.
FOO-axiom-23 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell From ( \kore-exists SortCell Val ( \kore-equals SortCell R Val ( inj SortKCell SortCell From ) ) ) ) ) $.
FOO-axiom-24 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortInt SortKItem From ) ) ) ) ) $.
FOO-axiom-25 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCellFragment From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedTopCellFragment SortKItem From ) ) ) ) ) $.
FOO-axiom-26 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortMap SortKItem From ) ) ) ) ) $.
FOO-axiom-27 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortIOString Val ( \kore-equals SortIOString R Val ( inj SortIOError SortIOString From ) ) ) ) ) $.
FOO-axiom-28 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortIOFile Val ( \kore-equals SortIOFile R Val ( inj SortIOError SortIOFile From ) ) ) ) ) $.
FOO-axiom-29 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'E2BIG ) ) ) $.
FOO-axiom-99 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EACCES ) ) ) $.
FOO-axiom-168 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EADDRINUSE ) ) ) $.
FOO-axiom-236 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EADDRNOTAVAIL ) ) ) $.
FOO-axiom-303 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EAFNOSUPPORT ) ) ) $.
FOO-axiom-369 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EAGAIN ) ) ) $.
FOO-axiom-434 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EALREADY ) ) ) $.
FOO-axiom-498 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EBADF ) ) ) $.
FOO-axiom-561 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EBUSY ) ) ) $.
FOO-axiom-623 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECHILD ) ) ) $.
FOO-axiom-684 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECONNABORTED ) ) ) $.
FOO-axiom-744 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECONNREFUSED ) ) ) $.
FOO-axiom-803 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECONNRESET ) ) ) $.
FOO-axiom-861 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EDEADLK ) ) ) $.
FOO-axiom-918 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EDESTADDRREQ ) ) ) $.
FOO-axiom-974 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EDOM ) ) ) $.
FOO-axiom-1029 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EEXIST ) ) ) $.
FOO-axiom-1083 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EFAULT ) ) ) $.
FOO-axiom-1136 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EFBIG ) ) ) $.
FOO-axiom-1188 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EHOSTDOWN ) ) ) $.
FOO-axiom-1239 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EHOSTUNREACH ) ) ) $.
FOO-axiom-1289 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EINPROGRESS ) ) ) $.
FOO-axiom-1338 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EINTR ) ) ) $.
FOO-axiom-1386 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EINVAL ) ) ) $.
FOO-axiom-1433 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EIO ) ) ) $.
FOO-axiom-1479 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EISCONN ) ) ) $.
FOO-axiom-1524 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EISDIR ) ) ) $.
FOO-axiom-1568 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ELOOP ) ) ) $.
FOO-axiom-1611 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EMFILE ) ) ) $.
FOO-axiom-1653 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EMLINK ) ) ) $.
FOO-axiom-1694 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EMSGSIZE ) ) ) $.
FOO-axiom-1734 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENAMETOOLONG ) ) ) $.
FOO-axiom-1773 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENETDOWN ) ) ) $.
FOO-axiom-1811 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENETRESET ) ) ) $.
FOO-axiom-1848 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENETUNREACH ) ) ) $.
FOO-axiom-1884 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENFILE ) ) ) $.
FOO-axiom-1919 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOBUFS ) ) ) $.
FOO-axiom-1953 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENODEV ) ) ) $.
FOO-axiom-1986 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOENT ) ) ) $.
FOO-axiom-2018 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOEXEC ) ) ) $.
FOO-axiom-2049 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOLCK ) ) ) $.
FOO-axiom-2079 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOMEM ) ) ) $.
FOO-axiom-2108 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOPROTOOPT ) ) ) $.
FOO-axiom-2136 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOSPC ) ) ) $.
FOO-axiom-2163 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOSYS ) ) ) $.
FOO-axiom-2189 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTCONN ) ) ) $.
FOO-axiom-2214 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTDIR ) ) ) $.
FOO-axiom-2238 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTEMPTY ) ) ) $.
FOO-axiom-2261 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTSOCK ) ) ) $.
FOO-axiom-2283 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTTY ) ) ) $.
FOO-axiom-2304 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENXIO ) ) ) $.
FOO-axiom-2324 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EOF ) ) ) $.
FOO-axiom-2343 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EOPNOTSUPP ) ) ) $.
FOO-axiom-2361 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EOVERFLOW ) ) ) $.
FOO-axiom-2378 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPERM ) ) ) $.
FOO-axiom-2394 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPFNOSUPPORT ) ) ) $.
FOO-axiom-2409 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPIPE ) ) ) $.
FOO-axiom-2423 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPROTONOSUPPORT ) ) ) $.
FOO-axiom-2436 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPROTOTYPE ) ) ) $.
FOO-axiom-2448 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ERANGE ) ) ) $.
FOO-axiom-2459 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EROFS ) ) ) $.
FOO-axiom-2469 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESHUTDOWN ) ) ) $.
FOO-axiom-2478 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESOCKTNOSUPPORT ) ) ) $.
FOO-axiom-2486 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESPIPE ) ) ) $.
FOO-axiom-2493 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESRCH ) ) ) $.
FOO-axiom-2499 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ETIMEDOUT ) ) ) $.
FOO-axiom-2504 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ETOOMANYREFS ) ) ) $.
FOO-axiom-2508 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EWOULDBLOCK ) ) ) $.
FOO-axiom-2511 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EXDEV ) ) ) $.
FOO-axiom-2513 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K0 ( \kore-exists SortStream Val ( \kore-equals SortStream R Val ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K K0 ) ) ) ) ) $.
FOO-axiom-2515 $a |- ( \kore-forall \kore-sort R ( \kore-forall \kore-sort SortSort ( \kore-forall SortSort K2 ( \kore-forall SortSort K1 ( \kore-forall SortBool K0 ( \kore-exists SortSort Val ( \kore-equals SortSort R Val ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortSort K0 K1 K2 ) ) ) ) ) ) ) ) $.
FOO-axiom-2516 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortK Val ( \kore-equals SortK R Val ( Lbl'Hash'logToFile K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2517 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K0 ( \kore-exists SortK Val ( \kore-equals SortK R Val ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String K0 ) ) ) ) ) $.
FOO-axiom-2518 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortInt Val ( \kore-equals SortInt R Val Lbl'Hash'stderr'Unds'K-IO'Unds'Int ) ) ) $.
FOO-axiom-2519 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortInt Val ( \kore-equals SortInt R Val Lbl'Hash'stdin'Unds'K-IO'Unds'Int ) ) ) $.
FOO-axiom-2520 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortInt Val ( \kore-equals SortInt R Val Lbl'Hash'stdout'Unds'K-IO'Unds'Int ) ) ) $.
FOO-axiom-2521 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K2 ( \kore-forall SortString K1 ( \kore-forall SortInt K0 ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( Lbl'Hash'systemResult K0 K1 K2 ) ) ) ) ) ) ) $.
FOO-axiom-2523 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortString K0 ( \kore-exists SortIOFile Val ( \kore-equals SortIOFile R Val ( Lbl'Hash'tempFile K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2525 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val ( Lbl'Hash'unknownIOError K0 ) ) ) ) ) $.
FOO-axiom-2527 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortList Val ( \kore-equals SortList R Val Lbl'Stop'List ) ) ) $.
FOO-axiom-2528 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortMap Val ( \kore-equals SortMap R Val Lbl'Stop'Map ) ) ) $.
FOO-axiom-2529 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortSet Val ( \kore-equals SortSet R Val Lbl'Stop'Set ) ) ) $.
FOO-axiom-2530 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortGeneratedCounterCell Val ( \kore-equals SortGeneratedCounterCell R Val ( Lbl'-LT-'generatedCounter'-GT-' K0 ) ) ) ) ) $.
FOO-axiom-2532 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell K1 ( \kore-forall SortKCell K0 ( \kore-exists SortGeneratedTopCell Val ( \kore-equals SortGeneratedTopCell R Val ( Lbl'-LT-'generatedTop'-GT-' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2534 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt K1 ( \kore-forall SortKCellOpt K0 ( \kore-exists SortGeneratedTopCellFragment Val ( \kore-equals SortGeneratedTopCellFragment R Val ( Lbl'-LT-'generatedTop'-GT-'-fragment K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2536 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K0 ( \kore-exists SortKCell Val ( \kore-equals SortKCell R Val ( Lbl'-LT-'k'-GT-' K0 ) ) ) ) ) $.
FOO-axiom-2538 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float K0 ) ) ) ) ) $.
FOO-axiom-2539 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id K0 ) ) ) ) ) $.
FOO-axiom-2540 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int K0 ) ) ) ) ) $.
FOO-axiom-2541 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K0 ( \kore-exists SortList Val ( \kore-equals SortList R Val ( LblListItem K0 ) ) ) ) ) $.
FOO-axiom-2542 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K2 ( \kore-forall SortKItem K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( LblMap'Coln'update K0 K1 K2 ) ) ) ) ) ) ) $.
FOO-axiom-2543 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( LblSet'Coln'difference K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2544 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortKItem K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( LblSet'Coln'in K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2545 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( LblSetItem K0 ) ) ) ) ) $.
FOO-axiom-2546 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K0 ( \kore-exists SortId Val ( \kore-equals SortId R Val ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String K0 ) ) ) ) ) $.
FOO-axiom-2547 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsAnd-'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2548 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsStar'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2549 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsPlus'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2550 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2551 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'Unds'-Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2552 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2553 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2554 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortMap K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2555 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2556 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2557 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2558 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2559 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'Bool'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2560 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2561 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K1 ( \kore-forall SortK K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'K'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2562 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2563 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'Bool'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2564 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2565 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K1 ( \kore-forall SortK K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'K'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2566 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2567 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-Eqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2568 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2569 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2570 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2574 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList K1 ( \kore-forall SortList K0 ( \kore-exists SortList Val ( \kore-equals SortList R Val ( Lbl'Unds'List'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2584 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( Lbl'Unds'Set'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2585 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2586 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K2 ( \kore-forall SortKItem K1 ( \kore-forall SortMap K0 ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem K0 K1 K2 ) ) ) ) ) ) ) $.
FOO-axiom-2587 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'andBool'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2588 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'andThenBool'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2589 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'impliesBool'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2590 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList K1 ( \kore-forall SortKItem K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2591 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortKItem K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2592 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2593 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'orElseBool'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2594 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'xorBool'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2595 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'Unds'xorInt'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2596 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K1 ( \kore-forall SortKItem K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( Lbl'UndsPipe'-'-GT-Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2597 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsPipe'Int'Unds' K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2598 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2599 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int K0 ) ) ) ) ) $.
FOO-axiom-2600 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo K1 ( \kore-forall SortFoo K0 ( \kore-exists SortFoo Val ( \kore-equals SortFoo R Val ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2604 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2605 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortFoo Val ( \kore-equals SortFoo R Val ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int K0 ) ) ) ) ) $.
FOO-axiom-2608 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortId Val ( \kore-equals SortId R Val ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int K0 ) ) ) ) ) $.
FOO-axiom-2609 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int K0 ) ) ) ) ) $.
FOO-axiom-2610 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo K0 ( \kore-exists SortFoo Val ( \kore-equals SortFoo R Val ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo K0 ) ) ) ) ) $.
FOO-axiom-2612 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2613 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map K0 ) ) ) ) ) $.
FOO-axiom-2614 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String K0 ) ) ) ) ) $.
FOO-axiom-2615 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2616 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2617 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortGeneratedCounterCellOpt Val ( \kore-equals SortGeneratedCounterCellOpt R Val LblnoGeneratedCounterCell ) ) ) $.
FOO-axiom-2618 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortKCellOpt Val ( \kore-equals SortKCellOpt R Val LblnoKCell ) ) ) $.
FOO-axiom-2619 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( LblnotBool'Unds' K0 ) ) ) ) ) $.
FOO-axiom-2620 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2621 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K2 ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String K0 K1 K2 ) ) ) ) ) ) ) $.
FOO-axiom-2622 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K2 ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String K0 K1 K2 ) ) ) ) ) ) ) $.
FOO-axiom-2623 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List K0 ) ) ) ) ) $.
FOO-axiom-2624 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map K0 ) ) ) ) ) $.
FOO-axiom-2625 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set K0 ) ) ) ) ) $.
FOO-axiom-2626 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K2 ( \kore-forall SortInt K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int K0 K1 K2 ) ) ) ) ) ) ) $.
FOO-axiom-2627 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map K0 K1 ) ) ) ) ) ) $.
FOO-axiom-2628 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'Tild'Int'Unds' K0 ) ) ) ) ) $.
FOO-axiom-2653 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK Var'Unds'0 ( \kore-forall SortK VarB1 ( \kore-forall SortBool VarC ( \kore-implies R ( \kore-equals SortBool R VarC ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortK R ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortK VarC VarB1 Var'Unds'0 ) VarB1 ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2654 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarB2 ( \kore-forall SortK Var'Unds'0 ( \kore-forall SortBool VarC ( \kore-implies R ( \kore-equals SortBool R ( LblnotBool'Unds' VarC ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortK R ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortK VarC Var'Unds'0 VarB2 ) VarB2 ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2655 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOInt R ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String VarS ) ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String VarS ( \kore-dv SortString "r%2B" ) ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2656 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R Lbl'Hash'stderr'Unds'K-IO'Unds'Int ( \kore-dv SortInt "2" ) ) ( \kore-top R ) ) ) ) $.
FOO-axiom-2657 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R Lbl'Hash'stdin'Unds'K-IO'Unds'Int ( \kore-dv SortInt "0" ) ) ( \kore-top R ) ) ) ) $.
FOO-axiom-2658 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R Lbl'Hash'stdout'Unds'K-IO'Unds'Int ( \kore-dv SortInt "1" ) ) ( \kore-top R ) ) ) ) $.
FOO-axiom-2659 $a |- ( \kore-forall SortGeneratedCounterCell Var'Unds'DotVar0 ( \kore-forall SortK Var'Unds'DotVar1 ( \kore-forall SortFoo VarY ( \kore-forall SortFoo VarX ( \kore-rewrites SortGeneratedTopCell ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo VarX VarY ) ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem VarX ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ) ) ) ) ) $.
FOO-axiom-2660 $a |- ( \kore-forall SortGeneratedCounterCell Var'Unds'DotVar0 ( \kore-forall SortK Var'Unds'DotVar1 ( \kore-forall SortFoo VarX ( \kore-rewrites SortGeneratedTopCell ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo VarX ) ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem VarX ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ) ) ) ) $.
FOO-axiom-2661 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( LblnotBool'Unds' ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 VarS1 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2662 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB2 ( \kore-forall SortBool VarB1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Bool'Unds' VarB1 VarB2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'Bool'Unds' VarB1 VarB2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2663 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Int'Unds' VarI1 VarI2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'Int'Unds' VarI1 VarI2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2664 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK2 ( \kore-forall SortK VarK1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'K'Unds' VarK1 VarK2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'K'Unds' VarK1 VarK2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2665 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2666 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsEqls'K'Unds' ( kseq ( inj SortInt SortKItem VarI1 ) dotk ) ( kseq ( inj SortInt SortKItem VarI2 ) dotk ) ) ( Lbl'UndsEqlsEqls'Int'Unds' VarI1 VarI2 ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2667 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK2 ( \kore-forall SortBool VarK1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsEqls'K'Unds' ( kseq ( inj SortBool SortKItem VarK1 ) dotk ) ( kseq ( inj SortBool SortKItem VarK2 ) dotk ) ) ( Lbl'UndsEqlsEqls'Bool'Unds' VarK1 VarK2 ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2668 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsEqls'K'Unds' ( kseq ( inj SortString SortKItem VarS1 ) dotk ) ( kseq ( inj SortString SortKItem VarS2 ) dotk ) ) ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2669 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( LblnotBool'Unds' ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2670 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 VarS1 ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2671 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2672 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) VarB ) VarB ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2673 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' VarB ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) ) VarB ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2674 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'1 ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2675 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2676 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) VarK ) VarK ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2677 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' VarK ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) ) VarK ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2678 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'1 ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2679 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI1 ( \kore-forall SortInt VarI2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Int'Unds' VarI2 ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( Lbl'Unds'divInt'Unds' VarI1 VarI2 ) ( Lbl'UndsSlsh'Int'Unds' ( Lbl'Unds'-Int'Unds' VarI1 ( Lbl'Unds'modInt'Unds' VarI1 VarI2 ) ) VarI2 ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2680 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int VarI1 VarI2 ) ( Lbl'UndsEqlsEqls'Int'Unds' ( Lbl'UndsPerc'Int'Unds' VarI2 VarI1 ) ( \kore-dv SortInt "0" ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2681 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) VarB ) VarB ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2682 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' VarB ( \kore-dv SortBool "false" ) ) ( LblnotBool'Unds' VarB ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2683 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2684 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' ( \kore-dv SortBool "false" ) Var'Unds'0 ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2685 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI1 ( \kore-forall SortInt VarI2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Int'Unds' VarI2 ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( Lbl'Unds'modInt'Unds' VarI1 VarI2 ) ( Lbl'UndsPerc'Int'Unds' ( Lbl'UndsPlus'Int'Unds' ( Lbl'UndsPerc'Int'Unds' VarI1 ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int VarI2 ) ) ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int VarI2 ) ) ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int VarI2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2686 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2687 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool VarB ( \kore-dv SortBool "false" ) ) VarB ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2688 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2689 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool ( \kore-dv SortBool "false" ) VarB ) VarB ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2690 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2691 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' VarK ( \kore-dv SortBool "false" ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2692 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.
FOO-axiom-2693 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' ( \kore-dv SortBool "false" ) VarK ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2694 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'xorBool'Unds' VarB VarB ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2695 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'xorBool'Unds' VarB ( \kore-dv SortBool "false" ) ) VarB ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2696 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'xorBool'Unds' ( \kore-dv SortBool "false" ) VarB ) VarB ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2697 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet VarS2 ( \kore-forall SortSet VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortSet R ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set VarS1 VarS2 ) ( Lbl'Unds'Set'Unds' VarS1 ( LblSet'Coln'difference VarS2 VarS1 ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2698 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarLEN ( \kore-forall SortInt VarIDX ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int VarI VarIDX VarLEN ) ( Lbl'Unds'modInt'Unds' ( Lbl'Unds-GT--GT-'Int'Unds' VarI VarIDX ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) VarLEN ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2699 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarToCount ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToCount ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String VarSource VarToCount ) ( Lbl'UndsPlus'Int'Unds' ( \kore-dv SortInt "1" ) ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( Lbl'UndsPlus'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToCount ( \kore-dv SortInt "0" ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarToCount ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarSource ) ) VarToCount ) ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2700 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarToCount ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-LT-'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToCount ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String VarSource VarToCount ) ( \kore-dv SortInt "0" ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2701 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-forall SortString VarS1 ( \kore-forall SortString VarS2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 ( \kore-dv SortString "" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 VarS2 VarI ) ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortInt ( Lbl'UndsEqlsEqls'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( \kore-dv SortInt "-1" ) ) ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortInt ( Lbl'UndsEqlsEqls'Int'Unds' ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ( \kore-dv SortInt "-1" ) ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2702 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt Var'Unds'1 ( \kore-forall SortString Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int Var'Unds'0 ( \kore-dv SortString "" ) Var'Unds'1 ) ( \kore-dv SortInt "-1" ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2703 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortId R ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int VarI ) ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( \kore-dv SortString "_" ) ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int VarI ) ) ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2704 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int VarI ) VarI ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2705 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell VarCell ( \kore-forall SortKCell Var'Unds'DotVar0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCell R ( LblgetGeneratedCounterCell ( Lbl'-LT-'generatedTop'-GT-' Var'Unds'DotVar0 VarCell ) ) VarCell ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2706 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCell R LblinitGeneratedCounterCell ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ( \kore-top R ) ) ) ) $.
FOO-axiom-2707 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarInit ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedTopCell R ( LblinitGeneratedTopCell VarInit ) ( Lbl'-LT-'generatedTop'-GT-' ( LblinitKCell VarInit ) LblinitGeneratedCounterCell ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2708 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarInit ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKCell R ( LblinitKCell VarInit ) ( Lbl'-LT-'k'-GT-' ( kseq ( Lblproject'Coln'KItem ( kseq ( LblMap'Coln'lookup VarInit ( inj SortKConfigVar SortKItem ( \kore-dv SortKConfigVar "%24PGM" ) ) ) dotk ) ) dotk ) ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2709 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortBool Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortBool SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisBool VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2710 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarBool ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisBool ( kseq ( inj SortBool SortKItem VarBool ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2711 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortCell Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortCell SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2712 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortCell VarCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisCell ( kseq ( inj SortCell SortKItem VarCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2713 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortFloat Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortFloat SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisFloat VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2714 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat VarFloat ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisFloat ( kseq ( inj SortFloat SortKItem VarFloat ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2715 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortFoo Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortFoo SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisFoo VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2716 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo VarFoo ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisFoo ( kseq ( inj SortFoo SortKItem VarFoo ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2717 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedCounterCell Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedCounterCell SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2718 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell VarGeneratedCounterCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCell ( kseq ( inj SortGeneratedCounterCell SortKItem VarGeneratedCounterCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2719 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedCounterCellOpt Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedCounterCellOpt SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCellOpt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2720 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt VarGeneratedCounterCellOpt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCellOpt ( kseq ( inj SortGeneratedCounterCellOpt SortKItem VarGeneratedCounterCellOpt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2721 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedTopCell Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedTopCell SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2722 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCell VarGeneratedTopCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCell ( kseq ( inj SortGeneratedTopCell SortKItem VarGeneratedTopCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2723 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedTopCellFragment Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedTopCellFragment SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCellFragment VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2724 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCellFragment VarGeneratedTopCellFragment ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCellFragment ( kseq ( inj SortGeneratedTopCellFragment SortKItem VarGeneratedTopCellFragment ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2725 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOError Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOError SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOError VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2726 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError VarIOError ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOError ( kseq ( inj SortIOError SortKItem VarIOError ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2727 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOFile Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOFile SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOFile VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2728 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOFile VarIOFile ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOFile ( kseq ( inj SortIOFile SortKItem VarIOFile ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2729 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOInt Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOInt SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOInt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2730 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOInt VarIOInt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOInt ( kseq ( inj SortIOInt SortKItem VarIOInt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2731 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOString Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOString SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOString VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2732 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOString VarIOString ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOString ( kseq ( inj SortIOString SortKItem VarIOString ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2733 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortId Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortId SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisId VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2734 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId VarId ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisId ( kseq ( inj SortId SortKItem VarId ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2735 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortInt Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortInt SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisInt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2736 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarInt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisInt ( kseq ( inj SortInt SortKItem VarInt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2737 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisK VarK ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2738 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKCell Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortKCell SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2739 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell VarKCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCell ( kseq ( inj SortKCell SortKItem VarKCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2740 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKCellOpt Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortKCellOpt SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCellOpt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2741 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCellOpt VarKCellOpt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCellOpt ( kseq ( inj SortKCellOpt SortKItem VarKCellOpt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2742 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKConfigVar Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortKConfigVar SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKConfigVar VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2743 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKConfigVar VarKConfigVar ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKConfigVar ( kseq ( inj SortKConfigVar SortKItem VarKConfigVar ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2744 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKItem Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq Var'Unds'0 dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKItem VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2745 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem VarKItem ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKItem ( kseq VarKItem dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2746 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortList Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortList SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisList VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2747 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList VarList ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisList ( kseq ( inj SortList SortKItem VarList ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2748 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortMap Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortMap SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisMap VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2749 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarMap ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisMap ( kseq ( inj SortMap SortKItem VarMap ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2750 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortSet Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortSet SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisSet VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2751 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet VarSet ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisSet ( kseq ( inj SortSet SortKItem VarSet ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2752 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortStream Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortStream SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisStream VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2753 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortStream VarStream ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisStream ( kseq ( inj SortStream SortKItem VarStream ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2754 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortString Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortString SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bot R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisString VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2755 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarString ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisString ( kseq ( inj SortString SortKItem VarString ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2756 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-LT-Eqls'Int'Unds' VarI1 VarI2 ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int VarI1 VarI2 ) VarI1 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2757 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'Int'Unds' VarI1 VarI2 ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int VarI1 VarI2 ) VarI2 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2758 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( LblnotBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) ) ( \kore-dv SortBool "false" ) ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) $.
FOO-axiom-2759 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblnotBool'Unds' ( \kore-dv SortBool "false" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) $.
FOO-axiom-2760 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK1 ( \kore-forall SortString VarK0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( Lblproject'ColnHash'tempFile'Coln'fd ( Lbl'Hash'tempFile VarK0 VarK1 ) ) VarK1 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2761 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK1 ( \kore-forall SortString VarK0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( Lblproject'ColnHash'tempFile'Coln'path ( Lbl'Hash'tempFile VarK0 VarK1 ) ) VarK0 ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2762 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( Lblproject'ColnHash'unknownIOError'Coln'errno ( Lbl'Hash'unknownIOError VarK0 ) ) VarK0 ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2763 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lblproject'Coln'Bool ( kseq ( inj SortBool SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2764 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortCell R ( Lblproject'Coln'Cell ( kseq ( inj SortCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2765 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortFloat R ( Lblproject'Coln'Float ( kseq ( inj SortFloat SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2766 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortFoo R ( Lblproject'Coln'Foo ( kseq ( inj SortFoo SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2767 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCell R ( Lblproject'Coln'GeneratedCounterCell ( kseq ( inj SortGeneratedCounterCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2768 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCellOpt R ( Lblproject'Coln'GeneratedCounterCellOpt ( kseq ( inj SortGeneratedCounterCellOpt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2769 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedTopCell R ( Lblproject'Coln'GeneratedTopCell ( kseq ( inj SortGeneratedTopCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2770 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCellFragment VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedTopCellFragment R ( Lblproject'Coln'GeneratedTopCellFragment ( kseq ( inj SortGeneratedTopCellFragment SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2771 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOError R ( Lblproject'Coln'IOError ( kseq ( inj SortIOError SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2772 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOFile VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOFile R ( Lblproject'Coln'IOFile ( kseq ( inj SortIOFile SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2773 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOInt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOInt R ( Lblproject'Coln'IOInt ( kseq ( inj SortIOInt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2774 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOString VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOString R ( Lblproject'Coln'IOString ( kseq ( inj SortIOString SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2775 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortId R ( Lblproject'Coln'Id ( kseq ( inj SortId SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2776 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( Lblproject'Coln'Int ( kseq ( inj SortInt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2777 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortK R ( Lblproject'Coln'K VarK ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2778 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKCell R ( Lblproject'Coln'KCell ( kseq ( inj SortKCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2779 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCellOpt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKCellOpt R ( Lblproject'Coln'KCellOpt ( kseq ( inj SortKCellOpt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2780 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKItem R ( Lblproject'Coln'KItem ( kseq VarK dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2781 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortList R ( Lblproject'Coln'List ( kseq ( inj SortList SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2782 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortMap R ( Lblproject'Coln'Map ( kseq ( inj SortMap SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2783 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortSet R ( Lblproject'Coln'Set ( kseq ( inj SortSet SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2784 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortStream VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortStream R ( Lblproject'Coln'Stream ( kseq ( inj SortStream SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2785 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( Lblproject'Coln'String ( kseq ( inj SortString SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.
FOO-axiom-2786 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarReplacement ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-forall SortInt VarCount ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-'Int'Unds' VarCount ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortString R ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int VarSource VarToReplace VarReplacement VarCount ) ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( \kore-dv SortInt "0" ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ) VarReplacement ) ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( Lbl'UndsPlus'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarToReplace ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarSource ) ) VarToReplace VarReplacement ( Lbl'Unds'-Int'Unds' VarCount ( \kore-dv SortInt "1" ) ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) ) $.
FOO-axiom-2787 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString Var'Unds'1 ( \kore-forall SortString Var'Unds'0 ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int VarSource Var'Unds'0 Var'Unds'1 ( \kore-dv SortInt "0" ) ) VarSource ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2788 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarReplacement ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String VarSource VarToReplace VarReplacement ) ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int VarSource VarToReplace VarReplacement ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String VarSource VarToReplace ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2789 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarReplacement ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortString R ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String VarSource VarToReplace VarReplacement ) ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( \kore-dv SortInt "0" ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ) VarReplacement ) ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( Lbl'UndsPlus'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarToReplace ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarSource ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2790 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString Var'Unds'0 ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-LT-'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortString R ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String VarSource VarToReplace Var'Unds'0 ) VarSource ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2791 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-forall SortString VarS1 ( \kore-forall SortString VarS2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 ( \kore-dv SortString "" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 VarS2 VarI ) ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.
FOO-axiom-2792 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt Var'Unds'1 ( \kore-forall SortString Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int Var'Unds'0 ( \kore-dv SortString "" ) Var'Unds'1 ) ( \kore-dv SortInt "-1" ) ) ( \kore-top R ) ) ) ) ) ) $.
FOO-axiom-2793 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarLEN ( \kore-forall SortInt VarIDX ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int VarI VarIDX VarLEN ) ( Lbl'Unds'-Int'Unds' ( Lbl'Unds'modInt'Unds' ( Lbl'UndsPlus'Int'Unds' ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int VarI VarIDX VarLEN ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) ( Lbl'Unds'-Int'Unds' VarLEN ( \kore-dv SortInt "1" ) ) ) ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) VarLEN ) ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) ( Lbl'Unds'-Int'Unds' VarLEN ( \kore-dv SortInt "1" ) ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.
step-0 $p |- ( \kore-rewrites SortGeneratedTopCell ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "12" ) ) ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ) $= constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type variable-2-type variable-3-type constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-14-type variable-2-type variable-3-type constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-14-type kore-forall-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-14-type kore-forall-pattern variable-13-type variable-2-type variable-3-type constant-symbol-22-pattern constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-14-type kore-forall-pattern variable-13-type kore-forall-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-14-type kore-forall-pattern variable-13-type kore-forall-pattern variable-12-type variable-2-type variable-3-type variable-12-type variable-13-type variable-14-type variable-15-type FOO-axiom-2659 constant-symbol-10-pattern constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-14-pattern kore-equals-pattern variable-2-type kore-exists-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern kore-equals-pattern variable-2-type kore-exists-pattern variable-5-type variable-63-type variable-62-type variable-3-type variable-2-type variable-3-type variable-5-type FOO-axiom-2530 variable-62-type variable-63-type domain-value-2-functional constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern kore-equals-pattern constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-14-pattern kore-equals-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-2-type variable-5-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev constant-symbol-22-substitution constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev constant-symbol-22-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev variable-3-type vev sbv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev variable-2-type vev sbv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev wv variable-5-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev sb constant-symbol-14-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-14-type kore-forall-pattern constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-14-type kore-forall-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-13-type variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-16-substitution constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-14-type variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-6-substitution constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-15-type variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-6-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev variable-12-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-12-type vev variable-13-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern variable-12-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-15-type vev wv variable-14-type vev wv variable-15-type vev wv variable-12-type vev variable-14-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-15-type vev sbv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-14-type vev sbv constant-symbol-7-substitution constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-13-type vev sbv constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev sb constant-symbol-3-substitution kore-and-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev variable-12-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-12-type vev variable-13-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-12-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-15-type vev sbv constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-13-type vev sbv constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev sb constant-symbol-3-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-substitution kore-forall-substitution kore-forall-elim variable-2-type variable-3-type KSEQ-axiom-3 constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-13-pattern variable-14-type variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-6-substitution constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-13-pattern variable-15-type variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-6-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-13-type vev constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-13-type vev variable-13-type vev wv constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern variable-13-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-6-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-2-substitution constant-symbol-13-pattern variable-15-type vev wv variable-14-type vev wv variable-15-type vev wv variable-13-type vev variable-14-type vev wv constant-symbol-13-pattern variable-13-type vev variable-15-type vev sbv constant-symbol-13-pattern variable-13-type vev variable-14-type vev sbv constant-symbol-7-substitution constant-symbol-0-substitution constant-symbol-13-pattern variable-13-type vev sb constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-10-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-13-type vev constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev variable-13-type vev wv constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-13-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-13-pattern variable-13-type vev constant-symbol-6-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-2-substitution constant-symbol-13-pattern variable-13-type vev variable-15-type vev sbv constant-symbol-0-substitution constant-symbol-13-pattern variable-13-type vev sb constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-10-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-substitution kore-forall-elim constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-8-pattern kore-equals-pattern variable-2-type kore-exists-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern kore-equals-pattern variable-2-type kore-exists-pattern variable-5-type variable-2-type variable-3-type variable-3-type variable-2-type variable-3-type variable-5-type FOO-axiom-2610 constant-symbol-10-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern kore-equals-pattern variable-2-type kore-exists-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern kore-equals-pattern variable-2-type kore-exists-pattern variable-5-type variable-63-type variable-62-type variable-3-type variable-2-type variable-3-type variable-5-type FOO-axiom-2605 variable-62-type variable-63-type domain-value-1-functional constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern kore-equals-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern kore-equals-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-2-type variable-5-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-5-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-5-type vev variable-3-type vev sbv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-5-type vev variable-2-type vev sbv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-5-type vev wv variable-5-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-5-type vev sb constant-symbol-9-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern kore-equals-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-8-pattern kore-equals-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-2-type variable-5-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev variable-3-type vev sbv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev variable-2-type vev sbv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev wv variable-5-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev sb constant-symbol-8-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-6-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-0-pattern variable-14-type vev constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern variable-14-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev wv constant-symbol-7-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev wv variable-14-type vev variable-14-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev variable-15-type vev sbv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev sb constant-symbol-7-substitution constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-13-substitution constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-14-type vev constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-14-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev variable-15-type vev sbv constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-13-substitution constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-10-substitution constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-14-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-elim constant-symbol-6-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-8-pattern kore-equals-pattern variable-2-type kore-exists-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern kore-equals-pattern variable-2-type kore-exists-pattern variable-5-type variable-2-type variable-3-type variable-3-type variable-2-type variable-3-type variable-5-type FOO-axiom-2610 constant-symbol-10-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern kore-equals-pattern variable-2-type kore-exists-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern kore-equals-pattern variable-2-type kore-exists-pattern variable-5-type variable-63-type variable-62-type variable-3-type variable-2-type variable-3-type variable-5-type FOO-axiom-2605 variable-62-type variable-63-type domain-value-0-functional constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern kore-equals-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern kore-equals-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-2-type variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev variable-3-type vev sbv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev variable-2-type vev sbv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev wv variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev sb constant-symbol-9-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern kore-equals-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-8-pattern kore-equals-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-2-type variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev variable-3-type vev sbv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev variable-2-type vev sbv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev wv variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-5-type vev sb constant-symbol-8-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-0-pattern variable-15-type vev constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern variable-15-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-7-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev wv variable-15-type vev constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev sb constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-12-pattern kore-dv-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-12-pattern constant-symbol-10-pattern constant-symbol-12-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-12-substitution kore-dv-substitution constant-symbol-9-substitution constant-symbol-8-substitution constant-symbol-7-substitution constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-13-substitution constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-15-type vev constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev sb constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-13-substitution constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-10-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution kore-rewrites-substitution kore-forall-elim constant-symbol-1-pattern kore-top-valid constant-symbol-1-pattern kore-top-valid kore-rewrites-conditional $.
step-1 $p |- ( \kore-rewrites SortGeneratedTopCell ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ) $= constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type variable-2-type variable-3-type constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-13-type variable-2-type variable-3-type constant-symbol-22-pattern constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-13-type kore-forall-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern variable-13-type kore-forall-pattern variable-12-type variable-2-type variable-3-type variable-12-type variable-13-type variable-15-type FOO-axiom-2660 constant-symbol-10-pattern constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-14-pattern kore-equals-pattern variable-2-type kore-exists-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern kore-equals-pattern variable-2-type kore-exists-pattern variable-5-type variable-63-type variable-62-type variable-3-type variable-2-type variable-3-type variable-5-type FOO-axiom-2530 variable-62-type variable-63-type domain-value-2-functional constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern kore-equals-pattern constant-symbol-22-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-14-pattern kore-equals-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-2-type variable-5-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev constant-symbol-22-substitution constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-22-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev constant-symbol-22-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev variable-3-type vev sbv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev variable-2-type vev sbv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev wv variable-5-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-5-type vev sb constant-symbol-14-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-16-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern variable-15-type kore-forall-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-13-type variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-16-substitution constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-15-type variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-6-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern kore-and-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev variable-12-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-12-type vev variable-13-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern variable-12-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-15-type vev wv variable-15-type vev wv variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-15-type vev sbv constant-symbol-8-substitution constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-13-type vev sbv constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev sb constant-symbol-3-substitution kore-and-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev wv constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-12-type vev variable-12-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-12-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-12-type vev variable-13-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-12-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-15-type vev sbv constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev variable-13-type vev sbv constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern variable-12-type vev sb constant-symbol-3-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-substitution kore-forall-elim variable-2-type variable-3-type KSEQ-axiom-3 constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-6-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern kore-rewrites-pattern constant-symbol-13-pattern variable-15-type variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-6-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-13-type vev constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-13-type vev variable-13-type vev wv constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern variable-13-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-6-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-2-substitution constant-symbol-13-pattern variable-15-type vev wv variable-15-type vev wv variable-13-type vev constant-symbol-13-pattern variable-13-type vev variable-15-type vev sbv constant-symbol-8-substitution constant-symbol-0-substitution constant-symbol-13-pattern variable-13-type vev sb constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-10-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern constant-symbol-4-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev wv constant-symbol-5-pattern variable-13-type vev constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-13-type vev variable-13-type vev wv constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv variable-13-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-13-pattern variable-13-type vev constant-symbol-6-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-2-substitution constant-symbol-13-pattern variable-13-type vev variable-15-type vev sbv constant-symbol-0-substitution constant-symbol-13-pattern variable-13-type vev sb constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-13-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-13-pattern variable-13-type vev constant-symbol-13-pattern variable-13-type vev constant-symbol-10-substitution constant-symbol-13-pattern variable-13-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-elim constant-symbol-10-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern kore-equals-pattern variable-2-type kore-exists-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern kore-equals-pattern variable-2-type kore-exists-pattern variable-5-type variable-63-type variable-62-type variable-3-type variable-2-type variable-3-type variable-5-type FOO-axiom-2605 variable-62-type variable-63-type domain-value-0-functional constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern kore-equals-pattern constant-symbol-6-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern kore-equals-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-2-type variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern variable-3-type vev wv variable-2-type vev wv variable-5-type vev wv constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev variable-3-type vev sbv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev variable-2-type vev sbv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev wv variable-5-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern variable-5-type vev sb constant-symbol-9-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern kore-and-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-0-pattern variable-15-type vev constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-8-pattern variable-15-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-8-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev wv variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev sb constant-symbol-8-substitution constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-13-substitution constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-1-pattern constant-symbol-1-pattern kore-top-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-3-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-1-substitution constant-symbol-1-pattern constant-symbol-1-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-1-substitution kore-top-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-4-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-14-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-5-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-0-pattern constant-symbol-13-pattern constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-0-pattern variable-15-type vev constant-symbol-13-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-6-pattern constant-symbol-2-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-6-pattern constant-symbol-2-pattern variable-15-type vev wv constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-6-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-2-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev sb constant-symbol-0-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-13-substitution constant-symbol-5-substitution constant-symbol-4-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern constant-symbol-10-pattern constant-symbol-15-pattern kore-dv-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-15-pattern constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-10-substitution constant-symbol-10-pattern constant-symbol-11-pattern kore-dv-pattern constant-symbol-9-pattern variable-15-type vev constant-symbol-15-substitution kore-dv-substitution constant-symbol-14-substitution constant-symbol-3-substitution kore-and-substitution kore-rewrites-substitution kore-forall-elim constant-symbol-1-pattern kore-top-valid constant-symbol-1-pattern kore-top-valid kore-rewrites-conditional $.
