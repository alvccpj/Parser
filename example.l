%{
#include "example.tab.h"
%}

%union {
    char *sval;
    int ival;
    float fval;
}

%%

[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return ID; }
\"(\\.|[^\\"])*\"      { yylval.sval = strdup(yytext); return TEXTO; }
[0-9]+                  { yylval.ival = atoi(yytext); return NUM_INT; }
[0-9]+"."[0-9]+         { yylval.fval = atof(yytext); return NUM_DEC; }

"int"        { return INT; }
"float"      { return FLOAT; }
"double"     { return DOUBLE; }
"char"       { return CHAR; }
"boolean"    { return BOOLEAN; }
"if"         { return IF; }
"else"       { return ELSE; }
"while"      { return WHILE; }
"for"        { return FOR; }
"switch"     { return SWITCH; }
"case"       { return CASE; }
"default"    { return DEFAULT; }
"break"      { return BREAK; }
"continue"   { return CONTINUE; }
"return"     { return RETURN; }
"struct"     { return STRUCT; }

"&&"       { return AND; }
"||"       { return OR; }
"=="       { return EQ; }
"!="       { return NE; }
">="       { return GE; }
"<="       { return LE; }

"+="       { return PLUS_EQ; }
"-="       { return MINUS_EQ; }
"*="       { return TIMES_EQ; }
"/="       { return DIV_EQ; }
"%="       { return MOD_EQ; }

"//"(.*)"\n"       /* Ignorar comentários de linha */
"/\*"[^*]*\*+"/"   /* Ignorar comentários de bloco */
.                  /* Ignorar outros caracteres */

%%

int yywrap(void) {
    return 1;
}
