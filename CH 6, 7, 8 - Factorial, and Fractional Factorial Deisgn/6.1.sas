DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW6_1.doc"; 
ODS Listing Close;													

Data Tool;
    input A B C Y;
	AB = A*B; AC = A*C; BC = B*C; ABC=AB*C;
	cards;
-1 -1 -1 22
-1 -1 -1 31
-1 -1 -1 25
1 -1 -1 32
1 -1 -1 43
1 -1 -1 29
-1 1 -1 35
-1 1 -1 34
-1 1 -1 50
1 1 -1 55
1 1 -1 47
1 1 -1 46
-1 -1 1 44
-1 -1 1 45
-1 -1 1 38
1 -1 1 40
1 -1 1 37
1 -1 1 36
-1 1 1 60
-1 1 1 50
-1 1 1 54
1 1 1 39
1 1 1 41
1 1 1 47
	;
proc print data = Tool;
run;


/* Create ANOVA */
Title 'AOVA for Problem 6.1';
proc glm data = Tool; 
class A B C AB AC BC ABC;
model Y = A B C AB AC BC ABC;
output out=tool_out p=yhat r=resid;
run;

Proc gplot data = tool_out;
	Title1 'Residual Plots for Tool 2^3 Experiment';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*A='R' / vref=0 ;
	plot resid*B='R' / vref=0 ;
	plot resid*C='R'/ vref=0;
run;

Proc GLM;
	Title1 'Levene Test for Factor A';
	class A;
	model y =  A;
	means A / hovtest;
run;

proc GLM;
	Title1 'Levene Test for Factor B';
	class B;
	model y = B;
	means B / hovtest;
run;

proc GLM;
	Title1 'Levene Test for Factor C';
	class C;
	model y = C;
	means C / hovtest;
run;

Title 'Checking for Interaction in 2^3 Tool Experiment between Factor A and Factor B';
proc glm data = Tool; 
class A B C AB AC BC ABC;
model Y = A B;
run;

Title 'Checking for Interaction in 2^3 Tool Experiment between Factor A and Factor C';
proc glm data = Tool; 
class A B C AB AC BC ABC;
model Y = A C;
run;

Title 'Checking for Interaction in 2^3 Tool Experiment between Factor B and Factor C';
proc glm data = Tool; 
class A B C AB AC BC ABC;
model Y = B C;
run;

/* Computing ranked normal scores by residuals*/
proc rank normal = vw; 
var Y;
ranks nscore; 
run;

/*plotting ranked residual vs. normal score*/
Title 'Normal Plot for 2^3 Tool Experiment';
proc gplot;
plot Y*nscore;
label nscore='Normal Score'; 
run;

proc univariate normal data = tool_out;
	Title1 'Normal Tests for Tool 2^3 Experiment';
	var resid; 
run;

proc GLM data = Tool;
	Title1 'Tukey Multiple Comparison for Factor A';
	class A B C AB AC BC ABC;
	model Y = A B C AB AC BC ABC;
	means A / tukey cldiff;
run; 

proc GLM data = Tool;
	Title1 'Tukey Multiple Comparison for Factor B';
	class A B C AB AC BC ABC;
	model Y = A B C AB AC BC ABC;
	means B / tukey cldiff;
run; 

proc GLM data = Tool;
	Title1 'Tukey Multiple Comparison for Factor C';
	class A B C AB AC BC ABC;
	model Y = A B C AB AC BC ABC;
	means C / tukey cldiff;
run; 




ODS Listing;
ODS RTF Close;
