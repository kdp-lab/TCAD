
set COLORS  [list green blue red orange magenta violet brown]
set color   [lindex  $COLORS [expr @node@%[llength $COLORS] ]]

set projname n@node|-2@transientn@node|-2@
set curvename n@node|-2@
set leftcurvename n@node|-2@left
set rightcurvename n@node|-2@right

set IVprojname n@node|-2@
set IVcurvename n@node|-2@IV

proj_load ${projname}_des.plt $projname
proj_load ${IVprojname}_des.plt $IVprojname

cv_createDS $curvename "$projname time" "$projname IMP2_electrode TotalCurrent" y
cv_createDS $leftcurvename "$projname time" "$projname IMP1_electrode TotalCurrent" y
cv_createDS $rightcurvename "$projname time" "$projname IMP3_electrode TotalCurrent" y
cv_createDS $IVcurvename "$IVprojname BOT_electrode InnerVoltage" "$IVprojname IMP2_electrode TotalCurrent" y

# cv_abs $curvename y
cv_setCurveAttr $curvename "n@node|sdevice@" $color solid 2 none 3 defcolor 1 defcolor

set Q [cv_compute "vecmax(integr(<${curvename}>))" A A A A]
set N [expr {${Q}/1.60217e-19}] 
ft_scalar N [format %.0f $N]

set Qleft [cv_compute "vecmin(integr(<${leftcurvename}>))" A A A A]
set Qright [cv_compute "vecmin(integr(<${rightcurvename}>))" A A A A]
set Nleft [expr {${Qleft}/1.60217e-19}] 
set Nright [expr {${Qright}/1.60217e-19}] 
ft_scalar Nleft [format %.0f $Nleft]
ft_scalar Nright [format %.0f $Nright]

set CCE [expr {${N}/@Ndep@}] 
ft_scalar CCE [format %.3f $CCE] 

set I [cv_compute "vecvaly(<$IVcurvename>, -150)" A A A A]
ft_scalar I_150 [format %.0f [expr {${I}*256*256*55*1e6}]]
set I [cv_compute "vecvaly(<$IVcurvename>, -500)" A A A A]
ft_scalar I_500 [format %.0f [expr {${I}*256*256*55*1e6}]]
set I [cv_compute "vecvaly(<$IVcurvename>, -1000)" A A A A]
ft_scalar I_1000 [format %.0f [expr {${I}*256*256*55*1e6}]]
#if "@doPlot@" == "true"
#else
	script_exit
#endif
 
# gr_setTitleAttr "I(t)"
# gr_setAxisAttr X  {Time (ns)}     16  {} {} black 1 14 0 5 0
# gr_setAxisAttr Y  {Current (A/um)} 16  {} {} black 1 14 0 5 1
# gr_setLegendAttr 1 Helvetica 10 {} white black black 1 top


