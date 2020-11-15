$c #Pattern $.
$c #ElementVariable $.
$c #SetVariable $.
$c #Variable $.
$c ( ) $.
$v ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 ph9 $.
$v x y z w $.
$v X Y Z W $.
$v xX yY $.
ph1-pattern $f #Pattern ph1 $.
ph2-pattern $f #Pattern ph2 $.
ph3-pattern $f #Pattern ph3 $.
ph4-pattern $f #Pattern ph4 $.
ph5-pattern $f #Pattern ph5 $.
ph6-pattern $f #Pattern ph6 $.
ph7-pattern $f #Pattern ph7 $.
ph8-pattern $f #Pattern ph8 $.
ph9-pattern $f #Pattern ph9 $.
x-element-var $f #ElementVariable x $.
y-element-var $f #ElementVariable y $.
z-element-var $f #ElementVariable z $.
w-element-var $f #ElementVariable w $.
X-element-var $f #SetVariable X $.
Y-element-var $f #SetVariable Y $.
Z-element-var $f #SetVariable Z $.
W-element-var $f #SetVariable W $.
xX-var $f #Variable xX $.
yY-var $f #Variable yY $.
element-var-is-var $a #Variable x $.
set-var-is-var $a #Variable X $.
var-is-pattern $a #Pattern xX $.
$c #Substitution $.
substitution-var $a #Substitution ph1 xX ph1 xX $.
${
$d xX yY $.
substitution-distinct-var $a #Substitution yY yY ph1 xX $.
$}
$c |- $.
$c \kore-bottom \kore-top \kore-not \kore-and \kore-or \kore-implies \kore-iff $.
$c \kore-exists \kore-forall $.
$c \kore-mu \kore-nu $.
$c \kore-ceil \kore-floor \kore-equals \kore-in $.
$c \kore-next \kore-rewrites $.
$c \kore-dv $.
$c \kore-sort $.
kore-exists-pattern $a #Pattern ( \kore-exists ph1 x ph2 ) $.
kore-forall-pattern $a #Pattern ( \kore-forall ph1 x ph2 ) $.
kore-bottom-pattern $a #Pattern ( \kore-bottom ph1 ) $.
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
kore-bottom-substitution.1 $e #Substitution ph1 ph2 ph3 xX $.
kore-bottom-substitution $a #Substitution ( \kore-bottom ph1 ) ( \kore-bottom ph2 ) ph3 xX $.
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
kore-top-valid $p |- ( \kore-top ph1 ) $= ? $.
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
kore-reflexivity $p |- ( \kore-forall \kore-sort z ( \kore-equals ph1 z ph2 ph2 ) ) $= ? $.

$( ---------------- end of prelude ---------------- $)

$( ---------------- start of module FOO ---------------- $)

$( sort SortK() $)

$( adding 1 new metavariables $)
$v var-variable-0 $.
variable-0-type $f #Variable var-variable-0 $.

$( adding 1 new metavariables $)
$v var-pattern-0 $.
variable-1-type $f #Pattern var-pattern-0 $.
$c SortK $.
BASIC-K-sort-0-pattern $a #Pattern SortK $.
${
BASIC-K-sort-0-substitution $a #Substitution SortK SortK var-pattern-0 var-variable-0 $.
$}

$( sort SortKItem() $)
$c SortKItem $.
BASIC-K-sort-1-pattern $a #Pattern SortKItem $.
${
BASIC-K-sort-1-substitution $a #Substitution SortKItem SortKItem var-pattern-0 var-variable-0 $.
$}

$( symbol kseq(SortKItem{}, SortK{}): SortK{} $)

$( adding 4 new metavariables $)
$v var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 $.
variable-2-type $f #Pattern var-pattern-1 $.
variable-3-type $f #Pattern var-pattern-2 $.
variable-4-type $f #Pattern var-pattern-3 $.
variable-5-type $f #Pattern var-pattern-4 $.
$c kseq $.
KSEQ-symbol-0-pattern $a #Pattern ( kseq var-pattern-1 var-pattern-2 ) $.
${
KSEQ-symbol-0-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
KSEQ-symbol-0-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
KSEQ-symbol-0-substitution $a #Substitution ( kseq var-pattern-1 var-pattern-2 ) ( kseq var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol dotk(): SortK{} $)
$c dotk $.
KSEQ-symbol-1-pattern $a #Pattern dotk $.
${
KSEQ-symbol-1-substitution $a #Substitution dotk dotk var-pattern-0 var-variable-0 $.
$}

$( symbol append(SortK{}, SortK{}): SortK{} $)
$c append $.
KSEQ-symbol-2-pattern $a #Pattern ( append var-pattern-1 var-pattern-2 ) $.
${
KSEQ-symbol-2-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
KSEQ-symbol-2-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
KSEQ-symbol-2-substitution $a #Substitution ( append var-pattern-1 var-pattern-2 ) ( append var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( adding 4 new metavariables $)
$v K2 K1 Val R $.
variable-6-type $f #ElementVariable K2 $.
variable-7-type $f #ElementVariable K1 $.
variable-8-type $f #ElementVariable Val $.
variable-9-type $f #ElementVariable R $.
$d K2 K1 Val R $.

$( axiom {R} \forall{}(K2:SortK{}, \forall{}(K1:SortKItem{}, \exists{R}(Val:SortK{}, \equals{SortK{}, R}(Val:SortK{}, kseq{}(K1:SortKItem{}, K2:SortK{}))))) $)
KSEQ-axiom-2 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K2 ( \kore-forall SortKItem K1 ( \kore-exists SortK Val ( \kore-equals SortK R Val ( kseq K1 K2 ) ) ) ) ) ) $.

$( axiom {R} \exists{R}(Val:SortK{}, \equals{SortK{}, R}(Val:SortK{}, dotk{}())) $)
KSEQ-axiom-3 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortK Val ( \kore-equals SortK R Val dotk ) ) ) $.

$( symbol inj(From): To $)

$( adding 2 new metavariables $)
$v var-pattern-5 var-pattern-6 $.
variable-10-type $f #Pattern var-pattern-5 $.
variable-11-type $f #Pattern var-pattern-6 $.
$c inj $.
INJ-symbol-0-pattern $a #Pattern ( inj var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
INJ-symbol-0-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
INJ-symbol-0-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
INJ-symbol-0-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
INJ-symbol-0-substitution $a #Substitution ( inj var-pattern-1 var-pattern-2 var-pattern-3 ) ( inj var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( sort SortKCellOpt() $)
$c SortKCellOpt $.
FOO-sort-0-pattern $a #Pattern SortKCellOpt $.
${
FOO-sort-0-substitution $a #Substitution SortKCellOpt SortKCellOpt var-pattern-0 var-variable-0 $.
$}

$( sort SortIOInt() $)
$c SortIOInt $.
FOO-sort-1-pattern $a #Pattern SortIOInt $.
${
FOO-sort-1-substitution $a #Substitution SortIOInt SortIOInt var-pattern-0 var-variable-0 $.
$}

$( sort SortGeneratedTopCellFragment() $)
$c SortGeneratedTopCellFragment $.
FOO-sort-2-pattern $a #Pattern SortGeneratedTopCellFragment $.
${
FOO-sort-2-substitution $a #Substitution SortGeneratedTopCellFragment SortGeneratedTopCellFragment var-pattern-0 var-variable-0 $.
$}

$( sort SortIOFile() $)
$c SortIOFile $.
FOO-sort-3-pattern $a #Pattern SortIOFile $.
${
FOO-sort-3-substitution $a #Substitution SortIOFile SortIOFile var-pattern-0 var-variable-0 $.
$}

$( sort SortList() $)
$c SortList $.
FOO-sort-4-pattern $a #Pattern SortList $.
${
FOO-sort-4-substitution $a #Substitution SortList SortList var-pattern-0 var-variable-0 $.
$}

$( sort SortKCell() $)
$c SortKCell $.
FOO-sort-5-pattern $a #Pattern SortKCell $.
${
FOO-sort-5-substitution $a #Substitution SortKCell SortKCell var-pattern-0 var-variable-0 $.
$}

$( sort SortGeneratedTopCell() $)
$c SortGeneratedTopCell $.
FOO-sort-6-pattern $a #Pattern SortGeneratedTopCell $.
${
FOO-sort-6-substitution $a #Substitution SortGeneratedTopCell SortGeneratedTopCell var-pattern-0 var-variable-0 $.
$}

$( sort SortGeneratedCounterCell() $)
$c SortGeneratedCounterCell $.
FOO-sort-7-pattern $a #Pattern SortGeneratedCounterCell $.
${
FOO-sort-7-substitution $a #Substitution SortGeneratedCounterCell SortGeneratedCounterCell var-pattern-0 var-variable-0 $.
$}

$( sort SortFloat() $)
$c SortFloat $.
FOO-sort-8-pattern $a #Pattern SortFloat $.
${
FOO-sort-8-substitution $a #Substitution SortFloat SortFloat var-pattern-0 var-variable-0 $.
$}

$( sort SortMap() $)
$c SortMap $.
FOO-sort-9-pattern $a #Pattern SortMap $.
${
FOO-sort-9-substitution $a #Substitution SortMap SortMap var-pattern-0 var-variable-0 $.
$}

$( sort SortString() $)
$c SortString $.
FOO-sort-10-pattern $a #Pattern SortString $.
${
FOO-sort-10-substitution $a #Substitution SortString SortString var-pattern-0 var-variable-0 $.
$}

$( sort SortIOString() $)
$c SortIOString $.
FOO-sort-11-pattern $a #Pattern SortIOString $.
${
FOO-sort-11-substitution $a #Substitution SortIOString SortIOString var-pattern-0 var-variable-0 $.
$}

$( sort SortId() $)
$c SortId $.
FOO-sort-12-pattern $a #Pattern SortId $.
${
FOO-sort-12-substitution $a #Substitution SortId SortId var-pattern-0 var-variable-0 $.
$}

$( sort SortGeneratedCounterCellOpt() $)
$c SortGeneratedCounterCellOpt $.
FOO-sort-13-pattern $a #Pattern SortGeneratedCounterCellOpt $.
${
FOO-sort-13-substitution $a #Substitution SortGeneratedCounterCellOpt SortGeneratedCounterCellOpt var-pattern-0 var-variable-0 $.
$}

$( sort SortKConfigVar() $)
$c SortKConfigVar $.
FOO-sort-14-pattern $a #Pattern SortKConfigVar $.
${
FOO-sort-14-substitution $a #Substitution SortKConfigVar SortKConfigVar var-pattern-0 var-variable-0 $.
$}

$( sort SortInt() $)
$c SortInt $.
FOO-sort-15-pattern $a #Pattern SortInt $.
${
FOO-sort-15-substitution $a #Substitution SortInt SortInt var-pattern-0 var-variable-0 $.
$}

$( sort SortIOError() $)
$c SortIOError $.
FOO-sort-16-pattern $a #Pattern SortIOError $.
${
FOO-sort-16-substitution $a #Substitution SortIOError SortIOError var-pattern-0 var-variable-0 $.
$}

$( sort SortSet() $)
$c SortSet $.
FOO-sort-17-pattern $a #Pattern SortSet $.
${
FOO-sort-17-substitution $a #Substitution SortSet SortSet var-pattern-0 var-variable-0 $.
$}

$( sort SortFoo() $)
$c SortFoo $.
FOO-sort-18-pattern $a #Pattern SortFoo $.
${
FOO-sort-18-substitution $a #Substitution SortFoo SortFoo var-pattern-0 var-variable-0 $.
$}

$( sort SortStream() $)
$c SortStream $.
FOO-sort-19-pattern $a #Pattern SortStream $.
${
FOO-sort-19-substitution $a #Substitution SortStream SortStream var-pattern-0 var-variable-0 $.
$}

$( sort SortCell() $)
$c SortCell $.
FOO-sort-20-pattern $a #Pattern SortCell $.
${
FOO-sort-20-substitution $a #Substitution SortCell SortCell var-pattern-0 var-variable-0 $.
$}

