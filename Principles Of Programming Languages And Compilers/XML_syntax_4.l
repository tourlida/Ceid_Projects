%{
	#include "y.tab.h"  
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	char *temp;
	char *stemp;
%}
%option noyywrap
%option yylineno
%x comments
str  [a-zA-Z0-9_]*[a-zA-Z_][a-zA-Z0-9_]*
quote [\"]
digit [0-9]
signed_integer{digit}+  
white_spaces [ \t\n]

%%
"<!--" BEGIN(comments);
<comments>{
     [^-\n]*
     "-"+[^->\n]*
     \n
     "-->" BEGIN(INITIAL);
}


"Workbook"                       {printf("\t WORKOBOOK: %s\n", yytext); return (WORKBOOK);}
"Worksheet"                       {printf("\t WORKSHEET: %s\n", yytext);  return (WORKSHEET);}
"Styles"                       {printf("\t STYLES: %s\n", yytext);  return (STYLES);}
"Style"                       {printf("\t STYLE: %s\n", yytext);return (STYLE);}
"Table"                       {printf("\t TABLE: %s\n", yytext);  return (TABLE);}
"ss:ExpandedRowCount"                       {printf("\t ExpandedRowCount: %s\n", yytext);  return (EXPANDEDROW);}
"ss:ExpandedColumnCount"                       {printf("\t ExpandedColumnCount: %s\n", yytext); return (EXPANDEDCOLUMN);}
"ss:StyleID"                       {printf("\t : StyleID %s\n", yytext); return (STYLEID);}
"ss:Name"                       {printf("\t Name: %s\n", yytext);  return (NAME);}
"Column"                       {printf("\t Column: %s\n", yytext);    return (COLUMN);}
"Row"                       {printf("\t Row: %s\n", yytext);    return (ROW);}
"Cell"                       {printf("\t Cell: %s\n", yytext);    return (CELL);}
"Data"                       {printf("\t Data: %s\n", yytext);    return (DATA);}
"ss:ID"                       {printf("\t ID: %s\n", yytext);    return (ID);}
"ss:Height"                       {printf("\t Height: %s\n", yytext);    return (HEIGHT);}
"ss:Hidden"                       {printf("\t Hidden: %s\n", yytext);    return (HIDDEN);}
"ss:MergeAcross"                       {printf("\t MergeAcross: %s\n", yytext);    return (MERGEACROSS);}
"ss:Width"                       {printf("\t Width: %s\n", yytext);   return (WIDTH);}
"ss:MergeDown"                       {printf("\t MergeDown: %s\n", yytext);    return (MERGEDOWN);}
"ss:Type"                       {printf("\t Type: %s\n", yytext);    return (TYPE);}
"ss:Protected"  {printf("\t Protected: %s\n", yytext);    return (PROTECTED);}
"\"Boolean\"" {printf("\t Boolean: %s\n", yytext);   return (QUOTE_BOOL);}
{white_spaces} {}
{str}           {printf("\t String: %s\n", yytext);   return (STRING);} 
{quote}{str}{quote}  {printf("\t Quoted String: %s\n", yytext);    yytext++; yytext[strlen(yytext)-1] = 0; yylval.str_t = yytext; return (QUOTE_STR);} 
{quote}{signed_integer}{quote}  {printf("\t Quoted signed_integer: %s\n", yytext); temp = yytext; temp++; temp[strlen(temp)-1] = 0; yylval.int_t = atoi(temp);   return (QUOTE_INT);}    
"=" { printf("\t Equal: %s\n", yytext); return (EQUAL);}
"<ss:"  {printf("\t Open %s\n", yytext);  return (OPEN);}
">"   {printf("\t Close %s\n", yytext);  return (CLOSE);}
"</ss:" {printf("\t OP_Close %s\n", yytext); return (OP_CLOSE);}
"/>" {printf("\t CL_Close %s\n", yytext); return (CL_CLOSE);}






