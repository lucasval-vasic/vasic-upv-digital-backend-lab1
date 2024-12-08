####################################################################################################
## Init
####################################################################################################
source ../scripts/set_globals.tcl

####################################################################################################
## Load design
####################################################################################################

init_design

####################################################################################################
## Load floorplan
####################################################################################################

#loadFPlan ../in/$BLOCK_NAME.power.fp

floorPlan -siteOnly core_jihd \
    -b      {   0.00   0.00 1430.00 1430.00 \
                160.00 160.00 1270.00 1270.00 \
                220.50 220.21 1209.46 1210.29  }\
    -noSnapToGrid

win

####################################################################################################
## Setup
####################################################################################################

setDesignMode -process 180
setMultiCpuUsage -localCpu 2

setAnalysisMode -analysisType onChipVariation -cppr both

setDontUse *XL true
setDontUse *X1 true

setPlaceMode -place_global_place_io_pins true
setPlaceMode -place_global_ignore_scan false

####################################################################################################
## Placement
####################################################################################################

place_opt_design
checkPlace ../rep/$BLOCK_NAME.checkPlace
saveDesign DBS/prects.enc

####################################################################################################
## Clock tree
####################################################################################################

extractRC
rcOut -spef ../out/$BLOCK_NAME.spef -rc_corner rc_cworst

delete_ccopt_clock_tree_spec
create_ccopt_clock_tree_spec -file ccopt.spec

source ccopt.spec

set_db cts_update_clock_latency false
set_db cts_inverter_cells {INJIHDX0 INJIHDX1 INJIHDX3 INJIHDX4 INJIHDX6 INJIHDX8 INJIHDX12}
set_db cts_buffer_cells {BUJIHDX0 BUJIHDX1 BUJIHDX3 BUJIHDX4 BUJIHDX6 BUJIHDX8 BUJIHDX12}

ccopt_design -cts
saveDesign DBS/cts.enc

####################################################################################################
## Optimization
####################################################################################################

timeDesign -postCTS

optDesign -postCTS
saveDesign DBS/postcts.enc

####################################################################################################
## Route
####################################################################################################

routeDesign
saveDesign DBS/route.enc

####################################################################################################
## Optimization
####################################################################################################

setExtractRCMode -engine postRoute
setExtractRCMode -effortLevel medium
timeDesign -postRoute
timeDesign -postRoute -hold

optDesign -postRoute -setup -hold
saveDesign DBS/postroute.enc

####################################################################################################
## Verification
####################################################################################################

verifyGeometry

####################################################################################################
## Write output
####################################################################################################

saveNetlist ../out/$BLOCK_NAME.vg

exit
