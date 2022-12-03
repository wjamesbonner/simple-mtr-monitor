#!/bin/bash

# Array holding the age of archival copies for each target to store, must match one in lifecycle.sh
archive_ages=(1 3 6 9 12 15 18 21 24 48 168)
echo "" > routes.html
#echo "HTTP/1.1 200 OK" >> routes.html
#echo "Content-Type: text/html; charset=UTF-8" >> routes.html
#echo "Server: netcat!" >> routes.html
echo "<html><head><style>.data th, .data tr, .data td { white-space: pre; border: 1px solid black; }</style></head><body><table class=\"data\">" >> routes.html
echo "<tr><th>Target Host</th><th>Current</th>" >> routes.html

for a in ${archive_ages[@]}; do
	echo "<th>-${a} Hours</th>" >> routes.html
done
echo "</tr>" >> routes.html

while read t; do
	echo "<tr>" >> routes.html
	echo "<td>$t</td>" >> routes.html
	route=`cat "$t/current_$t.trace"`
        route="${route//$'\n'/<br />}"
	echo "<td><pre>$route</pre></td>" >> routes.html
	for a in ${archive_ages[@]}; do
		route=`cat "$t/hour_${a}_$t.trace"`
		route="${route//$'\n'/<br />}"
		echo "<td><pre>$route</pre></td>" >> routes.html
	done
	echo "</tr>" >> routes.html

done <targets.txt
echo "</table></body></html>" >> routes.html

# Generate HTTP response
echo "HTTP/1.1 200 OK" > routes.http
echo "Content-Type: text/html; charset=UTF-8" >> routes.http
echo "Server: netcat!" >> routes.http
cat routes.html >> routes.http
