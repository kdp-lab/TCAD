# project name
name CV_pixel
# execution graph
job 8   -post { extract_vars "$nodedir" n8_des.out 8 }  -o n8_des "sdevice pp8_des.cmd"
job 9   -post { extract_vars "$nodedir" n9_vis.out 9 }  -o n9_vis "svisual n9_vis.tcl"
job 11   -post { extract_vars "$nodedir" n11_des.out 11 }  -o n11_des "sdevice pp11_des.cmd"
job 12   -post { extract_vars "$nodedir" n12_vis.out 12 }  -o n12_vis "svisual n12_vis.tcl"
check sdevice_des.cmd 1467197137
check sdevice.par 1467109017
check svisual_vis.tcl 1467105618
check global_tooldb 1705494888
check gtree.dat 1467197147
