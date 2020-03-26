$(  
    #############################
    Matching Logic Proof Checker.
    #############################
$)

$( syntactic categories of matching logic grammar $)
$c 
   #Pattern
   #Variable 
   #ElementVariable 
   #SetVariable 
   #Symbol
$.

$v phi psi phi1 phi2 phi3 $.
v-phi $f #Pattern phi $.
v-psi $f #Pattern psi $.
v-phi1 $f #Pattern phi1 $.
v-phi2 $f #Pattern phi2 $.
v-phi3 $f #Pattern phi3 $.

$v xX yY $.
v-xX $f #Variable xX $.
v-yY $f #Variable yY $.

$v x y $.
v-x $f #ElementVariable x $.
v-y $f #ElementVariable y $.

$v X Y $.
v-X $f #SetVariable X $.
v-Y $f #SetVariable Y $.

$v sigma sigma1 sigma2 sigma3 $.
v-sigma $f #Symbol sigma $.
v-sigma1 $f #Symbol sigma1 $.
v-sigma2 $f #Symbol sigma2 $.
v-sigma3 $f #Symbol sigma3 $.

$( primitive matching logic constructs $)
$c \app \bot \imp \ex \mu ( ) $.

$( assertions about matching logic patterns (parse trees) $)
$c
   #fv
   #subst
   #positiveOccurrence
   #negativeOccurrence
   #applicationContext
$.

a-ev $a #var x $.
a-sv $a 
var-svar $a #var X $.


$( matching logic provability $)
$c |- $.
