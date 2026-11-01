for c in tt ss ff sf fs; do for t in -40 0; do
  sed -e "s/\(sky130\.lib\.spice\) [a-z][a-z]/\1 $c/" \
      -e "s/^\.temp .*/.temp $t/" \
      -e "s/^Cbl  bl  gnd .*/Cbl  bl  gnd 150f/" \
      -e "s/^Cblb blb gnd .*/Cblb blb gnd 150f/" \
      -e '/^plot /d' -e '/^run$/d' final_one_bit_sram.spice > cold_${c}_${t}_150f.spice
  ngspice -b -o cold_${c}_${t}_150f.txt cold_${c}_${t}_150f.spice
done; done
grep -H -E "^(dout_max_read0|db_min_read0|dbl_sae0) " cold_*_150f.txt
