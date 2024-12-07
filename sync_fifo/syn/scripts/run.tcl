#### Template Script for RTL->Gate-Level Flow (generated from GENUS 17.10-p007_1) 

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################

set BLOCK_NAME sync_fifo
set GEN_EFF medium
set MAP_OPT_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"] 
set OUTPUTS_PATH ../out
set REPORTS_PATH ../rep
set LOG_PATH ../log

##Uncomment and specify machine names to enable super-threading.
##set_db / .super_thread_servers {<machine names>} 
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs
##set_db / .max_cpus_per_server 8

##Default undriven/unconnected setting is 'none'.  
##set_db / .hdl_unconnected_input_port_value 0 | 1 | x | none 
##set_db / .hdl_undriven_output_port_value   0 | 1 | x | none
##set_db / .hdl_undriven_signal_value        0 | 1 | x | none 

##set_db / .wireload_mode <value> 
set_db / .information_level 7 

if {![file exists ${LOG_PATH}]} {
  file mkdir ${LOG_PATH}
  puts "Creating directory ${LOG_PATH}"
}


if {![file exists ${OUTPUTS_PATH}]} {
  file mkdir ${OUTPUTS_PATH}
  puts "Creating directory ${OUTPUTS_PATH}"
}

if {![file exists ${REPORTS_PATH}]} {
  file mkdir ${REPORTS_PATH}
  puts "Creating directory ${REPORTS_PATH}"
}

###############################################################
## Library setup
###############################################################

## cell libs

# X-FAB 0.18um
set_db / .library { /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/liberty_LPMOS/v4_1_1/PVT_1_80V_range/D_CELLS_JIHD_LPMOS_slow_1_62V_125C.lib }

set_db / .lef_library  { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/cadence/v8_0/techLEF/v8_0_1_1/xh018_xx51_MET5_METMID.lef \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/LEF/v4_1_1/xh018_D_CELLS_JIHD.lef \
}

# AMS 0.35um
#set_db / .library { /cadence_pdk/AMS/AMS_410_ISR15/liberty/c35_1.8V/c35_CORELIB_WC.lib }

#set_db / .lef_library  { \
#    /cadence_pdk/AMS/AMS_410_ISR15/cds/HK_C35/LEF/c35b4/c35b4.lef \
#    /cadence_pdk/AMS/AMS_410_ISR15/cds/HK_C35/LEF/c35b4/CORELIB.lef \
#}

## Provide either cap_table_file or the qrc_tech_file
##set_db / .cap_table_file <file> 
#set_db / .qrc_tech_file <file>

##set_db / .lp_insert_clock_gating true 

####################################################################
## Load Design
####################################################################


read_hdl -language v2001 "../in/${BLOCK_NAME}.v"
elaborate $BLOCK_NAME
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration

check_design
check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

read_sdc ../../tcons/${BLOCK_NAME}.sdc
puts "The number of exceptions is [llength [vfind "design:$BLOCK_NAME" -exception *]]"

####################################################################################################
## Synthesizing to generic 
####################################################################################################
source ../scripts/syn_generic.tcl

####################################################################################################
## Synthesizing to gates
####################################################################################################
source ../scripts/syn_tech.tcl

#######################################################################################################
## Optimize Netlist
#######################################################################################################
source ../scripts/optimize.tcl

#######################################################################################################
## Write outputs
#######################################################################################################
source ../scripts/write_outputs.tcl

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

#file copy [get_db / .stdout_log] ${LOG_PATH}

quit
