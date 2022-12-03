#!/bin/bash

while read t; do

# Array holding the age of archival copies for each target to store
archive_ages=(1 3 6 9 12 15 18 21 24 48 168)

for a in ${archive_ages[@]}; do
	# if a current trace does not exist, exit, will re run automatically
	if [ ! -f "$t/current_$t.trace" ]; then
                echo "$t/current_$t.trace does not exist"
		continue
        fi

	# if hour old copy doesn't exist, copy the latest
	if [ ! -f "$t/hour_${a}_$t.trace" ]; then
		echo "Create hour $a copy"
		cp "$t/current_$t.trace" "$t/hour_${a}_$t.trace"
		continue
	fi

	# if the pending hour old copy doesn't exist, make from current
	if [ ! -f "$t/hour_${a}_pending_$t.trace" ]; then
		echo "Create hour $a pending copy"
                cp "$t/current_$t.trace" "$t/hour_${a}_pending_$t.trace"
		continue
        fi

	# calculate the time boundary to replace the hour archive version
	current_time=`date -r "$t/current_$t.trace"`
	#replacement_time=$(date -d "$current_time -1 hour" +%s)
	replacement_time=$(date -d "$current_time - ${a} hour" +%s)

	# retrieve the modification datetime of the pending hour copy
	pending_time=$(date -r "$t/hour_${a}_pending_$t.trace" +%s)

	# If the replacement threshold is larger (newer) than the pending copy
	# then the pending copy is at least an hour older than the latest trace
	# and will be promoted to replace the hour old copy
	if [[ $replacement_time > $pending_time ]]; then
		echo "Promoting pending $a copy"
		mv "$t/hour_${a}_pending_$t.trace" "$t/hour_${a}_$t.trace"
	fi

done
done <targets.txt
