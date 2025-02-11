lib::SetInfoDef 1
create_plot -1d -name Plot_CV
set N @node|-1@

set_plot_prop -title "C = pixel matrix to backside capacitance" -title_font_size 20
set_axis_prop -axis x -title {Bias voltage [V]} \
	-title_font_size 16 -scale_font_size 14 -type linear
set_axis_prop -axis y -title {1/C^2 [1/pF^2]} \
	-title_font_size 16 -scale_font_size 14 -type linear
set_legend_prop -font_size 12 -location top_left -font_att bold

#load_file #INSERT SOME PATH HERE 
#create_variable -name HPK1000Hzcurrent -dataset HPK1000Hz -function 1/(<cap:HPK1000Hz>^2)
#create_curve -name HPK1000Hz -dataset HPK1000Hz -axisX  "voltage" -axisY  "HPK1000Hzcurrent"
#set_curve_prop HPK1000Hz -label "HPK1000Hz" \
#	-color black -line_style solid -line_width 3

select_plots Plot_CV
load_file n${N}_ac_des.plt -name PLT($N)
create_variable -name 1overC2 -dataset PLT($N) -function "1/(<c(cn,cp):PLT($N)>*256*256*55*1e12)^2"  
create_variable -name negV -dataset PLT($N) -function "-<v(cp):PLT($N)>"
create_curve -name CV($N) -dataset PLT($N) \
	-axisX "negV" -axisY "1overC2"
set_curve_prop CV($N) -label "Simulation" \
	-color blue -line_style solid -line_width 2



