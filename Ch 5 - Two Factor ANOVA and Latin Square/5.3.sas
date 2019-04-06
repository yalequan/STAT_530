DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW5_3.doc"; 
ODS Listing Close;								

Data yield;
   input y a b;
   label y = 'Yield'
   		 a = 'PSI'
		 b = 'Temp';
   cards;
90.4 200 150
90.2 200 150
90.7 215 150
90.6 215 150
90.2 230 150
90.4 230 150
90.1 200 160
90.3 200 160
90.5 215 160
90.6 215 160
89.9 230 160
90.1 230 160
90.5 200 170
90.7 200 170
90.8 215 170
90.9 215 170
90.4 230 170
90.1 230 170
;
run;

proc print label data = yield;
run;

 proc GLM;
      Title1 'Two-way ANOVA for Problem 5.3';
	  Title2 ' y = Yield, a = PSI, b = Temp';
      class a b;
 	  model y= a b a*b;
	  output out=yield_out p=yhat r=resid;
run;

Proc gplot;
      Title1 'Residual Plot for Problem 5.3';
	  Title2 ' y = Yield, a = PSI, b = Temp';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*a='R' / vref=0 ;
	plot resid*b='R' / vref=0 ;
run;

Proc GLM;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Levene Test Problem 5.3';
Title2 ' y = Yield, a = PSI, b = Temp';
class a;
model y=a;
means a / hovtest;
run;

Proc GLM;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Levene Test Problem 5.3';
Title2 ' y = Yield, a = PSI, b = Temp';
class b;
model y=b;
means b / hovtest;
run;

Proc GLM;
/* Tukey Multiple Comparison  */
Title1 'Tukey Multiple Comparison for PSI Problem 5.3';
Title2 ' y = Yield, a = PSI, b = Temp';
class a b;
model y=a b a*b;
means a / tukey cldiff;
run;

Proc GLM;
/* Tukey Multiple Comparison */
Title1 'Tukey Multiple Comparison for Temp Problem 5.3';
Title2 ' y = Yield, a = PSI, b = Temp';
class a b;
model y= a b a*b;
means b / tukey cldiff;
run;

proc univariate normal;
      Title1 'Normal Tests for Problem 5.3';
	  Title2 ' y = Yield, a = PSI, b = Temp';
      var resid; 
run;

proc rank normal=vw; /* Computing ranked normal scores by residuals*/
var resid;
ranks nscore; run;
run;
proc plot ;
plot resid*nscore='R'; /*plotting ranked residual vs. normal score*/
label nscore='Normal Score'; run;

/* Refit without interaction to check normality again */

 proc GLM;
      Title1 'Two-way ANOVA for Problem 5.3';
	  Title2 ' y = Yield, a = PSI, b = Temp';
      class a b;
 	  model y= a b;
	  output out=yield_out p=yhat r=resid_2;
run;

proc univariate normal;
      Title1 'Normal Tests for Problem 5.3 without interaction';
	  Title2 ' y = Yield, a = PSI, b = Temp';
      var resid_2; 
run;

proc rank normal=vw; /* Computing ranked normal scores by residuals*/
var resid_2;
ranks nscore; run;
run;
proc plot ;
plot resid_2*nscore='R'; /*plotting ranked residual vs. normal score*/
label nscore='Normal Score'; 
run;

quit;



ODS Listing;
ODS RTF Close;
ODS Graphics off;
