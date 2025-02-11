# project name
name 3D_eFields
# execution graph
job 51   -post { extract_vars "$nodedir" n51_dvs.out 51 }  -o n51_dvs "sde -e -l n51_dvs.cmd"
job 56 -d "51"  -post { extract_vars "$nodedir" n56_des.out 56 }  -o n56_des "sdevice pp56_des.cmd"
check sde_dvs.cmd 1467105368
check sdevice_des.cmd 1466067483
check sdevice.par 1467109020
check global_tooldb 1705494888
check gtree.dat 1467197349
