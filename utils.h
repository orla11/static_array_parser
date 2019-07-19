#include <stdio.h>
#include <stdlib.h>

// MAX_LEN string for banner
// and index space
#define MAX_LEN 256
// Max array_ID space
#define MAX_SYM 256

// defining symbol tables
float sym[MAX_SYM][MAX_LEN];

char symbol[MAX_SYM][MAX_SYM];

// array to check if input array
// exists or not
// Eg. def[array_ID] = 0 (not exists) | 1 (exists)
unsigned int def[MAX_SYM];

// array to check if the array index specified in stdin
// exists within the bounds according to the initial
// declaration.
// Eg. a[8] => bounds[array_ID] = 8
unsigned int bounds[MAX_SYM];

// the array associate to every array_ID the respective type
// linked with the array declared.
// Eg. int a[8] => type[array_ID] = 1 (int) | 2 (float) | 3 (double)
unsigned int type[MAX_SYM];

// array to check if input array
// has been previosuly delcared 
// Eg. deC[array_ID] = 0 (not declared) | 1 (declared)
unsigned int dec[MAX_SYM];

// array used to host all arrays symbol table references when multiple declaration is
// used. Indexes are then used to assign type to each single array.
// Initialized with all values = 1111 by default.
// Eg. int a[8], b[90], c[87] => multiple_defs[array_ID] = array_ID 
// if multiple_defs[array_ID] is not 1111 then that array_ID was declared with its
// relative type associated.
int multiple_defs[MAX_SYM];

// result array [0] => result, [1] => array_sym_index (array_ID)
double res_arr[2];

void yyerror(const char *msg);      // print errors
void emoji(int choice, int divLen); // print emoji in console
void banner(void);                  // print banner with instructions
void print_image(FILE *fptr);       // print big starting banner image
void print_result();                // print final result of calculations
void check(int ref, int index);     // check if arrays are defined and/or indexes out of bounds
void check_double_dec(int ref, char * identifier);     // check if arrays already declared
void assign_type(char* string);     // assign type to single array
void empty_res();                   // empty res_array
void add_to_symbol(char * identifier);
int  get_index(char * identifier);