$( sort SortBool() $)
$c SortBool $.
FOO-sort-21-pattern $a #Pattern SortBool $.
${
FOO-sort-21-substitution $a #Substitution SortBool SortBool var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'E2BIG(): SortIOError{} $)
$c Lbl'Hash'E2BIG $.
FOO-symbol-0-pattern $a #Pattern Lbl'Hash'E2BIG $.
${
FOO-symbol-0-substitution $a #Substitution Lbl'Hash'E2BIG Lbl'Hash'E2BIG var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EACCES(): SortIOError{} $)
$c Lbl'Hash'EACCES $.
FOO-symbol-1-pattern $a #Pattern Lbl'Hash'EACCES $.
${
FOO-symbol-1-substitution $a #Substitution Lbl'Hash'EACCES Lbl'Hash'EACCES var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EADDRINUSE(): SortIOError{} $)
$c Lbl'Hash'EADDRINUSE $.
FOO-symbol-2-pattern $a #Pattern Lbl'Hash'EADDRINUSE $.
${
FOO-symbol-2-substitution $a #Substitution Lbl'Hash'EADDRINUSE Lbl'Hash'EADDRINUSE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EADDRNOTAVAIL(): SortIOError{} $)
$c Lbl'Hash'EADDRNOTAVAIL $.
FOO-symbol-3-pattern $a #Pattern Lbl'Hash'EADDRNOTAVAIL $.
${
FOO-symbol-3-substitution $a #Substitution Lbl'Hash'EADDRNOTAVAIL Lbl'Hash'EADDRNOTAVAIL var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EAFNOSUPPORT(): SortIOError{} $)
$c Lbl'Hash'EAFNOSUPPORT $.
FOO-symbol-4-pattern $a #Pattern Lbl'Hash'EAFNOSUPPORT $.
${
FOO-symbol-4-substitution $a #Substitution Lbl'Hash'EAFNOSUPPORT Lbl'Hash'EAFNOSUPPORT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EAGAIN(): SortIOError{} $)
$c Lbl'Hash'EAGAIN $.
FOO-symbol-5-pattern $a #Pattern Lbl'Hash'EAGAIN $.
${
FOO-symbol-5-substitution $a #Substitution Lbl'Hash'EAGAIN Lbl'Hash'EAGAIN var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EALREADY(): SortIOError{} $)
$c Lbl'Hash'EALREADY $.
FOO-symbol-6-pattern $a #Pattern Lbl'Hash'EALREADY $.
${
FOO-symbol-6-substitution $a #Substitution Lbl'Hash'EALREADY Lbl'Hash'EALREADY var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EBADF(): SortIOError{} $)
$c Lbl'Hash'EBADF $.
FOO-symbol-7-pattern $a #Pattern Lbl'Hash'EBADF $.
${
FOO-symbol-7-substitution $a #Substitution Lbl'Hash'EBADF Lbl'Hash'EBADF var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EBUSY(): SortIOError{} $)
$c Lbl'Hash'EBUSY $.
FOO-symbol-8-pattern $a #Pattern Lbl'Hash'EBUSY $.
${
FOO-symbol-8-substitution $a #Substitution Lbl'Hash'EBUSY Lbl'Hash'EBUSY var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ECHILD(): SortIOError{} $)
$c Lbl'Hash'ECHILD $.
FOO-symbol-9-pattern $a #Pattern Lbl'Hash'ECHILD $.
${
FOO-symbol-9-substitution $a #Substitution Lbl'Hash'ECHILD Lbl'Hash'ECHILD var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ECONNABORTED(): SortIOError{} $)
$c Lbl'Hash'ECONNABORTED $.
FOO-symbol-10-pattern $a #Pattern Lbl'Hash'ECONNABORTED $.
${
FOO-symbol-10-substitution $a #Substitution Lbl'Hash'ECONNABORTED Lbl'Hash'ECONNABORTED var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ECONNREFUSED(): SortIOError{} $)
$c Lbl'Hash'ECONNREFUSED $.
FOO-symbol-11-pattern $a #Pattern Lbl'Hash'ECONNREFUSED $.
${
FOO-symbol-11-substitution $a #Substitution Lbl'Hash'ECONNREFUSED Lbl'Hash'ECONNREFUSED var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ECONNRESET(): SortIOError{} $)
$c Lbl'Hash'ECONNRESET $.
FOO-symbol-12-pattern $a #Pattern Lbl'Hash'ECONNRESET $.
${
FOO-symbol-12-substitution $a #Substitution Lbl'Hash'ECONNRESET Lbl'Hash'ECONNRESET var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EDEADLK(): SortIOError{} $)
$c Lbl'Hash'EDEADLK $.
FOO-symbol-13-pattern $a #Pattern Lbl'Hash'EDEADLK $.
${
FOO-symbol-13-substitution $a #Substitution Lbl'Hash'EDEADLK Lbl'Hash'EDEADLK var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EDESTADDRREQ(): SortIOError{} $)
$c Lbl'Hash'EDESTADDRREQ $.
FOO-symbol-14-pattern $a #Pattern Lbl'Hash'EDESTADDRREQ $.
${
FOO-symbol-14-substitution $a #Substitution Lbl'Hash'EDESTADDRREQ Lbl'Hash'EDESTADDRREQ var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EDOM(): SortIOError{} $)
$c Lbl'Hash'EDOM $.
FOO-symbol-15-pattern $a #Pattern Lbl'Hash'EDOM $.
${
FOO-symbol-15-substitution $a #Substitution Lbl'Hash'EDOM Lbl'Hash'EDOM var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EEXIST(): SortIOError{} $)
$c Lbl'Hash'EEXIST $.
FOO-symbol-16-pattern $a #Pattern Lbl'Hash'EEXIST $.
${
FOO-symbol-16-substitution $a #Substitution Lbl'Hash'EEXIST Lbl'Hash'EEXIST var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EFAULT(): SortIOError{} $)
$c Lbl'Hash'EFAULT $.
FOO-symbol-17-pattern $a #Pattern Lbl'Hash'EFAULT $.
${
FOO-symbol-17-substitution $a #Substitution Lbl'Hash'EFAULT Lbl'Hash'EFAULT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EFBIG(): SortIOError{} $)
$c Lbl'Hash'EFBIG $.
FOO-symbol-18-pattern $a #Pattern Lbl'Hash'EFBIG $.
${
FOO-symbol-18-substitution $a #Substitution Lbl'Hash'EFBIG Lbl'Hash'EFBIG var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EHOSTDOWN(): SortIOError{} $)
$c Lbl'Hash'EHOSTDOWN $.
FOO-symbol-19-pattern $a #Pattern Lbl'Hash'EHOSTDOWN $.
${
FOO-symbol-19-substitution $a #Substitution Lbl'Hash'EHOSTDOWN Lbl'Hash'EHOSTDOWN var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EHOSTUNREACH(): SortIOError{} $)
$c Lbl'Hash'EHOSTUNREACH $.
FOO-symbol-20-pattern $a #Pattern Lbl'Hash'EHOSTUNREACH $.
${
FOO-symbol-20-substitution $a #Substitution Lbl'Hash'EHOSTUNREACH Lbl'Hash'EHOSTUNREACH var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EINPROGRESS(): SortIOError{} $)
$c Lbl'Hash'EINPROGRESS $.
FOO-symbol-21-pattern $a #Pattern Lbl'Hash'EINPROGRESS $.
${
FOO-symbol-21-substitution $a #Substitution Lbl'Hash'EINPROGRESS Lbl'Hash'EINPROGRESS var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EINTR(): SortIOError{} $)
$c Lbl'Hash'EINTR $.
FOO-symbol-22-pattern $a #Pattern Lbl'Hash'EINTR $.
${
FOO-symbol-22-substitution $a #Substitution Lbl'Hash'EINTR Lbl'Hash'EINTR var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EINVAL(): SortIOError{} $)
$c Lbl'Hash'EINVAL $.
FOO-symbol-23-pattern $a #Pattern Lbl'Hash'EINVAL $.
${
FOO-symbol-23-substitution $a #Substitution Lbl'Hash'EINVAL Lbl'Hash'EINVAL var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EIO(): SortIOError{} $)
$c Lbl'Hash'EIO $.
FOO-symbol-24-pattern $a #Pattern Lbl'Hash'EIO $.
${
FOO-symbol-24-substitution $a #Substitution Lbl'Hash'EIO Lbl'Hash'EIO var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EISCONN(): SortIOError{} $)
$c Lbl'Hash'EISCONN $.
FOO-symbol-25-pattern $a #Pattern Lbl'Hash'EISCONN $.
${
FOO-symbol-25-substitution $a #Substitution Lbl'Hash'EISCONN Lbl'Hash'EISCONN var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EISDIR(): SortIOError{} $)
$c Lbl'Hash'EISDIR $.
FOO-symbol-26-pattern $a #Pattern Lbl'Hash'EISDIR $.
${
FOO-symbol-26-substitution $a #Substitution Lbl'Hash'EISDIR Lbl'Hash'EISDIR var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ELOOP(): SortIOError{} $)
$c Lbl'Hash'ELOOP $.
FOO-symbol-27-pattern $a #Pattern Lbl'Hash'ELOOP $.
${
FOO-symbol-27-substitution $a #Substitution Lbl'Hash'ELOOP Lbl'Hash'ELOOP var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EMFILE(): SortIOError{} $)
$c Lbl'Hash'EMFILE $.
FOO-symbol-28-pattern $a #Pattern Lbl'Hash'EMFILE $.
${
FOO-symbol-28-substitution $a #Substitution Lbl'Hash'EMFILE Lbl'Hash'EMFILE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EMLINK(): SortIOError{} $)
$c Lbl'Hash'EMLINK $.
FOO-symbol-29-pattern $a #Pattern Lbl'Hash'EMLINK $.
${
FOO-symbol-29-substitution $a #Substitution Lbl'Hash'EMLINK Lbl'Hash'EMLINK var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EMSGSIZE(): SortIOError{} $)
$c Lbl'Hash'EMSGSIZE $.
FOO-symbol-30-pattern $a #Pattern Lbl'Hash'EMSGSIZE $.
${
FOO-symbol-30-substitution $a #Substitution Lbl'Hash'EMSGSIZE Lbl'Hash'EMSGSIZE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENAMETOOLONG(): SortIOError{} $)
$c Lbl'Hash'ENAMETOOLONG $.
FOO-symbol-31-pattern $a #Pattern Lbl'Hash'ENAMETOOLONG $.
${
FOO-symbol-31-substitution $a #Substitution Lbl'Hash'ENAMETOOLONG Lbl'Hash'ENAMETOOLONG var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENETDOWN(): SortIOError{} $)
$c Lbl'Hash'ENETDOWN $.
FOO-symbol-32-pattern $a #Pattern Lbl'Hash'ENETDOWN $.
${
FOO-symbol-32-substitution $a #Substitution Lbl'Hash'ENETDOWN Lbl'Hash'ENETDOWN var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENETRESET(): SortIOError{} $)
$c Lbl'Hash'ENETRESET $.
FOO-symbol-33-pattern $a #Pattern Lbl'Hash'ENETRESET $.
${
FOO-symbol-33-substitution $a #Substitution Lbl'Hash'ENETRESET Lbl'Hash'ENETRESET var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENETUNREACH(): SortIOError{} $)
$c Lbl'Hash'ENETUNREACH $.
FOO-symbol-34-pattern $a #Pattern Lbl'Hash'ENETUNREACH $.
${
FOO-symbol-34-substitution $a #Substitution Lbl'Hash'ENETUNREACH Lbl'Hash'ENETUNREACH var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENFILE(): SortIOError{} $)
$c Lbl'Hash'ENFILE $.
FOO-symbol-35-pattern $a #Pattern Lbl'Hash'ENFILE $.
${
FOO-symbol-35-substitution $a #Substitution Lbl'Hash'ENFILE Lbl'Hash'ENFILE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOBUFS(): SortIOError{} $)
$c Lbl'Hash'ENOBUFS $.
FOO-symbol-36-pattern $a #Pattern Lbl'Hash'ENOBUFS $.
${
FOO-symbol-36-substitution $a #Substitution Lbl'Hash'ENOBUFS Lbl'Hash'ENOBUFS var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENODEV(): SortIOError{} $)
$c Lbl'Hash'ENODEV $.
FOO-symbol-37-pattern $a #Pattern Lbl'Hash'ENODEV $.
${
FOO-symbol-37-substitution $a #Substitution Lbl'Hash'ENODEV Lbl'Hash'ENODEV var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOENT(): SortIOError{} $)
$c Lbl'Hash'ENOENT $.
FOO-symbol-38-pattern $a #Pattern Lbl'Hash'ENOENT $.
${
FOO-symbol-38-substitution $a #Substitution Lbl'Hash'ENOENT Lbl'Hash'ENOENT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOEXEC(): SortIOError{} $)
$c Lbl'Hash'ENOEXEC $.
FOO-symbol-39-pattern $a #Pattern Lbl'Hash'ENOEXEC $.
${
FOO-symbol-39-substitution $a #Substitution Lbl'Hash'ENOEXEC Lbl'Hash'ENOEXEC var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOLCK(): SortIOError{} $)
$c Lbl'Hash'ENOLCK $.
FOO-symbol-40-pattern $a #Pattern Lbl'Hash'ENOLCK $.
${
FOO-symbol-40-substitution $a #Substitution Lbl'Hash'ENOLCK Lbl'Hash'ENOLCK var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOMEM(): SortIOError{} $)
$c Lbl'Hash'ENOMEM $.
FOO-symbol-41-pattern $a #Pattern Lbl'Hash'ENOMEM $.
${
FOO-symbol-41-substitution $a #Substitution Lbl'Hash'ENOMEM Lbl'Hash'ENOMEM var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOPROTOOPT(): SortIOError{} $)
$c Lbl'Hash'ENOPROTOOPT $.
FOO-symbol-42-pattern $a #Pattern Lbl'Hash'ENOPROTOOPT $.
${
FOO-symbol-42-substitution $a #Substitution Lbl'Hash'ENOPROTOOPT Lbl'Hash'ENOPROTOOPT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOSPC(): SortIOError{} $)
$c Lbl'Hash'ENOSPC $.
FOO-symbol-43-pattern $a #Pattern Lbl'Hash'ENOSPC $.
${
FOO-symbol-43-substitution $a #Substitution Lbl'Hash'ENOSPC Lbl'Hash'ENOSPC var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOSYS(): SortIOError{} $)
$c Lbl'Hash'ENOSYS $.
FOO-symbol-44-pattern $a #Pattern Lbl'Hash'ENOSYS $.
${
FOO-symbol-44-substitution $a #Substitution Lbl'Hash'ENOSYS Lbl'Hash'ENOSYS var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOTCONN(): SortIOError{} $)
$c Lbl'Hash'ENOTCONN $.
FOO-symbol-45-pattern $a #Pattern Lbl'Hash'ENOTCONN $.
${
FOO-symbol-45-substitution $a #Substitution Lbl'Hash'ENOTCONN Lbl'Hash'ENOTCONN var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOTDIR(): SortIOError{} $)
$c Lbl'Hash'ENOTDIR $.
FOO-symbol-46-pattern $a #Pattern Lbl'Hash'ENOTDIR $.
${
FOO-symbol-46-substitution $a #Substitution Lbl'Hash'ENOTDIR Lbl'Hash'ENOTDIR var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOTEMPTY(): SortIOError{} $)
$c Lbl'Hash'ENOTEMPTY $.
FOO-symbol-47-pattern $a #Pattern Lbl'Hash'ENOTEMPTY $.
${
FOO-symbol-47-substitution $a #Substitution Lbl'Hash'ENOTEMPTY Lbl'Hash'ENOTEMPTY var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOTSOCK(): SortIOError{} $)
$c Lbl'Hash'ENOTSOCK $.
FOO-symbol-48-pattern $a #Pattern Lbl'Hash'ENOTSOCK $.
${
FOO-symbol-48-substitution $a #Substitution Lbl'Hash'ENOTSOCK Lbl'Hash'ENOTSOCK var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENOTTY(): SortIOError{} $)
$c Lbl'Hash'ENOTTY $.
FOO-symbol-49-pattern $a #Pattern Lbl'Hash'ENOTTY $.
${
FOO-symbol-49-substitution $a #Substitution Lbl'Hash'ENOTTY Lbl'Hash'ENOTTY var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ENXIO(): SortIOError{} $)
$c Lbl'Hash'ENXIO $.
FOO-symbol-50-pattern $a #Pattern Lbl'Hash'ENXIO $.
${
FOO-symbol-50-substitution $a #Substitution Lbl'Hash'ENXIO Lbl'Hash'ENXIO var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EOF(): SortIOError{} $)
$c Lbl'Hash'EOF $.
FOO-symbol-51-pattern $a #Pattern Lbl'Hash'EOF $.
${
FOO-symbol-51-substitution $a #Substitution Lbl'Hash'EOF Lbl'Hash'EOF var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EOPNOTSUPP(): SortIOError{} $)
$c Lbl'Hash'EOPNOTSUPP $.
FOO-symbol-52-pattern $a #Pattern Lbl'Hash'EOPNOTSUPP $.
${
FOO-symbol-52-substitution $a #Substitution Lbl'Hash'EOPNOTSUPP Lbl'Hash'EOPNOTSUPP var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EOVERFLOW(): SortIOError{} $)
$c Lbl'Hash'EOVERFLOW $.
FOO-symbol-53-pattern $a #Pattern Lbl'Hash'EOVERFLOW $.
${
FOO-symbol-53-substitution $a #Substitution Lbl'Hash'EOVERFLOW Lbl'Hash'EOVERFLOW var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EPERM(): SortIOError{} $)
$c Lbl'Hash'EPERM $.
FOO-symbol-54-pattern $a #Pattern Lbl'Hash'EPERM $.
${
FOO-symbol-54-substitution $a #Substitution Lbl'Hash'EPERM Lbl'Hash'EPERM var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EPFNOSUPPORT(): SortIOError{} $)
$c Lbl'Hash'EPFNOSUPPORT $.
FOO-symbol-55-pattern $a #Pattern Lbl'Hash'EPFNOSUPPORT $.
${
FOO-symbol-55-substitution $a #Substitution Lbl'Hash'EPFNOSUPPORT Lbl'Hash'EPFNOSUPPORT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EPIPE(): SortIOError{} $)
$c Lbl'Hash'EPIPE $.
FOO-symbol-56-pattern $a #Pattern Lbl'Hash'EPIPE $.
${
FOO-symbol-56-substitution $a #Substitution Lbl'Hash'EPIPE Lbl'Hash'EPIPE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EPROTONOSUPPORT(): SortIOError{} $)
$c Lbl'Hash'EPROTONOSUPPORT $.
FOO-symbol-57-pattern $a #Pattern Lbl'Hash'EPROTONOSUPPORT $.
${
FOO-symbol-57-substitution $a #Substitution Lbl'Hash'EPROTONOSUPPORT Lbl'Hash'EPROTONOSUPPORT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EPROTOTYPE(): SortIOError{} $)
$c Lbl'Hash'EPROTOTYPE $.
FOO-symbol-58-pattern $a #Pattern Lbl'Hash'EPROTOTYPE $.
${
FOO-symbol-58-substitution $a #Substitution Lbl'Hash'EPROTOTYPE Lbl'Hash'EPROTOTYPE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ERANGE(): SortIOError{} $)
$c Lbl'Hash'ERANGE $.
FOO-symbol-59-pattern $a #Pattern Lbl'Hash'ERANGE $.
${
FOO-symbol-59-substitution $a #Substitution Lbl'Hash'ERANGE Lbl'Hash'ERANGE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EROFS(): SortIOError{} $)
$c Lbl'Hash'EROFS $.
FOO-symbol-60-pattern $a #Pattern Lbl'Hash'EROFS $.
${
FOO-symbol-60-substitution $a #Substitution Lbl'Hash'EROFS Lbl'Hash'EROFS var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ESHUTDOWN(): SortIOError{} $)
$c Lbl'Hash'ESHUTDOWN $.
FOO-symbol-61-pattern $a #Pattern Lbl'Hash'ESHUTDOWN $.
${
FOO-symbol-61-substitution $a #Substitution Lbl'Hash'ESHUTDOWN Lbl'Hash'ESHUTDOWN var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ESOCKTNOSUPPORT(): SortIOError{} $)
$c Lbl'Hash'ESOCKTNOSUPPORT $.
FOO-symbol-62-pattern $a #Pattern Lbl'Hash'ESOCKTNOSUPPORT $.
${
FOO-symbol-62-substitution $a #Substitution Lbl'Hash'ESOCKTNOSUPPORT Lbl'Hash'ESOCKTNOSUPPORT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ESPIPE(): SortIOError{} $)
$c Lbl'Hash'ESPIPE $.
FOO-symbol-63-pattern $a #Pattern Lbl'Hash'ESPIPE $.
${
FOO-symbol-63-substitution $a #Substitution Lbl'Hash'ESPIPE Lbl'Hash'ESPIPE var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ESRCH(): SortIOError{} $)
$c Lbl'Hash'ESRCH $.
FOO-symbol-64-pattern $a #Pattern Lbl'Hash'ESRCH $.
${
FOO-symbol-64-substitution $a #Substitution Lbl'Hash'ESRCH Lbl'Hash'ESRCH var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ETIMEDOUT(): SortIOError{} $)
$c Lbl'Hash'ETIMEDOUT $.
FOO-symbol-65-pattern $a #Pattern Lbl'Hash'ETIMEDOUT $.
${
FOO-symbol-65-substitution $a #Substitution Lbl'Hash'ETIMEDOUT Lbl'Hash'ETIMEDOUT var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'ETOOMANYREFS(): SortIOError{} $)
$c Lbl'Hash'ETOOMANYREFS $.
FOO-symbol-66-pattern $a #Pattern Lbl'Hash'ETOOMANYREFS $.
${
FOO-symbol-66-substitution $a #Substitution Lbl'Hash'ETOOMANYREFS Lbl'Hash'ETOOMANYREFS var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EWOULDBLOCK(): SortIOError{} $)
$c Lbl'Hash'EWOULDBLOCK $.
FOO-symbol-67-pattern $a #Pattern Lbl'Hash'EWOULDBLOCK $.
${
FOO-symbol-67-substitution $a #Substitution Lbl'Hash'EWOULDBLOCK Lbl'Hash'EWOULDBLOCK var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'EXDEV(): SortIOError{} $)
$c Lbl'Hash'EXDEV $.
FOO-symbol-68-pattern $a #Pattern Lbl'Hash'EXDEV $.
${
FOO-symbol-68-substitution $a #Substitution Lbl'Hash'EXDEV Lbl'Hash'EXDEV var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'accept'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int(SortInt{}): SortIOInt{} $)
$c Lbl'Hash'accept'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int $.
FOO-symbol-69-pattern $a #Pattern ( Lbl'Hash'accept'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-69-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-69-substitution $a #Substitution ( Lbl'Hash'accept'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-1 ) ( Lbl'Hash'accept'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K(SortK{}): SortStream{} $)
$c Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K $.
FOO-symbol-70-pattern $a #Pattern ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K var-pattern-1 ) $.
${
FOO-symbol-70-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-70-substitution $a #Substitution ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K var-pattern-1 ) ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'close'LParUndsRParUnds'K-IO'Unds'K'Unds'Int(SortInt{}): SortK{} $)
$c Lbl'Hash'close'LParUndsRParUnds'K-IO'Unds'K'Unds'Int $.
FOO-symbol-71-pattern $a #Pattern ( Lbl'Hash'close'LParUndsRParUnds'K-IO'Unds'K'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-71-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-71-substitution $a #Substitution ( Lbl'Hash'close'LParUndsRParUnds'K-IO'Unds'K'Unds'Int var-pattern-1 ) ( Lbl'Hash'close'LParUndsRParUnds'K-IO'Unds'K'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'getc'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int(SortInt{}): SortIOInt{} $)
$c Lbl'Hash'getc'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int $.
FOO-symbol-72-pattern $a #Pattern ( Lbl'Hash'getc'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-72-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-72-substitution $a #Substitution ( Lbl'Hash'getc'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-1 ) ( Lbl'Hash'getc'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort(SortBool{}, SortSort, SortSort): SortSort $)

$( adding 2 new metavariables $)
$v var-pattern-7 var-pattern-8 $.
variable-12-type $f #Pattern var-pattern-7 $.
variable-13-type $f #Pattern var-pattern-8 $.
$c Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort $.
FOO-symbol-73-pattern $a #Pattern ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) $.
${
FOO-symbol-73-substitution.0 $e #Substitution var-pattern-1 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-73-substitution.1 $e #Substitution var-pattern-2 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-73-substitution.2 $e #Substitution var-pattern-3 var-pattern-7 var-pattern-0 var-variable-0 $.
FOO-symbol-73-substitution.3 $e #Substitution var-pattern-4 var-pattern-8 var-pattern-0 var-variable-0 $.
FOO-symbol-73-substitution $a #Substitution ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort var-pattern-5 var-pattern-6 var-pattern-7 var-pattern-8 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'lock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortK{} $)
$c Lbl'Hash'lock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int $.
FOO-symbol-74-pattern $a #Pattern ( Lbl'Hash'lock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-74-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-74-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-74-substitution $a #Substitution ( Lbl'Hash'lock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Hash'lock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'logToFile(SortString{}, SortString{}): SortK{} $)
$c Lbl'Hash'logToFile $.
FOO-symbol-75-pattern $a #Pattern ( Lbl'Hash'logToFile var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-75-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-75-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-75-substitution $a #Substitution ( Lbl'Hash'logToFile var-pattern-1 var-pattern-2 ) ( Lbl'Hash'logToFile var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'lstat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String(SortString{}): SortKItem{} $)
$c Lbl'Hash'lstat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String $.
FOO-symbol-76-pattern $a #Pattern ( Lbl'Hash'lstat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) $.
${
FOO-symbol-76-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-76-substitution $a #Substitution ( Lbl'Hash'lstat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) ( Lbl'Hash'lstat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'mkstemp'LParUndsRParUnds'K-IO'Unds'IOFile'Unds'String(SortString{}): SortIOFile{} $)
$c Lbl'Hash'mkstemp'LParUndsRParUnds'K-IO'Unds'IOFile'Unds'String $.
FOO-symbol-77-pattern $a #Pattern ( Lbl'Hash'mkstemp'LParUndsRParUnds'K-IO'Unds'IOFile'Unds'String var-pattern-1 ) $.
${
FOO-symbol-77-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-77-substitution $a #Substitution ( Lbl'Hash'mkstemp'LParUndsRParUnds'K-IO'Unds'IOFile'Unds'String var-pattern-1 ) ( Lbl'Hash'mkstemp'LParUndsRParUnds'K-IO'Unds'IOFile'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String(SortString{}): SortIOInt{} $)
$c Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String $.
FOO-symbol-78-pattern $a #Pattern ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String var-pattern-1 ) $.
${
FOO-symbol-78-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-78-substitution $a #Substitution ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String var-pattern-1 ) ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String(SortString{}, SortString{}): SortIOInt{} $)
$c Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String $.
FOO-symbol-79-pattern $a #Pattern ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-79-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-79-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-79-substitution $a #Substitution ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'opendir'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String(SortString{}): SortKItem{} $)
$c Lbl'Hash'opendir'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String $.
FOO-symbol-80-pattern $a #Pattern ( Lbl'Hash'opendir'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) $.
${
FOO-symbol-80-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-80-substitution $a #Substitution ( Lbl'Hash'opendir'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) ( Lbl'Hash'opendir'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'putc'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortK{} $)
$c Lbl'Hash'putc'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int $.
FOO-symbol-81-pattern $a #Pattern ( Lbl'Hash'putc'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-81-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-81-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-81-substitution $a #Substitution ( Lbl'Hash'putc'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Hash'putc'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'read'LParUndsCommUndsRParUnds'K-IO'Unds'IOString'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortIOString{} $)
$c Lbl'Hash'read'LParUndsCommUndsRParUnds'K-IO'Unds'IOString'Unds'Int'Unds'Int $.
FOO-symbol-82-pattern $a #Pattern ( Lbl'Hash'read'LParUndsCommUndsRParUnds'K-IO'Unds'IOString'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-82-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-82-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-82-substitution $a #Substitution ( Lbl'Hash'read'LParUndsCommUndsRParUnds'K-IO'Unds'IOString'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Hash'read'LParUndsCommUndsRParUnds'K-IO'Unds'IOString'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String(SortString{}): SortK{} $)
$c Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String $.
FOO-symbol-83-pattern $a #Pattern ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String var-pattern-1 ) $.
${
FOO-symbol-83-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-83-substitution $a #Substitution ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String var-pattern-1 ) ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'seek'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortK{} $)
$c Lbl'Hash'seek'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int $.
FOO-symbol-84-pattern $a #Pattern ( Lbl'Hash'seek'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-84-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-84-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-84-substitution $a #Substitution ( Lbl'Hash'seek'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Hash'seek'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'seekEnd'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortK{} $)
$c Lbl'Hash'seekEnd'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int $.
FOO-symbol-85-pattern $a #Pattern ( Lbl'Hash'seekEnd'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-85-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-85-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-85-substitution $a #Substitution ( Lbl'Hash'seekEnd'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Hash'seekEnd'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int(SortInt{}): SortK{} $)
$c Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int $.
FOO-symbol-86-pattern $a #Pattern ( Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-86-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-86-substitution $a #Substitution ( Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int var-pattern-1 ) ( Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'stat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String(SortString{}): SortKItem{} $)
$c Lbl'Hash'stat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String $.
FOO-symbol-87-pattern $a #Pattern ( Lbl'Hash'stat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) $.
${
FOO-symbol-87-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-87-substitution $a #Substitution ( Lbl'Hash'stat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) ( Lbl'Hash'stat'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'stderr'Unds'K-IO'Unds'Int(): SortInt{} $)
$c Lbl'Hash'stderr'Unds'K-IO'Unds'Int $.
FOO-symbol-88-pattern $a #Pattern Lbl'Hash'stderr'Unds'K-IO'Unds'Int $.
${
FOO-symbol-88-substitution $a #Substitution Lbl'Hash'stderr'Unds'K-IO'Unds'Int Lbl'Hash'stderr'Unds'K-IO'Unds'Int var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'stdin'Unds'K-IO'Unds'Int(): SortInt{} $)
$c Lbl'Hash'stdin'Unds'K-IO'Unds'Int $.
FOO-symbol-89-pattern $a #Pattern Lbl'Hash'stdin'Unds'K-IO'Unds'Int $.
${
FOO-symbol-89-substitution $a #Substitution Lbl'Hash'stdin'Unds'K-IO'Unds'Int Lbl'Hash'stdin'Unds'K-IO'Unds'Int var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'stdout'Unds'K-IO'Unds'Int(): SortInt{} $)
$c Lbl'Hash'stdout'Unds'K-IO'Unds'Int $.
FOO-symbol-90-pattern $a #Pattern Lbl'Hash'stdout'Unds'K-IO'Unds'Int $.
${
FOO-symbol-90-substitution $a #Substitution Lbl'Hash'stdout'Unds'K-IO'Unds'Int Lbl'Hash'stdout'Unds'K-IO'Unds'Int var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'system'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String(SortString{}): SortKItem{} $)
$c Lbl'Hash'system'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String $.
FOO-symbol-91-pattern $a #Pattern ( Lbl'Hash'system'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) $.
${
FOO-symbol-91-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-91-substitution $a #Substitution ( Lbl'Hash'system'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-1 ) ( Lbl'Hash'system'LParUndsRParUnds'K-IO'Unds'KItem'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'systemResult(SortInt{}, SortString{}, SortString{}): SortKItem{} $)
$c Lbl'Hash'systemResult $.
FOO-symbol-92-pattern $a #Pattern ( Lbl'Hash'systemResult var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-92-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-92-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-92-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-92-substitution $a #Substitution ( Lbl'Hash'systemResult var-pattern-1 var-pattern-2 var-pattern-3 ) ( Lbl'Hash'systemResult var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'tell'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int(SortInt{}): SortIOInt{} $)
$c Lbl'Hash'tell'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int $.
FOO-symbol-93-pattern $a #Pattern ( Lbl'Hash'tell'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-93-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-93-substitution $a #Substitution ( Lbl'Hash'tell'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-1 ) ( Lbl'Hash'tell'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'tempFile(SortString{}, SortInt{}): SortIOFile{} $)
$c Lbl'Hash'tempFile $.
FOO-symbol-94-pattern $a #Pattern ( Lbl'Hash'tempFile var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-94-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-94-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-94-substitution $a #Substitution ( Lbl'Hash'tempFile var-pattern-1 var-pattern-2 ) ( Lbl'Hash'tempFile var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'time'LParRParUnds'K-IO'Unds'Int(): SortInt{} $)
$c Lbl'Hash'time'LParRParUnds'K-IO'Unds'Int $.
FOO-symbol-95-pattern $a #Pattern Lbl'Hash'time'LParRParUnds'K-IO'Unds'Int $.
${
FOO-symbol-95-substitution $a #Substitution Lbl'Hash'time'LParRParUnds'K-IO'Unds'Int Lbl'Hash'time'LParRParUnds'K-IO'Unds'Int var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'unknownIOError(SortInt{}): SortIOError{} $)
$c Lbl'Hash'unknownIOError $.
FOO-symbol-96-pattern $a #Pattern ( Lbl'Hash'unknownIOError var-pattern-1 ) $.
${
FOO-symbol-96-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-96-substitution $a #Substitution ( Lbl'Hash'unknownIOError var-pattern-1 ) ( Lbl'Hash'unknownIOError var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'unlock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortK{} $)
$c Lbl'Hash'unlock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int $.
FOO-symbol-97-pattern $a #Pattern ( Lbl'Hash'unlock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-97-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-97-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-97-substitution $a #Substitution ( Lbl'Hash'unlock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Hash'unlock'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Hash'write'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'String(SortInt{}, SortString{}): SortK{} $)
$c Lbl'Hash'write'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'String $.
FOO-symbol-98-pattern $a #Pattern ( Lbl'Hash'write'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-98-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-98-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-98-substitution $a #Substitution ( Lbl'Hash'write'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Hash'write'LParUndsCommUndsRParUnds'K-IO'Unds'K'Unds'Int'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Stop'List(): SortList{} $)
$c Lbl'Stop'List $.
FOO-symbol-99-pattern $a #Pattern Lbl'Stop'List $.
${
FOO-symbol-99-substitution $a #Substitution Lbl'Stop'List Lbl'Stop'List var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Stop'Map(): SortMap{} $)
$c Lbl'Stop'Map $.
FOO-symbol-100-pattern $a #Pattern Lbl'Stop'Map $.
${
FOO-symbol-100-substitution $a #Substitution Lbl'Stop'Map Lbl'Stop'Map var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Stop'Set(): SortSet{} $)
$c Lbl'Stop'Set $.
FOO-symbol-101-pattern $a #Pattern Lbl'Stop'Set $.
${
FOO-symbol-101-substitution $a #Substitution Lbl'Stop'Set Lbl'Stop'Set var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'-LT-'generatedCounter'-GT-'(SortInt{}): SortGeneratedCounterCell{} $)
$c Lbl'-LT-'generatedCounter'-GT-' $.
FOO-symbol-102-pattern $a #Pattern ( Lbl'-LT-'generatedCounter'-GT-' var-pattern-1 ) $.
${
FOO-symbol-102-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-102-substitution $a #Substitution ( Lbl'-LT-'generatedCounter'-GT-' var-pattern-1 ) ( Lbl'-LT-'generatedCounter'-GT-' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'-LT-'generatedTop'-GT-'(SortKCell{}, SortGeneratedCounterCell{}): SortGeneratedTopCell{} $)
$c Lbl'-LT-'generatedTop'-GT-' $.
FOO-symbol-103-pattern $a #Pattern ( Lbl'-LT-'generatedTop'-GT-' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-103-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-103-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-103-substitution $a #Substitution ( Lbl'-LT-'generatedTop'-GT-' var-pattern-1 var-pattern-2 ) ( Lbl'-LT-'generatedTop'-GT-' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'-LT-'generatedTop'-GT-'-fragment(SortKCellOpt{}, SortGeneratedCounterCellOpt{}): SortGeneratedTopCellFragment{} $)
$c Lbl'-LT-'generatedTop'-GT-'-fragment $.
FOO-symbol-104-pattern $a #Pattern ( Lbl'-LT-'generatedTop'-GT-'-fragment var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-104-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-104-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-104-substitution $a #Substitution ( Lbl'-LT-'generatedTop'-GT-'-fragment var-pattern-1 var-pattern-2 ) ( Lbl'-LT-'generatedTop'-GT-'-fragment var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'-LT-'k'-GT-'(SortK{}): SortKCell{} $)
$c Lbl'-LT-'k'-GT-' $.
FOO-symbol-105-pattern $a #Pattern ( Lbl'-LT-'k'-GT-' var-pattern-1 ) $.
${
FOO-symbol-105-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-105-substitution $a #Substitution ( Lbl'-LT-'k'-GT-' var-pattern-1 ) ( Lbl'-LT-'k'-GT-' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblBase2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortString{} $)
$c LblBase2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int'Unds'Int $.
FOO-symbol-106-pattern $a #Pattern ( LblBase2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-106-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-106-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-106-substitution $a #Substitution ( LblBase2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( LblBase2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float(SortFloat{}): SortString{} $)
$c LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float $.
FOO-symbol-107-pattern $a #Pattern ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float var-pattern-1 ) $.
${
FOO-symbol-107-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-107-substitution $a #Substitution ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float var-pattern-1 ) ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblFloat2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float'Unds'String(SortFloat{}, SortString{}): SortString{} $)
$c LblFloat2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float'Unds'String $.
FOO-symbol-108-pattern $a #Pattern ( LblFloat2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-108-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-108-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-108-substitution $a #Substitution ( LblFloat2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float'Unds'String var-pattern-1 var-pattern-2 ) ( LblFloat2String'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id(SortId{}): SortString{} $)
$c LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id $.
FOO-symbol-109-pattern $a #Pattern ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id var-pattern-1 ) $.
${
FOO-symbol-109-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-109-substitution $a #Substitution ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id var-pattern-1 ) ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int(SortInt{}): SortString{} $)
$c LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int $.
FOO-symbol-110-pattern $a #Pattern ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-110-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-110-substitution $a #Substitution ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-1 ) ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblList'Coln'get(SortList{}, SortInt{}): SortKItem{} $)
$c LblList'Coln'get $.
FOO-symbol-111-pattern $a #Pattern ( LblList'Coln'get var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-111-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-111-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-111-substitution $a #Substitution ( LblList'Coln'get var-pattern-1 var-pattern-2 ) ( LblList'Coln'get var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblList'Coln'range(SortList{}, SortInt{}, SortInt{}): SortList{} $)
$c LblList'Coln'range $.
FOO-symbol-112-pattern $a #Pattern ( LblList'Coln'range var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-112-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-112-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-112-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-112-substitution $a #Substitution ( LblList'Coln'range var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblList'Coln'range var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblListItem(SortKItem{}): SortList{} $)
$c LblListItem $.
FOO-symbol-113-pattern $a #Pattern ( LblListItem var-pattern-1 ) $.
${
FOO-symbol-113-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-113-substitution $a #Substitution ( LblListItem var-pattern-1 ) ( LblListItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblMap'Coln'lookup(SortMap{}, SortKItem{}): SortKItem{} $)
$c LblMap'Coln'lookup $.
FOO-symbol-114-pattern $a #Pattern ( LblMap'Coln'lookup var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-114-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-114-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-114-substitution $a #Substitution ( LblMap'Coln'lookup var-pattern-1 var-pattern-2 ) ( LblMap'Coln'lookup var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblMap'Coln'update(SortMap{}, SortKItem{}, SortKItem{}): SortMap{} $)
$c LblMap'Coln'update $.
FOO-symbol-115-pattern $a #Pattern ( LblMap'Coln'update var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-115-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-115-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-115-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-115-substitution $a #Substitution ( LblMap'Coln'update var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblMap'Coln'update var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblSet'Coln'difference(SortSet{}, SortSet{}): SortSet{} $)
$c LblSet'Coln'difference $.
FOO-symbol-116-pattern $a #Pattern ( LblSet'Coln'difference var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-116-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-116-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-116-substitution $a #Substitution ( LblSet'Coln'difference var-pattern-1 var-pattern-2 ) ( LblSet'Coln'difference var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblSet'Coln'in(SortKItem{}, SortSet{}): SortBool{} $)
$c LblSet'Coln'in $.
FOO-symbol-117-pattern $a #Pattern ( LblSet'Coln'in var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-117-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-117-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-117-substitution $a #Substitution ( LblSet'Coln'in var-pattern-1 var-pattern-2 ) ( LblSet'Coln'in var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblSetItem(SortKItem{}): SortSet{} $)
$c LblSetItem $.
FOO-symbol-118-pattern $a #Pattern ( LblSetItem var-pattern-1 ) $.
${
FOO-symbol-118-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-118-substitution $a #Substitution ( LblSetItem var-pattern-1 ) ( LblSetItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblString2Base'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'Int(SortString{}, SortInt{}): SortInt{} $)
$c LblString2Base'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'Int $.
FOO-symbol-119-pattern $a #Pattern ( LblString2Base'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-119-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-119-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-119-substitution $a #Substitution ( LblString2Base'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'Int var-pattern-1 var-pattern-2 ) ( LblString2Base'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblString2Float'LParUndsRParUnds'STRING-COMMON'Unds'Float'Unds'String(SortString{}): SortFloat{} $)
$c LblString2Float'LParUndsRParUnds'STRING-COMMON'Unds'Float'Unds'String $.
FOO-symbol-120-pattern $a #Pattern ( LblString2Float'LParUndsRParUnds'STRING-COMMON'Unds'Float'Unds'String var-pattern-1 ) $.
${
FOO-symbol-120-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-120-substitution $a #Substitution ( LblString2Float'LParUndsRParUnds'STRING-COMMON'Unds'Float'Unds'String var-pattern-1 ) ( LblString2Float'LParUndsRParUnds'STRING-COMMON'Unds'Float'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String(SortString{}): SortId{} $)
$c LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String $.
FOO-symbol-121-pattern $a #Pattern ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String var-pattern-1 ) $.
${
FOO-symbol-121-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-121-substitution $a #Substitution ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String var-pattern-1 ) ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblString2Int'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String(SortString{}): SortInt{} $)
$c LblString2Int'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String $.
FOO-symbol-122-pattern $a #Pattern ( LblString2Int'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-1 ) $.
${
FOO-symbol-122-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-122-substitution $a #Substitution ( LblString2Int'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-1 ) ( LblString2Int'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsPerc'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsPerc'Int'Unds' $.
FOO-symbol-123-pattern $a #Pattern ( Lbl'UndsPerc'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-123-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-123-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-123-substitution $a #Substitution ( Lbl'UndsPerc'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPerc'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsAnd-'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsAnd-'Int'Unds' $.
FOO-symbol-124-pattern $a #Pattern ( Lbl'UndsAnd-'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-124-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-124-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-124-substitution $a #Substitution ( Lbl'UndsAnd-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsAnd-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsStar'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsStar'Int'Unds' $.
FOO-symbol-125-pattern $a #Pattern ( Lbl'UndsStar'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-125-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-125-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-125-substitution $a #Substitution ( Lbl'UndsStar'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsStar'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsPlus'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsPlus'Int'Unds' $.
FOO-symbol-126-pattern $a #Pattern ( Lbl'UndsPlus'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-126-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-126-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-126-substitution $a #Substitution ( Lbl'UndsPlus'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPlus'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String(SortString{}, SortString{}): SortString{} $)
$c Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String $.
FOO-symbol-127-pattern $a #Pattern ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-127-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-127-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-127-substitution $a #Substitution ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'-Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'Unds'-Int'Unds' $.
FOO-symbol-128-pattern $a #Pattern ( Lbl'Unds'-Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-128-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-128-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-128-substitution $a #Substitution ( Lbl'Unds'-Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'-Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map(SortMap{}, SortMap{}): SortMap{} $)
$c Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map $.
FOO-symbol-129-pattern $a #Pattern ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-129-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-129-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-129-substitution $a #Substitution ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsSlsh'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsSlsh'Int'Unds' $.
FOO-symbol-130-pattern $a #Pattern ( Lbl'UndsSlsh'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-130-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-130-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-130-substitution $a #Substitution ( Lbl'UndsSlsh'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsSlsh'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-LT--LT-'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'Unds-LT--LT-'Int'Unds' $.
FOO-symbol-131-pattern $a #Pattern ( Lbl'Unds-LT--LT-'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-131-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-131-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-131-substitution $a #Substitution ( Lbl'Unds-LT--LT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT--LT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-LT-Eqls'Int'Unds'(SortInt{}, SortInt{}): SortBool{} $)
$c Lbl'Unds-LT-Eqls'Int'Unds' $.
FOO-symbol-132-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-132-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-132-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-132-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map(SortMap{}, SortMap{}): SortBool{} $)
$c Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map $.
FOO-symbol-133-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-133-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-133-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-133-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set(SortSet{}, SortSet{}): SortBool{} $)
$c Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set $.
FOO-symbol-134-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-134-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-134-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-134-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String(SortString{}, SortString{}): SortBool{} $)
$c Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String $.
FOO-symbol-135-pattern $a #Pattern ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-135-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-135-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-135-substitution $a #Substitution ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-LT-'Int'Unds'(SortInt{}, SortInt{}): SortBool{} $)
$c Lbl'Unds-LT-'Int'Unds' $.
FOO-symbol-136-pattern $a #Pattern ( Lbl'Unds-LT-'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-136-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-136-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-136-substitution $a #Substitution ( Lbl'Unds-LT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String(SortString{}, SortString{}): SortBool{} $)
$c Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String $.
FOO-symbol-137-pattern $a #Pattern ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-137-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-137-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-137-substitution $a #Substitution ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsSlshEqls'Bool'Unds'(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'UndsEqlsSlshEqls'Bool'Unds' $.
FOO-symbol-138-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'Bool'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-138-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-138-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-138-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'Bool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'Bool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsSlshEqls'Int'Unds'(SortInt{}, SortInt{}): SortBool{} $)
$c Lbl'UndsEqlsSlshEqls'Int'Unds' $.
FOO-symbol-139-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-139-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-139-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-139-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsSlshEqls'K'Unds'(SortK{}, SortK{}): SortBool{} $)
$c Lbl'UndsEqlsSlshEqls'K'Unds' $.
FOO-symbol-140-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'K'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-140-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-140-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-140-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'K'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'K'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String(SortString{}, SortString{}): SortBool{} $)
$c Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String $.
FOO-symbol-141-pattern $a #Pattern ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-141-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-141-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-141-substitution $a #Substitution ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsEqls'Bool'Unds'(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'UndsEqlsEqls'Bool'Unds' $.
FOO-symbol-142-pattern $a #Pattern ( Lbl'UndsEqlsEqls'Bool'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-142-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-142-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-142-substitution $a #Substitution ( Lbl'UndsEqlsEqls'Bool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'Bool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsEqls'Int'Unds'(SortInt{}, SortInt{}): SortBool{} $)
$c Lbl'UndsEqlsEqls'Int'Unds' $.
FOO-symbol-143-pattern $a #Pattern ( Lbl'UndsEqlsEqls'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-143-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-143-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-143-substitution $a #Substitution ( Lbl'UndsEqlsEqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsEqls'K'Unds'(SortK{}, SortK{}): SortBool{} $)
$c Lbl'UndsEqlsEqls'K'Unds' $.
FOO-symbol-144-pattern $a #Pattern ( Lbl'UndsEqlsEqls'K'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-144-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-144-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-144-substitution $a #Substitution ( Lbl'UndsEqlsEqls'K'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'K'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String(SortString{}, SortString{}): SortBool{} $)
$c Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String $.
FOO-symbol-145-pattern $a #Pattern ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-145-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-145-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-145-substitution $a #Substitution ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-GT-Eqls'Int'Unds'(SortInt{}, SortInt{}): SortBool{} $)
$c Lbl'Unds-GT-Eqls'Int'Unds' $.
FOO-symbol-146-pattern $a #Pattern ( Lbl'Unds-GT-Eqls'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-146-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-146-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-146-substitution $a #Substitution ( Lbl'Unds-GT-Eqls'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-Eqls'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String(SortString{}, SortString{}): SortBool{} $)
$c Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String $.
FOO-symbol-147-pattern $a #Pattern ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-147-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-147-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-147-substitution $a #Substitution ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-GT--GT-'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'Unds-GT--GT-'Int'Unds' $.
FOO-symbol-148-pattern $a #Pattern ( Lbl'Unds-GT--GT-'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-148-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-148-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-148-substitution $a #Substitution ( Lbl'Unds-GT--GT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT--GT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-GT-'Int'Unds'(SortInt{}, SortInt{}): SortBool{} $)
$c Lbl'Unds-GT-'Int'Unds' $.
FOO-symbol-149-pattern $a #Pattern ( Lbl'Unds-GT-'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-149-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-149-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-149-substitution $a #Substitution ( Lbl'Unds-GT-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String(SortString{}, SortString{}): SortBool{} $)
$c Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String $.
FOO-symbol-150-pattern $a #Pattern ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-150-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-150-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-150-substitution $a #Substitution ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'List'Unds'(SortList{}, SortList{}): SortList{} $)
$c Lbl'Unds'List'Unds' $.
FOO-symbol-151-pattern $a #Pattern ( Lbl'Unds'List'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-151-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-151-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-151-substitution $a #Substitution ( Lbl'Unds'List'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'List'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'Map'Unds'(SortMap{}, SortMap{}): SortMap{} $)
$c Lbl'Unds'Map'Unds' $.
FOO-symbol-152-pattern $a #Pattern ( Lbl'Unds'Map'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-152-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-152-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-152-substitution $a #Substitution ( Lbl'Unds'Map'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'Map'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'Set'Unds'(SortSet{}, SortSet{}): SortSet{} $)
$c Lbl'Unds'Set'Unds' $.
FOO-symbol-153-pattern $a #Pattern ( Lbl'Unds'Set'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-153-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-153-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-153-substitution $a #Substitution ( Lbl'Unds'Set'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'Set'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsLSqBUnds-LT-'-'UndsRSqBUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'KItem(SortList{}, SortInt{}, SortKItem{}): SortList{} $)
$c Lbl'UndsLSqBUnds-LT-'-'UndsRSqBUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'KItem $.
FOO-symbol-154-pattern $a #Pattern ( Lbl'UndsLSqBUnds-LT-'-'UndsRSqBUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'KItem var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-154-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-154-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-154-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-154-substitution $a #Substitution ( Lbl'UndsLSqBUnds-LT-'-'UndsRSqBUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'KItem var-pattern-1 var-pattern-2 var-pattern-3 ) ( Lbl'UndsLSqBUnds-LT-'-'UndsRSqBUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'KItem var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsLSqBUnds-LT-'-undef'RSqB'(SortMap{}, SortKItem{}): SortMap{} $)
$c Lbl'UndsLSqBUnds-LT-'-undef'RSqB' $.
FOO-symbol-155-pattern $a #Pattern ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-155-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-155-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-155-substitution $a #Substitution ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' var-pattern-1 var-pattern-2 ) ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem(SortMap{}, SortKItem{}, SortKItem{}): SortKItem{} $)
$c Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem $.
FOO-symbol-156-pattern $a #Pattern ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-156-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-156-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-156-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-156-substitution $a #Substitution ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem var-pattern-1 var-pattern-2 var-pattern-3 ) ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsXor-Perc'Int'UndsUnds'(SortInt{}, SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsXor-Perc'Int'UndsUnds' $.
FOO-symbol-157-pattern $a #Pattern ( Lbl'UndsXor-Perc'Int'UndsUnds' var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-157-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-157-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-157-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-157-substitution $a #Substitution ( Lbl'UndsXor-Perc'Int'UndsUnds' var-pattern-1 var-pattern-2 var-pattern-3 ) ( Lbl'UndsXor-Perc'Int'UndsUnds' var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsXor-'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsXor-'Int'Unds' $.
FOO-symbol-158-pattern $a #Pattern ( Lbl'UndsXor-'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-158-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-158-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-158-substitution $a #Substitution ( Lbl'UndsXor-'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsXor-'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'andBool'Unds'(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'Unds'andBool'Unds' $.
FOO-symbol-159-pattern $a #Pattern ( Lbl'Unds'andBool'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-159-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-159-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-159-substitution $a #Substitution ( Lbl'Unds'andBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'andBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'andThenBool'Unds'(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'Unds'andThenBool'Unds' $.
FOO-symbol-160-pattern $a #Pattern ( Lbl'Unds'andThenBool'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-160-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-160-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-160-substitution $a #Substitution ( Lbl'Unds'andThenBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'andThenBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'divInt'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'Unds'divInt'Unds' $.
FOO-symbol-161-pattern $a #Pattern ( Lbl'Unds'divInt'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-161-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-161-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-161-substitution $a #Substitution ( Lbl'Unds'divInt'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'divInt'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortBool{} $)
$c Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int $.
FOO-symbol-162-pattern $a #Pattern ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-162-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-162-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-162-substitution $a #Substitution ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'impliesBool'Unds'(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'Unds'impliesBool'Unds' $.
FOO-symbol-163-pattern $a #Pattern ( Lbl'Unds'impliesBool'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-163-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-163-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-163-substitution $a #Substitution ( Lbl'Unds'impliesBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'impliesBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List(SortKItem{}, SortList{}): SortBool{} $)
$c Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List $.
FOO-symbol-164-pattern $a #Pattern ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-164-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-164-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-164-substitution $a #Substitution ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List var-pattern-1 var-pattern-2 ) ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map(SortKItem{}, SortMap{}): SortBool{} $)
$c Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map $.
FOO-symbol-165-pattern $a #Pattern ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-165-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-165-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-165-substitution $a #Substitution ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map var-pattern-1 var-pattern-2 ) ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'modInt'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'Unds'modInt'Unds' $.
FOO-symbol-166-pattern $a #Pattern ( Lbl'Unds'modInt'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-166-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-166-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-166-substitution $a #Substitution ( Lbl'Unds'modInt'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'modInt'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool $.
FOO-symbol-167-pattern $a #Pattern ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-167-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-167-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-167-substitution $a #Substitution ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool var-pattern-1 var-pattern-2 ) ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'orElseBool'Unds'(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'Unds'orElseBool'Unds' $.
FOO-symbol-168-pattern $a #Pattern ( Lbl'Unds'orElseBool'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-168-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-168-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-168-substitution $a #Substitution ( Lbl'Unds'orElseBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'orElseBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'xorBool'Unds'(SortBool{}, SortBool{}): SortBool{} $)
$c Lbl'Unds'xorBool'Unds' $.
FOO-symbol-169-pattern $a #Pattern ( Lbl'Unds'xorBool'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-169-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-169-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-169-substitution $a #Substitution ( Lbl'Unds'xorBool'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'xorBool'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Unds'xorInt'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'Unds'xorInt'Unds' $.
FOO-symbol-170-pattern $a #Pattern ( Lbl'Unds'xorInt'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-170-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-170-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-170-substitution $a #Substitution ( Lbl'Unds'xorInt'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'Unds'xorInt'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsPipe'-'-GT-Unds'(SortKItem{}, SortKItem{}): SortMap{} $)
$c Lbl'UndsPipe'-'-GT-Unds' $.
FOO-symbol-171-pattern $a #Pattern ( Lbl'UndsPipe'-'-GT-Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-171-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-171-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-171-substitution $a #Substitution ( Lbl'UndsPipe'-'-GT-Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPipe'-'-GT-Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsPipe'Int'Unds'(SortInt{}, SortInt{}): SortInt{} $)
$c Lbl'UndsPipe'Int'Unds' $.
FOO-symbol-172-pattern $a #Pattern ( Lbl'UndsPipe'Int'Unds' var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-172-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-172-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-172-substitution $a #Substitution ( Lbl'UndsPipe'Int'Unds' var-pattern-1 var-pattern-2 ) ( Lbl'UndsPipe'Int'Unds' var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set(SortSet{}, SortSet{}): SortSet{} $)
$c Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set $.
FOO-symbol-173-pattern $a #Pattern ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-173-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-173-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-173-substitution $a #Substitution ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int(SortInt{}): SortInt{} $)
$c LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int $.
FOO-symbol-174-pattern $a #Pattern ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-174-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-174-substitution $a #Substitution ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-1 ) ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo(SortFoo{}, SortFoo{}): SortFoo{} $)
$c Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo $.
FOO-symbol-175-pattern $a #Pattern ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-175-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-175-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-175-substitution $a #Substitution ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo var-pattern-1 var-pattern-2 ) ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int(SortInt{}, SortInt{}, SortInt{}): SortInt{} $)
$c LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int $.
FOO-symbol-176-pattern $a #Pattern ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-176-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-176-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-176-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-176-substitution $a #Substitution ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblcategoryChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String(SortString{}): SortString{} $)
$c LblcategoryChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String $.
FOO-symbol-177-pattern $a #Pattern ( LblcategoryChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String var-pattern-1 ) $.
${
FOO-symbol-177-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-177-substitution $a #Substitution ( LblcategoryChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String var-pattern-1 ) ( LblcategoryChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblchoice'LParUndsRParUnds'MAP'Unds'KItem'Unds'Map(SortMap{}): SortKItem{} $)
$c Lblchoice'LParUndsRParUnds'MAP'Unds'KItem'Unds'Map $.
FOO-symbol-178-pattern $a #Pattern ( Lblchoice'LParUndsRParUnds'MAP'Unds'KItem'Unds'Map var-pattern-1 ) $.
${
FOO-symbol-178-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-178-substitution $a #Substitution ( Lblchoice'LParUndsRParUnds'MAP'Unds'KItem'Unds'Map var-pattern-1 ) ( Lblchoice'LParUndsRParUnds'MAP'Unds'KItem'Unds'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblchoice'LParUndsRParUnds'SET'Unds'KItem'Unds'Set(SortSet{}): SortKItem{} $)
$c Lblchoice'LParUndsRParUnds'SET'Unds'KItem'Unds'Set $.
FOO-symbol-179-pattern $a #Pattern ( Lblchoice'LParUndsRParUnds'SET'Unds'KItem'Unds'Set var-pattern-1 ) $.
${
FOO-symbol-179-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-179-substitution $a #Substitution ( Lblchoice'LParUndsRParUnds'SET'Unds'KItem'Unds'Set var-pattern-1 ) ( Lblchoice'LParUndsRParUnds'SET'Unds'KItem'Unds'Set var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblchrChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int(SortInt{}): SortString{} $)
$c LblchrChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int $.
FOO-symbol-180-pattern $a #Pattern ( LblchrChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-180-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-180-substitution $a #Substitution ( LblchrChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-1 ) ( LblchrChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String(SortString{}, SortString{}): SortInt{} $)
$c LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String $.
FOO-symbol-181-pattern $a #Pattern ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-181-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-181-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-181-substitution $a #Substitution ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String var-pattern-1 var-pattern-2 ) ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String(SortString{}): SortString{} $)
$c LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String $.
FOO-symbol-182-pattern $a #Pattern ( LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String var-pattern-1 ) $.
${
FOO-symbol-182-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-182-substitution $a #Substitution ( LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String var-pattern-1 ) ( LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblfillList'LParUndsCommUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'Int'Unds'KItem(SortList{}, SortInt{}, SortInt{}, SortKItem{}): SortList{} $)
$c LblfillList'LParUndsCommUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'Int'Unds'KItem $.
FOO-symbol-183-pattern $a #Pattern ( LblfillList'LParUndsCommUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'Int'Unds'KItem var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) $.
${
FOO-symbol-183-substitution.0 $e #Substitution var-pattern-1 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-183-substitution.1 $e #Substitution var-pattern-2 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-183-substitution.2 $e #Substitution var-pattern-3 var-pattern-7 var-pattern-0 var-variable-0 $.
FOO-symbol-183-substitution.3 $e #Substitution var-pattern-4 var-pattern-8 var-pattern-0 var-variable-0 $.
FOO-symbol-183-substitution $a #Substitution ( LblfillList'LParUndsCommUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'Int'Unds'KItem var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) ( LblfillList'LParUndsCommUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'Int'Unds'KItem var-pattern-5 var-pattern-6 var-pattern-7 var-pattern-8 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int(SortString{}, SortString{}, SortInt{}): SortInt{} $)
$c LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int $.
FOO-symbol-184-pattern $a #Pattern ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-184-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-184-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-184-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-184-substitution $a #Substitution ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int(SortString{}, SortString{}, SortInt{}): SortInt{} $)
$c LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int $.
FOO-symbol-185-pattern $a #Pattern ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-185-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-185-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-185-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-185-substitution $a #Substitution ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int(SortInt{}): SortFoo{} $)
$c Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int $.
FOO-symbol-186-pattern $a #Pattern ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-186-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-186-substitution $a #Substitution ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int var-pattern-1 ) ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int(SortInt{}): SortId{} $)
$c LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int $.
FOO-symbol-187-pattern $a #Pattern ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-187-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-187-substitution $a #Substitution ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int var-pattern-1 ) ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int(SortInt{}): SortInt{} $)
$c LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int $.
FOO-symbol-188-pattern $a #Pattern ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-188-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-188-substitution $a #Substitution ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-1 ) ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblgetGeneratedCounterCell(SortGeneratedTopCell{}): SortGeneratedCounterCell{} $)
$c LblgetGeneratedCounterCell $.
FOO-symbol-189-pattern $a #Pattern ( LblgetGeneratedCounterCell var-pattern-1 ) $.
${
FOO-symbol-189-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-189-substitution $a #Substitution ( LblgetGeneratedCounterCell var-pattern-1 ) ( LblgetGeneratedCounterCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo(SortFoo{}): SortFoo{} $)
$c Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo $.
FOO-symbol-190-pattern $a #Pattern ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo var-pattern-1 ) $.
${
FOO-symbol-190-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-190-substitution $a #Substitution ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo var-pattern-1 ) ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblinitGeneratedCounterCell(): SortGeneratedCounterCell{} $)
$c LblinitGeneratedCounterCell $.
FOO-symbol-191-pattern $a #Pattern LblinitGeneratedCounterCell $.
${
FOO-symbol-191-substitution $a #Substitution LblinitGeneratedCounterCell LblinitGeneratedCounterCell var-pattern-0 var-variable-0 $.
$}

$( symbol LblinitGeneratedTopCell(SortMap{}): SortGeneratedTopCell{} $)
$c LblinitGeneratedTopCell $.
FOO-symbol-192-pattern $a #Pattern ( LblinitGeneratedTopCell var-pattern-1 ) $.
${
FOO-symbol-192-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-192-substitution $a #Substitution ( LblinitGeneratedTopCell var-pattern-1 ) ( LblinitGeneratedTopCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblinitKCell(SortMap{}): SortKCell{} $)
$c LblinitKCell $.
FOO-symbol-193-pattern $a #Pattern ( LblinitKCell var-pattern-1 ) $.
${
FOO-symbol-193-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-193-substitution $a #Substitution ( LblinitKCell var-pattern-1 ) ( LblinitKCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set(SortSet{}, SortSet{}): SortSet{} $)
$c LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set $.
FOO-symbol-194-pattern $a #Pattern ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-194-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-194-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-194-substitution $a #Substitution ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-1 var-pattern-2 ) ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisBool(SortK{}): SortBool{} $)
$c LblisBool $.
FOO-symbol-195-pattern $a #Pattern ( LblisBool var-pattern-1 ) $.
${
FOO-symbol-195-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-195-substitution $a #Substitution ( LblisBool var-pattern-1 ) ( LblisBool var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisCell(SortK{}): SortBool{} $)
$c LblisCell $.
FOO-symbol-196-pattern $a #Pattern ( LblisCell var-pattern-1 ) $.
${
FOO-symbol-196-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-196-substitution $a #Substitution ( LblisCell var-pattern-1 ) ( LblisCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisFloat(SortK{}): SortBool{} $)
$c LblisFloat $.
FOO-symbol-197-pattern $a #Pattern ( LblisFloat var-pattern-1 ) $.
${
FOO-symbol-197-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-197-substitution $a #Substitution ( LblisFloat var-pattern-1 ) ( LblisFloat var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisFoo(SortK{}): SortBool{} $)
$c LblisFoo $.
FOO-symbol-198-pattern $a #Pattern ( LblisFoo var-pattern-1 ) $.
${
FOO-symbol-198-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-198-substitution $a #Substitution ( LblisFoo var-pattern-1 ) ( LblisFoo var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisGeneratedCounterCell(SortK{}): SortBool{} $)
$c LblisGeneratedCounterCell $.
FOO-symbol-199-pattern $a #Pattern ( LblisGeneratedCounterCell var-pattern-1 ) $.
${
FOO-symbol-199-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-199-substitution $a #Substitution ( LblisGeneratedCounterCell var-pattern-1 ) ( LblisGeneratedCounterCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisGeneratedCounterCellOpt(SortK{}): SortBool{} $)
$c LblisGeneratedCounterCellOpt $.
FOO-symbol-200-pattern $a #Pattern ( LblisGeneratedCounterCellOpt var-pattern-1 ) $.
${
FOO-symbol-200-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-200-substitution $a #Substitution ( LblisGeneratedCounterCellOpt var-pattern-1 ) ( LblisGeneratedCounterCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisGeneratedTopCell(SortK{}): SortBool{} $)
$c LblisGeneratedTopCell $.
FOO-symbol-201-pattern $a #Pattern ( LblisGeneratedTopCell var-pattern-1 ) $.
${
FOO-symbol-201-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-201-substitution $a #Substitution ( LblisGeneratedTopCell var-pattern-1 ) ( LblisGeneratedTopCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisGeneratedTopCellFragment(SortK{}): SortBool{} $)
$c LblisGeneratedTopCellFragment $.
FOO-symbol-202-pattern $a #Pattern ( LblisGeneratedTopCellFragment var-pattern-1 ) $.
${
FOO-symbol-202-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-202-substitution $a #Substitution ( LblisGeneratedTopCellFragment var-pattern-1 ) ( LblisGeneratedTopCellFragment var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisIOError(SortK{}): SortBool{} $)
$c LblisIOError $.
FOO-symbol-203-pattern $a #Pattern ( LblisIOError var-pattern-1 ) $.
${
FOO-symbol-203-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-203-substitution $a #Substitution ( LblisIOError var-pattern-1 ) ( LblisIOError var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisIOFile(SortK{}): SortBool{} $)
$c LblisIOFile $.
FOO-symbol-204-pattern $a #Pattern ( LblisIOFile var-pattern-1 ) $.
${
FOO-symbol-204-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-204-substitution $a #Substitution ( LblisIOFile var-pattern-1 ) ( LblisIOFile var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisIOInt(SortK{}): SortBool{} $)
$c LblisIOInt $.
FOO-symbol-205-pattern $a #Pattern ( LblisIOInt var-pattern-1 ) $.
${
FOO-symbol-205-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-205-substitution $a #Substitution ( LblisIOInt var-pattern-1 ) ( LblisIOInt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisIOString(SortK{}): SortBool{} $)
$c LblisIOString $.
FOO-symbol-206-pattern $a #Pattern ( LblisIOString var-pattern-1 ) $.
${
FOO-symbol-206-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-206-substitution $a #Substitution ( LblisIOString var-pattern-1 ) ( LblisIOString var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisId(SortK{}): SortBool{} $)
$c LblisId $.
FOO-symbol-207-pattern $a #Pattern ( LblisId var-pattern-1 ) $.
${
FOO-symbol-207-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-207-substitution $a #Substitution ( LblisId var-pattern-1 ) ( LblisId var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisInt(SortK{}): SortBool{} $)
$c LblisInt $.
FOO-symbol-208-pattern $a #Pattern ( LblisInt var-pattern-1 ) $.
${
FOO-symbol-208-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-208-substitution $a #Substitution ( LblisInt var-pattern-1 ) ( LblisInt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisK(SortK{}): SortBool{} $)
$c LblisK $.
FOO-symbol-209-pattern $a #Pattern ( LblisK var-pattern-1 ) $.
${
FOO-symbol-209-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-209-substitution $a #Substitution ( LblisK var-pattern-1 ) ( LblisK var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisKCell(SortK{}): SortBool{} $)
$c LblisKCell $.
FOO-symbol-210-pattern $a #Pattern ( LblisKCell var-pattern-1 ) $.
${
FOO-symbol-210-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-210-substitution $a #Substitution ( LblisKCell var-pattern-1 ) ( LblisKCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisKCellOpt(SortK{}): SortBool{} $)
$c LblisKCellOpt $.
FOO-symbol-211-pattern $a #Pattern ( LblisKCellOpt var-pattern-1 ) $.
${
FOO-symbol-211-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-211-substitution $a #Substitution ( LblisKCellOpt var-pattern-1 ) ( LblisKCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisKConfigVar(SortK{}): SortBool{} $)
$c LblisKConfigVar $.
FOO-symbol-212-pattern $a #Pattern ( LblisKConfigVar var-pattern-1 ) $.
${
FOO-symbol-212-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-212-substitution $a #Substitution ( LblisKConfigVar var-pattern-1 ) ( LblisKConfigVar var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisKItem(SortK{}): SortBool{} $)
$c LblisKItem $.
FOO-symbol-213-pattern $a #Pattern ( LblisKItem var-pattern-1 ) $.
${
FOO-symbol-213-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-213-substitution $a #Substitution ( LblisKItem var-pattern-1 ) ( LblisKItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisList(SortK{}): SortBool{} $)
$c LblisList $.
FOO-symbol-214-pattern $a #Pattern ( LblisList var-pattern-1 ) $.
${
FOO-symbol-214-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-214-substitution $a #Substitution ( LblisList var-pattern-1 ) ( LblisList var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisMap(SortK{}): SortBool{} $)
$c LblisMap $.
FOO-symbol-215-pattern $a #Pattern ( LblisMap var-pattern-1 ) $.
${
FOO-symbol-215-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-215-substitution $a #Substitution ( LblisMap var-pattern-1 ) ( LblisMap var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisSet(SortK{}): SortBool{} $)
$c LblisSet $.
FOO-symbol-216-pattern $a #Pattern ( LblisSet var-pattern-1 ) $.
${
FOO-symbol-216-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-216-substitution $a #Substitution ( LblisSet var-pattern-1 ) ( LblisSet var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisStream(SortK{}): SortBool{} $)
$c LblisStream $.
FOO-symbol-217-pattern $a #Pattern ( LblisStream var-pattern-1 ) $.
${
FOO-symbol-217-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-217-substitution $a #Substitution ( LblisStream var-pattern-1 ) ( LblisStream var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblisString(SortK{}): SortBool{} $)
$c LblisString $.
FOO-symbol-218-pattern $a #Pattern ( LblisString var-pattern-1 ) $.
${
FOO-symbol-218-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-218-substitution $a #Substitution ( LblisString var-pattern-1 ) ( LblisString var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map(SortMap{}): SortSet{} $)
$c Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map $.
FOO-symbol-219-pattern $a #Pattern ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map var-pattern-1 ) $.
${
FOO-symbol-219-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-219-substitution $a #Substitution ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map var-pattern-1 ) ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblkeys'Unds'list'LParUndsRParUnds'MAP'Unds'List'Unds'Map(SortMap{}): SortList{} $)
$c Lblkeys'Unds'list'LParUndsRParUnds'MAP'Unds'List'Unds'Map $.
FOO-symbol-220-pattern $a #Pattern ( Lblkeys'Unds'list'LParUndsRParUnds'MAP'Unds'List'Unds'Map var-pattern-1 ) $.
${
FOO-symbol-220-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-220-substitution $a #Substitution ( Lblkeys'Unds'list'LParUndsRParUnds'MAP'Unds'List'Unds'Map var-pattern-1 ) ( Lblkeys'Unds'list'LParUndsRParUnds'MAP'Unds'List'Unds'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String(SortString{}): SortInt{} $)
$c LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String $.
FOO-symbol-221-pattern $a #Pattern ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-1 ) $.
${
FOO-symbol-221-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-221-substitution $a #Substitution ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-1 ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbllog2Int'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int(SortInt{}): SortInt{} $)
$c Lbllog2Int'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int $.
FOO-symbol-222-pattern $a #Pattern ( Lbllog2Int'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-222-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-222-substitution $a #Substitution ( Lbllog2Int'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-1 ) ( Lbllog2Int'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblmakeList'LParUndsCommUndsRParUnds'LIST'Unds'List'Unds'Int'Unds'KItem(SortInt{}, SortKItem{}): SortList{} $)
$c LblmakeList'LParUndsCommUndsRParUnds'LIST'Unds'List'Unds'Int'Unds'KItem $.
FOO-symbol-223-pattern $a #Pattern ( LblmakeList'LParUndsCommUndsRParUnds'LIST'Unds'List'Unds'Int'Unds'KItem var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-223-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-223-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-223-substitution $a #Substitution ( LblmakeList'LParUndsCommUndsRParUnds'LIST'Unds'List'Unds'Int'Unds'KItem var-pattern-1 var-pattern-2 ) ( LblmakeList'LParUndsCommUndsRParUnds'LIST'Unds'List'Unds'Int'Unds'KItem var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortInt{} $)
$c LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int $.
FOO-symbol-224-pattern $a #Pattern ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-224-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-224-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-224-substitution $a #Substitution ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int(SortInt{}, SortInt{}): SortInt{} $)
$c LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int $.
FOO-symbol-225-pattern $a #Pattern ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-225-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-225-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-225-substitution $a #Substitution ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 ) ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblnewUUID'Unds'STRING-COMMON'Unds'String(): SortString{} $)
$c LblnewUUID'Unds'STRING-COMMON'Unds'String $.
FOO-symbol-226-pattern $a #Pattern LblnewUUID'Unds'STRING-COMMON'Unds'String $.
${
FOO-symbol-226-substitution $a #Substitution LblnewUUID'Unds'STRING-COMMON'Unds'String LblnewUUID'Unds'STRING-COMMON'Unds'String var-pattern-0 var-variable-0 $.
$}

$( symbol LblnoGeneratedCounterCell(): SortGeneratedCounterCellOpt{} $)
$c LblnoGeneratedCounterCell $.
FOO-symbol-227-pattern $a #Pattern LblnoGeneratedCounterCell $.
${
FOO-symbol-227-substitution $a #Substitution LblnoGeneratedCounterCell LblnoGeneratedCounterCell var-pattern-0 var-variable-0 $.
$}

$( symbol LblnoKCell(): SortKCellOpt{} $)
$c LblnoKCell $.
FOO-symbol-228-pattern $a #Pattern LblnoKCell $.
${
FOO-symbol-228-substitution $a #Substitution LblnoKCell LblnoKCell var-pattern-0 var-variable-0 $.
$}

$( symbol LblnotBool'Unds'(SortBool{}): SortBool{} $)
$c LblnotBool'Unds' $.
FOO-symbol-229-pattern $a #Pattern ( LblnotBool'Unds' var-pattern-1 ) $.
${
FOO-symbol-229-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-229-substitution $a #Substitution ( LblnotBool'Unds' var-pattern-1 ) ( LblnotBool'Unds' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblordChar'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String(SortString{}): SortInt{} $)
$c LblordChar'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String $.
FOO-symbol-230-pattern $a #Pattern ( LblordChar'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-1 ) $.
${
FOO-symbol-230-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-230-substitution $a #Substitution ( LblordChar'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-1 ) ( LblordChar'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'ColnHash'tempFile'Coln'fd(SortIOFile{}): SortInt{} $)
$c Lblproject'ColnHash'tempFile'Coln'fd $.
FOO-symbol-231-pattern $a #Pattern ( Lblproject'ColnHash'tempFile'Coln'fd var-pattern-1 ) $.
${
FOO-symbol-231-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-231-substitution $a #Substitution ( Lblproject'ColnHash'tempFile'Coln'fd var-pattern-1 ) ( Lblproject'ColnHash'tempFile'Coln'fd var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'ColnHash'tempFile'Coln'path(SortIOFile{}): SortString{} $)
$c Lblproject'ColnHash'tempFile'Coln'path $.
FOO-symbol-232-pattern $a #Pattern ( Lblproject'ColnHash'tempFile'Coln'path var-pattern-1 ) $.
${
FOO-symbol-232-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-232-substitution $a #Substitution ( Lblproject'ColnHash'tempFile'Coln'path var-pattern-1 ) ( Lblproject'ColnHash'tempFile'Coln'path var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'ColnHash'unknownIOError'Coln'errno(SortIOError{}): SortInt{} $)
$c Lblproject'ColnHash'unknownIOError'Coln'errno $.
FOO-symbol-233-pattern $a #Pattern ( Lblproject'ColnHash'unknownIOError'Coln'errno var-pattern-1 ) $.
${
FOO-symbol-233-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-233-substitution $a #Substitution ( Lblproject'ColnHash'unknownIOError'Coln'errno var-pattern-1 ) ( Lblproject'ColnHash'unknownIOError'Coln'errno var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Bool(SortK{}): SortBool{} $)
$c Lblproject'Coln'Bool $.
FOO-symbol-234-pattern $a #Pattern ( Lblproject'Coln'Bool var-pattern-1 ) $.
${
FOO-symbol-234-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-234-substitution $a #Substitution ( Lblproject'Coln'Bool var-pattern-1 ) ( Lblproject'Coln'Bool var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Cell(SortK{}): SortCell{} $)
$c Lblproject'Coln'Cell $.
FOO-symbol-235-pattern $a #Pattern ( Lblproject'Coln'Cell var-pattern-1 ) $.
${
FOO-symbol-235-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-235-substitution $a #Substitution ( Lblproject'Coln'Cell var-pattern-1 ) ( Lblproject'Coln'Cell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Float(SortK{}): SortFloat{} $)
$c Lblproject'Coln'Float $.
FOO-symbol-236-pattern $a #Pattern ( Lblproject'Coln'Float var-pattern-1 ) $.
${
FOO-symbol-236-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-236-substitution $a #Substitution ( Lblproject'Coln'Float var-pattern-1 ) ( Lblproject'Coln'Float var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Foo(SortK{}): SortFoo{} $)
$c Lblproject'Coln'Foo $.
FOO-symbol-237-pattern $a #Pattern ( Lblproject'Coln'Foo var-pattern-1 ) $.
${
FOO-symbol-237-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-237-substitution $a #Substitution ( Lblproject'Coln'Foo var-pattern-1 ) ( Lblproject'Coln'Foo var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'GeneratedCounterCell(SortK{}): SortGeneratedCounterCell{} $)
$c Lblproject'Coln'GeneratedCounterCell $.
FOO-symbol-238-pattern $a #Pattern ( Lblproject'Coln'GeneratedCounterCell var-pattern-1 ) $.
${
FOO-symbol-238-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-238-substitution $a #Substitution ( Lblproject'Coln'GeneratedCounterCell var-pattern-1 ) ( Lblproject'Coln'GeneratedCounterCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'GeneratedCounterCellOpt(SortK{}): SortGeneratedCounterCellOpt{} $)
$c Lblproject'Coln'GeneratedCounterCellOpt $.
FOO-symbol-239-pattern $a #Pattern ( Lblproject'Coln'GeneratedCounterCellOpt var-pattern-1 ) $.
${
FOO-symbol-239-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-239-substitution $a #Substitution ( Lblproject'Coln'GeneratedCounterCellOpt var-pattern-1 ) ( Lblproject'Coln'GeneratedCounterCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'GeneratedTopCell(SortK{}): SortGeneratedTopCell{} $)
$c Lblproject'Coln'GeneratedTopCell $.
FOO-symbol-240-pattern $a #Pattern ( Lblproject'Coln'GeneratedTopCell var-pattern-1 ) $.
${
FOO-symbol-240-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-240-substitution $a #Substitution ( Lblproject'Coln'GeneratedTopCell var-pattern-1 ) ( Lblproject'Coln'GeneratedTopCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'GeneratedTopCellFragment(SortK{}): SortGeneratedTopCellFragment{} $)
$c Lblproject'Coln'GeneratedTopCellFragment $.
FOO-symbol-241-pattern $a #Pattern ( Lblproject'Coln'GeneratedTopCellFragment var-pattern-1 ) $.
${
FOO-symbol-241-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-241-substitution $a #Substitution ( Lblproject'Coln'GeneratedTopCellFragment var-pattern-1 ) ( Lblproject'Coln'GeneratedTopCellFragment var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'IOError(SortK{}): SortIOError{} $)
$c Lblproject'Coln'IOError $.
FOO-symbol-242-pattern $a #Pattern ( Lblproject'Coln'IOError var-pattern-1 ) $.
${
FOO-symbol-242-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-242-substitution $a #Substitution ( Lblproject'Coln'IOError var-pattern-1 ) ( Lblproject'Coln'IOError var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'IOFile(SortK{}): SortIOFile{} $)
$c Lblproject'Coln'IOFile $.
FOO-symbol-243-pattern $a #Pattern ( Lblproject'Coln'IOFile var-pattern-1 ) $.
${
FOO-symbol-243-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-243-substitution $a #Substitution ( Lblproject'Coln'IOFile var-pattern-1 ) ( Lblproject'Coln'IOFile var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'IOInt(SortK{}): SortIOInt{} $)
$c Lblproject'Coln'IOInt $.
FOO-symbol-244-pattern $a #Pattern ( Lblproject'Coln'IOInt var-pattern-1 ) $.
${
FOO-symbol-244-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-244-substitution $a #Substitution ( Lblproject'Coln'IOInt var-pattern-1 ) ( Lblproject'Coln'IOInt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'IOString(SortK{}): SortIOString{} $)
$c Lblproject'Coln'IOString $.
FOO-symbol-245-pattern $a #Pattern ( Lblproject'Coln'IOString var-pattern-1 ) $.
${
FOO-symbol-245-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-245-substitution $a #Substitution ( Lblproject'Coln'IOString var-pattern-1 ) ( Lblproject'Coln'IOString var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Id(SortK{}): SortId{} $)
$c Lblproject'Coln'Id $.
FOO-symbol-246-pattern $a #Pattern ( Lblproject'Coln'Id var-pattern-1 ) $.
${
FOO-symbol-246-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-246-substitution $a #Substitution ( Lblproject'Coln'Id var-pattern-1 ) ( Lblproject'Coln'Id var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Int(SortK{}): SortInt{} $)
$c Lblproject'Coln'Int $.
FOO-symbol-247-pattern $a #Pattern ( Lblproject'Coln'Int var-pattern-1 ) $.
${
FOO-symbol-247-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-247-substitution $a #Substitution ( Lblproject'Coln'Int var-pattern-1 ) ( Lblproject'Coln'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'K(SortK{}): SortK{} $)
$c Lblproject'Coln'K $.
FOO-symbol-248-pattern $a #Pattern ( Lblproject'Coln'K var-pattern-1 ) $.
${
FOO-symbol-248-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-248-substitution $a #Substitution ( Lblproject'Coln'K var-pattern-1 ) ( Lblproject'Coln'K var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'KCell(SortK{}): SortKCell{} $)
$c Lblproject'Coln'KCell $.
FOO-symbol-249-pattern $a #Pattern ( Lblproject'Coln'KCell var-pattern-1 ) $.
${
FOO-symbol-249-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-249-substitution $a #Substitution ( Lblproject'Coln'KCell var-pattern-1 ) ( Lblproject'Coln'KCell var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'KCellOpt(SortK{}): SortKCellOpt{} $)
$c Lblproject'Coln'KCellOpt $.
FOO-symbol-250-pattern $a #Pattern ( Lblproject'Coln'KCellOpt var-pattern-1 ) $.
${
FOO-symbol-250-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-250-substitution $a #Substitution ( Lblproject'Coln'KCellOpt var-pattern-1 ) ( Lblproject'Coln'KCellOpt var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'KItem(SortK{}): SortKItem{} $)
$c Lblproject'Coln'KItem $.
FOO-symbol-251-pattern $a #Pattern ( Lblproject'Coln'KItem var-pattern-1 ) $.
${
FOO-symbol-251-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-251-substitution $a #Substitution ( Lblproject'Coln'KItem var-pattern-1 ) ( Lblproject'Coln'KItem var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'List(SortK{}): SortList{} $)
$c Lblproject'Coln'List $.
FOO-symbol-252-pattern $a #Pattern ( Lblproject'Coln'List var-pattern-1 ) $.
${
FOO-symbol-252-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-252-substitution $a #Substitution ( Lblproject'Coln'List var-pattern-1 ) ( Lblproject'Coln'List var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Map(SortK{}): SortMap{} $)
$c Lblproject'Coln'Map $.
FOO-symbol-253-pattern $a #Pattern ( Lblproject'Coln'Map var-pattern-1 ) $.
${
FOO-symbol-253-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-253-substitution $a #Substitution ( Lblproject'Coln'Map var-pattern-1 ) ( Lblproject'Coln'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Set(SortK{}): SortSet{} $)
$c Lblproject'Coln'Set $.
FOO-symbol-254-pattern $a #Pattern ( Lblproject'Coln'Set var-pattern-1 ) $.
${
FOO-symbol-254-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-254-substitution $a #Substitution ( Lblproject'Coln'Set var-pattern-1 ) ( Lblproject'Coln'Set var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'Stream(SortK{}): SortStream{} $)
$c Lblproject'Coln'Stream $.
FOO-symbol-255-pattern $a #Pattern ( Lblproject'Coln'Stream var-pattern-1 ) $.
${
FOO-symbol-255-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-255-substitution $a #Substitution ( Lblproject'Coln'Stream var-pattern-1 ) ( Lblproject'Coln'Stream var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblproject'Coln'String(SortK{}): SortString{} $)
$c Lblproject'Coln'String $.
FOO-symbol-256-pattern $a #Pattern ( Lblproject'Coln'String var-pattern-1 ) $.
${
FOO-symbol-256-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-256-substitution $a #Substitution ( Lblproject'Coln'String var-pattern-1 ) ( Lblproject'Coln'String var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblrandInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int(SortInt{}): SortInt{} $)
$c LblrandInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int $.
FOO-symbol-257-pattern $a #Pattern ( LblrandInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-257-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-257-substitution $a #Substitution ( LblrandInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-1 ) ( LblrandInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set(SortMap{}, SortSet{}): SortMap{} $)
$c LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set $.
FOO-symbol-258-pattern $a #Pattern ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-258-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-258-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-258-substitution $a #Substitution ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set var-pattern-1 var-pattern-2 ) ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int(SortString{}, SortString{}, SortString{}, SortInt{}): SortString{} $)
$c Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int $.
FOO-symbol-259-pattern $a #Pattern ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) $.
${
FOO-symbol-259-substitution.0 $e #Substitution var-pattern-1 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-259-substitution.1 $e #Substitution var-pattern-2 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-259-substitution.2 $e #Substitution var-pattern-3 var-pattern-7 var-pattern-0 var-variable-0 $.
FOO-symbol-259-substitution.3 $e #Substitution var-pattern-4 var-pattern-8 var-pattern-0 var-variable-0 $.
FOO-symbol-259-substitution $a #Substitution ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 var-pattern-4 ) ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int var-pattern-5 var-pattern-6 var-pattern-7 var-pattern-8 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String(SortString{}, SortString{}, SortString{}): SortString{} $)
$c LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String $.
FOO-symbol-260-pattern $a #Pattern ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-260-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-260-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-260-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-260-substitution $a #Substitution ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String(SortString{}, SortString{}, SortString{}): SortString{} $)
$c LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String $.
FOO-symbol-261-pattern $a #Pattern ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-261-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-261-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-261-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-261-substitution $a #Substitution ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int(SortString{}, SortString{}, SortInt{}): SortInt{} $)
$c LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int $.
FOO-symbol-262-pattern $a #Pattern ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-262-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-262-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-262-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-262-substitution $a #Substitution ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int(SortString{}, SortString{}, SortInt{}): SortInt{} $)
$c LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int $.
FOO-symbol-263-pattern $a #Pattern ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-263-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-263-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-263-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-263-substitution $a #Substitution ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int(SortInt{}, SortInt{}, SortInt{}): SortInt{} $)
$c LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int $.
FOO-symbol-264-pattern $a #Pattern ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-264-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-264-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-264-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-264-substitution $a #Substitution ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List(SortList{}): SortInt{} $)
$c Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List $.
FOO-symbol-265-pattern $a #Pattern ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List var-pattern-1 ) $.
${
FOO-symbol-265-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-265-substitution $a #Substitution ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List var-pattern-1 ) ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map(SortMap{}): SortInt{} $)
$c Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map $.
FOO-symbol-266-pattern $a #Pattern ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map var-pattern-1 ) $.
${
FOO-symbol-266-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-266-substitution $a #Substitution ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map var-pattern-1 ) ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set(SortSet{}): SortInt{} $)
$c Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set $.
FOO-symbol-267-pattern $a #Pattern ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set var-pattern-1 ) $.
${
FOO-symbol-267-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-267-substitution $a #Substitution ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set var-pattern-1 ) ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblsrandInt'LParUndsRParUnds'INT'Unds'K'Unds'Int(SortInt{}): SortK{} $)
$c LblsrandInt'LParUndsRParUnds'INT'Unds'K'Unds'Int $.
FOO-symbol-268-pattern $a #Pattern ( LblsrandInt'LParUndsRParUnds'INT'Unds'K'Unds'Int var-pattern-1 ) $.
${
FOO-symbol-268-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-268-substitution $a #Substitution ( LblsrandInt'LParUndsRParUnds'INT'Unds'K'Unds'Int var-pattern-1 ) ( LblsrandInt'LParUndsRParUnds'INT'Unds'K'Unds'Int var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int(SortString{}, SortInt{}, SortInt{}): SortString{} $)
$c LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int $.
FOO-symbol-269-pattern $a #Pattern ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-269-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-269-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-269-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-269-substitution $a #Substitution ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblupdateList'LParUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'List(SortList{}, SortInt{}, SortList{}): SortList{} $)
$c LblupdateList'LParUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'List $.
FOO-symbol-270-pattern $a #Pattern ( LblupdateList'LParUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'List var-pattern-1 var-pattern-2 var-pattern-3 ) $.
${
FOO-symbol-270-substitution.0 $e #Substitution var-pattern-1 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-270-substitution.1 $e #Substitution var-pattern-2 var-pattern-5 var-pattern-0 var-variable-0 $.
FOO-symbol-270-substitution.2 $e #Substitution var-pattern-3 var-pattern-6 var-pattern-0 var-variable-0 $.
FOO-symbol-270-substitution $a #Substitution ( LblupdateList'LParUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'List var-pattern-1 var-pattern-2 var-pattern-3 ) ( LblupdateList'LParUndsCommUndsCommUndsRParUnds'LIST'Unds'List'Unds'List'Unds'Int'Unds'List var-pattern-4 var-pattern-5 var-pattern-6 ) var-pattern-0 var-variable-0 $.
$}

$( symbol LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map(SortMap{}, SortMap{}): SortMap{} $)
$c LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map $.
FOO-symbol-271-pattern $a #Pattern ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) $.
${
FOO-symbol-271-substitution.0 $e #Substitution var-pattern-1 var-pattern-3 var-pattern-0 var-variable-0 $.
FOO-symbol-271-substitution.1 $e #Substitution var-pattern-2 var-pattern-4 var-pattern-0 var-variable-0 $.
FOO-symbol-271-substitution $a #Substitution ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-1 var-pattern-2 ) ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map var-pattern-3 var-pattern-4 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lblvalues'LParUndsRParUnds'MAP'Unds'List'Unds'Map(SortMap{}): SortList{} $)
$c Lblvalues'LParUndsRParUnds'MAP'Unds'List'Unds'Map $.
FOO-symbol-272-pattern $a #Pattern ( Lblvalues'LParUndsRParUnds'MAP'Unds'List'Unds'Map var-pattern-1 ) $.
${
FOO-symbol-272-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-272-substitution $a #Substitution ( Lblvalues'LParUndsRParUnds'MAP'Unds'List'Unds'Map var-pattern-1 ) ( Lblvalues'LParUndsRParUnds'MAP'Unds'List'Unds'Map var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( symbol Lbl'Tild'Int'Unds'(SortInt{}): SortInt{} $)
$c Lbl'Tild'Int'Unds' $.
FOO-symbol-273-pattern $a #Pattern ( Lbl'Tild'Int'Unds' var-pattern-1 ) $.
${
FOO-symbol-273-substitution.0 $e #Substitution var-pattern-1 var-pattern-2 var-pattern-0 var-variable-0 $.
FOO-symbol-273-substitution $a #Substitution ( Lbl'Tild'Int'Unds' var-pattern-1 ) ( Lbl'Tild'Int'Unds' var-pattern-2 ) var-pattern-0 var-variable-0 $.
$}

$( adding 1 new metavariables $)
$v From $.
variable-14-type $f #ElementVariable From $.
$d K2 K1 Val R From $.

$( axiom {R} \forall{}(From:SortCell{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortCell{}, SortKItem{}}(From:SortCell{})))) $)
FOO-axiom-0 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortCell SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortIOString{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortIOString{}, SortKItem{}}(From:SortIOString{})))) $)
FOO-axiom-1 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOString From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOString SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortString{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortString{}, SortKItem{}}(From:SortString{})))) $)
FOO-axiom-2 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortString SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortKCellOpt{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortKCellOpt{}, SortKItem{}}(From:SortKCellOpt{})))) $)
FOO-axiom-3 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCellOpt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortKCellOpt SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortGeneratedCounterCellOpt{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortGeneratedCounterCellOpt{}, SortKItem{}}(From:SortGeneratedCounterCellOpt{})))) $)
FOO-axiom-4 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedCounterCellOpt SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortGeneratedCounterCell{}, \exists{R}(Val:SortGeneratedCounterCellOpt{}, \equals{SortGeneratedCounterCellOpt{}, R}(Val:SortGeneratedCounterCellOpt{}, inj{SortGeneratedCounterCell{}, SortGeneratedCounterCellOpt{}}(From:SortGeneratedCounterCell{})))) $)
FOO-axiom-5 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell From ( \kore-exists SortGeneratedCounterCellOpt Val ( \kore-equals SortGeneratedCounterCellOpt R Val ( inj SortGeneratedCounterCell SortGeneratedCounterCellOpt From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortKCell{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortKCell{}, SortKItem{}}(From:SortKCell{})))) $)
FOO-axiom-6 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortKCell SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortIOError{}, \exists{R}(Val:SortIOInt{}, \equals{SortIOInt{}, R}(Val:SortIOInt{}, inj{SortIOError{}, SortIOInt{}}(From:SortIOError{})))) $)
FOO-axiom-7 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortIOInt Val ( \kore-equals SortIOInt R Val ( inj SortIOError SortIOInt From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortKCell{}, \exists{R}(Val:SortKCellOpt{}, \equals{SortKCellOpt{}, R}(Val:SortKCellOpt{}, inj{SortKCell{}, SortKCellOpt{}}(From:SortKCell{})))) $)
FOO-axiom-8 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell From ( \kore-exists SortKCellOpt Val ( \kore-equals SortKCellOpt R Val ( inj SortKCell SortKCellOpt From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortSet{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortSet{}, SortKItem{}}(From:SortSet{})))) $)
FOO-axiom-9 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortSet SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortIOError{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortIOError{}, SortKItem{}}(From:SortIOError{})))) $)
FOO-axiom-10 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOError SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortGeneratedCounterCell{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortGeneratedCounterCell{}, SortKItem{}}(From:SortGeneratedCounterCell{})))) $)
FOO-axiom-11 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedCounterCell SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortInt{}, \exists{R}(Val:SortIOInt{}, \equals{SortIOInt{}, R}(Val:SortIOInt{}, inj{SortInt{}, SortIOInt{}}(From:SortInt{})))) $)
FOO-axiom-12 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt From ( \kore-exists SortIOInt Val ( \kore-equals SortIOInt R Val ( inj SortInt SortIOInt From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortFoo{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortFoo{}, SortKItem{}}(From:SortFoo{})))) $)
FOO-axiom-13 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortFoo SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortStream{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortStream{}, SortKItem{}}(From:SortStream{})))) $)
FOO-axiom-14 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortStream From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortStream SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortIOFile{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortIOFile{}, SortKItem{}}(From:SortIOFile{})))) $)
FOO-axiom-15 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOFile From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOFile SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortGeneratedTopCell{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortGeneratedTopCell{}, SortKItem{}}(From:SortGeneratedTopCell{})))) $)
FOO-axiom-16 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCell From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedTopCell SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortIOInt{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortIOInt{}, SortKItem{}}(From:SortIOInt{})))) $)
FOO-axiom-17 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOInt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortIOInt SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortList{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortList{}, SortKItem{}}(From:SortList{})))) $)
FOO-axiom-18 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortList SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortString{}, \exists{R}(Val:SortIOString{}, \equals{SortIOString{}, R}(Val:SortIOString{}, inj{SortString{}, SortIOString{}}(From:SortString{})))) $)
FOO-axiom-19 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString From ( \kore-exists SortIOString Val ( \kore-equals SortIOString R Val ( inj SortString SortIOString From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortId{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortId{}, SortKItem{}}(From:SortId{})))) $)
FOO-axiom-20 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortId SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortFloat{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortFloat{}, SortKItem{}}(From:SortFloat{})))) $)
FOO-axiom-21 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortFloat SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortBool{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortBool{}, SortKItem{}}(From:SortBool{})))) $)
FOO-axiom-22 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortBool SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortKCell{}, \exists{R}(Val:SortCell{}, \equals{SortCell{}, R}(Val:SortCell{}, inj{SortKCell{}, SortCell{}}(From:SortKCell{})))) $)
FOO-axiom-23 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell From ( \kore-exists SortCell Val ( \kore-equals SortCell R Val ( inj SortKCell SortCell From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortInt{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortInt{}, SortKItem{}}(From:SortInt{})))) $)
FOO-axiom-24 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortInt SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortGeneratedTopCellFragment{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortGeneratedTopCellFragment{}, SortKItem{}}(From:SortGeneratedTopCellFragment{})))) $)
FOO-axiom-25 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCellFragment From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortGeneratedTopCellFragment SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortMap{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, inj{SortMap{}, SortKItem{}}(From:SortMap{})))) $)
FOO-axiom-26 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap From ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( inj SortMap SortKItem From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortIOError{}, \exists{R}(Val:SortIOString{}, \equals{SortIOString{}, R}(Val:SortIOString{}, inj{SortIOError{}, SortIOString{}}(From:SortIOError{})))) $)
FOO-axiom-27 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortIOString Val ( \kore-equals SortIOString R Val ( inj SortIOError SortIOString From ) ) ) ) ) $.

$( axiom {R} \forall{}(From:SortIOError{}, \exists{R}(Val:SortIOFile{}, \equals{SortIOFile{}, R}(Val:SortIOFile{}, inj{SortIOError{}, SortIOFile{}}(From:SortIOError{})))) $)
FOO-axiom-28 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError From ( \kore-exists SortIOFile Val ( \kore-equals SortIOFile R Val ( inj SortIOError SortIOFile From ) ) ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'E2BIG{}())) $)
FOO-axiom-29 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'E2BIG ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EACCES{}())) $)
FOO-axiom-99 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EACCES ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EADDRINUSE{}())) $)
FOO-axiom-168 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EADDRINUSE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EADDRNOTAVAIL{}())) $)
FOO-axiom-236 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EADDRNOTAVAIL ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EAFNOSUPPORT{}())) $)
FOO-axiom-303 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EAFNOSUPPORT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EAGAIN{}())) $)
FOO-axiom-369 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EAGAIN ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EALREADY{}())) $)
FOO-axiom-434 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EALREADY ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EBADF{}())) $)
FOO-axiom-498 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EBADF ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EBUSY{}())) $)
FOO-axiom-561 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EBUSY ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ECHILD{}())) $)
FOO-axiom-623 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECHILD ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ECONNABORTED{}())) $)
FOO-axiom-684 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECONNABORTED ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ECONNREFUSED{}())) $)
FOO-axiom-744 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECONNREFUSED ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ECONNRESET{}())) $)
FOO-axiom-803 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ECONNRESET ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EDEADLK{}())) $)
FOO-axiom-861 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EDEADLK ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EDESTADDRREQ{}())) $)
FOO-axiom-918 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EDESTADDRREQ ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EDOM{}())) $)
FOO-axiom-974 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EDOM ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EEXIST{}())) $)
FOO-axiom-1029 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EEXIST ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EFAULT{}())) $)
FOO-axiom-1083 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EFAULT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EFBIG{}())) $)
FOO-axiom-1136 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EFBIG ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EHOSTDOWN{}())) $)
FOO-axiom-1188 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EHOSTDOWN ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EHOSTUNREACH{}())) $)
FOO-axiom-1239 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EHOSTUNREACH ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EINPROGRESS{}())) $)
FOO-axiom-1289 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EINPROGRESS ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EINTR{}())) $)
FOO-axiom-1338 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EINTR ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EINVAL{}())) $)
FOO-axiom-1386 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EINVAL ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EIO{}())) $)
FOO-axiom-1433 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EIO ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EISCONN{}())) $)
FOO-axiom-1479 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EISCONN ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EISDIR{}())) $)
FOO-axiom-1524 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EISDIR ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ELOOP{}())) $)
FOO-axiom-1568 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ELOOP ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EMFILE{}())) $)
FOO-axiom-1611 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EMFILE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EMLINK{}())) $)
FOO-axiom-1653 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EMLINK ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EMSGSIZE{}())) $)
FOO-axiom-1694 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EMSGSIZE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENAMETOOLONG{}())) $)
FOO-axiom-1734 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENAMETOOLONG ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENETDOWN{}())) $)
FOO-axiom-1773 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENETDOWN ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENETRESET{}())) $)
FOO-axiom-1811 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENETRESET ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENETUNREACH{}())) $)
FOO-axiom-1848 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENETUNREACH ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENFILE{}())) $)
FOO-axiom-1884 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENFILE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOBUFS{}())) $)
FOO-axiom-1919 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOBUFS ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENODEV{}())) $)
FOO-axiom-1953 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENODEV ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOENT{}())) $)
FOO-axiom-1986 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOENT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOEXEC{}())) $)
FOO-axiom-2018 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOEXEC ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOLCK{}())) $)
FOO-axiom-2049 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOLCK ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOMEM{}())) $)
FOO-axiom-2079 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOMEM ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOPROTOOPT{}())) $)
FOO-axiom-2108 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOPROTOOPT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOSPC{}())) $)
FOO-axiom-2136 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOSPC ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOSYS{}())) $)
FOO-axiom-2163 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOSYS ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOTCONN{}())) $)
FOO-axiom-2189 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTCONN ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOTDIR{}())) $)
FOO-axiom-2214 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTDIR ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOTEMPTY{}())) $)
FOO-axiom-2238 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTEMPTY ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOTSOCK{}())) $)
FOO-axiom-2261 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTSOCK ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENOTTY{}())) $)
FOO-axiom-2283 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENOTTY ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ENXIO{}())) $)
FOO-axiom-2304 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ENXIO ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EOF{}())) $)
FOO-axiom-2324 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EOF ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EOPNOTSUPP{}())) $)
FOO-axiom-2343 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EOPNOTSUPP ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EOVERFLOW{}())) $)
FOO-axiom-2361 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EOVERFLOW ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EPERM{}())) $)
FOO-axiom-2378 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPERM ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EPFNOSUPPORT{}())) $)
FOO-axiom-2394 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPFNOSUPPORT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EPIPE{}())) $)
FOO-axiom-2409 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPIPE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EPROTONOSUPPORT{}())) $)
FOO-axiom-2423 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPROTONOSUPPORT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EPROTOTYPE{}())) $)
FOO-axiom-2436 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EPROTOTYPE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ERANGE{}())) $)
FOO-axiom-2448 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ERANGE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EROFS{}())) $)
FOO-axiom-2459 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EROFS ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ESHUTDOWN{}())) $)
FOO-axiom-2469 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESHUTDOWN ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ESOCKTNOSUPPORT{}())) $)
FOO-axiom-2478 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESOCKTNOSUPPORT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ESPIPE{}())) $)
FOO-axiom-2486 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESPIPE ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ESRCH{}())) $)
FOO-axiom-2493 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ESRCH ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ETIMEDOUT{}())) $)
FOO-axiom-2499 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ETIMEDOUT ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'ETOOMANYREFS{}())) $)
FOO-axiom-2504 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'ETOOMANYREFS ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EWOULDBLOCK{}())) $)
FOO-axiom-2508 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EWOULDBLOCK ) ) ) $.

