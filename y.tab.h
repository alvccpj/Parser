#ifndef Y_TAB_H
#define Y_TAB_H

/* Definição de tokens */
#define INT 257
#define FLOAT 258
#define DOUBLE 259
#define CHAR 260
#define BOOLEAN 261
#define IF 262
#define ELSE 263
#define WHILE 264
#define FOR 265
#define SWITCH 266
#define CASE 267
#define DEFAULT 268
#define BREAK 269
#define CONTINUE 270
#define RETURN 271
#define STRUCT 272
#define NUM_INT 273
#define NUM_DEC 274
#define TEXTO 275
#define ID 276
#define AND 277
#define OR 278
#define EQ 279
#define NE 280
#define GE 281
#define LE 282
#define PTR_OP 283
#define PLUS_EQ 284
#define MINUS_EQ 285
#define TIMES_EQ 286
#define DIV_EQ 287
#define MOD_EQ 288

/* Definição da estrutura YYSTYPE */
typedef union {
    int ival;
    float fval;
    char *sval;
} YYSTYPE;

/* Protótipos de funções */
void yyerror(const char *s);
int yylex();

/* Protótipo da função yyparse */
int yyparse();

#endif /* Y_TAB_H */
