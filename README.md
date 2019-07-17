# STATIC ARRAY PARSER
An accademic project realized for the course of Language Processing Technologies made with Flex &amp; Bison.

ASSIGNMENT:
----------------------------------------------------------------------------
Using lex/yacc implement a parser to manage the definition of static arrays.
Arrays are defined as

int a[20], b[10];
float c[5];

where you may assume the datatypes int and float, double; the variable names
follow the usual rules for identifiers (alphanumeric string beginning with
a letter), and the array size must be specified in square brackets.
Then values can be assigned to each element in the defined arrays as

a[2] = 10;
a[3] = a[2]+3;

c[3] = a[3]*a[2];

Assume that uninitialised elements are set to 0. The expression on the left
can only have two operands that can be array elements or constants. Assume
to use the basic arithmetic operators +,-,*,/
----------------------------------------------------------------------------

## Prerequisites:
  - gcc
  - Bison
  - Flex

## **Run the example**
  - cd static_array_parser
  - chmod +x run.sh
  - ./run.sh
