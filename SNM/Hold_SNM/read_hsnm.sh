#!/bin/bash

CORNERS=("tt" "ss" "ff" "sf" "fs")
TEMPS=("27" "85" "0" "-40")
TEMPLATE="six_t_hold_snm.spice"

if [ ! -f "$TEMPLATE" ]; then
    echo "Error: Template file $TEMPLATE not found!"
    exit 1
fi

mkdir -p sim_results_hsnm

for corner in "${CORNERS[@]}"; do
    for temp in "${TEMPS[@]}"; do
        netlist="sim_results_hsnm/hsnm_${corner}_t${temp}.spice"
        output_log="sim_results_hsnm/log_${corner}_t${temp}.log"
        
        echo "Running HSNM simulation for Corner: $corner at Temperature: ${temp}°C..."
        
        sed -e "s/__CORNER__/$corner/g" \
            -e "s/__TEMP__/$temp/g" \
            "$TEMPLATE" > "$netlist"
            
        ngspice -b "$netlist" > "$output_log"
    done
done

echo "All HSNM corner simulations completed successfully!"
