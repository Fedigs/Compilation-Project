%{

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
char nom[20];
int val;
}objet;

int i=0;
objet t[10];

int getValeur(char*);
void *decimal_to_binary(int);
int puissance(int ,int );
int cardinal(int);
%}
%union {char chaine[256]; int entier;}
%token <entier> Tnb
%token <chaine> Tidnb Tcomp Tcard
%type <entier> affich exp ens elemts
%type <chaine> trait affect


%%
code : trait code
     | trait
     ;
trait : affich ';' { decimal_to_binary($1); printf("Entrer une utre fois :\n");}
      | affect ';' { printf ("donner une autre operation : \n");}
      ;
affich : Tidnb '=''='  { $$=getvaleur($1);}
			 ;
affect : Tidnb '=' ens { strcpy(t[i].nom,$1); t[i].val=$3; i++;}
			 | Tidnb '=' exp { strcpy(t[i].nom,$1); t[i].val=$3; i++;}
			 ;
			 
exp : Tidnb 'u' Tidnb { $$=getvaleur($1)|getvaleur($3);}
		| Tidnb 'i' Tidnb { $$=getvaleur($1)&getvaleur($3);}
		| Tidnb '\\' Tidnb { $$=getvaleur($1)^getvaleur($3);}
		| Tcomp '(' Tidnb ')' {$$=~getvaleur($3);}
		| Tcard '(' Tidnb ')' {$$=cardinal(getvaleur($3));}
		;
ens : '{'elemts'}' { $$=$2; /*$$=1;*/}
		;
elemts: Tnb ',' elemts { $$=(puissance(2,($1-1)) | $3); }
			| Tnb  { $$=puissance(2,($1-1));}
			;
%%

#include "lex.yy.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    printf("Donnez une expression: ");
    yyparse();
}
void *decimal_to_binary(int n){
	int c, d;
	printf("{ ");
	for (c=0; c<+30;c++)
	{
		d=n >> c;
		if (d&1)
			printf(" %d ",c+1);
	}
	printf("} \n");
}
int getvaleur(char* ch)
{
int j=0;
while(j<i &&(strcmp(t[j].nom,ch)!=0))
{
j++;
}
if(strcmp(t[j].nom,ch)==0)
	return t[j].val;
else
	return 0;
}
int puissance(int x,int n){
if(n==0){
return 1;
}
else
{
return x*puissance(x,n-1);
}


}
int cardinal(int x){


return 0;
}
