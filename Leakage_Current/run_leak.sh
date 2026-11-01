for c in tt ss ff sf fs; do for t in 27 85; do
  sed -e "s/sky130.lib.spice tt/sky130.lib.spice $c/" \
      -e "s/^\.temp 27/.temp $t/" \
      sram_cell_leakage_dc.spice > leak_${c}_${t}.spice
  ngspice -b -o leak_${c}_${t}.txt leak_${c}_${t}.spice
  echo "== $c $t"; grep -E "^(v\(q0\)|v\(q1\)|ileak0|ileak1) " leak_${c}_${t}.txt
done; done
