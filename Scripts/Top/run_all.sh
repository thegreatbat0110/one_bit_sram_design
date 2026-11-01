#!/bin/bash
NET=final_one_bit_sram.spice
for c in tt ss ff sf fs; do
  for t in 27 85; do
    sed -e "s/sky130.lib.spice tt/sky130.lib.spice $c/" \
        -e "s/^\.temp 27/.temp $t/" \
        -e '/^plot /d' $NET > run_${c}_${t}.spice
    ngspice -b -o log_${c}_${t}.txt run_${c}_${t}.spice
  done
done
