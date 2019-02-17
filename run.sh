#!/bin/bash

key="$1"

case $key in
    -s|--skip)
	chmod +x sap
	./sap
	;;
    *)
	rm -rf sap
	flex sap.l && bison -d sap.y && gcc -o sap sap.tab.c utils.c  -ll -ly
	chmod +x sap
	./sap
	;;
esac
