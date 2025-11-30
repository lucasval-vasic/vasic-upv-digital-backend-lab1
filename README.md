# Lab 1 - Constraints and basic timing analysis

## Introduction

In this lab we will become familiar with the digital IC implementation flow by exploring Static Timing Analysis (STA) using the Cadence tool Tempus.

Throughout the lab, you will also gain experience with the TCL scripting language, which is used to create automation scripts, and then apply it to analyze the timing characteristics of several digital blocks.

## Lab evaluation

You are required to produce a lab report that documents the actions and experiments described in this guide. Present the results of your experiments using text, screenshots, or any other appropriate media.

## Evaluation rubric

The following breakdown shows how each section of this lab contributes to the overall marks:

- Initial timing report: 1 point
- Timing constraints: 1 point
- Advanced timing report: 1 point
- Violations: 1 point
- Histogram: 1 point
- Change cell ECO: 1 point
- Add repeater ECO: 1 point
- Multi-clock design: 1 point
- Complete STA script: 1 point
- Alternate process: 1 point

## TCL

TCL (Tool Command Language)  is a powerful scripting language commonly used in electronic design automation (EDA) tools for automating tasks, configuring environments, and managing design flows. It is known for its simplicity, flexibility, and ease of integration with various tools.

### Basic TCL syntax

- Commands: Each line in TCL is a command. Commands are separated by either newlines or semicolons.
```
puts "puts commands prints text out to terminal"
```
- Comments: Only single line comments are supported. They are preceded by #
```
# This is a comment
```
- Variable assignment is done with command set. Syntax is "set varName value"
- Variables are automatically interpolated into strings.
- We can stop variable interpolation with backlash (\)
```
set design_name fifo
puts "The design name is $design_name"
puts "\$design_name is $design_name" 
```
- lists are TCL basic data structure. They can contain numbers, strings, whatever. Lists can be created with list element0 element1 ...
```
set first_list [list 0 1 2 3]
puts "this is my first list: $first_list"
```
- Mathematical expressions are evaluated with command expr. Wrapping the expression in curly braces ({}) will result in faster code execution.
```
set i 10
expr 2 * $i
expr {10 * $i}
```
- We can assign the output of an expression to a var using square brackets ([])
```
set res [ expr { 2 * $i } ]
puts "result is $res"
```
- Flow control. Conditionals: if, switch
```
set x 1

if {$x == 2} {puts "$x is 2"} else {puts "$x is not 2"}

set A 10
set B 20
set OP "add"

switch $OP {
    "add" { set res [expr {$A + $B}] }
    "sub" { set res [expr {$A - $B}] }
}

puts "result of $OP is $res"
```
- Flow control. Loops: while, for, foreach 
```
set x 0
set max 10

# while loop
while {$x <= $max} {
    puts "counting $x up to $max"
    set x [expr {$x + 1}]
}

# for loop
for {set x 0} {$x <= $max} {incr x} {# notice no $ on incr!
    puts "counting $x up to $max"
}

set step 2
for {set x 0} {$x <= $max} {incr x $step} {# notice no $ on incr!
    puts "counting $x up to $max in steps of $step"
}

# foreach loop used to iterate over lists
set designs [list "fifo" "cpu" "sram"]
foreach design $designs {
    puts "processing design $design"
}
```
- Methods are defined with proc. Syntax is proc name arguments body.
```
proc ten_times {x} {
    set res [expr $x * 10]
    return $res
}

set x 23
puts "ten times $x is [ten_time $x]" 
```