$( axiom {R} \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'EXDEV{}())) $)
FOO-axiom-2511 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val Lbl'Hash'EXDEV ) ) ) $.

$( adding 1 new metavariables $)
$v K0 $.
variable-15-type $f #ElementVariable K0 $.
$d K2 K1 Val R From K0 $.

$( axiom {R} \forall{}(K0:SortK{}, \exists{R}(Val:SortStream{}, \equals{SortStream{}, R}(Val:SortStream{}, Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K{}(K0:SortK{})))) $)
FOO-axiom-2513 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K0 ( \kore-exists SortStream Val ( \kore-equals SortStream R Val ( Lbl'Hash'buffer'LParUndsRParUnds'K-IO'Unds'Stream'Unds'K K0 ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v SortSort $.
variable-16-type $f #ElementVariable SortSort $.
$d K2 K1 Val R From K0 SortSort $.

$( axiom {R, SortSort} \forall{}(K2:SortSort, \forall{}(K1:SortSort, \forall{}(K0:SortBool{}, \exists{R}(Val:SortSort, \equals{SortSort, R}(Val:SortSort, Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort{SortSort}(K0:SortBool{}, K1:SortSort, K2:SortSort)))))) $)
FOO-axiom-2515 $a |- ( \kore-forall \kore-sort R ( \kore-forall \kore-sort SortSort ( \kore-forall SortSort K2 ( \kore-forall SortSort K1 ( \kore-forall SortBool K0 ( \kore-exists SortSort Val ( \kore-equals SortSort R Val ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortSort K0 K1 K2 ) ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortK{}, \equals{SortK{}, R}(Val:SortK{}, Lbl'Hash'logToFile{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2516 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortK Val ( \kore-equals SortK R Val ( Lbl'Hash'logToFile K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortString{}, \exists{R}(Val:SortK{}, \equals{SortK{}, R}(Val:SortK{}, Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String{}(K0:SortString{})))) $)
FOO-axiom-2517 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K0 ( \kore-exists SortK Val ( \kore-equals SortK R Val ( Lbl'Hash'remove'LParUndsRParUnds'K-IO'Unds'K'Unds'String K0 ) ) ) ) ) $.

$( axiom {R} \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'Hash'stderr'Unds'K-IO'Unds'Int{}())) $)
FOO-axiom-2518 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortInt Val ( \kore-equals SortInt R Val Lbl'Hash'stderr'Unds'K-IO'Unds'Int ) ) ) $.

$( axiom {R} \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'Hash'stdin'Unds'K-IO'Unds'Int{}())) $)
FOO-axiom-2519 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortInt Val ( \kore-equals SortInt R Val Lbl'Hash'stdin'Unds'K-IO'Unds'Int ) ) ) $.

$( axiom {R} \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'Hash'stdout'Unds'K-IO'Unds'Int{}())) $)
FOO-axiom-2520 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortInt Val ( \kore-equals SortInt R Val Lbl'Hash'stdout'Unds'K-IO'Unds'Int ) ) ) $.

