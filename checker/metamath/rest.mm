id $p |- ( \imp ph1 P ) $=
  vP vP vP wi wi vP vP wi vP vP pr-1 vP vP vP
  wi vP wi wi vP vP vP wi wi vP vP wi wi vP vP vP
  wi pr-1 vP vP vP wi vP pr-2 pr-mp
  pr-mp $.

$( We can prove proof rule schemas. $)
${
    p2inf.1 $e |- ( \imp ph1 ( \imp ph2 ph3 ) ) $.
    p2inf   $p |- ( \imp ( \imp ph1 ph2 ) ( \imp ph1 ph3 ) ) $=
      vP vQ vR wi wi vP vQ wi vP vR wi wi p2inf.1 vP
      vQ vR pr-2 pr-mp $.
$}

$( We can state metatheorems and leave their proofs as future work. $)
${
    nflipb $p |- ( \imp ( \imp ( \imp ph1 \bot ) ( \imp ph2 \bot ) ) ( \imp ph2 ph1 ) ) $= ? $.
$}

$( We can use #Equal to define syntactic sugar. $)

$c \neg $.
v-neg $a #Pattern ( \neg ph1 ) $.
df-neg $a #Equal ( \neg ph1 ) ( \imp ph1 \bot ) $.

$( We can prove all metalevel properties about \neg from its definition. $)

${
    nfneg.1 $e #NoFreeOccurrence xX ph1 $.
    nfneg   $p #NoFreeOccurrence xX ( \neg ph1 ) $=
      vP v-neg vP wb wi vxX vP df-neg vP wb vxX
      nfneg.1 vxX nfbot nfimp eqnf $.
$}

${
    nnneg.1 $e #NoPositiveOccurrence X ph1 $.
    nnneg   $p #NoNegativeOccurrence X ( \neg ph1 ) $=
      vph v-neg vph wb wi vX vph df-neg vph wb vX
      nnneg.1 vX wsv nnb nni eqnn $.
$}

${
    npneg.1 $e #NoNegativeOccurrence X ph1 $.
    npneg   $p #NoPositiveOccurrence X ( \neg ph1 ) $=
      vP v-neg vP wb wi vX vP df-neg vP wb vX
      npneg.1 vX npbot npimp eqnp $.
$}

${
    subst-neg.1 $e #Substitution P' ph1 ph3 yY $.
    subst-neg   $p #Substitution ( \neg P' ) ( \neg ph1 ) ph3 yY $=
      vPp v-neg vP v-neg vR vPp wb wi vP wb wi vR vyY
      vPp df-neg vP df-neg vR eq vPp vP vR wb wb vyY
      subst-neg.1 vR vyY sbb sbi eqsb $.
$}

${
    nn $p |- ( \imp ( \neg ( \neg ph1 ) ) ph1 ) $=
      vP v-neg v-neg vP wi vP v-neg wb wi vP wi vP
      v-neg v-neg vP v-neg wb wi vP vP vP v-neg df-neg vP
      eq eqi vP v-neg wb wi vP wi vP wb wi
      wb wi vP wi vP v-neg wb wi vP wb wi
      wb wi vP vP vP v-neg vP wb wi wb wb vP
      df-neg wb eq eqi vP eq eqi vP pr-3 eqp
      eqp $.
$}

${
    nflip $p |- ( \imp ( \imp ( \neg ph1 ) ( \neg ph2 ) ) ( \imp ph2 ph1 ) ) $=
      vP v-neg vQ v-neg wi vQ vP wi wi vP wb wi vQ
      wb wi wi vQ vP wi wi vP v-neg vQ v-neg wi
      vP wb wi vQ wb wi wi vQ vP wi vQ vP wi
      vP v-neg vP wb wi vQ v-neg vQ wb wi vP df-neg vQ
      df-neg eqi vQ vP wi eq eqi vP vQ nflipb eqp $.
$}



















$( DO NOT REVIEW BELOW $)

$c \iff $.
v-iff $a #Pattern ( \iff ph1 ph2 ) $.
${
    iff-intro.1 $e |- ( \imp ph1 ph2 ) $.
    iff-intro.2 $e |- ( \imp ph2 ph1 ) $.
    iff-intro   $a |- ( \iff ph1 ph2 ) $.
$}
${
    iff-elim-fw.1 $e |- ( \iff ph1 ph2 ) $.
    iff-elim-fw   $a |- ( \imp ph1 ph2 ) $.
$}
${
    iff-elim-bw.1 $e |- ( \iff ph1 ph2 ) $.
    iff-elim-bw   $a |- ( \imp ph2 ph1 ) $.
$}

$(
    \iff yields a congruence relation in terms of provability.
$)
${
    iff-thm.1 $e |- ( \iff ph1 ph2 ) $.
    iff-thm.2 $e |- ph1 $.
    iff-thm   $p |- ph2 $=
  vP vQ iff-thm.2 vP vQ iff-thm.1 iff-elim-fw pr-mp $.
$}

$(
    Defind \forall x ph1 === \neg ( \ex x ( \neg ph1 ) )
$)

$c \forall $.
vforall $a \forall x ph1 $.
df-forall $a #Equal ( \forall x ph1 ) ( \neg ( \ex x ( \neg ph1 ) ) ) $.

$c \app2 $.
wa2 $a #Pattern ( \app2 ph1 ph2 ph3 ) $.
df-app2 $a #Equal ( \app2 ph1 ph2 ph3 ) ( \app ( \app ph1 ph2 ) ph3 ) $.

$c \eq $.
v-eq $a #Pattern ( \eq ph1 ph2 ) $.
${
    eq-thm.1 $e |- ( \eq ph1 ph2 ) $.
    eq-thm.2 $e |- ph2 $.
    eq-thm   $a |- ph1 $.
$}

$( SIMP Definitions $)

$(

module SIMP
  syntax State ::= pair(Int,Int)
  rule pair(X,Y) => pair(X-1,Y+X) requires X >=Int 1
endmodule

$)

$( Define all K sorts. $)

$c Int Id KResult K List Map $.

$c Exp Stmt Pgm Ids $.

$c KCell StateCell TopCell k state t $.

$( int n, s; n = 1; while(n){s=s+n; n=n-1} $)

$c plusExp minusExp seqStmt ifStmt whileStmt assignStmt decvarPgm n s $.

$c SUM1 WHILE BODY ASSIGN-S ASSIGN-N  $.

symbInt $a #Symbol Int $.
symbId $a #Symbol Id $.
symbKResult $a #Symbol KResult $.
symbK $a #Symbol K $.
symbList $a #Symbol List $.
symbMap $a #Symbol Map $.

$( Some definitions about integers and maps $)
$c zero succ $. $( natural number constructors $)
symbzero $a #Symbol zero $.
symbsucc $a #Symbol succ $.

$c 0 1 2 3 4 5 $. $( literal values $)
symb0 $a #Symbol 0 $.
symb1 $a #Symbol 1 $.
symb2 $a #Symbol 2 $.
symb3 $a #Symbol 3 $.
symb4 $a #Symbol 4 $.
symb5 $a #Symbol 5 $.

df-0 $a #Equal 0 zero $.
df-1 $a #Equal 1 ( \app succ 0 ) $.
df-2 $a #Equal 2 ( \app succ 1 ) $.
df-3 $a #Equal 3 ( \app succ 2 ) $.
df-4 $a #Equal 4 ( \app succ 3 ) $.
df-5 $a #Equal 5 ( \app succ 4 ) $.

$c nil cons $. $( cons-lists constructors $)
symbnil $a #Symbol nil $.
symbcons $a #Symbol cons $.

$c list1 list2 $.
symblist1 $a #Symbol list1 $.
symblist2 $a #Symbol list2 $.
df-list1 $a |- ( \eq ( \app list1 ph1 ) ( \app2 cons ph1 nil ) ) $.
df-list2 $a |- ( \eq ( \app2 list2 ph1 ph2 ) ( \app2 cons ph1 ( \app list1 ph1 ) ) ) $.

$c map2 mapsto $.
 
symbExp $a #Symbol Exp $.
symbStmt $a #Symbol Stmt $.
symbPgm $a #Symbol Pgm $.
symbIds $a #Symbol Ids $.
 
symbKCell $a #Symbol KCell $.
symbStateCell $a #Symbol StateCell $.
symbTopCell $a #Symbol TopCell $.
symbk $a #Symbol k $.
symbstate $a #Symbol state $.
symbt $a #Symbol t $.
 
symbplusExp $a #Symbol plusExp $.
symbminusExp $a #Symbol minusExp $.
symbseqStmt $a #Symbol seqStmt $.
symbifStmt $a #Symbol ifStmt $.
symbwhileStmt $a #Symbol whileStmt $.
symbassignStmt $a #Symbol assignStmt $.
symbdecvarPgm $a #Symbol decvarPgm $.
symbn $a #Symbol n $.
symbs $a #Symbol s $.

symbSUM1 $a #Symbol SUM1 $.
symbWHILE $a #Symbol WHILE $.
symbBODY $a #Symbol BODY $.
symbASSIGN-S $a #Symbol ASSIGN-S $.
symbASSIGN-N $a #Symbol ASSIGN-N $.

df-ASSIGN-S $a #Equal ASSIGN-S ( \app2 assignStmt s ( \app2 plusExp  s n ) ) $.
df-ASSIGN-N $a #Equal ASSIGN-N ( \app2 assignStmt n ( \app2 minusExp n 1 ) ) $.
df-BODY $a #Equal BODY ( \app2 seqStmt ASSIGN-S ASSIGN-N ) $.
df-WHILE $a #Equal WHILE ( \app2 whileStmt n  BODY ) $.
df-SUM1 $a #Equal SUM1 ( \app2 decvarPgm ( \app2 list2 n s ) ( \app2 seqStmt ( \app2 assignStmt n 1 ) WHILE ) ) $.

$( Representing SUM configurations: code, value of n, value of s $)

$c \cfg $.
v-cfg $a #Pattern ( \cfg ph1 ph2 ph3 ) $.
df-cfg $a #Equal ( \cfg ph1 ph2 ph3 ) 
               ( \app2 t ( \app k ph1 ) ( \app state ( map2 ( \app2 mapsto n ph2 ) ( \app2 mapsto s ph3 ) ) ) ) $.


