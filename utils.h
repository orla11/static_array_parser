#include <stdio.h>
#include <stdlib.h>

// MAX_LEN string for banner, 
// symbol table, semantic-check utils arrays
#define MAX_LEN 256

// defining symbol table dimension
float sym[MAX_LEN][MAX_LEN];
// defining definitions, bounds arrays, 
// array type, already declared
unsigned int def[MAX_LEN];
unsigned int bounds[MAX_LEN];
unsigned int type[MAX_LEN];
unsigned int dec[MAX_LEN];
// array used to host all arrays sym-references when multiple declaration is
// used. Indexes are then used to assign type to each single array
int multiple_defs[MAX_LEN];
// result array [0] => result, [1] => array_sym_index
double res_arr[2];

void yyerror(const char *msg);
void emoji(int choice, int divLen); // print emoji in console
void banner(void);                  // print banner with instructions
void print_image(FILE *fptr);       // print big starting banner image
void print_result();                // print final result of calculations
void check(int ref, int index);     // check if arrays are defined and/or indexes out of bounds
void check_double_dec(int ref);     // check if arrays already declared
void assign_type(int refs[], char* string); // assign type to single array
void empty_res(); // empty res_array