$( axiom {R} \forall{}(K2:SortString{}, \forall{}(K1:SortString{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, Lbl'Hash'systemResult{}(K0:SortInt{}, K1:SortString{}, K2:SortString{})))))) $)
FOO-axiom-2521 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K2 ( \kore-forall SortString K1 ( \kore-forall SortInt K0 ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( Lbl'Hash'systemResult K0 K1 K2 ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortIOFile{}, \equals{SortIOFile{}, R}(Val:SortIOFile{}, Lbl'Hash'tempFile{}(K0:SortString{}, K1:SortInt{}))))) $)
FOO-axiom-2523 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortString K0 ( \kore-exists SortIOFile Val ( \kore-equals SortIOFile R Val ( Lbl'Hash'tempFile K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortIOError{}, \equals{SortIOError{}, R}(Val:SortIOError{}, Lbl'Hash'unknownIOError{}(K0:SortInt{})))) $)
FOO-axiom-2525 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortIOError Val ( \kore-equals SortIOError R Val ( Lbl'Hash'unknownIOError K0 ) ) ) ) ) $.

$( axiom {R} \exists{R}(Val:SortList{}, \equals{SortList{}, R}(Val:SortList{}, Lbl'Stop'List{}())) $)
FOO-axiom-2527 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortList Val ( \kore-equals SortList R Val Lbl'Stop'List ) ) ) $.

