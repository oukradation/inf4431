connect -url tcp:127.0.0.1:3121
source M:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.sdk/lab4_top_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zed 210248445746"} -index 0
loadhw M:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.sdk/lab4_top_hw_platform_0/system.hdf
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent Zed 210248445746"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248445746"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248445746"} -index 0
dow M:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.sdk/mt/Debug/mt.elf
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248445746"} -index 0
con
