CC = gcc
CFLAGS = -c -g -Wall -Wextra
LFLAGS = -g -Wall -Wextra

INPUTFILESIZEMEGABYTES = 1

KILO = 1024
MEGA = $(shell echo $(KILO)\*$(KILO) | bc)
INPUTFILESIZEBYTES = $(shell echo $(MEGA)\*$(INPUTFILESIZEMEGABYTES) | bc)
INPUTBLOCKSIZEBYTES = $(KILO)
INPUTBLOCKS = $(shell echo $(INPUTFILESIZEBYTES)\/$(INPUTBLOCKSIZEBYTES) | bc)

.PHONY: all clean

all: pi test rw mixed

pi: pi.o
	$(CC) $(LFLAGS) $^ -o $@ -lm
	
test: HW4_TEST.o
	$(CC) $(LFLAGS) $^ -o $@ -lm
#pi-sched: pi-sched.o
	#$(CC) $(LFLAGS) $^ -o $@ -lm

rw: rw.o rwinput
	$(CC) $(LFLAGS) rw.o -o $@ -lm

mixed: mixed.o rwinput
	$(CC) $(LFLAGS) mixed.o -o $@ -lm

pi.o: pi.c
	$(CC) $(CFLAGS) $<
	

#pi-sched.o: pi-sched.c
	#$(CC) $(CFLAGS) $<

rw.o: rw.c
	$(CC) $(CFLAGS) $<
	
mixed.o: mixed.c
	$(CC) $(CFLAGS) $<

test.o: HW4_TEST.c
	$(CC) $(CFLAGS) $<

rwinput: Makefile
	dd if=/dev/urandom of=./rwinput bs=$(INPUTBLOCKSIZEBYTES) count=$(INPUTBLOCKS)

clean: testclean
	rm -f pi test rw mixed
	rm -f rwinput
	rm -f *.o
	rm -f *~
	rm -f handout/*~
	rm -f handout/*.log
	rm -f handout/*.aux

testclean:
	rm -f rwoutput*
