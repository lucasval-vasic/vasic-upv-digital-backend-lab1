# clocks
create_clock -name wrclk -add -period 100.0 [get_ports wrclk]
create_clock -name rdclk -add -period 100.0 [get_ports rdclk]

# inputs
set_input_delay -clock [get_clocks wrclk] -add_delay 1.0 [get_ports data[*]]
set_input_delay -clock [get_clocks wrclk] -add_delay 1.0 [get_ports wrreq]
set_input_delay -clock [get_clocks rdclk] -add_delay 1.0 [get_ports rdreq]
set_false_path -from [get_ports aclr]

set_load 0.1 [get_ports data[*]]
set_load 0.1 [get_ports wrreq]
set_load 0.1 [get_ports rdreq]
set_load 0.1 [get_ports aclr]
set_load 0.1 [get_ports wrclk]
set_load 0.1 [get_ports rdclk]

set_driving_cell -lib_cell BUJIHDX4 -library D_CELLS_JIHD_LPMOS_fast_1_98V_m40C -pin Y data[*]
set_driving_cell -lib_cell BUJIHDX4 -library D_CELLS_JIHD_LPMOS_fast_1_98V_m40C -pin Y wrreq
set_driving_cell -lib_cell BUJIHDX4 -library D_CELLS_JIHD_LPMOS_fast_1_98V_m40C -pin Y rdreq
set_driving_cell -lib_cell BUJIHDX4 -library D_CELLS_JIHD_LPMOS_fast_1_98V_m40C -pin Y aclr
set_driving_cell -lib_cell BUJIHDX4 -library D_CELLS_JIHD_LPMOS_fast_1_98V_m40C -pin Y wrclk
set_driving_cell -lib_cell BUJIHDX4 -library D_CELLS_JIHD_LPMOS_fast_1_98V_m40C -pin Y rdclk

set_input_transition 1.3 [get_ports data[*]]
set_input_transition 1.3 [get_ports wrreq]
set_input_transition 1.3 [get_ports rdreq]
set_input_transition 1.3 [get_ports aclr]
set_input_transition 1.3 [get_ports wrclk]
set_input_transition 1.3 [get_ports rdclk]

# outputs
set_output_delay -clock [get_clocks rdclk] -add_delay 1.0 [get_ports q[*]]
set_output_delay -clock [get_clocks wrclk] -add_delay 1.0 [get_ports wr_full]
set_output_delay -clock [get_clocks wrclk] -add_delay 1.0 [get_ports wr_empty]
set_output_delay -clock [get_clocks wrclk] -add_delay 1.0 [get_ports wrusedw]
set_output_delay -clock [get_clocks rdclk] -add_delay 1.0 [get_ports rd_full]
set_output_delay -clock [get_clocks rdclk] -add_delay 1.0 [get_ports rd_empty]
set_output_delay -clock [get_clocks rdclk] -add_delay 1.0 [get_ports rdusedw]

set_load 0.1 [get_ports q[*]]
set_load 0.1 [get_ports wr_full]
set_load 0.1 [get_ports wr_empty]
set_load 0.1 [get_ports wrusedw]
set_load 0.1 [get_ports rd_full]
set_load 0.1 [get_ports rd_empty]
set_load 0.1 [get_ports rdusedw]

set_propagated_clock [all_clocks]
set_clock_uncertainty -hold 0.1 [all_clocks]
set_clock_uncertainty -setup 0.1 [all_clocks]
