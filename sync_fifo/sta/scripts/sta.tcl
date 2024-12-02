set BLOCK_NAME "sync_fifo"
set LIB_PATH "../../../lib/slow.lib"
set REPORT_DIR "../rep"

################################
# Load netlist parasitics
################################

source ../scripts/load_design.tcl

################################
# Load netlist parasitics
################################

#read_spef  ../../design/SPEF/corner_worst_CMAX.spef.gz

################################
# Add constraints
################################

read_sdc ../../tcons/$BLOCK_NAME.sdc

################################
# Adjust timer settings
################################

set_delay_cal_mode -siAware true    ;# Turn on SI when true

################################################################
#To dump aggressor info in report_delay_calculation -si command
#################################################################

set_si_mode -enable_delay_report true

##########################################
#enable the glitch reports to be generated
##########################################

set_si_mode -enable_glitch_report true

##########################
#Enable glitch propagation
##########################

set_si_mode -enable_glitch_propagation true
set_global timing_pba_exhaustive_path_nworst_limit 2
set_global timing_path_based_exhaustive_max_paths_limit 1000
#set_global timing_path_based_enable_exhaustive_depth_bounded_by_gba false

###################################
# Run timing
###################################

update_timing -full

###################################
# Create reports
###################################

source ../scripts/reports.tcl


puts "STA completed"
###################################
# If in interactive session, return to the Tempus prompt
# If in batch session, return to the Linux prompt
###################################
#exit
