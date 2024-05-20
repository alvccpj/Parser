%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

%}

%token INT FLOAT DOUBLE CHAR BOOLEAN IF ELSE WHILE FOR SWITCH CASE DEFAULT BREAK CONTINUE RETURN STRUCT NUM_INT NUM_DEC TEXTO ID AND OR EQ NE GE LE PTR_OP
%token PLUS_EQ MINUS_EQ TIMES_EQ DIV_EQ MOD_EQ
%token PLUS_PLUS MINUS_MINUS
%token COMMENT BLOCK_COMMENT
%token VARARGS

%left '+' '-'
%left '*' '/'
%right '='

%%

Programa: DeclaracaoList
        ;

DeclaracaoList: /* empty */
              | DeclaracaoList Declaracao
              ;

Declaracao: DeclaracaoVariavel
          | DeclaracaoFuncao
          | DeclaracaoEstrutura
          | Comentario
          ;

DeclaracaoVariavel: Tipo ID ';'
                 | Tipo ID '=' Expressao ';'
                 ;

Tipo: INT
    | FLOAT
    | DOUBLE
    | CHAR
    | BOOLEAN
    ;

DeclaracaoFuncao: Tipo ID '(' Parametros ')' Bloco
                ;

Parametros: /* empty */
          | Parametro
          | Parametro ',' Parametros
          ;

Parametro: Tipo ID
         | Tipo ID '[' ']'
         | Tipo VARARGS ID
         ;

Bloco: '{' DeclaracaoList '}'
     ;

Comentario: COMMENT
          | BLOCK_COMMENT
          ;

Expressao: Atribuicao
         ;

Atribuicao: ID '=' Expressao
          | ID PLUS_EQ Expressao
          | ID MINUS_EQ Expressao
          | ID TIMES_EQ Expressao
          | ID DIV_EQ Expressao
          | ID MOD_EQ Expressao
          | ID AND '=' Expressao
          | ID OR '=' Expressao
          ;

Expressao: ExpressaoLogica
         ;

ExpressaoLogica: ExpressaoRelacional
               | ExpressaoLogica AND ExpressaoRelacional
               | ExpressaoLogica OR ExpressaoRelacional
               | '!' ExpressaoRelacional
               ;

ExpressaoRelacional: ExpressaoAritmetica
                   | ExpressaoAritmetica '>' ExpressaoAritmetica
                   | ExpressaoAritmetica GE ExpressaoAritmetica
                   | ExpressaoAritmetica '<' ExpressaoAritmetica
                   | ExpressaoAritmetica LE ExpressaoAritmetica
                   | ExpressaoAritmetica NE ExpressaoAritmetica
                   | ExpressaoAritmetica EQ ExpressaoAritmetica
                   ;

ExpressaoAritmetica: ExpressaoMultiplicativa
                   | ExpressaoAritmetica '+' ExpressaoMultiplicativa
                   | ExpressaoAritmetica '-' ExpressaoMultiplicativa
                   ;

ExpressaoMultiplicativa: ExpressaoUnaria
                       | ExpressaoMultiplicativa '*' ExpressaoUnaria
                       | ExpressaoMultiplicativa '/' ExpressaoUnaria
                       | ExpressaoMultiplicativa '%' ExpressaoUnaria
                       ;

ExpressaoUnaria: ExpressaoPostfix
               | '-' ExpressaoUnaria
               | PLUS_PLUS ExpressaoPostfix
               | MINUS_MINUS ExpressaoPostfix
               ;

ExpressaoPostfix: Primaria
                | Primaria '[' Expressao ']'
                | Primaria '(' Argumentos ')'
                | Primaria '.' ID
                | Primaria PTR_OP ID
                ;

Argumentos: /* empty */
          | ExpressaoLista
          ;

ExpressaoLista: Expressao
              | Expressao ',' ExpressaoLista
              ;

Primaria: ID
        | NUM_INT
        | NUM_DEC
        | TEXTO
        | '(' Expressao ')'
        ;

DeclaracaoEstrutura: STRUCT ID '{' DeclaracaoVariavelList '}' ';'
                   ;

DeclaracaoVariavelList: /* empty */
                      | DeclaracaoVariavelList DeclaracaoVariavel
                      ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}
