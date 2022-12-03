#!/bin/bash
while true
do
	while read t; do
		mkdir -p $t
		mtr -m 100 -b -u --report-wide --report-cycles 50 $t > buffer.trace
		cat buffer.trace > "$t/current_$t.trace"
	done <targets.txt
	sleep 1
done
