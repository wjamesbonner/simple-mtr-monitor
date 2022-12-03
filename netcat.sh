#!/bin/bash

while true; do cat routes.http | nc -l 8080; done
