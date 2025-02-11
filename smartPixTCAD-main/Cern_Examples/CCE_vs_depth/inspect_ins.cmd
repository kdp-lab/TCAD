load_library extend

set projname transientn@node|-1@
proj_load ${projname}_des.plt $projname

set N1 @node|-1@
proj_load n${N1}_des.plt curve1
cv_createDS NO_NAME {curve1 BOT_electrode InnerVoltage} {curve1 IMP1_electrode TotalCurrent} y
cv_createWithFormula curve_IV "<TotalCurrent_IMP1_electrode>" A A 
set LEAKAGE [cv_compute "vecvaly(<curve_IV>, @voltage@)" A A A A]

set c1 curve1
set c2 curve2
set c3 curve3

cv_createDS $c1 "$projname time" "$projname IMP1_electrode TotalCurrent" y
cv_createDS $c2 "$projname time" "$projname IMP2_electrode TotalCurrent" y
cv_createDS $c3 "$projname time" "$projname IMP3_electrode TotalCurrent" y

set Q1 [cv_compute "vecvaly(integr(<${c1}>*(1 - $LEAKAGE)), 20e-9)" A A A A]
set Q2 [cv_compute "vecvaly(integr(<${c2}>*(1 - $LEAKAGE)), 20e-9)" A A A A]
set Q3 [cv_compute "vecvaly(integr(<${c3}>*(1 - $LEAKAGE)), 20e-9)" A A A A]

set N1 [expr {${Q1}/1.60217e-19}] 
set N2 [expr {${Q2}/1.60217e-19}] 
set N3 [expr {${Q3}/1.60217e-19}] 

set Q  [expr {${N2}}] 
ft_scalar N_NEW [format %.3f $Q] 

script_exit
 





