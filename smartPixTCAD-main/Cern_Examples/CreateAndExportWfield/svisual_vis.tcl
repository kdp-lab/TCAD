set plot1V n@node|-2@_midIMP_1V_0000_des 
set plot0V n@node|-2@_midIMP_0V_0000_des 

load_file $plot0V.tdr
create_plot -dataset $plot0V
load_file $plot1V.tdr
create_plot -dataset $plot1V

diff_plots "Plot_$plot1V Plot_$plot0V" -display

load_script_file probe_pot.tcl

exit
