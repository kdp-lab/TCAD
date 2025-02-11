# Note that this must be called directly before the SVisual script, since every time this job runs
# the file "probe_pot.tcl" overwritten. This is done because this file takes a lot of space. 

g++ mk_script.cpp
./a.out Plot_n@node|-1@_midIMP_1V_0000_des-Plot_n@node|-1@_midIMP_0V_0000_des @node|-1@
