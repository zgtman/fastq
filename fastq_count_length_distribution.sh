#!/bin/bash

T="$(date +%s)"

for i in *fastq.gz

 do awk 'END{print FILENAME":"}' $i > ${i%.fastq.gz}.temp.txt && zcat $i | paste - - - - | awk '{print length($3)}' | sort | awk '{a[$0]++}END{for(i in a){print i "--->" a[i]}}' | sort -h -r  >> ${i%.fastq.gz}.temp.txt

echo "Processing '$i' Sample"

done;

paste *.temp.txt > final_fastq_count_length_distribution.xls

rm -rf *.temp.txt


T="$(($(date +%s)-T))"

echo "Time Duration of Analysis in Seconds: ${T} s" 
