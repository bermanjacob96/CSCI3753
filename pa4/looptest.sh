#!/bin/bash

#File: looptest
#Author: Jacob Berman
#Project: CSCI 3753 Programming Assignment 4
#Create Date: 2016/12/11
#Modify Date: 2016/15/11
#Description:
#	A simple bash script to run a 3 iterations of each test case
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

#-------------------CPU Bound Tests-------------------#

echo "Starting CPU_BOUND tests..."

#OTHER CPU LIGHT 
echo "OTHER CPU  LIGHT"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$CPU_INTENSIVE"
done
echo "1 done"

#OTHER CPU LIGHT RANDOM
echo "OTHER CPU LIGHT RADNOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$CPU_INTENSIVE" "RAND"
done
echo "2 done"

#OTHER CPU MEDIUM
echo "OTHER CPU MEDIUM RADNOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE"
done
echo "3 done"

#OTHER CPU MEDIUM RAND
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE" "RAND"
done
echo "4 done"

#OTHER CPU HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$CPU_INTENSIVE"
done
echo "5 done"

#OTHER CPU HIGH RAND
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$CPU_INTENSIVE" "RAND"
done
echo "6 done"

#FIFO CPU LIGHT 
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$CPU_INTENSIVE"
done
echo "7 done"

#FIFO CPU LIGHT  RAND
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$CPU_INTENSIVE" "RAND"
done 
echo "8 done"

#FIFO CPU MEDIUM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE"
done 
echo "9 done"

#FIFO CPU MEDIUM RAND
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE" "RAND"
done 
echo "10 done"

#FIFO CPU HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$CPU_INTENSIVE"
done 
echo "11 done"

#FIFO CPU HIGH RAND
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$CPU_INTENSIVE" "RAND"
done 
echo "12 done"

#RR CPU LIGHT
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$CPU_INTENSIVE"
done
echo "13 done"

#RR CPU LIGHT RAND
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$CPU_INTENSIVE" "RAND"
done
echo "14 done"

#RR CPU MEDIUM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE"
done
echo "15 done"

#RR CPU MEDIUM RAND
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$CPU_INTENSIVE" "RAND"
done
echo "16 done"

#RR CPU HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$CPU_INTENSIVE"
done
echo "17 done"

#RR CPU HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$CPU_INTENSIVE" "RAND"
done
echo "18 done"

echo "CPU_BOUND TESTS COMPLETED"

#-------------------IO BOUND TESTS-------------------#

echo "Starting IO_BOUND tests..."

#OTHER IO LIGHT
echo "OTHER IO_BOUND lIGHT"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$IO_INTENSIVE"
done
echo "19 done"

#OTHER IO LIGHT RANDOM
echo "OTHER IO_BOUND lIGHT RANDOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$IO_INTENSIVE" "RAND"
done
echo "20 done"

#OTHER IO MEDIUM
echo "OTHER IO_BOUND MEDIUM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE"
done
echo "21 done"

#OTHER IO MEDIUM RANDOM
echo "OTHER IO_BOUND MEDIUM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE" "RAND"
done
echo "22 done"

#OTHER IO HIGH
echo "OTHER IO_BOUND HIGH"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$IO_INTENSIVE"
done
echo "23 done"

#OTHER IO HIGH RANDOM
echo "OTHER IO_BOUND HIGH"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$IO_INTENSIVE" "RAND"
done
echo "24 done"

#FIFO IO LIGHT
echo "FIFO IO_BOUND LIGHT"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$IO_INTENSIVE"
done
echo "25 done"

#FIFO IO LIGHT RADNOM
echo "FIFO IO_BOUND LIGHT RADNOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$IO_INTENSIVE" "RAND"
done
echo "26 done"

#FIFO IO MEDIUM
echo "FIFO IO_BOUND MEDIUM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE"
done
echo "27 done"

#FIFO IO MEDIUM RANDOM
echo "FIFO IO_BOUND MEDIUM RANDOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE" "RAND"
done
echo "28 done"

#FIFO IO HIGH
echo "FIFO IO_BOUND HIGH"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$IO_INTENSIVE"
done
echo "29 done"

#FIFO IO HIGH RANDOM
echo "FIFO IO_BOUND HIGH RADNOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$IO_INTENSIVE" "RAND"
done
echo "30 done"

#RR IO LIGHT
echo "RR IO_BOUND LIGHT"
for i in 1 2 3 
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$IO_INTENSIVE" 
done
echo "31 done"

#RR IO LIGHT RANDOM
echo "RR IO_BOUND LIGHT RANDOM"
for i in 1 2 3 
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$IO_INTENSIVE" "RAND"
done
echo "32 done"

#RR IO MEDIUM
echo "RR IO_BOUND MEDIUM"
for i in 1 2 3 
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE"
done
echo "33 done"

#RR IO MEDIUM RANDOM
echo "RR IO_BOUND MEDIUM RADNOM"
for i in 1 2 3 
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$IO_INTENSIVE" "RAND"
done
echo "34 done"

#RR IO HIGH
echo "RR IO_BOUND HIGH"
for i in 1 2 3 
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$IO_INTENSIVE"
done
echo "35 done"

#RR IO HIGH RANDOM
echo "RR IO_BOUND HIGH RANDOM"
for i in 1 2 3 
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$IO_INTENSIVE" "RAND"
done
echo "36 done"

#-------------------MIXED TESTS-------------------#

echo "Starting Mixed tests..."

#OTHER MIXED LIGHT
echo "OTHER MIXED LIGHT"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE"
done
echo "37 done"

#OTHER MIXED LIGHT RANDOM
echo "OTHER MIXED LIGHT RANDOM"
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" "RAND"
done
echo "38 done"

#OTHER MIXED MEDIUM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
done
echo "39 done"

#OTHER MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "RAND"
done
echo "40 done"

#OTHER MIXED HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
done
echo "41 done"

#OTHER MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT1" -o data.csv -a sudo ./test SCHED_OTHER "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "RAND"
done
echo "42 done"

#FIFO MIXED LIGHT
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE"
done
echo "43 done"

#FIFO MIXED LIGHT RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" "RAND"
done
echo "44 done"

#FIFO MIXED MEDIUM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
done
echo "45 done"

#FIFO MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "RAND"
done
echo "46 done"

#FIFO MIXED HIGH
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
done
echo "47 done"

#FIFO MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT2" -o data.csv -a sudo ./test SCHED_FIFO "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "RAND"
done
echo "48 done"

#RR MIXED LIGHT
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" 
done
echo "49 done"

#RR MIXED LIGHT RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv-a sudo ./test SCHED_RR "$SIMULATIONS_LIGHT" "$MIXED_INTENSIVE" "RAND"
done
echo "50 done"

#RR MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE"
done
echo "51 done"

#RR MIXED MEDIUM RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_MEDIUM" "$MIXED_INTENSIVE" "RAND"
done
echo "52 done"

#RR MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE"
done
echo "53 done"

#RR MIXED HIGH RANDOM
for i in 1 2 3
do
/usr/bin/time -f "$TIMEFORMAT3" -o data.csv -a sudo ./test SCHED_RR "$SIMULATIONS_HIGH" "$MIXED_INTENSIVE" "RAND"
done
echo "54 done"

echo "Mixed tests completed..."



