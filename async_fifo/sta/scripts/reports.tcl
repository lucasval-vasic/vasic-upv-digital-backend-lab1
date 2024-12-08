##########################
#Generate SI glitch report
##########################
report_noise -txtfile ${REPORT_DIR}/glitch.rpt

#####################
# Reports that check design health
#####################
check_design -type timing -out_file    ${REPORT_DIR}/check_design.rpt
check_timing -verbose > ${REPORT_DIR}/check_timing.rpt
report_annotated_parasitics         > ${REPORT_DIR}/annotated.rpt
report_analysis_coverage            > ${REPORT_DIR}/coverage.rpt

#####################
# Reports that describe constraints
#####################
report_clocks                       > ${REPORT_DIR}/clocks.rpt
report_case_analysis                > ${REPORT_DIR}/case_analysis.rpt
report_inactive_arcs                > ${REPORT_DIR}/inactive_arcs.rpt
 
#####################
# Reports that describe timing health
#####################
report_constraint -all_violators                                > ${REPORT_DIR}/allviol.rpt
report_analysis_summary                                         > ${REPORT_DIR}/analysis_summary.rpt
report_timing -path_type summary_slack_only -late -max_paths 5  > ${REPORT_DIR}/start_end_slack.rpt

#####################
# GBA Reports that show detailed timing
#####################
report_timing -late   -max_paths 50 -nworst 1 -path_type full_clock -net  > ${REPORT_DIR}/worst_max_path.rpt
report_timing -early  -max_paths 50 -nworst 1 -path_type full_clock -net  > ${REPORT_DIR}/worst_min_path.rpt
report_timing -path_type end_slack_only                       > ${REPORT_DIR}/setup_1.rpt
report_timing -path_type end_slack_only  -early               > ${REPORT_DIR}/hold_1.rpt
report_timing -late    -max_paths 100                         > ${REPORT_DIR}/setup_100.rpt.gz
report_timing -early   -max_paths 100                         > ${REPORT_DIR}/hold_100.rpt.gz

#####################
# PBA Reports that show detailed timing
#####################
report_timing -retime path_slew_propagation -max_paths 50 -nworst 1 -path_type full_clock    > ${REPORT_DIR}/pba_50_paths.rpt