$( axiom {R} \exists{R}(Val:SortMap{}, \equals{SortMap{}, R}(Val:SortMap{}, Lbl'Stop'Map{}())) $)
FOO-axiom-2528 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortMap Val ( \kore-equals SortMap R Val Lbl'Stop'Map ) ) ) $.

$( axiom {R} \exists{R}(Val:SortSet{}, \equals{SortSet{}, R}(Val:SortSet{}, Lbl'Stop'Set{}())) $)
FOO-axiom-2529 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortSet Val ( \kore-equals SortSet R Val Lbl'Stop'Set ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortGeneratedCounterCell{}, \equals{SortGeneratedCounterCell{}, R}(Val:SortGeneratedCounterCell{}, Lbl'-LT-'generatedCounter'-GT-'{}(K0:SortInt{})))) $)
FOO-axiom-2530 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortGeneratedCounterCell Val ( \kore-equals SortGeneratedCounterCell R Val ( Lbl'-LT-'generatedCounter'-GT-' K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortGeneratedCounterCell{}, \forall{}(K0:SortKCell{}, \exists{R}(Val:SortGeneratedTopCell{}, \equals{SortGeneratedTopCell{}, R}(Val:SortGeneratedTopCell{}, Lbl'-LT-'generatedTop'-GT-'{}(K0:SortKCell{}, K1:SortGeneratedCounterCell{}))))) $)
FOO-axiom-2532 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell K1 ( \kore-forall SortKCell K0 ( \kore-exists SortGeneratedTopCell Val ( \kore-equals SortGeneratedTopCell R Val ( Lbl'-LT-'generatedTop'-GT-' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortGeneratedCounterCellOpt{}, \forall{}(K0:SortKCellOpt{}, \exists{R}(Val:SortGeneratedTopCellFragment{}, \equals{SortGeneratedTopCellFragment{}, R}(Val:SortGeneratedTopCellFragment{}, Lbl'-LT-'generatedTop'-GT-'-fragment{}(K0:SortKCellOpt{}, K1:SortGeneratedCounterCellOpt{}))))) $)
FOO-axiom-2534 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt K1 ( \kore-forall SortKCellOpt K0 ( \kore-exists SortGeneratedTopCellFragment Val ( \kore-equals SortGeneratedTopCellFragment R Val ( Lbl'-LT-'generatedTop'-GT-'-fragment K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortK{}, \exists{R}(Val:SortKCell{}, \equals{SortKCell{}, R}(Val:SortKCell{}, Lbl'-LT-'k'-GT-'{}(K0:SortK{})))) $)
FOO-axiom-2536 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K0 ( \kore-exists SortKCell Val ( \kore-equals SortKCell R Val ( Lbl'-LT-'k'-GT-' K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortFloat{}, \exists{R}(Val:SortString{}, \equals{SortString{}, R}(Val:SortString{}, LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float{}(K0:SortFloat{})))) $)
FOO-axiom-2538 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblFloat2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Float K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortId{}, \exists{R}(Val:SortString{}, \equals{SortString{}, R}(Val:SortString{}, LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id{}(K0:SortId{})))) $)
FOO-axiom-2539 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblId2String'LParUndsRParUnds'ID-COMMON'Unds'String'Unds'Id K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortString{}, \equals{SortString{}, R}(Val:SortString{}, LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int{}(K0:SortInt{})))) $)
FOO-axiom-2540 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortKItem{}, \exists{R}(Val:SortList{}, \equals{SortList{}, R}(Val:SortList{}, LblListItem{}(K0:SortKItem{})))) $)
FOO-axiom-2541 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K0 ( \kore-exists SortList Val ( \kore-equals SortList R Val ( LblListItem K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K2:SortKItem{}, \forall{}(K1:SortKItem{}, \forall{}(K0:SortMap{}, \exists{R}(Val:SortMap{}, \equals{SortMap{}, R}(Val:SortMap{}, LblMap'Coln'update{}(K0:SortMap{}, K1:SortKItem{}, K2:SortKItem{})))))) $)
FOO-axiom-2542 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K2 ( \kore-forall SortKItem K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( LblMap'Coln'update K0 K1 K2 ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortSet{}, \forall{}(K0:SortSet{}, \exists{R}(Val:SortSet{}, \equals{SortSet{}, R}(Val:SortSet{}, LblSet'Coln'difference{}(K0:SortSet{}, K1:SortSet{}))))) $)
FOO-axiom-2543 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( LblSet'Coln'difference K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortSet{}, \forall{}(K0:SortKItem{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, LblSet'Coln'in{}(K0:SortKItem{}, K1:SortSet{}))))) $)
FOO-axiom-2544 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortKItem K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( LblSet'Coln'in K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortKItem{}, \exists{R}(Val:SortSet{}, \equals{SortSet{}, R}(Val:SortSet{}, LblSetItem{}(K0:SortKItem{})))) $)
FOO-axiom-2545 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( LblSetItem K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortString{}, \exists{R}(Val:SortId{}, \equals{SortId{}, R}(Val:SortId{}, LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String{}(K0:SortString{})))) $)
FOO-axiom-2546 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K0 ( \kore-exists SortId Val ( \kore-equals SortId R Val ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'UndsAnd-'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2547 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsAnd-'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'UndsStar'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2548 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsStar'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'UndsPlus'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2549 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsPlus'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortString{}, \equals{SortString{}, R}(Val:SortString{}, Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2550 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'Unds'-Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2551 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'Unds'-Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortMap{}, \forall{}(K0:SortMap{}, \exists{R}(Val:SortMap{}, \equals{SortMap{}, R}(Val:SortMap{}, Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map{}(K0:SortMap{}, K1:SortMap{}))))) $)
FOO-axiom-2552 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( Lbl'Unds'-Map'UndsUnds'MAP'Unds'Map'Unds'Map'Unds'Map K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-LT-Eqls'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2553 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortMap{}, \forall{}(K0:SortMap{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map{}(K0:SortMap{}, K1:SortMap{}))))) $)
FOO-axiom-2554 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortMap K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'Map'UndsUnds'MAP'Unds'Bool'Unds'Map'Unds'Map K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortSet{}, \forall{}(K0:SortSet{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set{}(K0:SortSet{}, K1:SortSet{}))))) $)
FOO-axiom-2555 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'Set'UndsUnds'SET'Unds'Bool'Unds'Set'Unds'Set K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2556 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-LT-'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2557 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2558 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsSlshEqls'Bool'Unds'{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2559 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'Bool'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsSlshEqls'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2560 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortK{}, \forall{}(K0:SortK{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsSlshEqls'K'Unds'{}(K0:SortK{}, K1:SortK{}))))) $)
FOO-axiom-2561 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K1 ( \kore-forall SortK K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'K'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2562 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsEqls'Bool'Unds'{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2563 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'Bool'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsEqls'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2564 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortK{}, \forall{}(K0:SortK{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsEqls'K'Unds'{}(K0:SortK{}, K1:SortK{}))))) $)
FOO-axiom-2565 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK K1 ( \kore-forall SortK K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'K'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2566 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-GT-Eqls'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2567 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-Eqls'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2568 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-GT-'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2569 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2570 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortList{}, \forall{}(K0:SortList{}, \exists{R}(Val:SortList{}, \equals{SortList{}, R}(Val:SortList{}, Lbl'Unds'List'Unds'{}(K0:SortList{}, K1:SortList{}))))) $)
FOO-axiom-2574 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList K1 ( \kore-forall SortList K0 ( \kore-exists SortList Val ( \kore-equals SortList R Val ( Lbl'Unds'List'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortSet{}, \forall{}(K0:SortSet{}, \exists{R}(Val:SortSet{}, \equals{SortSet{}, R}(Val:SortSet{}, Lbl'Unds'Set'Unds'{}(K0:SortSet{}, K1:SortSet{}))))) $)
FOO-axiom-2584 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( Lbl'Unds'Set'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortKItem{}, \forall{}(K0:SortMap{}, \exists{R}(Val:SortMap{}, \equals{SortMap{}, R}(Val:SortMap{}, Lbl'UndsLSqBUnds-LT-'-undef'RSqB'{}(K0:SortMap{}, K1:SortKItem{}))))) $)
FOO-axiom-2585 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( Lbl'UndsLSqBUnds-LT-'-undef'RSqB' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K2:SortKItem{}, \forall{}(K1:SortKItem{}, \forall{}(K0:SortMap{}, \exists{R}(Val:SortKItem{}, \equals{SortKItem{}, R}(Val:SortKItem{}, Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem{}(K0:SortMap{}, K1:SortKItem{}, K2:SortKItem{})))))) $)
FOO-axiom-2586 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K2 ( \kore-forall SortKItem K1 ( \kore-forall SortMap K0 ( \kore-exists SortKItem Val ( \kore-equals SortKItem R Val ( Lbl'UndsLSqBUndsRSqB'orDefault'UndsUnds'MAP'Unds'KItem'Unds'Map'Unds'KItem'Unds'KItem K0 K1 K2 ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'andBool'Unds'{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2587 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'andBool'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'andThenBool'Unds'{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2588 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'andThenBool'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'impliesBool'Unds'{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2589 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'impliesBool'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortList{}, \forall{}(K0:SortKItem{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List{}(K0:SortKItem{}, K1:SortList{}))))) $)
FOO-axiom-2590 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList K1 ( \kore-forall SortKItem K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'in'UndsUnds'LIST'Unds'Bool'Unds'KItem'Unds'List K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortMap{}, \forall{}(K0:SortKItem{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map{}(K0:SortKItem{}, K1:SortMap{}))))) $)
FOO-axiom-2591 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortKItem K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2592 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'orElseBool'Unds'{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2593 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'orElseBool'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortBool{}, \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, Lbl'Unds'xorBool'Unds'{}(K0:SortBool{}, K1:SortBool{}))))) $)
FOO-axiom-2594 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K1 ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( Lbl'Unds'xorBool'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'Unds'xorInt'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2595 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'Unds'xorInt'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortKItem{}, \forall{}(K0:SortKItem{}, \exists{R}(Val:SortMap{}, \equals{SortMap{}, R}(Val:SortMap{}, Lbl'UndsPipe'-'-GT-Unds'{}(K0:SortKItem{}, K1:SortKItem{}))))) $)
FOO-axiom-2596 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem K1 ( \kore-forall SortKItem K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( Lbl'UndsPipe'-'-GT-Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'UndsPipe'Int'Unds'{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2597 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'UndsPipe'Int'Unds' K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortSet{}, \forall{}(K0:SortSet{}, \exists{R}(Val:SortSet{}, \equals{SortSet{}, R}(Val:SortSet{}, Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set{}(K0:SortSet{}, K1:SortSet{}))))) $)
FOO-axiom-2598 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int{}(K0:SortInt{})))) $)
FOO-axiom-2599 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortFoo{}, \forall{}(K0:SortFoo{}, \exists{R}(Val:SortFoo{}, \equals{SortFoo{}, R}(Val:SortFoo{}, Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo{}(K0:SortFoo{}, K1:SortFoo{}))))) $)
FOO-axiom-2600 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo K1 ( \kore-forall SortFoo K0 ( \kore-exists SortFoo Val ( \kore-equals SortFoo R Val ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}))))) $)
FOO-axiom-2604 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortFoo{}, \equals{SortFoo{}, R}(Val:SortFoo{}, Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int{}(K0:SortInt{})))) $)
FOO-axiom-2605 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortFoo Val ( \kore-equals SortFoo R Val ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortId{}, \equals{SortId{}, R}(Val:SortId{}, LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int{}(K0:SortInt{})))) $)
FOO-axiom-2608 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortId Val ( \kore-equals SortId R Val ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int{}(K0:SortInt{})))) $)
FOO-axiom-2609 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortFoo{}, \exists{R}(Val:SortFoo{}, \equals{SortFoo{}, R}(Val:SortFoo{}, Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo{}(K0:SortFoo{})))) $)
FOO-axiom-2610 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo K0 ( \kore-exists SortFoo Val ( \kore-equals SortFoo R Val ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortSet{}, \forall{}(K0:SortSet{}, \exists{R}(Val:SortSet{}, \equals{SortSet{}, R}(Val:SortSet{}, LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set{}(K0:SortSet{}, K1:SortSet{}))))) $)
FOO-axiom-2612 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortSet K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( LblintersectSet'LParUndsCommUndsRParUnds'SET'Unds'Set'Unds'Set'Unds'Set K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortMap{}, \exists{R}(Val:SortSet{}, \equals{SortSet{}, R}(Val:SortSet{}, Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map{}(K0:SortMap{})))) $)
FOO-axiom-2613 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K0 ( \kore-exists SortSet Val ( \kore-equals SortSet R Val ( Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortString{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(K0:SortString{})))) $)
FOO-axiom-2614 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2615 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortInt{}, \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int{}(K0:SortInt{}, K1:SortInt{}))))) $)
FOO-axiom-2616 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K1 ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \exists{R}(Val:SortGeneratedCounterCellOpt{}, \equals{SortGeneratedCounterCellOpt{}, R}(Val:SortGeneratedCounterCellOpt{}, LblnoGeneratedCounterCell{}())) $)
FOO-axiom-2617 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortGeneratedCounterCellOpt Val ( \kore-equals SortGeneratedCounterCellOpt R Val LblnoGeneratedCounterCell ) ) ) $.

$( axiom {R} \exists{R}(Val:SortKCellOpt{}, \equals{SortKCellOpt{}, R}(Val:SortKCellOpt{}, LblnoKCell{}())) $)
FOO-axiom-2618 $a |- ( \kore-forall \kore-sort R ( \kore-exists SortKCellOpt Val ( \kore-equals SortKCellOpt R Val LblnoKCell ) ) ) $.

$( axiom {R} \forall{}(K0:SortBool{}, \exists{R}(Val:SortBool{}, \equals{SortBool{}, R}(Val:SortBool{}, LblnotBool'Unds'{}(K0:SortBool{})))) $)
FOO-axiom-2619 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool K0 ( \kore-exists SortBool Val ( \kore-equals SortBool R Val ( LblnotBool'Unds' K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortSet{}, \forall{}(K0:SortMap{}, \exists{R}(Val:SortMap{}, \equals{SortMap{}, R}(Val:SortMap{}, LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set{}(K0:SortMap{}, K1:SortSet{}))))) $)
FOO-axiom-2620 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( LblremoveAll'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Set K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K2:SortString{}, \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortString{}, \equals{SortString{}, R}(Val:SortString{}, LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}, K2:SortString{})))))) $)
FOO-axiom-2621 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K2 ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String K0 K1 K2 ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K2:SortString{}, \forall{}(K1:SortString{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortString{}, \equals{SortString{}, R}(Val:SortString{}, LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String{}(K0:SortString{}, K1:SortString{}, K2:SortString{})))))) $)
FOO-axiom-2622 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString K2 ( \kore-forall SortString K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String K0 K1 K2 ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortList{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List{}(K0:SortList{})))) $)
FOO-axiom-2623 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lblsize'LParUndsRParUnds'LIST'Unds'Int'Unds'List K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortMap{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map{}(K0:SortMap{})))) $)
FOO-axiom-2624 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lblsize'LParUndsRParUnds'MAP'Unds'Int'Unds'Map K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortSet{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set{}(K0:SortSet{})))) $)
FOO-axiom-2625 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lblsize'LParUndsRParUnds'SET'Unds'Int'Unds'Set K0 ) ) ) ) ) $.

$( axiom {R} \forall{}(K2:SortInt{}, \forall{}(K1:SortInt{}, \forall{}(K0:SortString{}, \exists{R}(Val:SortString{}, \equals{SortString{}, R}(Val:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(K0:SortString{}, K1:SortInt{}, K2:SortInt{})))))) $)
FOO-axiom-2626 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K2 ( \kore-forall SortInt K1 ( \kore-forall SortString K0 ( \kore-exists SortString Val ( \kore-equals SortString R Val ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int K0 K1 K2 ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K1:SortMap{}, \forall{}(K0:SortMap{}, \exists{R}(Val:SortMap{}, \equals{SortMap{}, R}(Val:SortMap{}, LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map{}(K0:SortMap{}, K1:SortMap{}))))) $)
FOO-axiom-2627 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap K1 ( \kore-forall SortMap K0 ( \kore-exists SortMap Val ( \kore-equals SortMap R Val ( LblupdateMap'LParUndsCommUndsRParUnds'MAP'Unds'Map'Unds'Map'Unds'Map K0 K1 ) ) ) ) ) ) $.

$( axiom {R} \forall{}(K0:SortInt{}, \exists{R}(Val:SortInt{}, \equals{SortInt{}, R}(Val:SortInt{}, Lbl'Tild'Int'Unds'{}(K0:SortInt{})))) $)
FOO-axiom-2628 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt K0 ( \kore-exists SortInt Val ( \kore-equals SortInt R Val ( Lbl'Tild'Int'Unds' K0 ) ) ) ) ) $.

$( adding 3 new metavariables $)
$v Var'Unds'0 VarB1 VarC $.
variable-17-type $f #ElementVariable Var'Unds'0 $.
variable-18-type $f #ElementVariable VarB1 $.
variable-19-type $f #ElementVariable VarC $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC $.

$( domain value "true" of sort SortBool{} $)
$c "true" $.
domain-value-0-pattern $a #Pattern "true" $.
${
domain-value-0-substitution $a #Substitution "true" "true" var-pattern-0 var-variable-0 $.
$}

