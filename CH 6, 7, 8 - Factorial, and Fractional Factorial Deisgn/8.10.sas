 "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW8.10.doc"; 
ODS Listing Close;	

/*input data*/
data springs;
input A B C D E height;
cards;
-1 -1 -1 -1 -1  7.78
-1 -1 -1 -1 -1  7.78
-1 -1 -1 -1 -1  7.81
 1 -1 -1  1 -1  8.15
 1 -1 -1  1 -1  8.18
 1 -1 -1  1 -1  7.88
-1  1 -1  1 -1  7.50
-1  1 -1  1 -1  7.56
-1  1 -1  1 -1  7.50
 1  1 -1 -1 -1  7.59
 1  1 -1 -1 -1  7.56
 1  1 -1 -1 -1  7.75
-1 -1  1  1 -1  7.54
-1 -1  1  1 -1  8.00
-1 -1  1  1 -1  7.88
 1 -1  1 -1 -1  7.69
 1 -1  1 -1 -1  8.09
 1 -1  1 -1 -1  8.06
-1  1  1 -1 -1  7.56
-1  1  1 -1 -1  7.52
-1  1  1 -1 -1  7.44
 1  1  1  1 -1  7.56
 1  1  1  1 -1  7.81
 1  1  1  1 -1  7.69
-1 -1 -1 -1  1  7.50
-1 -1 -1 -1  1  7.25
-1 -1 -1 -1  1  7.12
 1 -1 -1  1  1  7.88
 1 -1 -1  1  1  7.88
 1 -1 -1  1  1  7.44
-1  1 -1  1  1  7.50
-1  1 -1  1  1  7.56
-1  1 -1  1  1  7.50
 1  1 -1 -1  1  7.63
 1  1 -1 -1  1  7.75
 1  1 -1 -1  1  7.56
-1 -1  1  1  1  7.32
-1 -1  1  1  1  7.44
-1 -1  1  1  1  7.44
 1 -1  1 -1  1  7.56
 1 -1  1 -1  1  7.69
 1 -1  1 -1  1  7.62
-1  1  1 -1  1  7.18
-1  1  1 -1  1  7.18
-1  1  1 -1  1  7.25
 1  1  1  1  1  7.81
 1  1  1  1  1  7.50
 1  1  1  1  1  7.59
;

/*Define interaction terms*/
data inter;
set springs;
 AB=A*B;
 AC=A*C;
 AD=A*D;
 AE=A*E;
 BE=B*E;
 CE=C*E;
 DE=D*E;
run;

/*Obtain estimates for interaction terms*/
Title1 'Estimate Effects';
proc glm data=inter;
class A B C D E AB AC AD AE BE CE DE;
model height=A B C D E AB AC AD AE BE CE DE;
estimate 'A' A -1 1;
estimate 'B' B -1 1;
estimate 'C' C -1 1;
estimate 'D' D -1 1;
estimate 'E' E -1 1;
estimate 'AB' AB -1 1;
estimate 'AC' AC -1 1;
estimate 'AD' AD -1 1;
estimate 'AE' AE -1 1;
estimate 'BE' BE -1 1;
estimate 'CE' CE -1 1;
estimate 'DE' DE -1 1;
run;

/*ANOVA with significant factors only*/
Title1 'ANOVA with Significant Factors';
proc glm PLOTS=(DIAGNOSTICS RESIDUALS);
class A B E BE;
model height=A B E BE;
output out=error r=res p=pred;
run;

/*Residual Plot*/
proc sgplot;
Title 'Residual Plot';
scatter x=pred y=res;
refline 0;
run;

/*QQ Plot*/
proc univariate data=error;
Title 'QQ Plot';
var res;
qqplot res/normal (mu=0 sigma=est);
run;

ODS Listing;
ODS RTF Close;
