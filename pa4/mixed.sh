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


echo "$HEADER" > mixed_data.csv
#-------------------MIXED TESTS-------------------#

echo "Starting Mixed tests..."

#OTHER MIXED LIGHT
echo "OTHER MIXED LIGHT"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o mixed_data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE"
done
echo "37 done"

#OTHER MIXED LIGHT RANDOM
echo "OTHER MIXED LIGHT RANDOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o mixed_data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" "RAND"
done
echo "38 done"

#OTHER MIXED MEDIUM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o mixed_data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
done
echo "39 done"

#OTHER MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o mixed_data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "RAND"
done
echo "40 done"

#OTHER MIXED HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o mixed_data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
done
echo "41 done"

#OTHER MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o mixed_data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "RAND"
done
echo "42 done"

#FIFO MIXED LIGHT
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o mixed_data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE"
done
echo "43 done"

#FIFO MIXED LIGHT RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o mixed_data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" "RAND"
done
echo "44 done"

#FIFO MIXED MEDIUM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o mixed_data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
done
echo "45 done"

#FIFO MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o mixed_data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "RAND"
done
echo "46 done"

#FIFO MIXED HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o mixed_data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
done
echo "47 done"

#FIFO MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o mixed_data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "RAND"
done
echo "48 done"

#RR MIXED LIGHT
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o mixed_data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" 
done
echo "49 done"

#RR MIXED LIGHT RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o mixed_data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" "RAND"
done
echo "50 done"

#RR MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o mixed_data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
done
echo "51 done"

#RR MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o mixed_data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "RAND"
done
echo "52 done"

#RR MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o mixed_data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
done
echo "53 done"

#RR MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o mixed_data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "RAND"
done
echo "54 done"

echo "Mixed tests completed..."