$( adding 2 new metavariables $)
$v var-elementvariable-0 var-elementvariable-1 $.
variable-20-type $f #ElementVariable var-elementvariable-0 $.
variable-21-type $f #ElementVariable var-elementvariable-1 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 $.
domain-value-0-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortBool var-elementvariable-1 ( \kore-equals SortBool var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortBool "true" ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortK{}, \forall{}(VarB1:SortK{}, \forall{}(VarC:SortBool{}, \implies{R}(\equals{SortBool{}, R}(VarC:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortK{}, R}(Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort{SortK{}}(VarC:SortBool{}, VarB1:SortK{}, Var'Unds'0:SortK{}), VarB1:SortK{}), \top{R}()))))) $)
FOO-axiom-2653 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK Var'Unds'0 ( \kore-forall SortK VarB1 ( \kore-forall SortBool VarC ( \kore-implies R ( \kore-equals SortBool R VarC ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortK R ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortK VarC VarB1 Var'Unds'0 ) VarB1 ) ( \kore-top R ) ) ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarB2 $.
variable-22-type $f #ElementVariable VarB2 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 $.

$( axiom {R} \forall{}(VarB2:SortK{}, \forall{}(Var'Unds'0:SortK{}, \forall{}(VarC:SortBool{}, \implies{R}(\equals{SortBool{}, R}(LblnotBool'Unds'{}(VarC:SortBool{}), \dv{SortBool{}}("true")), \and{R}(\equals{SortK{}, R}(Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort{SortK{}}(VarC:SortBool{}, Var'Unds'0:SortK{}, VarB2:SortK{}), VarB2:SortK{}), \top{R}()))))) $)
FOO-axiom-2654 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarB2 ( \kore-forall SortK Var'Unds'0 ( \kore-forall SortBool VarC ( \kore-implies R ( \kore-equals SortBool R ( LblnotBool'Unds' VarC ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortK R ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortK VarC Var'Unds'0 VarB2 ) VarB2 ) ( \kore-top R ) ) ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarS $.
variable-23-type $f #ElementVariable VarS $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS $.

$( domain value "r+" of sort SortString{} $)
$c "r%2B" $.
domain-value-1-pattern $a #Pattern "r%2B" $.
${
domain-value-1-substitution $a #Substitution "r%2B" "r%2B" var-pattern-0 var-variable-0 $.
$}
domain-value-1-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortString var-elementvariable-1 ( \kore-equals SortString var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortString "r%2B" ) ) ) ) $.

$( axiom {R} \forall{}(VarS:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortIOInt{}, R}(Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String{}(VarS:SortString{}), Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String{}(VarS:SortString{}, \dv{SortString{}}("r+"))), \top{R}()))) $)
FOO-axiom-2655 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOInt R ( Lbl'Hash'open'LParUndsRParUnds'K-IO'Unds'IOInt'Unds'String VarS ) ( Lbl'Hash'open'LParUndsCommUndsRParUnds'K-IO'Unds'IOInt'Unds'String'Unds'String VarS ( \kore-dv SortString "r%2B" ) ) ) ( \kore-top R ) ) ) ) ) $.

$( domain value "2" of sort SortInt{} $)
$c "2" $.
domain-value-2-pattern $a #Pattern "2" $.
${
domain-value-2-substitution $a #Substitution "2" "2" var-pattern-0 var-variable-0 $.
$}
domain-value-2-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "2" ) ) ) ) $.

$( axiom {R} \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(Lbl'Hash'stderr'Unds'K-IO'Unds'Int{}(), \dv{SortInt{}}("2")), \top{R}())) $)
FOO-axiom-2656 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R Lbl'Hash'stderr'Unds'K-IO'Unds'Int ( \kore-dv SortInt "2" ) ) ( \kore-top R ) ) ) ) $.

$( domain value "0" of sort SortInt{} $)
$c "0" $.
domain-value-3-pattern $a #Pattern "0" $.
${
domain-value-3-substitution $a #Substitution "0" "0" var-pattern-0 var-variable-0 $.
$}
domain-value-3-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "0" ) ) ) ) $.

$( axiom {R} \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(Lbl'Hash'stdin'Unds'K-IO'Unds'Int{}(), \dv{SortInt{}}("0")), \top{R}())) $)
FOO-axiom-2657 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R Lbl'Hash'stdin'Unds'K-IO'Unds'Int ( \kore-dv SortInt "0" ) ) ( \kore-top R ) ) ) ) $.

$( domain value "1" of sort SortInt{} $)
$c "1" $.
domain-value-4-pattern $a #Pattern "1" $.
${
domain-value-4-substitution $a #Substitution "1" "1" var-pattern-0 var-variable-0 $.
$}
domain-value-4-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "1" ) ) ) ) $.

$( axiom {R} \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(Lbl'Hash'stdout'Unds'K-IO'Unds'Int{}(), \dv{SortInt{}}("1")), \top{R}())) $)
FOO-axiom-2658 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R Lbl'Hash'stdout'Unds'K-IO'Unds'Int ( \kore-dv SortInt "1" ) ) ( \kore-top R ) ) ) ) $.

$( adding 4 new metavariables $)
$v Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX $.
variable-24-type $f #ElementVariable Var'Unds'DotVar0 $.
variable-25-type $f #ElementVariable Var'Unds'DotVar1 $.
variable-26-type $f #ElementVariable VarY $.
variable-27-type $f #ElementVariable VarX $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX $.

$( axiom {} \forall{}(Var'Unds'DotVar0:SortGeneratedCounterCell{}, \forall{}(Var'Unds'DotVar1:SortK{}, \forall{}(VarY:SortFoo{}, \forall{}(VarX:SortFoo{}, \rewrites{SortGeneratedTopCell{}}(\and{SortGeneratedTopCell{}}(\top{SortGeneratedTopCell{}}(), Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo{}(VarX:SortFoo{}, VarY:SortFoo{})), Var'Unds'DotVar1:SortK{})), Var'Unds'DotVar0:SortGeneratedCounterCell{})), \and{SortGeneratedTopCell{}}(\top{SortGeneratedTopCell{}}(), Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(VarX:SortFoo{}), Var'Unds'DotVar1:SortK{})), Var'Unds'DotVar0:SortGeneratedCounterCell{}))))))) $)
FOO-axiom-2659 $a |- ( \kore-forall SortGeneratedCounterCell Var'Unds'DotVar0 ( \kore-forall SortK Var'Unds'DotVar1 ( \kore-forall SortFoo VarY ( \kore-forall SortFoo VarX ( \kore-rewrites SortGeneratedTopCell ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo VarX VarY ) ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem VarX ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ) ) ) ) ) $.

$( axiom {} \forall{}(Var'Unds'DotVar0:SortGeneratedCounterCell{}, \forall{}(Var'Unds'DotVar1:SortK{}, \forall{}(VarX:SortFoo{}, \rewrites{SortGeneratedTopCell{}}(\and{SortGeneratedTopCell{}}(\top{SortGeneratedTopCell{}}(), Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo{}(VarX:SortFoo{})), Var'Unds'DotVar1:SortK{})), Var'Unds'DotVar0:SortGeneratedCounterCell{})), \and{SortGeneratedTopCell{}}(\top{SortGeneratedTopCell{}}(), Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(VarX:SortFoo{}), Var'Unds'DotVar1:SortK{})), Var'Unds'DotVar0:SortGeneratedCounterCell{})))))) $)
FOO-axiom-2660 $a |- ( \kore-forall SortGeneratedCounterCell Var'Unds'DotVar0 ( \kore-forall SortK Var'Unds'DotVar1 ( \kore-forall SortFoo VarX ( \kore-rewrites SortGeneratedTopCell ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo VarX ) ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ( \kore-and SortGeneratedTopCell ( \kore-top SortGeneratedTopCell ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem VarX ) Var'Unds'DotVar1 ) ) Var'Unds'DotVar0 ) ) ) ) ) ) $.

$( adding 2 new metavariables $)
$v VarS2 VarS1 $.
variable-28-type $f #ElementVariable VarS2 $.
variable-29-type $f #ElementVariable VarS1 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 $.

$( axiom {R} \forall{}(VarS2:SortString{}, \forall{}(VarS1:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS1:SortString{}, VarS2:SortString{}), LblnotBool'Unds'{}(Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS2:SortString{}, VarS1:SortString{}))), \top{R}())))) $)
FOO-axiom-2661 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds-LT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( LblnotBool'Unds' ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 VarS1 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB2:SortBool{}, \forall{}(VarB1:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'Bool'Unds'{}(VarB1:SortBool{}, VarB2:SortBool{}), LblnotBool'Unds'{}(Lbl'UndsEqlsEqls'Bool'Unds'{}(VarB1:SortBool{}, VarB2:SortBool{}))), \top{R}())))) $)
FOO-axiom-2662 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB2 ( \kore-forall SortBool VarB1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Bool'Unds' VarB1 VarB2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'Bool'Unds' VarB1 VarB2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( adding 2 new metavariables $)
$v VarI2 VarI1 $.
variable-30-type $f #ElementVariable VarI2 $.
variable-31-type $f #ElementVariable VarI1 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 $.

$( axiom {R} \forall{}(VarI2:SortInt{}, \forall{}(VarI1:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'Int'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{}), LblnotBool'Unds'{}(Lbl'UndsEqlsEqls'Int'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{}))), \top{R}())))) $)
FOO-axiom-2663 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Int'Unds' VarI1 VarI2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'Int'Unds' VarI1 VarI2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( adding 2 new metavariables $)
$v VarK2 VarK1 $.
variable-32-type $f #ElementVariable VarK2 $.
variable-33-type $f #ElementVariable VarK1 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 $.

$( axiom {R} \forall{}(VarK2:SortK{}, \forall{}(VarK1:SortK{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'K'Unds'{}(VarK1:SortK{}, VarK2:SortK{}), LblnotBool'Unds'{}(Lbl'UndsEqlsEqls'K'Unds'{}(VarK1:SortK{}, VarK2:SortK{}))), \top{R}())))) $)
FOO-axiom-2664 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK2 ( \kore-forall SortK VarK1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'K'Unds' VarK1 VarK2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'K'Unds' VarK1 VarK2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarS2:SortString{}, \forall{}(VarS1:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS1:SortString{}, VarS2:SortString{}), LblnotBool'Unds'{}(Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS1:SortString{}, VarS2:SortString{}))), \top{R}())))) $)
FOO-axiom-2665 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( LblnotBool'Unds' ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI2:SortInt{}, \forall{}(VarI1:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsEqls'K'Unds'{}(kseq{}(inj{SortInt{}, SortKItem{}}(VarI1:SortInt{}), dotk{}()), kseq{}(inj{SortInt{}, SortKItem{}}(VarI2:SortInt{}), dotk{}())), Lbl'UndsEqlsEqls'Int'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{})), \top{R}())))) $)
FOO-axiom-2666 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsEqls'K'Unds' ( kseq ( inj SortInt SortKItem VarI1 ) dotk ) ( kseq ( inj SortInt SortKItem VarI2 ) dotk ) ) ( Lbl'UndsEqlsEqls'Int'Unds' VarI1 VarI2 ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK2:SortBool{}, \forall{}(VarK1:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsEqls'K'Unds'{}(kseq{}(inj{SortBool{}, SortKItem{}}(VarK1:SortBool{}), dotk{}()), kseq{}(inj{SortBool{}, SortKItem{}}(VarK2:SortBool{}), dotk{}())), Lbl'UndsEqlsEqls'Bool'Unds'{}(VarK1:SortBool{}, VarK2:SortBool{})), \top{R}())))) $)
FOO-axiom-2667 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK2 ( \kore-forall SortBool VarK1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsEqls'K'Unds' ( kseq ( inj SortBool SortKItem VarK1 ) dotk ) ( kseq ( inj SortBool SortKItem VarK2 ) dotk ) ) ( Lbl'UndsEqlsEqls'Bool'Unds' VarK1 VarK2 ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarS2:SortString{}, \forall{}(VarS1:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsEqls'K'Unds'{}(kseq{}(inj{SortString{}, SortKItem{}}(VarS1:SortString{}), dotk{}()), kseq{}(inj{SortString{}, SortKItem{}}(VarS2:SortString{}), dotk{}())), Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS1:SortString{}, VarS2:SortString{})), \top{R}())))) $)
FOO-axiom-2668 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'UndsEqlsEqls'K'Unds' ( kseq ( inj SortString SortKItem VarS1 ) dotk ) ( kseq ( inj SortString SortKItem VarS2 ) dotk ) ) ( Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarS2:SortString{}, \forall{}(VarS1:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS1:SortString{}, VarS2:SortString{}), LblnotBool'Unds'{}(Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS1:SortString{}, VarS2:SortString{}))), \top{R}())))) $)
FOO-axiom-2669 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( LblnotBool'Unds' ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarS2:SortString{}, \forall{}(VarS1:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS1:SortString{}, VarS2:SortString{}), Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS2:SortString{}, VarS1:SortString{})), \top{R}())))) $)
FOO-axiom-2670 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarS2 ( \kore-forall SortString VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds-GT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS1 VarS2 ) ( Lbl'Unds-LT-'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 VarS1 ) ) ( \kore-top R ) ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v Var'Unds'1 $.
variable-34-type $f #ElementVariable Var'Unds'1 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 $.

$( domain value "false" of sort SortBool{} $)
$c "false" $.
domain-value-5-pattern $a #Pattern "false" $.
${
domain-value-5-substitution $a #Substitution "false" "false" var-pattern-0 var-variable-0 $.
$}
domain-value-5-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortBool var-elementvariable-1 ( \kore-equals SortBool var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortBool "false" ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \forall{}(Var'Unds'1:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andBool'Unds'{}(\and{SortBool{}}(\dv{SortBool{}}("false"), Var'Unds'1:SortBool{}), Var'Unds'0:SortBool{}), Var'Unds'1:SortBool{}), \top{R}())))) $)
FOO-axiom-2671 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarB $.
variable-35-type $f #ElementVariable VarB $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB $.

$( axiom {R} \forall{}(VarB:SortBool{}, \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andBool'Unds'{}(\and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'0:SortBool{}), VarB:SortBool{}), VarB:SortBool{}), \equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2672 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) VarB ) VarB ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andBool'Unds'{}(VarB:SortBool{}, \and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'0:SortBool{})), VarB:SortBool{}), \equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2673 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' VarB ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) ) VarB ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'1:SortBool{}, \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andBool'Unds'{}(Var'Unds'0:SortBool{}, \and{SortBool{}}(\dv{SortBool{}}("false"), Var'Unds'1:SortBool{})), Var'Unds'1:SortBool{}), \top{R}())))) $)
FOO-axiom-2674 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'1 ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \forall{}(Var'Unds'1:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andThenBool'Unds'{}(\and{SortBool{}}(\dv{SortBool{}}("false"), Var'Unds'1:SortBool{}), Var'Unds'0:SortBool{}), Var'Unds'1:SortBool{}), \top{R}())))) $)
FOO-axiom-2675 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarK $.
variable-36-type $f #ElementVariable VarK $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK $.

$( axiom {R} \forall{}(VarK:SortBool{}, \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andThenBool'Unds'{}(\and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'0:SortBool{}), VarK:SortBool{}), VarK:SortBool{}), \equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2676 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) VarK ) VarK ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortBool{}, \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andThenBool'Unds'{}(VarK:SortBool{}, \and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'0:SortBool{})), VarK:SortBool{}), \equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2677 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' VarK ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) ) VarK ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'1:SortBool{}, \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'andThenBool'Unds'{}(Var'Unds'0:SortBool{}, \and{SortBool{}}(\dv{SortBool{}}("false"), Var'Unds'1:SortBool{})), Var'Unds'1:SortBool{}), \top{R}())))) $)
FOO-axiom-2678 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'1 ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'andThenBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "false" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI1:SortInt{}, \forall{}(VarI2:SortInt{}, \implies{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'Int'Unds'{}(VarI2:SortInt{}, \dv{SortInt{}}("0")), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(Lbl'Unds'divInt'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{}), Lbl'UndsSlsh'Int'Unds'{}(Lbl'Unds'-Int'Unds'{}(VarI1:SortInt{}, Lbl'Unds'modInt'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{})), VarI2:SortInt{})), \top{R}())))) $)
FOO-axiom-2679 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI1 ( \kore-forall SortInt VarI2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Int'Unds' VarI2 ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( Lbl'Unds'divInt'Unds' VarI1 VarI2 ) ( Lbl'UndsSlsh'Int'Unds' ( Lbl'Unds'-Int'Unds' VarI1 ( Lbl'Unds'modInt'Unds' VarI1 VarI2 ) ) VarI2 ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI2:SortInt{}, \forall{}(VarI1:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int{}(VarI1:SortInt{}, VarI2:SortInt{}), Lbl'UndsEqlsEqls'Int'Unds'{}(Lbl'UndsPerc'Int'Unds'{}(VarI2:SortInt{}, VarI1:SortInt{}), \dv{SortInt{}}("0"))), \top{R}())))) $)
FOO-axiom-2680 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'dividesInt'UndsUnds'INT-COMMON'Unds'Bool'Unds'Int'Unds'Int VarI1 VarI2 ) ( Lbl'UndsEqlsEqls'Int'Unds' ( Lbl'UndsPerc'Int'Unds' VarI2 VarI1 ) ( \kore-dv SortInt "0" ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'impliesBool'Unds'{}(\and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'0:SortBool{}), VarB:SortBool{}), VarB:SortBool{}), \equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2681 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) VarB ) VarB ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'impliesBool'Unds'{}(VarB:SortBool{}, \dv{SortBool{}}("false")), LblnotBool'Unds'{}(VarB:SortBool{})), \top{R}()))) $)
FOO-axiom-2682 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' VarB ( \kore-dv SortBool "false" ) ) ( LblnotBool'Unds' VarB ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \forall{}(Var'Unds'1:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'impliesBool'Unds'{}(Var'Unds'0:SortBool{}, \and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'1:SortBool{})), Var'Unds'1:SortBool{}), \equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2683 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'impliesBool'Unds'{}(\dv{SortBool{}}("false"), Var'Unds'0:SortBool{}), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2684 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'impliesBool'Unds' ( \kore-dv SortBool "false" ) Var'Unds'0 ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI1:SortInt{}, \forall{}(VarI2:SortInt{}, \implies{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'Int'Unds'{}(VarI2:SortInt{}, \dv{SortInt{}}("0")), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(Lbl'Unds'modInt'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{}), Lbl'UndsPerc'Int'Unds'{}(Lbl'UndsPlus'Int'Unds'{}(Lbl'UndsPerc'Int'Unds'{}(VarI1:SortInt{}, LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int{}(VarI2:SortInt{})), LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int{}(VarI2:SortInt{})), LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int{}(VarI2:SortInt{}))), \top{R}())))) $)
FOO-axiom-2685 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI1 ( \kore-forall SortInt VarI2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'Int'Unds' VarI2 ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( Lbl'Unds'modInt'Unds' VarI1 VarI2 ) ( Lbl'UndsPerc'Int'Unds' ( Lbl'UndsPlus'Int'Unds' ( Lbl'UndsPerc'Int'Unds' VarI1 ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int VarI2 ) ) ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int VarI2 ) ) ( LblabsInt'LParUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int VarI2 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \forall{}(Var'Unds'1:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool{}(\and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'1:SortBool{}), Var'Unds'0:SortBool{}), Var'Unds'1:SortBool{}), \equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2686 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool{}(VarB:SortBool{}, \dv{SortBool{}}("false")), VarB:SortBool{}), \top{R}()))) $)
FOO-axiom-2687 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool VarB ( \kore-dv SortBool "false" ) ) VarB ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \forall{}(Var'Unds'1:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool{}(Var'Unds'0:SortBool{}, \and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'1:SortBool{})), Var'Unds'1:SortBool{}), \equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2688 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool{}(\dv{SortBool{}}("false"), VarB:SortBool{}), VarB:SortBool{}), \top{R}()))) $)
FOO-axiom-2689 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orBool'UndsUnds'BOOL'Unds'Bool'Unds'Bool'Unds'Bool ( \kore-dv SortBool "false" ) VarB ) VarB ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \forall{}(Var'Unds'1:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orElseBool'Unds'{}(\and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'1:SortBool{}), Var'Unds'0:SortBool{}), Var'Unds'1:SortBool{}), \equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2690 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) Var'Unds'0 ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orElseBool'Unds'{}(VarK:SortBool{}, \dv{SortBool{}}("false")), VarK:SortBool{}), \top{R}()))) $)
FOO-axiom-2691 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' VarK ( \kore-dv SortBool "false" ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \forall{}(Var'Unds'1:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orElseBool'Unds'{}(Var'Unds'0:SortBool{}, \and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'1:SortBool{})), Var'Unds'1:SortBool{}), \equals{SortBool{}, R}(Var'Unds'1:SortBool{}, \dv{SortBool{}}("true")))))) $)
FOO-axiom-2692 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-forall SortBool Var'Unds'1 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' Var'Unds'0 ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'1 ) ) Var'Unds'1 ) ( \kore-equals SortBool R Var'Unds'1 ( \kore-dv SortBool "true" ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'orElseBool'Unds'{}(\dv{SortBool{}}("false"), VarK:SortBool{}), VarK:SortBool{}), \top{R}()))) $)
FOO-axiom-2693 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'orElseBool'Unds' ( \kore-dv SortBool "false" ) VarK ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'xorBool'Unds'{}(VarB:SortBool{}, VarB:SortBool{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2694 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'xorBool'Unds' VarB VarB ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'xorBool'Unds'{}(VarB:SortBool{}, \dv{SortBool{}}("false")), VarB:SortBool{}), \top{R}()))) $)
FOO-axiom-2695 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'xorBool'Unds' VarB ( \kore-dv SortBool "false" ) ) VarB ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarB:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lbl'Unds'xorBool'Unds'{}(\dv{SortBool{}}("false"), VarB:SortBool{}), VarB:SortBool{}), \top{R}()))) $)
FOO-axiom-2696 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarB ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lbl'Unds'xorBool'Unds' ( \kore-dv SortBool "false" ) VarB ) VarB ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarS2:SortSet{}, \forall{}(VarS1:SortSet{}, \implies{R}(\top{R}(), \and{R}(\equals{SortSet{}, R}(Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set{}(VarS1:SortSet{}, VarS2:SortSet{}), Lbl'Unds'Set'Unds'{}(VarS1:SortSet{}, LblSet'Coln'difference{}(VarS2:SortSet{}, VarS1:SortSet{}))), \top{R}())))) $)
FOO-axiom-2697 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet VarS2 ( \kore-forall SortSet VarS1 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortSet R ( Lbl'UndsPipe'Set'UndsUnds'SET'Unds'Set'Unds'Set'Unds'Set VarS1 VarS2 ) ( Lbl'Unds'Set'Unds' VarS1 ( LblSet'Coln'difference VarS2 VarS1 ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( adding 3 new metavariables $)
$v VarLEN VarIDX VarI $.
variable-37-type $f #ElementVariable VarLEN $.
variable-38-type $f #ElementVariable VarIDX $.
variable-39-type $f #ElementVariable VarI $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI $.

$( axiom {R} \forall{}(VarLEN:SortInt{}, \forall{}(VarIDX:SortInt{}, \forall{}(VarI:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int{}(VarI:SortInt{}, VarIDX:SortInt{}, VarLEN:SortInt{}), Lbl'Unds'modInt'Unds'{}(Lbl'Unds-GT--GT-'Int'Unds'{}(VarI:SortInt{}, VarIDX:SortInt{}), Lbl'Unds-LT--LT-'Int'Unds'{}(\dv{SortInt{}}("1"), VarLEN:SortInt{}))), \top{R}()))))) $)
FOO-axiom-2698 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarLEN ( \kore-forall SortInt VarIDX ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int VarI VarIDX VarLEN ) ( Lbl'Unds'modInt'Unds' ( Lbl'Unds-GT--GT-'Int'Unds' VarI VarIDX ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) VarLEN ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.

$( adding 2 new metavariables $)
$v VarToCount VarSource $.
variable-40-type $f #ElementVariable VarToCount $.
variable-41-type $f #ElementVariable VarSource $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource $.

$( axiom {R} \forall{}(VarToCount:SortString{}, \forall{}(VarSource:SortString{}, \implies{R}(\equals{SortBool{}, R}(Lbl'Unds-GT-Eqls'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToCount:SortString{}, \dv{SortInt{}}("0")), \dv{SortInt{}}("0")), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String{}(VarSource:SortString{}, VarToCount:SortString{}), Lbl'UndsPlus'Int'Unds'{}(\dv{SortInt{}}("1"), LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String{}(LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarSource:SortString{}, Lbl'UndsPlus'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToCount:SortString{}, \dv{SortInt{}}("0")), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarToCount:SortString{})), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarSource:SortString{})), VarToCount:SortString{}))), \top{R}())))) $)
FOO-axiom-2699 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarToCount ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToCount ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String VarSource VarToCount ) ( Lbl'UndsPlus'Int'Unds' ( \kore-dv SortInt "1" ) ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( Lbl'UndsPlus'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToCount ( \kore-dv SortInt "0" ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarToCount ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarSource ) ) VarToCount ) ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarToCount:SortString{}, \forall{}(VarSource:SortString{}, \implies{R}(\equals{SortBool{}, R}(Lbl'Unds-LT-'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToCount:SortString{}, \dv{SortInt{}}("0")), \dv{SortInt{}}("0")), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String{}(VarSource:SortString{}, VarToCount:SortString{}), \dv{SortInt{}}("0")), \top{R}())))) $)
FOO-axiom-2700 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarToCount ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-LT-'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToCount ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String VarSource VarToCount ) ( \kore-dv SortInt "0" ) ) ( \kore-top R ) ) ) ) ) ) $.

$( domain value "" of sort SortString{} $)
$c "" $.
domain-value-6-pattern $a #Pattern "" $.
${
domain-value-6-substitution $a #Substitution "" "" var-pattern-0 var-variable-0 $.
$}
domain-value-6-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortString var-elementvariable-1 ( \kore-equals SortString var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortString "" ) ) ) ) $.

$( domain value "-1" of sort SortInt{} $)
$c "-1" $.
domain-value-7-pattern $a #Pattern "-1" $.
${
domain-value-7-substitution $a #Substitution "-1" "-1" var-pattern-0 var-variable-0 $.
$}
domain-value-7-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "-1" ) ) ) ) $.

$( axiom {R} \forall{}(VarI:SortInt{}, \forall{}(VarS1:SortString{}, \forall{}(VarS2:SortString{}, \implies{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS2:SortString{}, \dv{SortString{}}("")), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, VarS2:SortString{}, VarI:SortInt{}), Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort{SortInt{}}(Lbl'UndsEqlsEqls'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("0"), \dv{SortInt{}}("1")), VarI:SortInt{}), \dv{SortInt{}}("-1")), LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("1"), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarS2:SortString{})), VarI:SortInt{}), Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort{SortInt{}}(Lbl'UndsEqlsEqls'Int'Unds'{}(LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("1"), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarS2:SortString{})), VarI:SortInt{}), \dv{SortInt{}}("-1")), LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("0"), \dv{SortInt{}}("1")), VarI:SortInt{}), LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("0"), \dv{SortInt{}}("1")), VarI:SortInt{}), LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("1"), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarS2:SortString{})), VarI:SortInt{}))))), \top{R}()))))) $)
FOO-axiom-2701 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-forall SortString VarS1 ( \kore-forall SortString VarS2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 ( \kore-dv SortString "" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 VarS2 VarI ) ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortInt ( Lbl'UndsEqlsEqls'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( \kore-dv SortInt "-1" ) ) ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ( Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort SortInt ( Lbl'UndsEqlsEqls'Int'Unds' ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ( \kore-dv SortInt "-1" ) ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'1:SortInt{}, \forall{}(Var'Unds'0:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(Var'Unds'0:SortString{}, \dv{SortString{}}(""), Var'Unds'1:SortInt{}), \dv{SortInt{}}("-1")), \top{R}())))) $)
FOO-axiom-2702 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt Var'Unds'1 ( \kore-forall SortString Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int Var'Unds'0 ( \kore-dv SortString "" ) Var'Unds'1 ) ( \kore-dv SortInt "-1" ) ) ( \kore-top R ) ) ) ) ) ) $.

$( domain value "_" of sort SortString{} $)
$c "_" $.
domain-value-8-pattern $a #Pattern "_" $.
${
domain-value-8-substitution $a #Substitution "_" "_" var-pattern-0 var-variable-0 $.
$}
domain-value-8-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortString var-elementvariable-1 ( \kore-equals SortString var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortString "_" ) ) ) ) $.

