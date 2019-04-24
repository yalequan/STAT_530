DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW6_5.doc"; 
ODS Listing Close;													

Data Cutting;
    input A B Y;
	AB = A*B;
	cards;
-1 -1 18.2
-1 -1 18.9
-1 -1 12.9
-1 -1 14.4
1 -1 27.2
1 -1 24.0
1 -1 22.4
1 -1 22.5
-1 1 15.9
-1 1 14.5
-1 1 15.1
-1 1 14.2
1 1 41.0
1 1 43.9
1 1 36.3
1 1 39.9
;
run;
Title ' ';
proc print data = Cutting;
run;

/* Create ANOVA */
Title 'AOVA for Problem 6.5';
proc glm data = Cutting; 
class A B AB;
model Y = A B AB;
output out=cutting_out p=yhat r=resid;
run;

/* Residual Plots */

Proc gplot data = cutting_out;
	Title1 'Residual Plots for Tool 2^3 Experiment';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*A='R' / vref=0 ;
	plot resid*B='R' / vref=0 ;
run;

/* Levene Tests */

Proc GLM data = Cutting;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	class A B AB;
	model y = A;
	means A / hovtest;
run;

proc GLM data = Cutting;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	class B;
	model y = B;
	means B / hovtest;
run;

********************************************Transformations for Unequal Variance***********************************************************************;

data Sqrt_Cutting; set Cutting;
	Z = sqrt(y);
	run;

Proc GLM data = Sqrt_Cutting;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = sqrt(y)';
	class A B AB;
	model Z = A;
	means A / hovtest;
run;

proc GLM data = Sqrt_Cutting;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = sqrt(y)';
	class A B AB;
	model Z = B;
	means B / hovtest;
run;

data Inv_Cutting; set Cutting;
	Z = 1/(y);
	run;

Proc GLM data = Inv_Cutting;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = A;
	means A / hovtest;
run;

proc GLM data = Inv_Cutting;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = B;
	means B / hovtest;
run;

data Log_Cutting; set Cutting;
	Z = log(y);
	run;

Proc GLM data = Log_Cutting;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = log(y)';
	class A B AB;
	model Z = A;
	means A / hovtest;
run;

proc GLM data = Log_Cutting;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = log(y)';
	class A B AB;
	model Z = B;
	means B / hovtest;
run;

**********************************************Begin Aalysis with Transformation*************************************************************************;

Title 'ANOVA for transformed data';
Title2 'Z = 1/(y)';
proc glm data = Inv_Cutting; 
class A B AB;
model Z = A B AB;
output out=Inv_Cutting_out p=yhat r=resid;
run;

Title 'Checking for Interaction in 2^2 Cutting Experiment between Factor A and Factor B';
	Title2 'Z = 1/(y)';
proc glm data = Inv_Cutting; 
class A B AB;
model Z = A B;
run;

proc univariate normal data = Inv_Cutting_out;
	Title1 'Normal Tests for 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	var resid; 
run;

/* Computing ranked normal scores by residuals*/
proc rank normal = vw data = Inv_Cutting; 
var Z;
ranks nscore; 
run;

/*plotting ranked residual vs. normal score*/

proc gplot;
Title1 'Normal Plot for 2^2 Cutting Experiment';
Title2 'Z = 1/(y)';
plot Z*nscore;
label nscore='Normal Score'; 
run;

proc GLM data = Inv_Cutting;
	Title1 'Tukey Multiple Comparison for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = A B AB;
	means A / tukey cldiff;
run; 

proc GLM data = Inv_Cutting;
	Title1 'Tukey Multiple Comparison for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = A B AB;
	means B / tukey cldiff;
run;  


ODS Listing;
ODS RTF Close;
