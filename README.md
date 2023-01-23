# Bison-Flex email parser
Validates your email address
## Compile:
1. yacc email.yacc -d
2. lex email.lex
3. cc y.tab.c lex.yy.c
## Run:
 ./a.out your.email@gmail.com
