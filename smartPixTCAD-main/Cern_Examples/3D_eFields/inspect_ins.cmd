
set COLORS  [list green blue red orange magenta violet brown]
set color   [lindex  $COLORS [expr @node@%[llength $COLORS] ]]

set projname n@node|-1@transientn@node|-1@
proj_load ${projname}_des.plt $projname

set c1 curve1
set c2 curve2
set c3 curve3
set c4 curve4
set c5 curve5
set c6 curve6
set c7 curve7
set c8 curve8
set c9 curve9

cv_createDS $c1 "$projname time" "$projname IMP1_electrode TotalCurrent" y
cv_createDS $c2 "$projname time" "$projname IMP2_electrode TotalCurrent" y
cv_createDS $c3 "$projname time" "$projname IMP3_electrode TotalCurrent" y
cv_createDS $c4 "$projname time" "$projname IMP4_electrode TotalCurrent" y
cv_createDS $c5 "$projname time" "$projname IMP5_electrode TotalCurrent" y
cv_createDS $c6 "$projname time" "$projname IMP6_electrode TotalCurrent" y
cv_createDS $c7 "$projname time" "$projname IMP7_electrode TotalCurrent" y
cv_createDS $c8 "$projname time" "$projname IMP8_electrode TotalCurrent" y
cv_createDS $c9 "$projname time" "$projname IMP9_electrode TotalCurrent" y

# cv_abs $curvename y
# cv_setCurveAttr $curvename "n@node|sdevice@" $color solid 2 none 3 defcolor 1 defcolor

set Q1 [cv_compute "vecmax(integr(<${c1}>))" A A A A]
set Q2 [cv_compute "vecmax(integr(<${c2}>))" A A A A]
set Q3 [cv_compute "vecmax(integr(<${c3}>))" A A A A]
set Q4 [cv_compute "vecmax(integr(<${c4}>))" A A A A]
set Q5 [cv_compute "vecmax(integr(<${c5}>))" A A A A]
set Q6 [cv_compute "vecmax(integr(<${c6}>))" A A A A]
set Q7 [cv_compute "vecmax(integr(<${c7}>))" A A A A]
set Q8 [cv_compute "vecmax(integr(<${c8}>))" A A A A]
set Q9 [cv_compute "vecmax(integr(<${c9}>))" A A A A]

set N1 [expr {${Q1}/1.60217e-19}] 
set N2 [expr {${Q2}/1.60217e-19}] 
set N3 [expr {${Q3}/1.60217e-19}] 
set N4 [expr {${Q4}/1.60217e-19}] 
set N5 [expr {${Q5}/1.60217e-19}] 
set N6 [expr {${Q6}/1.60217e-19}] 
set N7 [expr {${Q7}/1.60217e-19}] 
set N8 [expr {${Q8}/1.60217e-19}] 
set N9 [expr {${Q9}/1.60217e-19}] 

ft_scalar N1 [format %.0f $N1]
ft_scalar N2 [format %.0f $N2]
ft_scalar N3 [format %.0f $N3]
ft_scalar N4 [format %.0f $N4]
ft_scalar N5 [format %.0f $N5]
ft_scalar N6 [format %.0f $N6]
ft_scalar N7 [format %.0f $N7]
ft_scalar N8 [format %.0f $N8]
ft_scalar N9 [format %.0f $N9]

set CCE [expr {${N5}/16000}] 
ft_scalar CCE [format %.3f $CCE] 

script_exit
 
# gr_setTitleAttr "I(t)"
# gr_setAxisAttr X  {Time (ns)}     16  {} {} black 1 14 0 5 0
# gr_setAxisAttr Y  {Current (A/um)} 16  {} {} black 1 14 0 5 1
# gr_setLegendAttr 1 Helvetica 10 {} white black black 1 top


