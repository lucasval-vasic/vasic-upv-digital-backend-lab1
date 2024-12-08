#######################################################################################################
## Optimize Netlist
#######################################################################################################

## Uncomment to remove assigns & insert tiehilo cells during Incremental synthesis
##set_db / .remove_assigns true 
##set_remove_assign_options -buffer_or_inverter <libcell> -design <design|subdesign> 
##set_db / .use_tiehilo_for_const <none|duplicate|unique> 
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt
write_snapshot -outdir $REPORTS_PATH -tag syn_opt
report_summary -directory $REPORTS_PATH

puts "Runtime & Memory after 'syn_opt'"
time_info OPT
