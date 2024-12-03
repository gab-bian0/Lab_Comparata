#!/bin/bash
input_file="$1" # Sostituisci con il nome del file di input 
output_file="$2" # Sostituisci con il nome del file di output 
awk 'BEGIN {count=1} /^>/ {print ">Protein" count; count++} !/^>/ {print}' "$input_file" > "$output_file"
