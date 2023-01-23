%{
#include <stdio.h>
#include <string.h>
#define MAXS 256
static char s[MAXS];
char login[MAXS];
char domain[MAXS];
int yylex();
int yyparse();
void yyerror(const char *str)
{
fprintf( stderr, "error: %s\n" ,str);
}

int yywrap()
{
return(1);
}
int main(int n, char*v[])
{
int k;
for(k=0;k<20;k++){
s[k]='\0';
}
printf("\nВсего параметров n=%d", n);
printf("\nПараметр v[0]=%s", v[0]);
for (k=1;k<n;k++) {
printf("\nПараметр v[%d]=%s", k, v[k]);
if (k>1) strcat(s, " "); 
strcat(s, v[k]);
}
printf("\nПолная строка=%s\n", s);
yy_scan_string(&s);
yyparse();
}

%}

%start start

%union { char* value_string; }


%token LETTER CHECKDOT DIGIT

%type <value_string>  DIGIT LETTER CHECKDOT
%% /* начало раздела правил */

start: login '@' domain
{
printf("Login = %s\n",login);
printf("Domain = %s\n",domain);
};
login: login '.' LETTER{
strcat(login, ".");
strcat(login, $3);
}
|
login '.' DIGIT{
strcat(login, ".");
strcat(login, $3);
}|

login '_' LETTER{
strcat(login, "_");
strcat(login, $3);
}|

login '_' DIGIT{
strcat(login, "_");
strcat(login, $3);
}|

login '-' LETTER{
strcat(login, "-");
strcat(login, $3);
}|

login '-' DIGIT{
strcat(login, "-");
strcat(login, $3);
}|

login LETTER{
strcat(login, $2);
}|
login DIGIT{
strcat(login, $2);
}|
LETTER{
strcat(login, $1);
};

domain: name '.' CHECKDOT{
strcat(domain, ".");
strcat(domain, $3);
};

name: name LETTER{strcat(domain, $2);
}|
LETTER{
strcat(domain, $1);
};

%%

