#!/bin/bash

Questo scipt fa il mapping in maniera automatica Variables

assembly=$1
fastq1=$2
fastq2=$3

#naming file
outname=$(basename -s _rawass.fa "$assembly")

#Mapping short reeds on assembly
minimap2 -ax sr --MD -t "$assembly" "$fastq1" "$fastq2" > "$outname"_sr.sam
minimap2 -ax map-pb --MD -t 5 "$assembly" "$fastq1" "$fastq2" > "$outname"_pac.sam

#converting sam into bam
samtools view -Sb "$outname"_sr.sam > "$outname"_sr.bam
samtools view -Sb "$outname"_pac.sam > "$outname"_pac.bam 
rm "$outname"_sr.sam  "$outname"_pac.sam

#sorting and indexing bam file
samtools sort -@5 -o "$outname"_sr_sorted.bam "$outname"_sr.bam 
samtools sort -@5 -o "$outname"_pac_sorted.bam "$outname"_pac.bam
samtools index "$outname"_sr_sorted.bam
samtools index "$outname"_pac_sorted.bam

echo -e "$R1\n$R2" > <READS_PATH>

