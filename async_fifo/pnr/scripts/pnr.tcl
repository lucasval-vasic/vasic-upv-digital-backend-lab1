####################################################################################################
## Init
####################################################################################################
set BLOCK_NAME sync_fifo

source ../scripts/set_globals.tcl

####################################################################################################
## Load design
####################################################################################################

#set init_verilog {../in/${BLOCK_NAME}.vg}
set init_verilog {../in/sync_fifo.vg}
init_design

####################################################################################################
## Load floorplan
####################################################################################################

loadFPlan ../in/$BLOCK_NAME.power.fp
win

####################################################################################################
## Setup
####################################################################################################

setDesignMode -process 45
setMultiCpuUsage -localCpu 2

setAnalysisMode -analysisType onChipVariation -cppr both

setDontUse *XL true
setDontUse *X1 true

setPlaceMode -place_global_place_io_pins true

####################################################################################################
## Placement
####################################################################################################

place_opt_design
checkPlace leon.checkPlace
saveDesign DBS/prects.enc

####################################################################################################
## Clock tree
####################################################################################################

extractRC
rcOut -spef leon.spef -rc_corner rc_worst

setOptMode -opt_enable_podv2_clock_opt_flow true

add_ndr -width {Metal1 0.12 Metal2 0.14 Metal3 0.14 Metal4 0.14 Metal5 0.14 Metal6 0.14 Metal7 0.14 Metal8 0.14 Metal9 0.14 } -spacing {Metal1 0.12 Metal2 0.14 Metal3 0.14 Metal4 0.14 Metal5 0.14 Metal6 0.14 Metal7 0.14 Metal8 0.14 Metal9 0.14 } -name 2w2s
create_route_type -name clkroute -non_default_rule 2w2s -bottom_preferred_layer Metal5 -top_preferred_layer Metal6
set_ccopt_property route_type clkroute -net_type trunk
set_ccopt_property route_type clkroute -net_type leaf 
set_ccopt_property buffer_cells {CLKBUFX8 CLKBUFX12}
set_ccopt_property inverter_cells {CLKINVX8 CLKINVX12}
set_ccopt_property clock_gating_cells TLATNTSCA*
create_ccopt_clock_tree_spec -file ccopt.spec
source ccopt.spec
#clock_opt_design -cts
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
