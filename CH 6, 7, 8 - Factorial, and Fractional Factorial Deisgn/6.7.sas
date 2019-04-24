DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW6_7.doc"; 
ODS Listing Close;	

Data chemical;
input A B C D Y;
AB = A*B; AC = A*C; BC = B*C; ABC = A*B*C; AD = A*D; BD = B*D; ABD = A*B*D; CD = C*D; ACD = A*C*D; BCD = B*C*D; ABCD = A*B*C*D;
cards;
-1 -1 -1 -1 90
-1 -1 -1 -1 93
1 -1 -1 -1 74
1 -1 -1 -1 78
-1 1 -1 -1 81
-1 1 -1 -1 85
1 1 -1 -1 83
1 1 -1 -1 80
-1 -1 1 -1 77
-1 -1 1 -1 78
1 -1 1 -1 81
1 -1 1 -1 80
-1 1 1 -1 88
-1 1 1 -1 82
1 1 1 -1 73
1 1 1 -1 70
-1 -1 -1 1 98
-1 -1 -1 1 95
1 -1 -1 1 72
1 -1 -1 1 76
-1 1 -1 1 87
-1 1 -1 1 83
1 1 -1 1 85
1 1 -1 1 86
-1 -1 1 1 99
-1 -1 1 1 90
1 -1 1 1 79
1 -1 1 1 75
-1 1 1 1 87
-1 1 1 1 84
1 1 1 1 80
1 1 1 1 80
;
run;

proc print data = chemical;
title 'Data for Chemical Experiment';
run;

/* Create ANOVA */
Title 'Full AOVA for Problem 6.7 Chemical Experiment';
proc glm data = chemical; 
class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
model Y = A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
output out=chemical_out p=yhat r=resid;
run;

Title 'Reduced AOVA for Problem 6.7 Chemical Experiment based on Effect Estimate';
proc glm data = chemical; 
class A C D AB ABC AD ABD CD ABCD;
model Y = A C D AB ABC AD ABD CD ABCD;
output out=chemical_out p=yhat r=resid;
run;


Proc gplot data = chemical_out;
	Title1 'Residual Plots for Chemical 2^4 Experiment';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*A='R' / vref=0 ;
	plot resid*B='R' / vref=0 ;
	plot resid*C='R'/ vref=0;
	plot resid*D='R'/ vref = 0;
run;

Proc GLM data = chemical;
	Title1 'Levene Test for Factor A';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model y =  A;
	means A / hovtest;
run;

proc GLM data = chemical;
	Title1 'Levene Test for Factor B';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model y = B;
	means B / hovtest;
run;

proc GLM data = chemical;
	Title1 'Levene Test for Factor C';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model y = C;
	means C / hovtest;
run;

proc GLM data = chemical;
	Title1 'Levene Test for Factor D';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model y = D;
	means D / hovtest;
run;

Title 'Checking for Interaction in Chemical 2^4 Experiment between Factor A and Factor B';
proc GLM data = chemical;
class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
model Y = A B;
run;

Title 'Checking for Interaction in Chemical 2^4 Experiment between Factor A and Factor C';
proc GLM data = chemical;
class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
model Y = A C;
run;

Title 'Checking for Interaction in Chemical 2^4 Experiment between Factor A and Factor D';
proc GLM data = chemical;
class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
model Y = A D;
run;

Title 'Checking for Interaction in Chemical 2^4 Experiment between Factor B and Factor C';
proc GLM data = chemical;
class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
model Y = B C;
run;

Title 'Checking for Interaction in Chemical 2^4 Experiment between Factor B and Factor D';
proc GLM data = chemical;
class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
model Y = B D;
run;

Title 'Checking for Interaction in Chemical 2^4 Experiment between Factor C and Factor D';
proc GLM data = chemical;
class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
model Y = C D;
run;
/* Computing ranked normal scores by residuals*/
proc rank normal = vw; 
var Y;
ranks nscore; 
run;

/*plotting ranked residual vs. normal score*/
Title 'Normal Plot for Chemical 2^4 Experiment';
proc gplot;
plot Y*nscore;
label nscore='Normal Score'; 
run;

proc univariate normal data = chemical_out;
	Title1 'Normal Tests for Chemical 2^4 Experiment';
	var resid; 
run;

/* Multiple Comparison */

proc GLM data = chemical;
	Title1 'Tukey Multiple Comparison for Factor A';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model Y = A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	means A / tukey cldiff;
run; 

proc GLM data = chemical;
	Title1 'Tukey Multiple Comparison for Factor B';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model Y = A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	means B / tukey cldiff;
run; 

proc GLM data = chemical;
	Title1 'Tukey Multiple Comparison for Factor C';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model Y = A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	means C / tukey cldiff;
run; 

proc GLM data = chemical;
	Title1 'Tukey Multiple Comparison for Factor D';
	class A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	model Y = A	B C	D AB AC	BC ABC AD BD ABD CD	ACD	BCD	ABCD;
	means D / tukey cldiff;
run;

ODS Listing;
ODS RTF Close;
