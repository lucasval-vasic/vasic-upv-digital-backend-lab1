#################################
### Write outputs
#################################

write_snapshot -outdir ${REPORTS_PATH} -tag final
report_summary -directory ${REPORTS_PATH}
write_hdl  > ${OUTPUTS_PATH}/${BLOCK_NAME}.vg
#write_script > ${OUTPUTS_PATH}/${BLOCK_NAME}.script
write_sdc > ${OUTPUTS_PATH}/${BLOCK_NAME}_m.sdc

write_do_lec -golden_design fv_map -revised_design ${OUTPUTS_PATH}/${BLOCK_NAME}_m.v -logfile  ${LOG_PATH}/intermediate2final.lec.log > ${OUTPUTS_PATH}/intermediate2final.lec.do
#Uncomment if the RTL is to be compared with the final netlist..
write_do_lec -revised_design ${OUTPUTS_PATH}/${BLOCK_NAME}_m.v -logfile ${LOG_PATH}/rtl2final.lec.log > ${OUTPUTS_PATH}/rtl2final.lec.do
