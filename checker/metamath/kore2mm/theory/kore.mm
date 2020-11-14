$[ theory/matching-logic.mm $]

$(
    Kore syntax https://github.com/kframework/kore/blob/master/docs/kore-syntax.md 
$)

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

kore-ceil-pattern   $a #Pattern ( \kore-ceil ph1 ph2 ph3 ) $.
kore-floor-pattern  $a #Pattern ( \kore-floor ph1 ph2 ph3 ) $.
kore-equals-pattern $a #Pattern ( \kore-equals ph1 ph2 ph3 ph4 ) $.
kore-in-pattern $a #Pattern ( \kore-in ph1 ph2 ph3 ph4 ) $.
kore-rewrites-pattern $a #Pattern ( \kore-rewrites ph1 ph2 ph3 ) $.
kore-dv-pattern $a #Pattern ( \kore-dv ph1 ph2 ) $.

kore-sort-pattern $a #Pattern \kore-sort $.

$(
    Substitution rules
$)

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

$(
    Kore lemmas
$)

kore-top-valid $p |- ( \kore-top ph1 ) $= ? $.

${
    $(
        ph1: rewrite sort
        ph2: rewrite condition (`requires` clause)
        ph3: LHS
        ph4: `ensures` clause
        ph5: RHS
    $)
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
    $( ph3 is functional and has sort ph1 $)
    kore-forall-elim.2 $e |- ( \kore-forall \kore-sort z ( \kore-exists ph1 y ( \kore-equals ph1 z y ph3 ) ) ) $.
    kore-forall-elim.3 $e #Substitution ph4 ph2 ph3 x $.
    kore-forall-elim $p |- ph4 $= ? $.
$}

$( a variant of the quantifier elimination above, more convenient for proving functional properties $)
${
    $d w x $.
    $d z y $.
    $d w ph1 $.
    $d y ph3 $.
    $d y ph1 $.
    $d z ph3 $.
    $d z ph1 $.
    kore-forall-elim-variant.1 $e |- ( \kore-forall \kore-sort w ( \kore-forall ph1 x ph2 ) ) $.
    $( ph3 is functional and has sort ph1 $)
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
    $( ph2 = ph3 $)
    kore-equality.1 $e |- ( \kore-forall \kore-sort z ( \kore-equals ph1 z ph2 ph3 ) ) $.
    kore-equality.2 $e |- ph4 $.
    kore-equality.3 $e #Substitution ph4 ph5 ph2 x $.
    kore-equality.4 $e #Substitution ph6 ph5 ph3 x $.
    kore-equality $p |- ph6 $= ? $.
$}
