load_library extend

set COLORS  [list green blue red orange magenta violet brown]
set color   [lindex  $COLORS [expr @node@%[llength $COLORS] ]]

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
set c4 curve4
set c5 curve5

cv_createDS $c1 "$projname time" "$projname IMP1_electrode TotalCurrent" y
cv_createDS $c2 "$projname time" "$projname IMP2_electrode TotalCurrent" y
cv_createDS $c3 "$projname time" "$projname IMP3_electrode TotalCurrent" y
cv_createDS $c4 "$projname time" "$projname IMP4_electrode TotalCurrent" y
cv_createDS $c5 "$projname time" "$projname IMP5_electrode TotalCurrent" y

set Q1 [cv_compute "vecvaly(integr(<${c1}> - $LEAKAGE), @inttime@)" A A A A]
set Q2 [cv_compute "vecvaly(integr(<${c2}> - $LEAKAGE), @inttime@)" A A A A]
set Q3 [cv_compute "vecvaly(integr(<${c3}> - $LEAKAGE), @inttime@)" A A A A]
set Q4 [cv_compute "vecvaly(integr(<${c4}> - $LEAKAGE), @inttime@)" A A A A]
set Q5 [cv_compute "vecvaly(integr(<${c5}> - $LEAKAGE), @inttime@)" A A A A]

set N1 [expr {${Q1}/1.60217e-19}] 
set N2 [expr {${Q2}/1.60217e-19}] 
set N3 [expr {${Q3}/1.60217e-19}] 
set N4 [expr {${Q4}/1.60217e-19}] 
set N5 [expr {${Q5}/1.60217e-19}] 

ft_scalar N1 [format %.0f $N1]
ft_scalar N2 [format %.0f $N2]
ft_scalar N3 [format %.0f $N3]
ft_scalar N4 [format %.0f $N4]
ft_scalar N5 [format %.0f $N5]

# ft_scalar NTOT [format %.0f [expr {$N1+$N2+$N3+$N4+$N5}]]

set CCE [expr {${N3}/16000}] 
ft_scalar CCE_TCAD [format %.3f $CCE] 

script_exit
 




# 
# set COLORS  [list green blue red orange magenta violet brown]
# set color   [lindex  $COLORS [expr @node@%[llength $COLORS] ]]
# 
# set projname transientn@node|-1@
# proj_load ${projname}_des.plt $projname
# 
# set c1 curve1
# #if "@mesh@" == "2D_P3" || "@mesh@" == "2D_P5"
# set c2 curve2
# set c3 curve3
# #endif
# #if "@mesh@" == "2D_P5"
# set c4 curve4
# set c5 curve5
# #endif
# 
# cv_createDS $c1 "$projname time" "$projname IMP1_electrode TotalCurrent" y
# #if "@mesh@" == "2D_P3" || "@mesh@" == "2D_P5"
# cv_createDS $c2 "$projname time" "$projname IMP2_electrode TotalCurrent" y
# cv_createDS $c3 "$projname time" "$projname IMP3_electrode TotalCurrent" y
# #endif
# #if "@mesh@" == "2D_P5"
# cv_createDS $c4 "$projname time" "$projname IMP4_electrode TotalCurrent" y
# cv_createDS $c5 "$projname time" "$projname IMP5_electrode TotalCurrent" y
# #endif
# 
# # cv_abs $curvename y
# # cv_setCurveAttr $curvename "n@node|sdevice@" $color solid 2 none 3 defcolor 1 defcolor
# 
# set Q1 [cv_compute "vecmax(integr(<${c1}>))" A A A A]
# #if "@mesh@" == "2D_P3" || "@mesh@" == "2D_P5"
# set Q2 [cv_compute "vecmax(integr(<${c2}>))" A A A A]
# set Q3 [cv_compute "vecmax(integr(<${c3}>))" A A A A]
# #endif
# #if "@mesh@" == "2D_P5"
# set Q4 [cv_compute "vecmax(integr(<${c4}>))" A A A A]
# set Q5 [cv_compute "vecmax(integr(<${c5}>))" A A A A]
# #endif
# 
# set N1 [expr {${Q1}/1.60217e-19}] 
# #if "@mesh@" == "2D_P3" || "@mesh@" == "2D_P5"
# set N2 [expr {${Q2}/1.60217e-19}] 
# set N3 [expr {${Q3}/1.60217e-19}] 
# #endif
# #if "@mesh@" == "2D_P5"
# set N4 [expr {${Q4}/1.60217e-19}] 
# set N5 [expr {${Q5}/1.60217e-19}] 
# #endif
# 
# ft_scalar N1 [format %.0f $N1]
# #if "@mesh@" == "2D_P3" || "@mesh@" == "2D_P5"
# ft_scalar N2 [format %.0f $N2]
# ft_scalar N3 [format %.0f $N3]
# #endif
# #if "@mesh@" == "2D_P5"
# ft_scalar N4 [format %.0f $N4]
# ft_scalar N5 [format %.0f $N5]
# #endif
# 
# #if "@mesh@" == "2D_P1"
# set CCE [expr {${N1}/16000}] 
# ft_scalar CCE [format %.3f $CCE] 
# #endif
# 
# #if "@mesh@" == "2D_P3"
# set CCE [expr {${N2}/16000}] 
# ft_scalar CCE [format %.3f $CCE] 
# #endif
# 
# #if "@mesh@" == "2D_P5"
# set CCE [expr {${N3}/16000}] 
# ft_scalar CCE [format %.3f $CCE] 
# #endif
# 
# 
# script_exit
#  
# # gr_setTitleAttr "I(t)"
# # gr_setAxisAttr X  {Time (ns)}     16  {} {} black 1 14 0 5 0
# # gr_setAxisAttr Y  {Current (A/um)} 16  {} {} black 1 14 0 5 1
# # gr_setLegendAttr 1 Helvetica 10 {} white black black 1 top
# 
# 
