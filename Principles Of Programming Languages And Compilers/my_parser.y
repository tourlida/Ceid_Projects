%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define YYERROR_VERBOSE
extern int yylineno;
	extern char* yytext;
	extern FILE *yyin;
	extern FILE *yyout;
	

char **sids ; // style ids decleared in the header
char **ids ;  // style ids in the rest of the text
int errors = 0;
int ECCvalue = 0;  
int ERCvalue = 0;
int rcount = 0 ;
int ccount = 0;	
int c1 = 0;
int c2 = 0;

%}


%error-verbose

%union {
	int int_t;
	char *str_t;
	int bool_t;
	}


%token WORKBOOK DATA STYLES STYLE WORKSHEET  TABLE  TOKROW COLUMN CELL
%token ROW
%token ID PROTECTED NAME EXPANDEDROW EXPANDEDCOLUMN STYLEID WIDTH HIDDEN HEIGHT MERGEACROSS MERGEDOWN TYPE 
%token BOOL STRING SIGNED_INT DATE STR NUMBER QUOTE_STR QUOTE_INT QUOTE_BOOL
%left CLOSE CL_CLOSE 
%right EQUAL OPEN OP_CLOSE ROW

%type <int_t> QUOTE_INT
%type <str_t> QUOTE_STR


%%
 
root : Workbook ;

Workbook : OPEN WORKBOOK CLOSE Styles_rule Worksheet   OP_CLOSE WORKBOOK CLOSE;
Worksheet: OPEN WORKSHEET Protected NAME EQUAL QUOTE_STR  Protected CLOSE Table OP_CLOSE WORKSHEET CLOSE;
Protected : /*e*/ | PROTECTED EQUAL QUOTE_BOOL;/*dwstou timh boolean*/ 
Styles_rule : /*e*/ | Styles_rule OPEN STYLES CLOSE Style OP_CLOSE STYLES CLOSE  ; 
Style : /*e*/ | Style OPEN STYLE ID EQUAL QUOTE_STR CLOSE OP_CLOSE STYLE CLOSE Style {sids = (char**)realloc(sids,1); sids[c1] = (char*)malloc(strlen($6) + 1); strcpy(sids[c1],$6); c1++;} ; 

Table:/*e*/ |  OPEN TABLE ExpandedColumnCount ExpandedRowCount StyleID CLOSE Atr  OP_CLOSE TABLE CLOSE ;
ExpandedColumnCount: /*e*/ |  EXPANDEDCOLUMN EQUAL QUOTE_INT {ECCvalue = $3;};
ExpandedRowCount: /*e*/ |   EXPANDEDROW EQUAL QUOTE_INT {ERCvalue = $3;};
StyleID: /*e*/ |  STYLEID EQUAL QUOTE_STR {ids = (char**)realloc(ids,1); ids[c2] = (char*)malloc(strlen($3) + 1); strcpy(ids[c2],$3);c2++;};

Atr: Column Row 
   ;
Column: /*e*/ |  Column OPEN COLUMN Hidden Width StyleID  CL_CLOSE  {ccount ++; }  ;
Hidden: /*e*/ |  HIDDEN EQUAL QUOTE_BOOL  ;
Width: /*e*/ |  WIDTH EQUAL QUOTE_INT;
Row : /*e*/ |  OPEN ROW Height Hidden StyleID  CLOSE Cell OP_CLOSE ROW CLOSE Row {rcount ++; } ;
Height : /*e*/ | HEIGHT EQUAL QUOTE_INT;
Cell : /*e*/ | Cell OPEN CELL MergeAcross MergeDown StyleID CLOSE Data OP_CLOSE CELL CLOSE ;
MergeAcross: /*e*/ | MERGEACROSS EQUAL QUOTE_INT ;
MergeDown: /*e*/ | MERGEDOWN EQUAL QUOTE_INT ;
Data: /*e*/ | Data OPEN DATA TYPE  EQUAL Type_Cont  CLOSE Content OP_CLOSE DATA CLOSE  ;
Content: /*e*/ | STRING Content ;
Type_Cont: QUOTE_BOOL
    | QUOTE_STR 
    | QUOTE_INT 
    ;



%%

int yywrap(void)
{
   return 0;
}

void yyerror(char *s){
        errors++;
	printf("\n------- ERROR AT LINE #%d. %s \n\n", yylineno,s);
	
}
								

int main (int argc, char **argv){
	argv++;
	argc--;
	int i,j,l;
	char *p;
	char *q;
	int found[c1];
	int found2[c2];
	errors=0;
	  int errflag1 = 0;
	int errflag2 = 0;
	int errflag3 = 0;
	if(argc>0)
		yyin=fopen(argv[0], "r");
	else
		yyin=stdin;
			
	yyparse();

	if (ERCvalue != rcount){
	printf("Beware that the decleared rows are not equal to the existing rows\n");
	errflag1 = 1;
}
	if (ECCvalue != ccount){
	printf("Beware that the decleared columns are not equal to the existing columns\n");
	errflag1 =1;
				}

	for  (i=0;i<c1;i++){
		found[i] = 0;
				}
	
	for  (i=0;i<c1;i++){
		for (j=0;j<c1;j++){
		if( strcmp(sids[i],sids[j]) == 0){
			found[i]++;
		}
		}
		}

		for (i=0;i<c1;i++){
		if (found[i] > 1){
			errflag2 = 1;
				break;
				}
				}
		for  (i=0;i<c1;i++){
		found[i] = 0;
				}

	for (i=0;i<c2;i++){
		for (j=0;j<c1;j++){
		if (strcmp(ids[i],sids[j]) == 0)
			found2[i]++;	
				
			}
			}

	for (i=0;i<c2;i++){
		if (found2[i] == 0){
			errflag3 =1;
			break;
				}
				}
				

	
	if((errors==0) && (errflag1 == 0 ) && (errflag2 == 0)&&(errflag3 == 0)) {
	     printf("------- PARSING COMPLETED, VALID PROGRAM.\n\n"); 
        }

	if (errflag1 == 1){
		printf("ERROR AT YOUR ROWS/COLUMNS DECLERATIONS\n");
	}

	if (errflag2 == 1){
		printf("DUPLICATE STYLE ID DECLERATION\n");
	  		}
	if (errflag3 == 1){
	printf("STYLE ID NOT DECLARED ABOVE\n");
	}

	
	return 0;
} 
