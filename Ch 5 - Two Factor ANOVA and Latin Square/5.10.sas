DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW5_10.doc"; 
ODS Listing Close;								

Data light_test;
   input Y A B;
   label Y = 'Light Output'
   		 A = 'Temp'
		 B = 'Glass Type';
   cards;
580 100 1
568 100 1
570 100 1
1090 125 1
1087 125 1
1085 125 1
1392 150 1
1380 150 1
1386 150 1
550 100 2
530 100 2
579 100 2
1070 125 2
1035 125 2
1000 125 2
1328 150 2
1312 150 2
1299 150 2
546 100 3
575 100 3
599 100 3
1045 125 3
1053 125 3
1066 125 3
867 150 3
904 150 3
889 150 3
;
run;

proc print label data = light_test;
run;

 proc GLM data = light_test;
      Title1 'Two-way ANOVA for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type';
      class B A;
 	  model Y = B A B*A;
	  output out=light_out p=yhat r=resid;
run;

Proc gplot data = light_out;
      Title1 'Residual Plot for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*A='R' / vref=0 ;
	plot resid*B='R' / vref=0 ;
run;

Proc GLM data = light_test;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Problem 5.10 Facotor A Levene Test';
Title2 'Y = Light Output, A = Temp, B = Glass Type';
class A;
model Y = A;
means A / hovtest;
run;

Proc GLM data = light_test;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Problem 5.10 Factor B Levene Test';
Title2 'Y = Light Output, A = Temp, B = Glass Type';
class B;
model Y = B;
means B / hovtest;
run;

/* Log Transformation to fix variance */

data log_light_test; set light_test;
	Z = log(Y);
run;

proc print data = log_light_test;
Title 'Y = Light Output, A = Temp, B = Glass Type, Z = Log(Y)';
run;

 proc GLM data = log_light_test;
      Title1 'Two-way ANOVA, LOG Transformation for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, Z = Log(Y)';
      class B A;
 	  model Z = B A B*A;
	  output out=light_out p=yhat r=resid_log;
run;

Proc gplot data = log_light_test;
      Title1 'Residual Plot LOG Transformation for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, Z = Log Y';
 	plot resid_log*yhat='R' / vref=0 ;
	plot resid_log*A='R' / vref=0 ;
	plot resid_log*B='R' / vref=0 ;
run;

Proc GLM data = log_light_test;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA, LOG Transformation for Problem 5.10 Facotor A Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, Z = Log Y';
class A;
model Z = A;
means A / hovtest;
run;

Proc GLM data = log_light_test;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA LOG Transformation for Problem 5.10 Factor B Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, Z = Log Y';
class B;
model Z = B;
means B / hovtest;
run;

/* SQRT Transformation to fix variance */

data sqrt_light_test; set light_test;
	W = sqrt(Y);
run;

proc print data = sqrt_light_test;
Title 'Y = Light Output, A = Temp, B = Glass Type, W = SQRT(Y)';
run;

 proc GLM data = sqrt_light_test;
      Title1 'Two-way ANOVA, SQRT Transformation for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, W = SQRT(Y)';
      class B A;
 	  model W = B A B*A;
	  output out=light_out p=yhat r=resid_sqrt;
run;

Proc gplot data = sqrt_light_test;
      Title1 'Residual Plot SQRT Transformation for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, W = SQRT(Y)';
 	plot resid_sqrt*yhat='R' / vref=0 ;
	plot resid_sqrt*A='R' / vref=0 ;
	plot resid_sqrt*B='R' / vref=0 ;
run;


/* Fit one way ANOVA to obtain Levene Test */

Proc GLM data = sqrt_light_test;
	  Title1 'Fitting One-Way ANOVA, SQRT Transformation for Problem 5.10 Facotor A Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, W = SQRT(Y)';
class A;
model W = A;
means A / hovtest;
run;

/* Fit one way ANOVA to obtain Levene Test */

Proc GLM data = sqrt_light_test;
      Title1 'Fitting One-Way ANOVA SQRT Transformation for Problem 5.10 Factor B Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, W = SQRT(Y)';
class B;
model W = B;
means B / hovtest;
run;

/* Inverse Transformation to fix variance */

data inv_light_test; set light_test;
	V = 1/(Y);
run;

proc print data = inv_light_test;
Title1 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
run;

 proc GLM data = inv_light_test;
      Title1 'Two-way ANOVA, INV Transformation for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
      class B A;
 	  model V = B A B*A;
	  output out=inv_out p=yhat r=resid_inv;
run;

Proc gplot data = inv_out;
      Title1 'Residual Plot INV Transformation for Problem 5.10';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
 	plot resid_inv*yhat='R' / vref=0 ;
	plot resid_inv*A='R' / vref=0 ;
	plot resid_inv*B='R' / vref=0 ;
run;

/* Computing ranked normal scores by residuals*/

proc rank normal=vw; 
      Title1 'Normal Plot INV Transformation for Problem 5.10 Factor B Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
var resid_inv;
ranks nscore; run;
run;

proc plot;
      Title1 'Plotting Residuals INV Transformation for Problem 5.10 Factor B Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
plot resid_inv*nscore='R'; /*plotting ranked residual vs. normal score*/
label nscore='Normal Score'; run;
quit;

proc univariate normal;
      Title1 'Normal Tests INV Transformation for Problem 5.10 Factor B Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
      var resid_inv; 
run;


/* Fit one way ANOVA to obtain Levene Test */

Proc GLM data = inv_light_test;
	  Title1 'Fitting One-Way ANOVA, INV Transform for Problem 5.10 Facotor A Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
class A;
model V = A;
means A / hovtest;
run;

/* Fit one way ANOVA to obtain Levene Test */

Proc GLM data = inv_light_test;
      Title1 'Fitting One-Way ANOVA INV Transformation for Problem 5.10 Factor B Levene Test';
	  Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
class B;
model V = B;
means B / hovtest;
run;


proc GLM;
	Title1 'Tukey for Temperature Factor';
	Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
	class A B;
	model V = A B A*B;
	means A / tukey cldiff;
run;

proc GLM;
	Title1 'Tukey for Glass Type Factor';
	Title2 'Y = Light Output, A = Temp, B = Glass Type, V = 1/(Y)';
	class A B;
	model V = A B A*B;
	means B / tukey cldiff;
run;

quit;
ODS Listing;
ODS RTF Close;
ODS Graphics off;
