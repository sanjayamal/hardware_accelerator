# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {Common 17-41} -limit 10000000
set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.cache/wt [current_project]
set_property parent.project_path C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property ip_repo_paths c:/ip_repo/neural_acc_1.0 [current_project]
set_property ip_output_repo c:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4.xci
set_property used_in_implementation false [get_files -all c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_ooc.xdc]
set_property is_locked true [get_files c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.runs/blk_mem_gen_4_synth_1 -new_name blk_mem_gen_4 -ip [get_ips blk_mem_gen_4]]

if { $cached_ip eq {} } {

synth_design -top blk_mem_gen_4 -part xc7z020clg484-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix blk_mem_gen_4_ blk_mem_gen_4.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_4_stub.v
 lappend ipCachedFiles blk_mem_gen_4_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_4_stub.vhdl
 lappend ipCachedFiles blk_mem_gen_4_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_4_sim_netlist.v
 lappend ipCachedFiles blk_mem_gen_4_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_4_sim_netlist.vhdl
 lappend ipCachedFiles blk_mem_gen_4_sim_netlist.vhdl

 config_ip_cache -add -dcp blk_mem_gen_4.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips blk_mem_gen_4]
}

rename_ref -prefix_all blk_mem_gen_4_

write_checkpoint -force -noxdef blk_mem_gen_4.dcp

catch { report_utilization -file blk_mem_gen_4_utilization_synth.rpt -pb blk_mem_gen_4_utilization_synth.pb }

if { [catch {
  file copy -force C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.runs/blk_mem_gen_4_synth_1/blk_mem_gen_4.dcp c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.runs/blk_mem_gen_4_synth_1/blk_mem_gen_4.dcp c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.runs/blk_mem_gen_4_synth_1/blk_mem_gen_4_stub.v c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.runs/blk_mem_gen_4_synth_1/blk_mem_gen_4_stub.vhdl c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.runs/blk_mem_gen_4_synth_1/blk_mem_gen_4_sim_netlist.v c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.runs/blk_mem_gen_4_synth_1/blk_mem_gen_4_sim_netlist.vhdl c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.ip_user_files/ip/blk_mem_gen_4]} {
  catch { 
    file copy -force c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_stub.v C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.ip_user_files/ip/blk_mem_gen_4
  }
}

if {[file isdir C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.ip_user_files/ip/blk_mem_gen_4]} {
  catch { 
    file copy -force c:/ip_repo/blk_mem_gen_4_1/blk_mem_gen_4_stub.vhdl C:/ip_repo/neural_acc_v1_0_project/neural_acc_v1_0_project.ip_user_files/ip/blk_mem_gen_4
  }
}