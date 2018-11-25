proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir M:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.cache/wt [current_project]
  set_property parent.project_path M:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.xpr [current_project]
  set_property ip_output_repo M:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet M:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.runs/synth_1/lab4_top.dcp
  add_files -quiet m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.dcp
  set_property netlist_only true [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.dcp]
  add_files -quiet m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0.dcp
  set_property netlist_only true [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0.dcp]
  add_files -quiet m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_0/design_1_auto_pc_0.dcp
  set_property netlist_only true [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_0/design_1_auto_pc_0.dcp]
  add_files -quiet m:/pc/work/inf4431/lab4/lab4/task2/pr/ram_lab4/ram_lab4.dcp
  set_property netlist_only true [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/ram_lab4/ram_lab4.dcp]
  add_files -quiet m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/ip/ila_0/ila_0.dcp
  set_property netlist_only true [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/ip/ila_0/ila_0.dcp]
  read_xdc -ref design_1_processing_system7_0_0 -cells inst m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_proc_sys_reset_0_0 -cells U0 m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_board.xdc
  set_property processing_order EARLY [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_board.xdc]
  read_xdc -ref design_1_proc_sys_reset_0_0 -cells U0 m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0.xdc
  set_property processing_order EARLY [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0.xdc]
  read_xdc -mode out_of_context -ref ila_0 -cells U0 m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc
  set_property processing_order EARLY [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc]
  read_xdc -ref ila_0 -cells U0 m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc
  set_property processing_order EARLY [get_files m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc]
  read_xdc M:/pc/work/inf4431/lab4/lab4/task2/constraints/constraints_lab4.xdc
  link_design -top lab4_top -part xc7z020clg484-1
  write_hwdef -file lab4_top.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force lab4_top_opt.dcp
  catch { report_drc -file lab4_top_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force lab4_top_placed.dcp
  catch { report_io -file lab4_top_io_placed.rpt }
  catch { report_utilization -file lab4_top_utilization_placed.rpt -pb lab4_top_utilization_placed.pb }
  catch { report_control_sets -verbose -file lab4_top_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force lab4_top_routed.dcp
  catch { report_drc -file lab4_top_drc_routed.rpt -pb lab4_top_drc_routed.pb -rpx lab4_top_drc_routed.rpx }
  catch { report_methodology -file lab4_top_methodology_drc_routed.rpt -rpx lab4_top_methodology_drc_routed.rpx }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file lab4_top_timing_summary_routed.rpt -rpx lab4_top_timing_summary_routed.rpx }
  catch { report_power -file lab4_top_power_routed.rpt -pb lab4_top_power_summary_routed.pb -rpx lab4_top_power_routed.rpx }
  catch { report_route_status -file lab4_top_route_status.rpt -pb lab4_top_route_status.pb }
  catch { report_clock_utilization -file lab4_top_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force lab4_top_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

