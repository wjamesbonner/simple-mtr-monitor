#!/bin/bash
while read t; do
  mkdir -p $t
done <targets.txt
