#!/bin/bash

#File: testscript
#Author: Andy Sayler
#Revised: Shivakant Mishra
#Project: CSCI 3753 Programming Assignment 4
#Create Date: 2016/30/10
#Modify Date: 2016/30/10
#Description:
#	A simple bash script to run a signle copy of each test case
#	and gather the relevent data.

HEADER="Schedule, Wall Clock Time (sec), Total User Mode CPU Seconds, Total Kernel Mode CPU Seconds, CPU Percentage, Total Non-Voluntary Context Switches, Total Voluntary Context Switches, # Processes"
TIMEFORMAT1="SCHED_OTHER, %e, %U, %S, %P, %c, %w"
TIMEFORMAT2="SCHED_FIFO, %e, %U, %S, %P, %c, %w"
TIMEFORMAT3="SCHED_RR, %e, %U, %S, %P, %c, %w"

SIMULATIONS_LIGHT="10"
SIMULATIONS_MEDIUM="50"
SIMULATIONS_HIGH="100"

CPU_INTENSIVE="CPU"
IO_INTENSIVE="IO"
MIXED_INTENSIVE="Mixed"

RAND= "RAND"

make clean
make


echo "$HEADER" > data.csv

# CPU Bound Tests

#OTHER CPU LIGHT
echo "OTHER CPU LIGHT"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$CPU_INTENSIVE"
done
echo "1 done"
