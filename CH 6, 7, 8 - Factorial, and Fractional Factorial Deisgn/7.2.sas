DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW7_2.doc"; 
ODS Listing Close;													

Data Cutting_Block;
    input A B X Y;
	AB = A*B;
	cards;
-1 -1 1 18.2
-1 -1 2 18.9
-1 -1 3 12.9
-1 -1 4 14.4
1 -1 1 27.2
1 -1 2 24.0
1 -1 3 22.4
1 -1 4 22.5
-1 1 1 15.9
-1 1 2 14.5
-1 1 3 15.1
-1 1 4 14.2
1 1 1 41.0
1 1 2 43.9
1 1 3 36.3
1 1 4 39.9
;
run;
Title ' ';
proc print data = Cutting_Block;
run;

/* Create ANOVA */
Title1 'AOVA for Problem 7.2';
Title2 'X =  Block';
proc glm data = Cutting_Block; 
class A B AB X;
model Y = A B X AB;
output out=cutting_block_out p=yhat r=resid;
run;

/* Residual Plots */

Proc gplot data = cutting_block_out;
	Title1 'Residual Plots for Tool 2^3 Experiment';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*A='R' / vref=0 ;
	plot resid*B='R' / vref=0 ;
run;

/* Levene Tests */

Proc GLM data = Cutting_Block;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	class A B AB;
	model y = A;
	means A / hovtest;
run;

proc GLM data = Cutting_Block;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	class B;
	model y = B;
	means B / hovtest;
run;

********************************************Transformations for Unequal Variance***********************************************************************;

data Sqrt_Cutting_Block; set Cutting_Block;
	Z = sqrt(y);
	run;

Proc GLM data = Sqrt_Cutting_Block;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = sqrt(y)';
	class A B AB;
	model Z = A;
	means A / hovtest;
run;

proc GLM data = Sqrt_Cutting_Block;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = sqrt(y)';
	class A B AB;
	model Z = B;
	means B / hovtest;
run;

data Inv_Cutting_Block; set Cutting_Block;
	Z = 1/(y);
	run;

Proc GLM data = Inv_Cutting_Block;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = A;
	means A / hovtest;
run;

proc GLM data = Inv_Cutting_Block;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = B;
	means B / hovtest;
run;

data Log_Cutting_Block; set Cutting_Block;
	Z = log(y);
	run;

Proc GLM data = Log_Cutting_Block;
	Title1 'Levene Test for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = log(y)';
	class A B AB;
	model Z = A;
	means A / hovtest;
run;

proc GLM data = Log_Cutting_Block;
	Title1 'Levene Test for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = log(y)';
	class A B AB;
	model Z = B;
	means B / hovtest;
run;

**********************************************Begin Aalysis with Transformation*************************************************************************;

Title 'ANOVA for transformed data';
Title2 'Z = 1/(y)';
proc glm data = Inv_Cutting_Block; 
class A B AB;
model Z = A B AB;
output out=Inv_Cutting_Block_out p=yhat r=resid;
run;

Title 'Checking for Interaction in 2^2 Cutting Experiment between Factor A and Factor B';
	Title2 'Z = 1/(y)';
proc glm data = Inv_Cutting_Block; 
class A B AB;
model Z = A B;
run;

proc univariate normal data = Inv_Cutting_Block_out;
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

proc GLM data = Inv_Cutting_Block;
	Title1 'Tukey Multiple Comparison for Factor A in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = A B AB;
	means A / tukey cldiff;
run; 

proc GLM data = Inv_Cutting_Block;
	Title1 'Tukey Multiple Comparison for Factor B in 2^2 Cutting Experiment';
	Title2 'Z = 1/(y)';
	class A B AB;
	model Z = A B AB;
	means B / tukey cldiff;
run;  


ODS Listing;
ODS RTF Close;
