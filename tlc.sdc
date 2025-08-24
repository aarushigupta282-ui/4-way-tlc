# Create main clock with 10ns period (100MHz)
create_clock -name clk -period 10 -waveform {0 5} [get_ports clock]

# Clock transition times
set_clock_transition -rise 0.1 [get_clocks clk]
set_clock_transition -fall 0.1 [get_clocks clk]

# Clock uncertainty (for setup/hold margin)
set_clock_uncertainty 0.01 [get_clocks clk]

# Input delay for reset signal (assuming active-high reset)
set_input_delay -max 1.0 [get_ports reset] -clock [get_clocks clk]

# Output delay for light signals (north, south, east, west)
set_output_delay -max 1.0 [get_ports north] -clock [get_clocks clk]
set_output_delay -max 1.0 [get_ports south] -clock [get_clocks clk]
set_output_delay -max 1.0 [get_ports east] -clock [get_clocks clk]
set_output_delay -max 1.0 [get_ports west] -clock [get_clocks clk]

# Optional: Load and drive assumptions for accuracy
# set_driving_cell -lib_cell INVX1 -library <your_lib> [get_ports reset]
# set_load 0.05 [get_ports {north south east west}]set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1000.0ps

# Set the current design
current_design counter

create_clock -name "clk" -add -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports rst]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[0]}]
set_ideal_network [get_ports rst]
set_ideal_network [get_ports SE]
set_wire_load_mode "enclosed"
set_dont_use [get_lib_cells slow_vdd1v0/HOLDX1]
set_clock_uncertainty -setup 0.1 [get_ports clk]
set_clock_uncertainty -hold 0.1 [get_ports clk]

