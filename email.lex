%{

#include <stdio.h>
#include "y.tab.h"
%}
%%
[A-Za-z] {
yylval.value_string = yytext;
return(LETTER);
}
[0-9] {
yylval.value_string = yytext;
return(DIGIT);
}
[-._@%^:#*!\[\]\{\}] {
return(yytext[0]);
}
com|ru {
yylval.value_string = yytext;
return (CHECKDOT);
}
%%

