#-------------------------------------------------------------------------------
#   define library set
#-------------------------------------------------------------------------------

# slow timing UPF
create_library_set -name ls_wc_upf -timing { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/liberty_LPMOS/v4_1_1/PVT_1_80V_range/D_CELLS_JIHD_LPMOS_slow_1_62V_125C.lib \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/IO_CELLS_F3V/v2_1/liberty_UPF_LPMOS/v2_1_0/PVT_1_80V_3_30V_range/IO_CELLS_F3V_LPMOS_UPF_slow_1_62V_3_00V_125C.lib \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/spram/XSPRAMLP_128X16_M8P/v4_0_2/liberty_UPF_LPMOS/XSPRAMLP_128X16_M8P_UPF_slow_1_62V_125C.lib } \
    -si { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/IO_CELLS_F3V/IO_CELLS_F3V_LPMOS_slow_1_62V_3_00V_125C.cdB \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/D_CELLS_JIHD/D_CELLS_JIHD_LPMOS_slow_1_62V_125C.cdB }

# fast timing UPF
create_library_set -name ls_bc_upf -timing { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/liberty_LPMOS/v4_1_1/PVT_1_80V_range/D_CELLS_JIHD_LPMOS_fast_1_98V_m40C.lib \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/IO_CELLS_F3V/v2_1/liberty_UPF_LPMOS/v2_1_0/PVT_1_80V_3_30V_range/IO_CELLS_F3V_LPMOS_UPF_fast_1_98V_3_60V_m40C.lib \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/spram/XSPRAMLP_128X16_M8P/v4_0_2/liberty_UPF_LPMOS/XSPRAMLP_128X16_M8P_UPF_fast_1_98V_m40C.lib } \
    -si { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/IO_CELLS_F3V/IO_CELLS_F3V_LPMOS_fast_1_98V_3_60V_m40C.cdB \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/D_CELLS_JIHD/D_CELLS_JIHD_LPMOS_fast_1_98V_m40C.cdB }

# slow timing CCST
create_library_set -name ls_wc_ccst -timing { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/liberty_CCS_TIMING_LPMOS/v4_1_1/PVT_1_80V_range/D_CELLS_JIHD_LPMOS_ccs_timing_slow_1_62V_125C.lib.gz \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/IO_CELLS_F3V/v2_1/liberty_CCS_TIMING_LPMOS/v2_1_0/PVT_1_80V_3_30V_range/IO_CELLS_F3V_LPMOS_ccs_timing_slow_1_62V_3_00V_125C.lib.gz \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/spram/XSPRAMLP_128X16_M8P/v4_0_2/liberty_UPF_LPMOS/XSPRAMLP_128X16_M8P_UPF_slow_1_62V_125C.lib } \
    -si { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/IO_CELLS_F3V/IO_CELLS_F3V_LPMOS_slow_1_62V_3_00V_125C.cdB \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/D_CELLS_JIHD/D_CELLS_JIHD_LPMOS_slow_1_62V_125C.cdB }

# fast timing CCST
create_library_set -name ls_bc_ccst -timing { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/liberty_CCS_TIMING_LPMOS/v4_1_1/PVT_1_80V_range/D_CELLS_JIHD_LPMOS_ccs_timing_fast_1_98V_m40C.lib.gz \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/IO_CELLS_F3V/v2_1/liberty_CCS_TIMING_LPMOS/v2_1_0/PVT_1_80V_3_30V_range/IO_CELLS_F3V_LPMOS_ccs_timing_fast_1_98V_3_60V_m40C.lib.gz \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/spram/XSPRAMLP_128X16_M8P/v4_0_2/liberty_UPF_LPMOS/XSPRAMLP_128X16_M8P_UPF_fast_1_98V_m40C.lib } \
    -si { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/IO_CELLS_F3V/IO_CELLS_F3V_LPMOS_fast_1_98V_3_60V_m40C.cdB \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/D_CELLS_JIHD/D_CELLS_JIHD_LPMOS_fast_1_98V_m40C.cdB }

# slow timing CCSP
create_library_set -name ls_wc_ccsp -timing { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/liberty_CCS_POWER_LPMOS/v4_1_1/PVT_1_80V_range/D_CELLS_JIHD_LPMOS_ccs_power_slow_1_62V_125C.lib.gz \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/IO_CELLS_F3V/v2_1/liberty_CCS_POWER_LPMOS/v2_1_0/PVT_1_80V_3_30V_range/IO_CELLS_F3V_LPMOS_ccs_power_slow_1_62V_3_00V_125C.lib.gz \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/spram/XSPRAMLP_128X16_M8P/v4_0_2/liberty_UPF_LPMOS/XSPRAMLP_128X16_M8P_UPF_slow_1_62V_125C.lib } \
    -si { \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/IO_CELLS_F3V/IO_CELLS_F3V_LPMOS_slow_1_62V_3_00V_125C.cdB \
    /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/celticDB/D_CELLS_JIHD/D_CELLS_JIHD_LPMOS_slow_1_62V_125C.cdB }

#-------------------------------------------------------------------------------
#   create timing condition
#-------------------------------------------------------------------------------

#create_timing_condition -name tc_wc_upf -library_sets ls_wc_upf
#create_timing_condition -name tc_bc_upf -library_sets ls_bc_upf

#create_timing_condition -name tc_wc_ccst -library_sets ls_wc_ccst
#create_timing_condition -name tc_bc_ccst -library_sets ls_bc_ccst

#create_timing_condition -name tc_wc_ccsp -library_sets ls_wc_ccsp

#-------------------------------------------------------------------------------
#   create RC corner
#-------------------------------------------------------------------------------

create_rc_corner \
    -T 125 \
    -cap_table /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/cadence/v8_0/capTbl/v8_0_1/xh018_xx51_MET5_METMID_max.capTbl \
    -name rc_cworst \
    -qx_tech_file  /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/cadence/v8_0/QRC_pvs/v8_0_1_1/XH018_1151/QRC-Max/qrcTechFile

create_delay_corner -name dc_wc_upf -rc_corner rc_cworst -library_set ls_wc_upf

create_rc_corner \
    -T -40 \
    -cap_table /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/cadence/v8_0/capTbl/v8_0_1/xh018_xx51_MET5_METMID_min.capTbl \
    -name rc_cbest \
    -qx_tech_file /cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/cadence/v8_0/QRC_pvs/v8_0_1_1/XH018_1151/QRC-Min/qrcTechFile

create_delay_corner -name dc_bc_upf -rc_corner rc_cbest -library_set ls_bc_upf

#-------------------------------------------------------------------------------
#   create constraint mode
#-------------------------------------------------------------------------------

create_constraint_mode -name cm -sdc_files [list ../../tcons/$BLOCK_NAME.sdc]


#-------------------------------------------------------------------------------
#   create analysis view
#-------------------------------------------------------------------------------

create_analysis_view -name av_wc_upf -delay_corner dc_wc_upf -constraint_mode cm
create_analysis_view -name av_bc_upf -delay_corner dc_bc_upf -constraint_mode cm

#-------------------------------------------------------------------------------
#   activate analysis view
#-------------------------------------------------------------------------------

set_analysis_view -setup {av_wc_upf} -hold {av_bc_upf}