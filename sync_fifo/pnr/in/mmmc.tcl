create_library_set -name fast\
   -timing\
    [list ../../../lib2/min/fast.lib]
create_library_set -name slow\
   -timing\
    [list ../../../lib2/max/slow.lib]
create_rc_corner -name rc_best\
   -cap_table ../../../lib/captbl/worst/capTable\
   -preRoute_res 1.34236\
   -postRoute_res 1.34236\
   -preRoute_cap 1.10066\
   -postRoute_cap 0.960235\
   -postRoute_xcap 1.22327\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -postRoute_clkcap {0.969117 0 0}\
   -T 0\
   -qx_tech_file ../../../lib/qx/qrcTechFile\
   -qx_conf_file ../../../lib/qx/qrc.conf
create_rc_corner -name rc_worst\
   -cap_table ../../../lib/captbl/worst/capTable\
   -preRoute_res 1.34236\
   -postRoute_res 1.34236\
   -preRoute_cap 1.10066\
   -postRoute_cap 0.960234\
   -postRoute_xcap 1.22327\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -postRoute_clkcap {0.969117 0 0}\
   -T 125\
   -qx_tech_file ../../../lib/qx/qrcTechFile\
   -qx_conf_file ../../../lib/qx/qrc.conf
create_delay_corner -name slow_max\
   -library_set slow\
   -rc_corner rc_worst
create_delay_corner -name fast_min\
   -library_set fast\
   -rc_corner rc_best
create_constraint_mode -name functional_func_slow_max\
   -sdc_files\
    [list ../../tcons/sync_fifo.sdc]
create_analysis_view -name func_slow_max -constraint_mode functional_func_slow_max -delay_corner slow_max
create_analysis_view -name func_fast_min -constraint_mode functional_func_slow_max -delay_corner fast_min
set_analysis_view -setup [list func_slow_max] -hold [list func_fast_min]
