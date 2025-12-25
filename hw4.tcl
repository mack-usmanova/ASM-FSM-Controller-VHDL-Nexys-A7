#inputs:
# clk, x, reset STD_LOGIC
#outputs:
# z, s STD_LOGIC

restart

# create train of clock pulses of 100MHz
add_force clk {0 0ns} {1 10ns} -repeat_every 20ns

# apply active low CPU_RESETN
add_force reset {0 0ns}

# initialize inputs
add_force x {0 0ns}

# wait out 100ns
run 50ns

# set active low reset back to inactive state
add_force reset {1 0ns}
run 20ns

# turn on x 
add_force x {1 0ns}
run 20ns

# turn off x 
add_force x {1 0ns}
run 20ns

# turn on x 
add_force x {1 0ns}
run 20ns

# turn off x 
add_force x {0 0ns}
run 20ns

# turn on x 
add_force x {0 0ns}
run 20ns

# turn off x 
add_force x {0 0ns}
run 20ns

# turn on x 
add_force x {1 0ns}
run 20ns

# turn off x 
add_force x {0 0ns}
run 20ns

add_force reset {0 0ns}
run 20ns