$( axiom {R} \forall{}(VarI:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortId{}, R}(LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int{}(VarI:SortInt{}), LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String{}(Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String{}(\dv{SortString{}}("_"), LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int{}(VarI:SortInt{})))), \top{R}()))) $)
FOO-axiom-2703 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortId R ( LblfreshId'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'Int VarI ) ( LblString2Id'LParUndsRParUnds'ID-COMMON'Unds'Id'Unds'String ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( \kore-dv SortString "_" ) ( LblInt2String'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'Int VarI ) ) ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int{}(VarI:SortInt{}), VarI:SortInt{}), \top{R}()))) $)
FOO-axiom-2704 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblfreshInt'LParUndsRParUnds'INT'Unds'Int'Unds'Int VarI ) VarI ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarCell $.
variable-42-type $f #ElementVariable VarCell $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell $.

$( axiom {R} \forall{}(VarCell:SortGeneratedCounterCell{}, \forall{}(Var'Unds'DotVar0:SortKCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortGeneratedCounterCell{}, R}(LblgetGeneratedCounterCell{}(Lbl'-LT-'generatedTop'-GT-'{}(Var'Unds'DotVar0:SortKCell{}, VarCell:SortGeneratedCounterCell{})), VarCell:SortGeneratedCounterCell{}), \top{R}())))) $)
FOO-axiom-2705 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell VarCell ( \kore-forall SortKCell Var'Unds'DotVar0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCell R ( LblgetGeneratedCounterCell ( Lbl'-LT-'generatedTop'-GT-' Var'Unds'DotVar0 VarCell ) ) VarCell ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \implies{R}(\top{R}(), \and{R}(\equals{SortGeneratedCounterCell{}, R}(LblinitGeneratedCounterCell{}(), Lbl'-LT-'generatedCounter'-GT-'{}(\dv{SortInt{}}("0"))), \top{R}())) $)
FOO-axiom-2706 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCell R LblinitGeneratedCounterCell ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ( \kore-top R ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarInit $.
variable-43-type $f #ElementVariable VarInit $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit $.

$( axiom {R} \forall{}(VarInit:SortMap{}, \implies{R}(\top{R}(), \and{R}(\equals{SortGeneratedTopCell{}, R}(LblinitGeneratedTopCell{}(VarInit:SortMap{}), Lbl'-LT-'generatedTop'-GT-'{}(LblinitKCell{}(VarInit:SortMap{}), LblinitGeneratedCounterCell{}())), \top{R}()))) $)
FOO-axiom-2707 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarInit ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedTopCell R ( LblinitGeneratedTopCell VarInit ) ( Lbl'-LT-'generatedTop'-GT-' ( LblinitKCell VarInit ) LblinitGeneratedCounterCell ) ) ( \kore-top R ) ) ) ) ) $.

$( domain value "$PGM" of sort SortKConfigVar{} $)
$c "%24PGM" $.
domain-value-9-pattern $a #Pattern "%24PGM" $.
${
domain-value-9-substitution $a #Substitution "%24PGM" "%24PGM" var-pattern-0 var-variable-0 $.
$}
domain-value-9-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortKConfigVar var-elementvariable-1 ( \kore-equals SortKConfigVar var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortKConfigVar "%24PGM" ) ) ) ) $.