### Further reading
[This is a great tutorial in case you totally *loved* TCL and want to become a guru.](https://wiki.tcl-lang.org/page/Tcl+Tutorial+Lesson+0)

## Basic constraints

Before starting with the Tempus lab we will review the first design that we will analyze. This design is a synchronous FIFO with a single clock port and separate read and write ports.

[This is a high level overview of the synchronous FIFO.](sync_fifo.md) Please read it through and become familiar with the block.

You can find the RTL code for the FIFO [here](sync_fifo/rtl/sync_fifo.v). It will be useful to also become familiar with it.

## Tempus introduction

We will first execute the config_cadence.sh script to add the Cadence tools to the system path:

```console
> source config_cadence.sh
```

Now we are ready to launch Tempus, the Static Timing Analysis (STA) tool from Cadence. cd into the sync_fifo/sta/run folder of the lab and execute the tempus command:

```console
> cd sync_fifo/sta/run
> tempus
```

If everything went well you should see the Tempus command prompt, composed of the tool name plus the command count:

> tempus 1> _

Notice how Tempus created files on the current run/ folder to log the current run and the commands issued to Tempus. These files may be useful to debug some errors or review the log, especially as the output of some commands may be verbose.

### First steps

The common way to execute the design flow is by reading TCL scripts with commands in them. The first script we will see is load_design.tcl. Please open it with an editor and examine it.

You can see that the most important commands are the ones to read the standard cell library and the design netlist:

```console
################################
# Read the libraries
################################
read_lib $LIB_PATH

################################
# Read the netlist
################################
read_verilog "../in/$BLOCK_NAME.vg"

################################
# Link the design
################################
set_top_module $BLOCK_NAME 
```

As you can see we are using TCL variables to hold the path to the standard cell libraries, and the design name. This is a common practice that allows us to reuse most of the scripts that we will run for any design.

We will manually set those variables in order to run the load_design script. Type this into the Tempus prompt:

```console
> set BLOCK_NAME "sync_fifo"
> set LIB_PATH "/cadence_pdk/xfab/XKIT/x_all/cadence/XFAB_Digital_Power_RefKit-cadence/v1_3_1/pdk/xh018/diglibs/D_CELLS_JIHD/v4_1/liberty_LPMOS/v4_1_1/PVT_1_80V_range/D_CELLS_JIHD_LPMOS_slow_1_62V_125C.lib"
```

This will set the LIB_PATH variable used in load_design.script to the slow corner library for the D_CELLS JIHD library variant of the digital library for X-Fab 0.18um process. The design we will analyze was implemented in this process and library. 

### Design load

Now we can source (ie execute) the load_design script:
```console
> source ../scripts/load_design.tcl
```

After a few screens of text we will get the Tempus prompt again. Seeing the design cell count report that will confirm us that the design and libraries were properly loaded.

Now we can start issuing command to analyze the design timing. Just remember that since we loaded a library with a single corner our timing analysis will limit to the slow corner.

### Initial timing report
The quintessential Tempus command is report_timing. This command  supports several arguments to tailor the scope of the timing report and its format. If we add no arguments then the single most critical path will be reported. Try it now:

```console
> report_timing
```
We will get no paths reported since the design is unconstrained: we specified no clocks or timing checks at all!

In order to hold our timing constraints we will create a constraints file in sync_fifo/tcons/sync_fifo.sdc. You will be filling up this file, starting with your first constraint command to create a clock. Let's start with a relatively slow 30MHz frequency.

It is strongly suggested to use a TCL variable to hold the clock frequency and then perform a mathematical operation to obtain the clock period for the create_clock constraint.

After the clock has been created we need to ask Tempus to propagate it, this is to ensure that the clock signal is distributed across the clock tree and reaches all the flops in the design. We do this by appending this command at the end of the SDC file:

```console
set_propagated_clock [all_clocks]
```

Once you have created the clock you can read the SDC file:

```console
> read_sdc ../../tcons/$BLOCK_NAME.sdc
```

Calling up report_timing will trigger a timing update. This is the process in which Tempus takes design data and constraints and performs the timing analysis. A call to report_timing after the constraints have been modified will trigger this timing update. It can also be triggered manually with the update_timing command.

If everything went well you should see your first timing report, focusing on the design's critical path. The default report_timing is very complete, but it lacks the full clock path breakdown so let's add it with the -path_type argument:

```console
> report_timing -path_type full_clock
```
Now you can examine in detail the timing report. Notice how the slack is computed, by subtracting the data launch and data capture timestamps. As you can see many factors affect the slack computation such as the flop setup time, the clock tree delay, the logical cells delay...

### Advanced reports
Let's check out a few options to tweak the report timing output. By default, a single timing path is reported. In order to increase this we can make use of the -max_paths or -nworst arguments to either print a maximum number of paths, or the worst n paths in the design.

Combining these options with a path_type argument of "summary" or "end" allows us to print a report in table format to quickly review many paths at once.

As we mentioned above report_timing supports many arguments to customize both the type of timing paths reported and the report layout itself. Please check the man page for it to get a sense of the options supported:

```console
> man report_timing
```

Now check out the design netlist in sta/in/sync_fifo.vg, select a specific register and report the timing paths that start and end on it. Check out the manual to find the report_timing arguments to get these reports.

Notice how by default only setup (max delay) paths are reported. Check out the manual to find out how to report hold paths (min delay) and report them.

As you can see the slack on these paths is much smaller than on the setup paths since the minimum delay in a design can be very short. Although the timing reports for max and min delay are very similar a capital difference is the different value in the "Phase shift" figure used to compute the slack.

### Violations
Given that we can see the slack for the design's critical path we can find out the maximum operating frequency for the design. Reduce the clock period, so the clock runs _faster_ than the design would allow and report timing again.

It is a good idea to wrap all the tempus commands we used before to set up libraries, block name and load design in a script of your own since we will be re-running many analysis from now on. 

You should see paths with negative slack, this is, violating paths or violations for the new operating frequency. Tempus provides a convenient way to report all setup check violators:

```console
> report_constraint -late
```

We can also report any violating path, regardless of the type:

```console
> report_constraints -all_violators
```

This will show many violating paths for min delay check, this is, hold paths. They all start in the FIFO input controls such as the reset port aclr. What is happening? We didn't add any constraints for the IO ports so Tempus assumed they all should experience zero delay with respect to the clock.

Now is the time to add these constraints. Set an input delay of 1ns and a load of 0.1pF to each of the pins (except for the clock which will only need a load, not an input delay). Then add an output delay of 1ns and a load of 0.1pF to all output ports.

Remember to dial back the clock frequency to the original 30MHz value. Rerun the analysis and confirm that no more violations are reported.

One last thing for correctness’s sake: asynchronous reset signals such as aclr should not be constrained with a delay relative to a clock. Instead, they should be described as completely asynchronous signals. In SDC this is accomplished setting a false path starting from the aclr port. Modify the tcons file to remove the input delay and set the false path. The violators report should still be clean.

Now that our SDC file is complete we can try an additional constraint: setting a multicycle path. Increase the frequency again and select a specific register to register transfer for which a setup violation is reported. Create a multicycle path constraint of 2 clock periods for setup timing. Report the path and ensure that the violation is gone.

#### Slack histogram
A useful tool to quickly assess the overall state of timing on a design is to print out the histogram report. We can do it in Tempus with the report_slack_histogram command. By default, report_slack_histogram only reports violating paths so we should use the -max_slack argument and set an arbitrarily large value like 10,000ns to report all paths:

```console
> report_slack_histogram -max_slack 10000
```

A useful argument is -step where we can set the step size between histogram bins to get a coarse or finely granulated report.

### ECO preview
In addition to analyzing a finalized design we can use Tempus to preview the effect of small fixes to the design done as part of the ECO flow we discussed on the theory session. In this case we consider very small fixes like resizing or inserting an extra buffer.

First we will analyze the effect of resizing a buffer. Run the timing analysis clocking the block at a frequency _slightly_ faster than the maximum operating frequency. Now report one of the violating paths and select a candidate buffer to resize (a good candidate is a buffer that currently uses a reduced driving strength like X1 or X2). Make a note of the buffer instance name and use the ecoChangeCell command:

````console
> ecoChangeCell -inst instance_name -cell new_cell
````
Now report again the violating path and notice how the slack increased. Don't worry if the path still violates, this is just a simple example to see the effect of the ECO preview command.

Another possible ECO change is to add a buffer. This is sometimes done to fix hold timing issues where the data path is too fast. Select a candidate flop and make note of the name, then add the buffer (repeater in ECO jargon).

You will need to add a name for the newly added buffer. A good practice is to use a prefix like eco_ to clearly distinguish it from the buffers inserted automatically by implementation flow. This is the syntax for the AddRepeater command:

```console
> ecoAddRepeater -term reg_name/D -cell new_cell -name new_cell_name
```

Rerun the timing analysis and notice how the path delay and slack changed after the ECO command.

As we mentioned this is just a preview of the ECO effects since it assumes that there will be enough space in the core area to resize or add a cell, and it does not consider signal integrity or routing issues, nor it will update the pararisitic elements. However it may be useful to assess the effect of edits before commiting them in the PnR tool and rerunning the last steps of flow to perform parasitic extraction and STA again.

### Multi-clock designs

We will now consider a design with multiple clocks: an asynchronous FIFO with separate write and read ports, each with its own clock input.

[This is a high level overview of the asynchronous FIFO.](async_fifo.md) Please read it through and become familiar with the block.

You can find the RTL code for the FIFO [here](async_fifo/rtl/async_fifo.v). Again it would be a good idea to get familiar with it for the next steps.

### Constraints and design load

Create a new SDC file to add constraints for the FIFO. Set a similar clock frequency on both write and read clocks. Then add IO constraints for the input and output ports, taking into account that each of the IO ports will need to be constrained to the respective write or read clock. You can refer to the RTL code if you're unsure about a specific port.

Once constraints are in place load the design and constraints, and ensure no errors are produced when applying the constraints to the design.

#### Timing report

Produce a few timing reports for each of the clock domains. Also report the violations and think about why are they happening. Any guesses?

### Clock domain crossing

The nature of the asynchronous FIFO design creates timing paths that cross the boundaries between write and clock domains. This of course contradicts the ideal synchronous design methodology but is a requisite of the design. Clock Domain Crossing is a discipline on its own that will be taught later in your Masters so we will not get very deep into it. For the time being we will set a false path between both clock domains and report violators.

Is the report clean of violations now? If it isn't, did you make sure to set the false path in both directions?

### Complete STA script

Now we will see an example of a complete STA flow. Open the scripts/sta.tcl script and read it through. Notice how it executes some scripts we already saw, and how it calls up the gen_reports.tcl script to produce reports as files that we can review once the Tempus session is complete.

Run the sta.tcl script and examine the different files it produces. You already produced many of those reports already, but now they are in a handy format to review and analyze after Tempus completed the run.

###  Alternate process

Up to now we have been processing designs implemented in the X-Fab 0.18um process. We will now analyze the async_fifo design implemented in the AMS 0.35um process. 

In order to use a new process we will essentially need to do 2 things:

1. Change the library path to use the file /cadence_pdk/AMS/AMS_410_ISR15/liberty/c35_1.8V/c35_CORELIB_WC.lib. This characterizes the slow corner of the core cells for the 1.8V variant of CMOS process.

2. Change the load_design command to load the netlist contained in async_fifo/sta/in/async_fifo_0p35um.vg

In order to compare to the previous run make a backup copy of the rep directory with an alternate name and run the sta.tcl script after applying these modifications.

Now compare the rep/final_timing.rep report. Is the critical path the same or similar? Has the slack for this critical path changed or stayed the same?
