for cb in 100f 150f 200f 250f 300f; do for c in sf ss; do
  sed -e "s/\(sky130\.lib\.spice\) [a-z][a-z]/\1 $c/" \
      -e "s/^Cbl  bl  gnd .*/Cbl  bl  gnd $cb/" \
      -e "s/^Cblb blb gnd .*/Cblb blb gnd $cb/" \
      -e '/^plot /d' -e '/^run$/d' final_one_bit_sram.spice > r_${c}_${cb}.spice
  ngspice -b -o log_${c}_${cb}.txt r_${c}_${cb}.spice
done; done
grep -H -E "^(dbl_sae0|dout_max_read0|db_min_read0) " log_s?_*f.txt
