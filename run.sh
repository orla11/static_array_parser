#!/bin/bash

key="$1"

case $key in
    -s|--skip)
	chmod +x sap
	./sap
	;;
    *)
	flex sap.l && bison sap.y && gcc -o sap sap.tab.c -ll -ly
	chmod +x sap
	./sap
	;;
esac
