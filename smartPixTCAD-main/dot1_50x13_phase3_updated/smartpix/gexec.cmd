# project name
name smartpix
# execution graph
job 3   -post { extract_vars "$nodedir" n3_des.out 3 }  -o n3_des "sdevice pp3_des.cmd"
job 1   -post { extract_vars "$nodedir" n1_dvs.out 1 }  -o n1_dvs "sde -e -l n1_dvs.cmd"
job 2 -d "1" -pre { snmesh_prologue 2 n1_msh.cmd n1_msh.tdr n1_bnd.tdr } -post { extract_vars "$nodedir" n2_msh.out 2 }  -o n2_msh "snmesh  "
check sde_dvs.cmd 1737408267
check sde_epi.csv 1723570009
check sdevice_des.cmd 1731352328
check global_tooldb 1705494888
check gtree.dat 1737408296
# included files
