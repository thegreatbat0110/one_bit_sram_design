#!/bin/bash

CORNERS=("tt" "ss" "ff" "sf" "fs")
TEMPS=("27" "85" "0" "-40")
TEMPLATE="six_t_read_snm.spice"

mkdir -p sim_results

for corner in "${CORNERS[@]}"; do
    for temp in "${TEMPS[@]}"; do
        netlist="sim_results/rsnm_${corner}_t${temp}.spice"
        output_log="sim_results/log_${corner}_t${temp}.log"
        
        echo "Running simulation for Corner: $corner at Temperature: ${temp}°C..."
        
        # Replace __CORNER__ and __TEMP__ cleanly using sed
        sed -e "s/__CORNER__/$corner/g" \
            -e "s/__TEMP__/$temp/g" \
            "$TEMPLATE" > "$netlist"
            
        ngspice -b "$netlist" > "$output_log"
    done
done

echo "All corner simulations completed!"
