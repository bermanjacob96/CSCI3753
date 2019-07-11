#!/bin/bash

#File: testscript
#Author: Jacob Berman
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

SIMULATIONS_LOW="10"
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

echo CPU Bound Tests
echo
echo CPU Bound Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LOW" "$CPU_INTENSIVE"
echo 

echo CPU Bound Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_LOW" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE" 
echo

echo CPU Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$CPU_INTENSIVE"
echo

echo CPU Bound Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_LOW" "$CPU_INTENSIVE"
echo

echo CPU Bound Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_LOW" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE"
echo

echo CPU Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$CPU_INTENSIVE"
echo

echo CPU Bound Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_LOW" "$CPU_INTENSIVE" 
echo

echo CPU Bound Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_LOW" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE"
echo

echo CPU Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE" "$RAND"
echo

echo CPU Bound Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$CPU_INTENSIVE"
echo

echo CPU Bound Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$CPU_INTENSIVE" "$RAND"
echo

# IO Bound Tests

echo IO Bound Tests

echo IO Bound Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_LOW" "$IO_INTENSIVE"
echo

echo IO Bound Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_LOW" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE" 
echo

echo IO Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$IO_INTENSIVE"
echo

echo IO Bound Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_LOW" "$IO_INTENSIVE"
echo

echo IO Bound Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_LOW" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE"
echo

echo IO Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$IO_INTENSIVE"
echo

echo IO Bound Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_LOW" "$IO_INTENSIVE" 
echo

echo IO Bound Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_LOW" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE"
echo

echo IO Bound Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE" "$RAND"
echo

echo IO Bound Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$IO_INTENSIVE"
echo

echo IO Bound Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$IO_INTENSIVE" "$RAND"
echo

# Mixed Tests

echo Mixed Tests

echo Mixed Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_LOW" "$MIXED_INTENSIVE"
echo

echo Mixed Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_LOW" "$MIXED_INTENSIVE" "$RAND"
echo

echo Mixed Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" 
echo

echo Mixed Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "$RAND"
echo

echo Mixed Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
echo

echo Mixed Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT1" sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "$RAND"
echo



echo Mixed Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_LOW" "$MIXED_INTENSIVE"
echo

echo Mixed Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_LOW" "$MIXED_INTENSIVE" "$RAND"
echo

echo Mixed Test with "$SIMULATIONS_MEDIUM" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
echo

echo Mixed Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "$RAND"
echo

echo Mixed Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
echo

echo Mixed Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT2" sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "$RAND"
echo



echo Mixed Test with "$SIMULATIONS_LOW" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_LOW" "$MIXED_INTENSIVE" 
echo

echo Mixed Test with "$SIMULATIONS_LOW" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_LOW" "$MIXED_INTENSIVE" "$RAND"
echo

echo Mixed Test with "$SIMULATIONS_MEDIUM" Simulations and NUniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
echo

echo Mixed Test with "$SIMULATIONS_MEDIUM" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "$RAND"
echo

echo Mixed Test with "$SIMULATIONS_HIGH" Simulations and Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
echo

echo Mixed Test with "$SIMULATIONS_HIGH" Simulations and Non-Uniform Priorities
/usr/bin/time -f "$TIMEFORMAT3" sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "$RAND"
echo
