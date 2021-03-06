# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir M:/pc/work/inf4431/lab2/delivery/stopwatch2/stopwatch2.cache/wt [current_project]
set_property parent.project_path M:/pc/work/inf4431/lab2/delivery/stopwatch2/stopwatch2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property ip_output_repo m:/pc/work/inf4431/lab2/delivery/stopwatch2/stopwatch2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  M:/pc/work/inf4431/lab2/delivery/subprog_pck.vhd
  M:/pc/work/inf4431/lab2/delivery/subprog_bdy.vhd
  M:/pc/work/inf4431/lab2/delivery/seg7ctrl_ent.vhd
  M:/pc/work/inf4431/lab2/delivery/decoder.vhd
  M:/pc/work/inf4431/lab2/delivery/clock_ent.vhd
  M:/pc/work/inf4431/lab2/delivery/timer.vhd
  M:/pc/work/inf4431/lab2/delivery/seg7ctrl_rtl.vhd
  M:/pc/work/inf4431/lab2/delivery/top_ent.vhd
  M:/pc/work/inf4431/lab2/delivery/clock_rtl.vhd
  M:/pc/work/inf4431/lab2/delivery/top_str.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc M:/pc/work/inf4431/lab2/delivery/stopwatch2/stopwatch2.srcs/constrs_1/new/constraints.xdc
set_property used_in_implementation false [get_files M:/pc/work/inf4431/lab2/delivery/stopwatch2/stopwatch2.srcs/constrs_1/new/constraints.xdc]


synth_design -top top -part xc7z020clg484-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