$( axiom {R} \forall{}(VarInit:SortMap{}, \implies{R}(\top{R}(), \and{R}(\equals{SortKCell{}, R}(LblinitKCell{}(VarInit:SortMap{}), Lbl'-LT-'k'-GT-'{}(kseq{}(Lblproject'Coln'KItem{}(kseq{}(LblMap'Coln'lookup{}(VarInit:SortMap{}, inj{SortKConfigVar{}, SortKItem{}}(\dv{SortKConfigVar{}}("$PGM"))), dotk{}())), dotk{}()))), \top{R}()))) $)
FOO-axiom-2708 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarInit ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKCell R ( LblinitKCell VarInit ) ( Lbl'-LT-'k'-GT-' ( kseq ( Lblproject'Coln'KItem ( kseq ( LblMap'Coln'lookup VarInit ( inj SortKConfigVar SortKItem ( \kore-dv SortKConfigVar "%24PGM" ) ) ) dotk ) ) dotk ) ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortBool{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortBool{}, SortKItem{}}(Var'Unds'0:SortBool{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisBool{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2709 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortBool Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortBool SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisBool VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarBool $.
variable-44-type $f #ElementVariable VarBool $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool $.

$( axiom {R} \forall{}(VarBool:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisBool{}(kseq{}(inj{SortBool{}, SortKItem{}}(VarBool:SortBool{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2710 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarBool ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisBool ( kseq ( inj SortBool SortKItem VarBool ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortCell{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortCell{}, SortKItem{}}(Var'Unds'1:SortCell{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisCell{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2711 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortCell Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortCell SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarCell:SortCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisCell{}(kseq{}(inj{SortCell{}, SortKItem{}}(VarCell:SortCell{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2712 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortCell VarCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisCell ( kseq ( inj SortCell SortKItem VarCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortFloat{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortFloat{}, SortKItem{}}(Var'Unds'1:SortFloat{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisFloat{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2713 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortFloat Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortFloat SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisFloat VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarFloat $.
variable-45-type $f #ElementVariable VarFloat $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat $.

$( axiom {R} \forall{}(VarFloat:SortFloat{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisFloat{}(kseq{}(inj{SortFloat{}, SortKItem{}}(VarFloat:SortFloat{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2714 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat VarFloat ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisFloat ( kseq ( inj SortFloat SortKItem VarFloat ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortFoo{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortFoo{}, SortKItem{}}(Var'Unds'1:SortFoo{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisFoo{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2715 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortFoo Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortFoo SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisFoo VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarFoo $.
variable-46-type $f #ElementVariable VarFoo $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo $.

$( axiom {R} \forall{}(VarFoo:SortFoo{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisFoo{}(kseq{}(inj{SortFoo{}, SortKItem{}}(VarFoo:SortFoo{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2716 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo VarFoo ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisFoo ( kseq ( inj SortFoo SortKItem VarFoo ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortGeneratedCounterCell{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortGeneratedCounterCell{}, SortKItem{}}(Var'Unds'0:SortGeneratedCounterCell{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisGeneratedCounterCell{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2717 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedCounterCell Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedCounterCell SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarGeneratedCounterCell $.
variable-47-type $f #ElementVariable VarGeneratedCounterCell $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell $.

$( axiom {R} \forall{}(VarGeneratedCounterCell:SortGeneratedCounterCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisGeneratedCounterCell{}(kseq{}(inj{SortGeneratedCounterCell{}, SortKItem{}}(VarGeneratedCounterCell:SortGeneratedCounterCell{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2718 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell VarGeneratedCounterCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCell ( kseq ( inj SortGeneratedCounterCell SortKItem VarGeneratedCounterCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortGeneratedCounterCellOpt{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortGeneratedCounterCellOpt{}, SortKItem{}}(Var'Unds'0:SortGeneratedCounterCellOpt{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisGeneratedCounterCellOpt{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2719 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedCounterCellOpt Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedCounterCellOpt SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCellOpt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarGeneratedCounterCellOpt $.
variable-48-type $f #ElementVariable VarGeneratedCounterCellOpt $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt $.

$( axiom {R} \forall{}(VarGeneratedCounterCellOpt:SortGeneratedCounterCellOpt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisGeneratedCounterCellOpt{}(kseq{}(inj{SortGeneratedCounterCellOpt{}, SortKItem{}}(VarGeneratedCounterCellOpt:SortGeneratedCounterCellOpt{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2720 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt VarGeneratedCounterCellOpt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedCounterCellOpt ( kseq ( inj SortGeneratedCounterCellOpt SortKItem VarGeneratedCounterCellOpt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortGeneratedTopCell{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortGeneratedTopCell{}, SortKItem{}}(Var'Unds'1:SortGeneratedTopCell{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisGeneratedTopCell{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2721 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedTopCell Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedTopCell SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarGeneratedTopCell $.
variable-49-type $f #ElementVariable VarGeneratedTopCell $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell $.

$( axiom {R} \forall{}(VarGeneratedTopCell:SortGeneratedTopCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisGeneratedTopCell{}(kseq{}(inj{SortGeneratedTopCell{}, SortKItem{}}(VarGeneratedTopCell:SortGeneratedTopCell{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2722 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCell VarGeneratedTopCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCell ( kseq ( inj SortGeneratedTopCell SortKItem VarGeneratedTopCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortGeneratedTopCellFragment{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortGeneratedTopCellFragment{}, SortKItem{}}(Var'Unds'0:SortGeneratedTopCellFragment{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisGeneratedTopCellFragment{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2723 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortGeneratedTopCellFragment Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortGeneratedTopCellFragment SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCellFragment VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarGeneratedTopCellFragment $.
variable-50-type $f #ElementVariable VarGeneratedTopCellFragment $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment $.

$( axiom {R} \forall{}(VarGeneratedTopCellFragment:SortGeneratedTopCellFragment{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisGeneratedTopCellFragment{}(kseq{}(inj{SortGeneratedTopCellFragment{}, SortKItem{}}(VarGeneratedTopCellFragment:SortGeneratedTopCellFragment{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2724 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCellFragment VarGeneratedTopCellFragment ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisGeneratedTopCellFragment ( kseq ( inj SortGeneratedTopCellFragment SortKItem VarGeneratedTopCellFragment ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortIOError{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortIOError{}, SortKItem{}}(Var'Unds'1:SortIOError{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisIOError{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2725 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOError Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOError SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOError VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarIOError $.
variable-51-type $f #ElementVariable VarIOError $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError $.

$( axiom {R} \forall{}(VarIOError:SortIOError{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisIOError{}(kseq{}(inj{SortIOError{}, SortKItem{}}(VarIOError:SortIOError{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2726 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError VarIOError ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOError ( kseq ( inj SortIOError SortKItem VarIOError ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortIOFile{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortIOFile{}, SortKItem{}}(Var'Unds'1:SortIOFile{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisIOFile{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2727 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOFile Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOFile SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOFile VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarIOFile $.
variable-52-type $f #ElementVariable VarIOFile $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile $.

$( axiom {R} \forall{}(VarIOFile:SortIOFile{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisIOFile{}(kseq{}(inj{SortIOFile{}, SortKItem{}}(VarIOFile:SortIOFile{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2728 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOFile VarIOFile ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOFile ( kseq ( inj SortIOFile SortKItem VarIOFile ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortIOInt{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortIOInt{}, SortKItem{}}(Var'Unds'1:SortIOInt{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisIOInt{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2729 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOInt Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOInt SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOInt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarIOInt $.
variable-53-type $f #ElementVariable VarIOInt $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt $.

$( axiom {R} \forall{}(VarIOInt:SortIOInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisIOInt{}(kseq{}(inj{SortIOInt{}, SortKItem{}}(VarIOInt:SortIOInt{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2730 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOInt VarIOInt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOInt ( kseq ( inj SortIOInt SortKItem VarIOInt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortIOString{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortIOString{}, SortKItem{}}(Var'Unds'1:SortIOString{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisIOString{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2731 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortIOString Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortIOString SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOString VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarIOString $.
variable-54-type $f #ElementVariable VarIOString $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString $.

$( axiom {R} \forall{}(VarIOString:SortIOString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisIOString{}(kseq{}(inj{SortIOString{}, SortKItem{}}(VarIOString:SortIOString{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2732 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOString VarIOString ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisIOString ( kseq ( inj SortIOString SortKItem VarIOString ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortId{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortId{}, SortKItem{}}(Var'Unds'1:SortId{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisId{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2733 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortId Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortId SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisId VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarId $.
variable-55-type $f #ElementVariable VarId $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId $.

$( axiom {R} \forall{}(VarId:SortId{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisId{}(kseq{}(inj{SortId{}, SortKItem{}}(VarId:SortId{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2734 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId VarId ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisId ( kseq ( inj SortId SortKItem VarId ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortInt{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortInt{}, SortKItem{}}(Var'Unds'0:SortInt{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisInt{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2735 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortInt Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortInt SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisInt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarInt $.
variable-56-type $f #ElementVariable VarInt $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt $.

$( axiom {R} \forall{}(VarInt:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisInt{}(kseq{}(inj{SortInt{}, SortKItem{}}(VarInt:SortInt{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2736 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarInt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisInt ( kseq ( inj SortInt SortKItem VarInt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisK{}(VarK:SortK{}), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2737 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisK VarK ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortKCell{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortKCell{}, SortKItem{}}(Var'Unds'1:SortKCell{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisKCell{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2738 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKCell Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortKCell SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCell VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarKCell $.
variable-57-type $f #ElementVariable VarKCell $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell $.

$( axiom {R} \forall{}(VarKCell:SortKCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisKCell{}(kseq{}(inj{SortKCell{}, SortKItem{}}(VarKCell:SortKCell{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2739 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell VarKCell ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCell ( kseq ( inj SortKCell SortKItem VarKCell ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortKCellOpt{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortKCellOpt{}, SortKItem{}}(Var'Unds'1:SortKCellOpt{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisKCellOpt{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2740 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKCellOpt Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortKCellOpt SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCellOpt VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarKCellOpt $.
variable-58-type $f #ElementVariable VarKCellOpt $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt $.

$( axiom {R} \forall{}(VarKCellOpt:SortKCellOpt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisKCellOpt{}(kseq{}(inj{SortKCellOpt{}, SortKItem{}}(VarKCellOpt:SortKCellOpt{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2741 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCellOpt VarKCellOpt ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKCellOpt ( kseq ( inj SortKCellOpt SortKItem VarKCellOpt ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortKConfigVar{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortKConfigVar{}, SortKItem{}}(Var'Unds'1:SortKConfigVar{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisKConfigVar{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2742 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKConfigVar Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortKConfigVar SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKConfigVar VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarKConfigVar $.
variable-59-type $f #ElementVariable VarKConfigVar $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar $.

$( axiom {R} \forall{}(VarKConfigVar:SortKConfigVar{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisKConfigVar{}(kseq{}(inj{SortKConfigVar{}, SortKItem{}}(VarKConfigVar:SortKConfigVar{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2743 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKConfigVar VarKConfigVar ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKConfigVar ( kseq ( inj SortKConfigVar SortKItem VarKConfigVar ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortKItem{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(Var'Unds'0:SortKItem{}, dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisKItem{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2744 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortKItem Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq Var'Unds'0 dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisKItem VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarKItem $.
variable-60-type $f #ElementVariable VarKItem $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem $.

$( axiom {R} \forall{}(VarKItem:SortKItem{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisKItem{}(kseq{}(VarKItem:SortKItem{}, dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2745 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem VarKItem ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisKItem ( kseq VarKItem dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortList{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortList{}, SortKItem{}}(Var'Unds'0:SortList{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisList{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2746 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortList Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortList SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisList VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarList $.
variable-61-type $f #ElementVariable VarList $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList $.

$( axiom {R} \forall{}(VarList:SortList{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisList{}(kseq{}(inj{SortList{}, SortKItem{}}(VarList:SortList{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2747 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList VarList ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisList ( kseq ( inj SortList SortKItem VarList ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortMap{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortMap{}, SortKItem{}}(Var'Unds'1:SortMap{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisMap{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2748 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortMap Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortMap SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisMap VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarMap $.
variable-62-type $f #ElementVariable VarMap $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap $.

$( axiom {R} \forall{}(VarMap:SortMap{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisMap{}(kseq{}(inj{SortMap{}, SortKItem{}}(VarMap:SortMap{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2749 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarMap ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisMap ( kseq ( inj SortMap SortKItem VarMap ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortSet{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortSet{}, SortKItem{}}(Var'Unds'1:SortSet{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisSet{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2750 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortSet Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortSet SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisSet VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarSet $.
variable-63-type $f #ElementVariable VarSet $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap VarSet $.

$( axiom {R} \forall{}(VarSet:SortSet{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisSet{}(kseq{}(inj{SortSet{}, SortKItem{}}(VarSet:SortSet{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2751 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet VarSet ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisSet ( kseq ( inj SortSet SortKItem VarSet ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'0:SortStream{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortStream{}, SortKItem{}}(Var'Unds'0:SortStream{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisStream{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2752 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortStream Var'Unds'0 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortStream SortKItem Var'Unds'0 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisStream VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarStream $.
variable-64-type $f #ElementVariable VarStream $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap VarSet VarStream $.

$( axiom {R} \forall{}(VarStream:SortStream{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisStream{}(kseq{}(inj{SortStream{}, SortKItem{}}(VarStream:SortStream{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2753 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortStream VarStream ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisStream ( kseq ( inj SortStream SortKItem VarStream ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\and{R}(\not{R}(\or{R}(\exists{R}(Var'Unds'1:SortString{}, \and{R}(\top{R}(), \and{R}(\ceil{SortK{}, R}(\and{SortK{}}(VarK:SortK{}, kseq{}(inj{SortString{}, SortKItem{}}(Var'Unds'1:SortString{}), dotk{}()))), \top{R}()))), \bottom{R}())), \top{R}()), \and{R}(\equals{SortBool{}, R}(LblisString{}(VarK:SortK{}), \dv{SortBool{}}("false")), \top{R}()))) $)
FOO-axiom-2754 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-and R ( \kore-not R ( \kore-or R ( \kore-exists SortString Var'Unds'1 ( \kore-and R ( \kore-top R ) ( \kore-and R ( \kore-ceil SortK R ( \kore-and SortK VarK ( kseq ( inj SortString SortKItem Var'Unds'1 ) dotk ) ) ) ( \kore-top R ) ) ) ) ( \kore-bottom R ) ) ) ( \kore-top R ) ) ( \kore-and R ( \kore-equals SortBool R ( LblisString VarK ) ( \kore-dv SortBool "false" ) ) ( \kore-top R ) ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarString $.
variable-65-type $f #ElementVariable VarString $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap VarSet VarStream VarString $.

$( axiom {R} \forall{}(VarString:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblisString{}(kseq{}(inj{SortString{}, SortKItem{}}(VarString:SortString{}), dotk{}())), \dv{SortBool{}}("true")), \top{R}()))) $)
FOO-axiom-2755 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarString ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblisString ( kseq ( inj SortString SortKItem VarString ) dotk ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI2:SortInt{}, \forall{}(VarI1:SortInt{}, \implies{R}(\equals{SortBool{}, R}(Lbl'Unds-LT-Eqls'Int'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{}), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int{}(VarI1:SortInt{}, VarI2:SortInt{}), VarI1:SortInt{}), \top{R}())))) $)
FOO-axiom-2756 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-LT-Eqls'Int'Unds' VarI1 VarI2 ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int VarI1 VarI2 ) VarI1 ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI2:SortInt{}, \forall{}(VarI1:SortInt{}, \implies{R}(\equals{SortBool{}, R}(Lbl'Unds-GT-Eqls'Int'Unds'{}(VarI1:SortInt{}, VarI2:SortInt{}), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int{}(VarI1:SortInt{}, VarI2:SortInt{}), VarI2:SortInt{}), \top{R}())))) $)
FOO-axiom-2757 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI2 ( \kore-forall SortInt VarI1 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'Int'Unds' VarI1 VarI2 ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblminInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int VarI1 VarI2 ) VarI2 ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortBool{}, \implies{R}(\equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true")), \and{R}(\equals{SortBool{}, R}(LblnotBool'Unds'{}(\and{SortBool{}}(\dv{SortBool{}}("true"), Var'Unds'0:SortBool{})), \dv{SortBool{}}("false")), \equals{SortBool{}, R}(Var'Unds'0:SortBool{}, \dv{SortBool{}}("true"))))) $)
FOO-axiom-2758 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool Var'Unds'0 ( \kore-implies R ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortBool R ( LblnotBool'Unds' ( \kore-and SortBool ( \kore-dv SortBool "true" ) Var'Unds'0 ) ) ( \kore-dv SortBool "false" ) ) ( \kore-equals SortBool R Var'Unds'0 ( \kore-dv SortBool "true" ) ) ) ) ) ) $.

$( axiom {R} \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(LblnotBool'Unds'{}(\dv{SortBool{}}("false")), \dv{SortBool{}}("true")), \top{R}())) $)
FOO-axiom-2759 $a |- ( \kore-forall \kore-sort R ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( LblnotBool'Unds' ( \kore-dv SortBool "false" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-top R ) ) ) ) $.

$( adding 1 new metavariables $)
$v VarK0 $.
variable-66-type $f #ElementVariable VarK0 $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap VarSet VarStream VarString VarK0 $.

$( axiom {R} \forall{}(VarK1:SortInt{}, \forall{}(VarK0:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(Lblproject'ColnHash'tempFile'Coln'fd{}(Lbl'Hash'tempFile{}(VarK0:SortString{}, VarK1:SortInt{})), VarK1:SortInt{}), \top{R}())))) $)
FOO-axiom-2760 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK1 ( \kore-forall SortString VarK0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( Lblproject'ColnHash'tempFile'Coln'fd ( Lbl'Hash'tempFile VarK0 VarK1 ) ) VarK1 ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK1:SortInt{}, \forall{}(VarK0:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortString{}, R}(Lblproject'ColnHash'tempFile'Coln'path{}(Lbl'Hash'tempFile{}(VarK0:SortString{}, VarK1:SortInt{})), VarK0:SortString{}), \top{R}())))) $)
FOO-axiom-2761 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK1 ( \kore-forall SortString VarK0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( Lblproject'ColnHash'tempFile'Coln'path ( Lbl'Hash'tempFile VarK0 VarK1 ) ) VarK0 ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK0:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(Lblproject'ColnHash'unknownIOError'Coln'errno{}(Lbl'Hash'unknownIOError{}(VarK0:SortInt{})), VarK0:SortInt{}), \top{R}()))) $)
FOO-axiom-2762 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( Lblproject'ColnHash'unknownIOError'Coln'errno ( Lbl'Hash'unknownIOError VarK0 ) ) VarK0 ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortBool{}, \implies{R}(\top{R}(), \and{R}(\equals{SortBool{}, R}(Lblproject'Coln'Bool{}(kseq{}(inj{SortBool{}, SortKItem{}}(VarK:SortBool{}), dotk{}())), VarK:SortBool{}), \top{R}()))) $)
FOO-axiom-2763 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortBool VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortBool R ( Lblproject'Coln'Bool ( kseq ( inj SortBool SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortCell{}, R}(Lblproject'Coln'Cell{}(kseq{}(inj{SortCell{}, SortKItem{}}(VarK:SortCell{}), dotk{}())), VarK:SortCell{}), \top{R}()))) $)
FOO-axiom-2764 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortCell R ( Lblproject'Coln'Cell ( kseq ( inj SortCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortFloat{}, \implies{R}(\top{R}(), \and{R}(\equals{SortFloat{}, R}(Lblproject'Coln'Float{}(kseq{}(inj{SortFloat{}, SortKItem{}}(VarK:SortFloat{}), dotk{}())), VarK:SortFloat{}), \top{R}()))) $)
FOO-axiom-2765 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFloat VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortFloat R ( Lblproject'Coln'Float ( kseq ( inj SortFloat SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortFoo{}, \implies{R}(\top{R}(), \and{R}(\equals{SortFoo{}, R}(Lblproject'Coln'Foo{}(kseq{}(inj{SortFoo{}, SortKItem{}}(VarK:SortFoo{}), dotk{}())), VarK:SortFoo{}), \top{R}()))) $)
FOO-axiom-2766 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortFoo VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortFoo R ( Lblproject'Coln'Foo ( kseq ( inj SortFoo SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortGeneratedCounterCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortGeneratedCounterCell{}, R}(Lblproject'Coln'GeneratedCounterCell{}(kseq{}(inj{SortGeneratedCounterCell{}, SortKItem{}}(VarK:SortGeneratedCounterCell{}), dotk{}())), VarK:SortGeneratedCounterCell{}), \top{R}()))) $)
FOO-axiom-2767 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCell R ( Lblproject'Coln'GeneratedCounterCell ( kseq ( inj SortGeneratedCounterCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortGeneratedCounterCellOpt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortGeneratedCounterCellOpt{}, R}(Lblproject'Coln'GeneratedCounterCellOpt{}(kseq{}(inj{SortGeneratedCounterCellOpt{}, SortKItem{}}(VarK:SortGeneratedCounterCellOpt{}), dotk{}())), VarK:SortGeneratedCounterCellOpt{}), \top{R}()))) $)
FOO-axiom-2768 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedCounterCellOpt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedCounterCellOpt R ( Lblproject'Coln'GeneratedCounterCellOpt ( kseq ( inj SortGeneratedCounterCellOpt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortGeneratedTopCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortGeneratedTopCell{}, R}(Lblproject'Coln'GeneratedTopCell{}(kseq{}(inj{SortGeneratedTopCell{}, SortKItem{}}(VarK:SortGeneratedTopCell{}), dotk{}())), VarK:SortGeneratedTopCell{}), \top{R}()))) $)
FOO-axiom-2769 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedTopCell R ( Lblproject'Coln'GeneratedTopCell ( kseq ( inj SortGeneratedTopCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortGeneratedTopCellFragment{}, \implies{R}(\top{R}(), \and{R}(\equals{SortGeneratedTopCellFragment{}, R}(Lblproject'Coln'GeneratedTopCellFragment{}(kseq{}(inj{SortGeneratedTopCellFragment{}, SortKItem{}}(VarK:SortGeneratedTopCellFragment{}), dotk{}())), VarK:SortGeneratedTopCellFragment{}), \top{R}()))) $)
FOO-axiom-2770 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortGeneratedTopCellFragment VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortGeneratedTopCellFragment R ( Lblproject'Coln'GeneratedTopCellFragment ( kseq ( inj SortGeneratedTopCellFragment SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortIOError{}, \implies{R}(\top{R}(), \and{R}(\equals{SortIOError{}, R}(Lblproject'Coln'IOError{}(kseq{}(inj{SortIOError{}, SortKItem{}}(VarK:SortIOError{}), dotk{}())), VarK:SortIOError{}), \top{R}()))) $)
FOO-axiom-2771 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOError VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOError R ( Lblproject'Coln'IOError ( kseq ( inj SortIOError SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortIOFile{}, \implies{R}(\top{R}(), \and{R}(\equals{SortIOFile{}, R}(Lblproject'Coln'IOFile{}(kseq{}(inj{SortIOFile{}, SortKItem{}}(VarK:SortIOFile{}), dotk{}())), VarK:SortIOFile{}), \top{R}()))) $)
FOO-axiom-2772 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOFile VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOFile R ( Lblproject'Coln'IOFile ( kseq ( inj SortIOFile SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortIOInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortIOInt{}, R}(Lblproject'Coln'IOInt{}(kseq{}(inj{SortIOInt{}, SortKItem{}}(VarK:SortIOInt{}), dotk{}())), VarK:SortIOInt{}), \top{R}()))) $)
FOO-axiom-2773 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOInt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOInt R ( Lblproject'Coln'IOInt ( kseq ( inj SortIOInt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortIOString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortIOString{}, R}(Lblproject'Coln'IOString{}(kseq{}(inj{SortIOString{}, SortKItem{}}(VarK:SortIOString{}), dotk{}())), VarK:SortIOString{}), \top{R}()))) $)
FOO-axiom-2774 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortIOString VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortIOString R ( Lblproject'Coln'IOString ( kseq ( inj SortIOString SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortId{}, \implies{R}(\top{R}(), \and{R}(\equals{SortId{}, R}(Lblproject'Coln'Id{}(kseq{}(inj{SortId{}, SortKItem{}}(VarK:SortId{}), dotk{}())), VarK:SortId{}), \top{R}()))) $)
FOO-axiom-2775 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortId VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortId R ( Lblproject'Coln'Id ( kseq ( inj SortId SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(Lblproject'Coln'Int{}(kseq{}(inj{SortInt{}, SortKItem{}}(VarK:SortInt{}), dotk{}())), VarK:SortInt{}), \top{R}()))) $)
FOO-axiom-2776 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( Lblproject'Coln'Int ( kseq ( inj SortInt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortK{}, \implies{R}(\top{R}(), \and{R}(\equals{SortK{}, R}(Lblproject'Coln'K{}(VarK:SortK{}), VarK:SortK{}), \top{R}()))) $)
FOO-axiom-2777 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortK VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortK R ( Lblproject'Coln'K VarK ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortKCell{}, \implies{R}(\top{R}(), \and{R}(\equals{SortKCell{}, R}(Lblproject'Coln'KCell{}(kseq{}(inj{SortKCell{}, SortKItem{}}(VarK:SortKCell{}), dotk{}())), VarK:SortKCell{}), \top{R}()))) $)
FOO-axiom-2778 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCell VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKCell R ( Lblproject'Coln'KCell ( kseq ( inj SortKCell SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortKCellOpt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortKCellOpt{}, R}(Lblproject'Coln'KCellOpt{}(kseq{}(inj{SortKCellOpt{}, SortKItem{}}(VarK:SortKCellOpt{}), dotk{}())), VarK:SortKCellOpt{}), \top{R}()))) $)
FOO-axiom-2779 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKCellOpt VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKCellOpt R ( Lblproject'Coln'KCellOpt ( kseq ( inj SortKCellOpt SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortKItem{}, \implies{R}(\top{R}(), \and{R}(\equals{SortKItem{}, R}(Lblproject'Coln'KItem{}(kseq{}(VarK:SortKItem{}, dotk{}())), VarK:SortKItem{}), \top{R}()))) $)
FOO-axiom-2780 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortKItem VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortKItem R ( Lblproject'Coln'KItem ( kseq VarK dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortList{}, \implies{R}(\top{R}(), \and{R}(\equals{SortList{}, R}(Lblproject'Coln'List{}(kseq{}(inj{SortList{}, SortKItem{}}(VarK:SortList{}), dotk{}())), VarK:SortList{}), \top{R}()))) $)
FOO-axiom-2781 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortList VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortList R ( Lblproject'Coln'List ( kseq ( inj SortList SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortMap{}, \implies{R}(\top{R}(), \and{R}(\equals{SortMap{}, R}(Lblproject'Coln'Map{}(kseq{}(inj{SortMap{}, SortKItem{}}(VarK:SortMap{}), dotk{}())), VarK:SortMap{}), \top{R}()))) $)
FOO-axiom-2782 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortMap VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortMap R ( Lblproject'Coln'Map ( kseq ( inj SortMap SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortSet{}, \implies{R}(\top{R}(), \and{R}(\equals{SortSet{}, R}(Lblproject'Coln'Set{}(kseq{}(inj{SortSet{}, SortKItem{}}(VarK:SortSet{}), dotk{}())), VarK:SortSet{}), \top{R}()))) $)
FOO-axiom-2783 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortSet VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortSet R ( Lblproject'Coln'Set ( kseq ( inj SortSet SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortStream{}, \implies{R}(\top{R}(), \and{R}(\equals{SortStream{}, R}(Lblproject'Coln'Stream{}(kseq{}(inj{SortStream{}, SortKItem{}}(VarK:SortStream{}), dotk{}())), VarK:SortStream{}), \top{R}()))) $)
FOO-axiom-2784 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortStream VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortStream R ( Lblproject'Coln'Stream ( kseq ( inj SortStream SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( axiom {R} \forall{}(VarK:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortString{}, R}(Lblproject'Coln'String{}(kseq{}(inj{SortString{}, SortKItem{}}(VarK:SortString{}), dotk{}())), VarK:SortString{}), \top{R}()))) $)
FOO-axiom-2785 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarK ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( Lblproject'Coln'String ( kseq ( inj SortString SortKItem VarK ) dotk ) ) VarK ) ( \kore-top R ) ) ) ) ) $.

$( adding 3 new metavariables $)
$v VarReplacement VarToReplace VarCount $.
variable-67-type $f #ElementVariable VarReplacement $.
variable-68-type $f #ElementVariable VarToReplace $.
variable-69-type $f #ElementVariable VarCount $.
$d K2 K1 Val R From K0 SortSort Var'Unds'0 VarB1 VarC var-elementvariable-0 var-elementvariable-1 VarB2 VarS Var'Unds'DotVar0 Var'Unds'DotVar1 VarY VarX VarS2 VarS1 VarI2 VarI1 VarK2 VarK1 Var'Unds'1 VarB VarK VarLEN VarIDX VarI VarToCount VarSource VarCell VarInit VarBool VarFloat VarFoo VarGeneratedCounterCell VarGeneratedCounterCellOpt VarGeneratedTopCell VarGeneratedTopCellFragment VarIOError VarIOFile VarIOInt VarIOString VarId VarInt VarKCell VarKCellOpt VarKConfigVar VarKItem VarList VarMap VarSet VarStream VarString VarK0 VarReplacement VarToReplace VarCount $.

$( axiom {R} \forall{}(VarReplacement:SortString{}, \forall{}(VarToReplace:SortString{}, \forall{}(VarSource:SortString{}, \forall{}(VarCount:SortInt{}, \implies{R}(\equals{SortBool{}, R}(Lbl'Unds-GT-'Int'Unds'{}(VarCount:SortInt{}, \dv{SortInt{}}("0")), \dv{SortBool{}}("true")), \and{R}(\equals{SortString{}, R}(Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, VarReplacement:SortString{}, VarCount:SortInt{}), Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String{}(Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String{}(LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarSource:SortString{}, \dv{SortInt{}}("0"), LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, \dv{SortInt{}}("0"))), VarReplacement:SortString{}), Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int{}(LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarSource:SortString{}, Lbl'UndsPlus'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, \dv{SortInt{}}("0")), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarToReplace:SortString{})), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarSource:SortString{})), VarToReplace:SortString{}, VarReplacement:SortString{}, Lbl'Unds'-Int'Unds'{}(VarCount:SortInt{}, \dv{SortInt{}}("1"))))), \top{R}())))))) $)
FOO-axiom-2786 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarReplacement ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-forall SortInt VarCount ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-'Int'Unds' VarCount ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortString R ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int VarSource VarToReplace VarReplacement VarCount ) ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( \kore-dv SortInt "0" ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ) VarReplacement ) ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( Lbl'UndsPlus'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarToReplace ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarSource ) ) VarToReplace VarReplacement ( Lbl'Unds'-Int'Unds' VarCount ( \kore-dv SortInt "1" ) ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'1:SortString{}, \forall{}(Var'Unds'0:SortString{}, \forall{}(VarSource:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortString{}, R}(Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, Var'Unds'0:SortString{}, Var'Unds'1:SortString{}, \dv{SortInt{}}("0")), VarSource:SortString{}), \top{R}()))))) $)
FOO-axiom-2787 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString Var'Unds'1 ( \kore-forall SortString Var'Unds'0 ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int VarSource Var'Unds'0 Var'Unds'1 ( \kore-dv SortInt "0" ) ) VarSource ) ( \kore-top R ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarReplacement:SortString{}, \forall{}(VarToReplace:SortString{}, \forall{}(VarSource:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortString{}, R}(LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String{}(VarSource:SortString{}, VarToReplace:SortString{}, VarReplacement:SortString{}), Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, VarReplacement:SortString{}, LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String{}(VarSource:SortString{}, VarToReplace:SortString{}))), \top{R}()))))) $)
FOO-axiom-2788 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarReplacement ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortString R ( LblreplaceAll'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String VarSource VarToReplace VarReplacement ) ( Lblreplace'LParUndsCommUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String'Unds'Int VarSource VarToReplace VarReplacement ( LblcountAllOccurrences'LParUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String VarSource VarToReplace ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarReplacement:SortString{}, \forall{}(VarToReplace:SortString{}, \forall{}(VarSource:SortString{}, \implies{R}(\equals{SortBool{}, R}(Lbl'Unds-GT-Eqls'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, \dv{SortInt{}}("0")), \dv{SortInt{}}("0")), \dv{SortBool{}}("true")), \and{R}(\equals{SortString{}, R}(LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String{}(VarSource:SortString{}, VarToReplace:SortString{}, VarReplacement:SortString{}), Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String{}(Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String{}(LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarSource:SortString{}, \dv{SortInt{}}("0"), LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, \dv{SortInt{}}("0"))), VarReplacement:SortString{}), LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarSource:SortString{}, Lbl'UndsPlus'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, \dv{SortInt{}}("0")), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarToReplace:SortString{})), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarSource:SortString{})))), \top{R}()))))) $)
FOO-axiom-2789 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString VarReplacement ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-GT-Eqls'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortString R ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String VarSource VarToReplace VarReplacement ) ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( Lbl'UndsPlus'String'UndsUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( \kore-dv SortInt "0" ) ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ) VarReplacement ) ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarSource ( Lbl'UndsPlus'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarToReplace ) ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarSource ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'0:SortString{}, \forall{}(VarToReplace:SortString{}, \forall{}(VarSource:SortString{}, \implies{R}(\equals{SortBool{}, R}(Lbl'Unds-LT-'Int'Unds'{}(LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarSource:SortString{}, VarToReplace:SortString{}, \dv{SortInt{}}("0")), \dv{SortInt{}}("0")), \dv{SortBool{}}("true")), \and{R}(\equals{SortString{}, R}(LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String{}(VarSource:SortString{}, VarToReplace:SortString{}, Var'Unds'0:SortString{}), VarSource:SortString{}), \top{R}()))))) $)
FOO-axiom-2790 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortString Var'Unds'0 ( \kore-forall SortString VarToReplace ( \kore-forall SortString VarSource ( \kore-implies R ( \kore-equals SortBool R ( Lbl'Unds-LT-'Int'Unds' ( LblfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarSource VarToReplace ( \kore-dv SortInt "0" ) ) ( \kore-dv SortInt "0" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortString R ( LblreplaceFirst'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'String'Unds'String VarSource VarToReplace Var'Unds'0 ) VarSource ) ( \kore-top R ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarI:SortInt{}, \forall{}(VarS1:SortString{}, \forall{}(VarS2:SortString{}, \implies{R}(\equals{SortBool{}, R}(Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String{}(VarS2:SortString{}, \dv{SortString{}}("")), \dv{SortBool{}}("true")), \and{R}(\equals{SortInt{}, R}(LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, VarS2:SortString{}, VarI:SortInt{}), LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int{}(LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("0"), \dv{SortInt{}}("1")), VarI:SortInt{}), LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(VarS1:SortString{}, LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int{}(VarS2:SortString{}, \dv{SortInt{}}("1"), LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String{}(VarS2:SortString{})), VarI:SortInt{}))), \top{R}()))))) $)
FOO-axiom-2791 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarI ( \kore-forall SortString VarS1 ( \kore-forall SortString VarS2 ( \kore-implies R ( \kore-equals SortBool R ( Lbl'UndsEqlsSlshEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String VarS2 ( \kore-dv SortString "" ) ) ( \kore-dv SortBool "true" ) ) ( \kore-and R ( \kore-equals SortInt R ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 VarS2 VarI ) ( LblmaxInt'LParUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int ( LblrfindString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "0" ) ( \kore-dv SortInt "1" ) ) VarI ) ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int VarS1 ( LblsubstrString'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'String'Unds'String'Unds'Int'Unds'Int VarS2 ( \kore-dv SortInt "1" ) ( LbllengthString'LParUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String VarS2 ) ) VarI ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.

$( axiom {R} \forall{}(Var'Unds'1:SortInt{}, \forall{}(Var'Unds'0:SortString{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int{}(Var'Unds'0:SortString{}, \dv{SortString{}}(""), Var'Unds'1:SortInt{}), \dv{SortInt{}}("-1")), \top{R}())))) $)
FOO-axiom-2792 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt Var'Unds'1 ( \kore-forall SortString Var'Unds'0 ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int Var'Unds'0 ( \kore-dv SortString "" ) Var'Unds'1 ) ( \kore-dv SortInt "-1" ) ) ( \kore-top R ) ) ) ) ) ) $.

$( axiom {R} \forall{}(VarLEN:SortInt{}, \forall{}(VarIDX:SortInt{}, \forall{}(VarI:SortInt{}, \implies{R}(\top{R}(), \and{R}(\equals{SortInt{}, R}(LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int{}(VarI:SortInt{}, VarIDX:SortInt{}, VarLEN:SortInt{}), Lbl'Unds'-Int'Unds'{}(Lbl'Unds'modInt'Unds'{}(Lbl'UndsPlus'Int'Unds'{}(LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int{}(VarI:SortInt{}, VarIDX:SortInt{}, VarLEN:SortInt{}), Lbl'Unds-LT--LT-'Int'Unds'{}(\dv{SortInt{}}("1"), Lbl'Unds'-Int'Unds'{}(VarLEN:SortInt{}, \dv{SortInt{}}("1")))), Lbl'Unds-LT--LT-'Int'Unds'{}(\dv{SortInt{}}("1"), VarLEN:SortInt{})), Lbl'Unds-LT--LT-'Int'Unds'{}(\dv{SortInt{}}("1"), Lbl'Unds'-Int'Unds'{}(VarLEN:SortInt{}, \dv{SortInt{}}("1"))))), \top{R}()))))) $)
FOO-axiom-2793 $a |- ( \kore-forall \kore-sort R ( \kore-forall SortInt VarLEN ( \kore-forall SortInt VarIDX ( \kore-forall SortInt VarI ( \kore-implies R ( \kore-top R ) ( \kore-and R ( \kore-equals SortInt R ( LblsignExtendBitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int VarI VarIDX VarLEN ) ( Lbl'Unds'-Int'Unds' ( Lbl'Unds'modInt'Unds' ( Lbl'UndsPlus'Int'Unds' ( LblbitRangeInt'LParUndsCommUndsCommUndsRParUnds'INT-COMMON'Unds'Int'Unds'Int'Unds'Int'Unds'Int VarI VarIDX VarLEN ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) ( Lbl'Unds'-Int'Unds' VarLEN ( \kore-dv SortInt "1" ) ) ) ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) VarLEN ) ) ( Lbl'Unds-LT--LT-'Int'Unds' ( \kore-dv SortInt "1" ) ( Lbl'Unds'-Int'Unds' VarLEN ( \kore-dv SortInt "1" ) ) ) ) ) ( \kore-top R ) ) ) ) ) ) ) $.

$( ---------------- end of module FOO ---------------- $)

$( 
rewriting step 0:
inj{SortGeneratedTopCell{}, SortKItem{}}(Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo{}(Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo{}(Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int{}(\dv{SortInt{}}("13"))), Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo{}(Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int{}(\dv{SortInt{}}("12"))))), dotk{}())), Lbl'-LT-'generatedCounter'-GT-'{}(\dv{SortInt{}}("0"))))
=>
inj{SortGeneratedTopCell{}, SortKItem{}}(Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo{}(Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int{}(\dv{SortInt{}}("13")))), dotk{}())), Lbl'-LT-'generatedCounter'-GT-'{}(\dv{SortInt{}}("0"))))
$)

$( domain value "13" of sort SortInt{} $)
$c "13" $.
domain-value-10-pattern $a #Pattern "13" $.
${
domain-value-10-substitution $a #Substitution "13" "13" var-pattern-0 var-variable-0 $.
$}
domain-value-10-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "13" ) ) ) ) $.

$( domain value "12" of sort SortInt{} $)
$c "12" $.
domain-value-11-pattern $a #Pattern "12" $.
${
domain-value-11-substitution $a #Substitution "12" "12" var-pattern-0 var-variable-0 $.
$}
domain-value-11-functional $a |- ( \kore-forall \kore-sort var-elementvariable-0 ( \kore-exists SortInt var-elementvariable-1 ( \kore-equals SortInt var-elementvariable-0 var-elementvariable-1 ( \kore-dv SortInt "12" ) ) ) ) $.
step-0 $p |- ( \kore-rewrites SortGeneratedTopCell ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblbar'LParUndsCommUndsRParUnds'FOO'Unds'Foo'Unds'Foo'Unds'Foo ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "12" ) ) ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ) $= FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type variable-8-type variable-9-type FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-26-type variable-8-type variable-9-type BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-26-type kore-forall-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-26-type kore-forall-pattern variable-25-type variable-8-type variable-9-type FOO-sort-7-pattern BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-26-type kore-forall-pattern variable-25-type kore-forall-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-26-type kore-forall-pattern variable-25-type kore-forall-pattern variable-24-type variable-8-type variable-9-type variable-24-type variable-25-type variable-26-type variable-27-type FOO-axiom-2659 FOO-sort-15-pattern FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-102-pattern kore-equals-pattern variable-8-type kore-exists-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern kore-equals-pattern variable-8-type kore-exists-pattern variable-15-type variable-21-type variable-20-type variable-9-type variable-8-type variable-9-type variable-15-type FOO-axiom-2530 variable-20-type variable-21-type domain-value-3-functional FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern kore-equals-pattern FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-102-pattern kore-equals-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-8-type variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-7-substitution FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-102-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-7-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var variable-9-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var variable-8-type element-var-is-var substitution-distinct-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var substitution-var FOO-symbol-102-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-26-type kore-forall-pattern BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-26-type kore-forall-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-25-type variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-0-substitution FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-26-type variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-substitution FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution kore-top-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-1-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-26-type element-var-is-var substitution-distinct-var FOO-symbol-175-substitution INJ-symbol-0-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-25-type element-var-is-var substitution-distinct-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var substitution-var FOO-symbol-103-substitution kore-and-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution kore-top-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-1-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var INJ-symbol-0-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-25-type element-var-is-var substitution-distinct-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var substitution-var FOO-symbol-103-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-substitution kore-forall-substitution kore-forall-elim variable-8-type variable-9-type KSEQ-axiom-3 FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern KSEQ-symbol-1-pattern variable-26-type variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-substitution FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern KSEQ-symbol-1-pattern variable-27-type variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution kore-top-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern BASIC-K-sort-1-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-26-type element-var-is-var substitution-distinct-var FOO-symbol-175-substitution INJ-symbol-0-substitution KSEQ-symbol-1-pattern variable-25-type element-var-is-var substitution-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution kore-top-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern BASIC-K-sort-1-substitution KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var INJ-symbol-0-substitution KSEQ-symbol-1-pattern variable-25-type element-var-is-var substitution-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-substitution kore-forall-elim FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-190-pattern kore-equals-pattern variable-8-type kore-exists-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern kore-equals-pattern variable-8-type kore-exists-pattern variable-15-type variable-8-type variable-9-type variable-9-type variable-8-type variable-9-type variable-15-type FOO-axiom-2610 FOO-sort-15-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern kore-equals-pattern variable-8-type kore-exists-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern kore-equals-pattern variable-8-type kore-exists-pattern variable-15-type variable-21-type variable-20-type variable-9-type variable-8-type variable-9-type variable-15-type FOO-axiom-2605 variable-20-type variable-21-type domain-value-11-functional FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern kore-equals-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern kore-equals-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern variable-8-type variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-sort-18-substitution FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-sort-18-substitution FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern variable-15-type element-var-is-var variable-9-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern variable-15-type element-var-is-var variable-8-type element-var-is-var substitution-distinct-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern variable-15-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern variable-15-type element-var-is-var substitution-var FOO-symbol-186-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern kore-equals-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-190-pattern kore-equals-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern variable-8-type variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-substitution FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-substitution FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var variable-9-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var variable-8-type element-var-is-var substitution-distinct-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var substitution-var FOO-symbol-190-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution kore-top-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-symbol-175-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern BASIC-K-sort-1-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var substitution-var FOO-symbol-175-substitution INJ-symbol-0-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern KSEQ-symbol-1-substitution KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution kore-top-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern BASIC-K-sort-1-substitution FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var INJ-symbol-0-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern KSEQ-symbol-1-substitution KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-26-type element-var-is-var variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-substitution variable-26-type element-var-is-var FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-elim FOO-sort-18-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-190-pattern kore-equals-pattern variable-8-type kore-exists-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern kore-equals-pattern variable-8-type kore-exists-pattern variable-15-type variable-8-type variable-9-type variable-9-type variable-8-type variable-9-type variable-15-type FOO-axiom-2610 FOO-sort-15-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern kore-equals-pattern variable-8-type kore-exists-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern kore-equals-pattern variable-8-type kore-exists-pattern variable-15-type variable-21-type variable-20-type variable-9-type variable-8-type variable-9-type variable-15-type FOO-axiom-2605 variable-20-type variable-21-type domain-value-10-functional FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern kore-equals-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern kore-equals-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-8-type variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-18-substitution FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-18-substitution FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var variable-9-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var variable-8-type element-var-is-var substitution-distinct-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var substitution-var FOO-symbol-186-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern kore-equals-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-190-pattern kore-equals-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-8-type variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-substitution FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-substitution FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var variable-9-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var variable-8-type element-var-is-var substitution-distinct-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-15-type element-var-is-var substitution-var FOO-symbol-190-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution kore-top-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-symbol-175-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern BASIC-K-sort-1-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var substitution-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-11-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-11-pattern FOO-sort-15-pattern domain-value-11-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern domain-value-11-substitution kore-dv-substitution FOO-symbol-186-substitution FOO-symbol-190-substitution FOO-symbol-175-substitution INJ-symbol-0-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern KSEQ-symbol-1-substitution KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-6-substitution kore-top-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern BASIC-K-sort-1-substitution FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var substitution-var INJ-symbol-0-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern KSEQ-symbol-1-substitution KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-15-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution kore-rewrites-substitution kore-forall-elim FOO-sort-6-pattern kore-top-valid FOO-sort-6-pattern kore-top-valid kore-rewrites-conditional $.

$( 
rewriting step 1:
inj{SortGeneratedTopCell{}, SortKItem{}}(Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo{}(Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int{}(\dv{SortInt{}}("13")))), dotk{}())), Lbl'-LT-'generatedCounter'-GT-'{}(\dv{SortInt{}}("0"))))
=>
inj{SortGeneratedTopCell{}, SortKItem{}}(Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'k'-GT-'{}(kseq{}(inj{SortFoo{}, SortKItem{}}(Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int{}(\dv{SortInt{}}("13"))), dotk{}())), Lbl'-LT-'generatedCounter'-GT-'{}(\dv{SortInt{}}("0"))))
$)
step-1 $p |- ( \kore-rewrites SortGeneratedTopCell ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblid'LParUndsRParUnds'FOO'Unds'Foo'Unds'Foo ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ( Lbl'-LT-'generatedTop'-GT-' ( Lbl'-LT-'k'-GT-' ( kseq ( inj SortFoo SortKItem ( Lblfoo'LParUndsRParUnds'FOO'Unds'Foo'Unds'Int ( \kore-dv SortInt "13" ) ) ) dotk ) ) ( Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv SortInt "0" ) ) ) ) $= FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type variable-8-type variable-9-type BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-25-type variable-8-type variable-9-type FOO-sort-7-pattern BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-25-type kore-forall-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern variable-25-type kore-forall-pattern variable-24-type variable-8-type variable-9-type variable-24-type variable-25-type variable-27-type FOO-axiom-2660 FOO-sort-15-pattern FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-102-pattern kore-equals-pattern variable-8-type kore-exists-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern kore-equals-pattern variable-8-type kore-exists-pattern variable-15-type variable-21-type variable-20-type variable-9-type variable-8-type variable-9-type variable-15-type FOO-axiom-2530 variable-20-type variable-21-type domain-value-3-functional FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern kore-equals-pattern FOO-sort-7-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-102-pattern kore-equals-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-8-type variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-7-substitution FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-7-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-102-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-7-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var variable-9-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var variable-8-type element-var-is-var substitution-distinct-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern variable-15-type element-var-is-var substitution-var FOO-symbol-102-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern BASIC-K-sort-0-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern variable-27-type kore-forall-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-25-type variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-0-substitution FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution kore-top-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-1-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type element-var-is-var var-is-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var FOO-symbol-190-substitution INJ-symbol-0-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-25-type element-var-is-var substitution-distinct-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var substitution-var FOO-symbol-103-substitution kore-and-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-6-substitution kore-top-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern variable-24-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-substitution variable-24-type element-var-is-var FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern BASIC-K-sort-1-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var INJ-symbol-0-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var variable-25-type element-var-is-var substitution-distinct-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-24-type element-var-is-var substitution-var FOO-symbol-103-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-substitution kore-forall-elim variable-8-type variable-9-type KSEQ-axiom-3 FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern FOO-sort-18-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern kore-rewrites-pattern KSEQ-symbol-1-pattern variable-27-type variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution kore-top-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern BASIC-K-sort-1-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern variable-27-type element-var-is-var var-is-pattern variable-27-type element-var-is-var var-is-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var FOO-symbol-190-substitution INJ-symbol-0-substitution KSEQ-symbol-1-pattern variable-25-type element-var-is-var substitution-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-6-substitution kore-top-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern KSEQ-symbol-0-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern variable-25-type element-var-is-var var-is-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-18-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern BASIC-K-sort-1-substitution KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-27-type element-var-is-var substitution-distinct-var INJ-symbol-0-substitution KSEQ-symbol-1-pattern variable-25-type element-var-is-var substitution-var KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern KSEQ-symbol-1-pattern variable-25-type element-var-is-var variable-25-type element-var-is-var KSEQ-symbol-1-pattern FOO-sort-15-substitution variable-25-type element-var-is-var KSEQ-symbol-1-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution kore-rewrites-substitution kore-forall-substitution kore-forall-elim FOO-sort-15-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern kore-equals-pattern variable-8-type kore-exists-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern kore-equals-pattern variable-8-type kore-exists-pattern variable-15-type variable-21-type variable-20-type variable-9-type variable-8-type variable-9-type variable-15-type FOO-axiom-2605 variable-20-type variable-21-type domain-value-10-functional FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern kore-equals-pattern FOO-sort-18-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern kore-equals-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-8-type variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-18-substitution FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern variable-9-type element-var-is-var var-is-pattern variable-8-type element-var-is-var var-is-pattern variable-15-type element-var-is-var var-is-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-18-substitution FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var variable-9-type element-var-is-var substitution-distinct-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var variable-8-type element-var-is-var substitution-distinct-var variable-15-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern variable-15-type element-var-is-var substitution-var FOO-symbol-186-substitution kore-equals-substitution kore-exists-substitution kore-forall-elim-variant FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern kore-and-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-6-substitution kore-top-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-symbol-190-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern FOO-symbol-190-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern BASIC-K-sort-1-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var var-is-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var substitution-var FOO-symbol-190-substitution INJ-symbol-0-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern KSEQ-symbol-1-substitution KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-6-pattern FOO-sort-6-pattern kore-top-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-symbol-103-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-6-substitution FOO-sort-6-pattern FOO-sort-6-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-6-substitution kore-top-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-symbol-105-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-symbol-102-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern KSEQ-symbol-0-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern INJ-symbol-0-pattern KSEQ-symbol-1-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-pattern BASIC-K-sort-1-pattern variable-27-type element-var-is-var var-is-pattern variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-18-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern BASIC-K-sort-1-substitution FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var substitution-var INJ-symbol-0-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern KSEQ-symbol-1-substitution KSEQ-symbol-0-substitution FOO-symbol-105-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern kore-dv-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-3-pattern FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern variable-27-type element-var-is-var variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern FOO-sort-15-substitution variable-27-type element-var-is-var FOO-sort-15-pattern domain-value-10-pattern kore-dv-pattern FOO-symbol-186-pattern domain-value-3-substitution kore-dv-substitution FOO-symbol-102-substitution FOO-symbol-103-substitution kore-and-substitution kore-rewrites-substitution kore-forall-elim FOO-sort-6-pattern kore-top-valid FOO-sort-6-pattern kore-top-valid kore-rewrites-conditional $.
