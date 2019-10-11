@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.1\\bin
call %xv_path%/xsim neural_acc_tb_behav -key {Behavioral:sim_1:Functional:neural_acc_tb} -tclbatch neural_acc_tb.tcl -view C:/ip_repo/neural_acc_v1_0_project/neural_acc_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
