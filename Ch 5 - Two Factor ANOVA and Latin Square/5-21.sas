DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW5_21.doc"; 
ODS Listing Close;							

Data chem;
   input y x1 $ x2 x3;
   label y = 'Yield'
   		 x1 = 'Temp'
		 x2 = 'Pressure'
	     x3 = 'Day';
   cards;
86.3 low 250 1
84.0 low 260 1
85.8 low 270 1
88.5 med 250 1
87.3 med 260 1
89.0 med 270 1
89.1 high 250 1
90.2 high 260 1
91.3 high 270 1
86.1 low 250 2
85.2 low 260 2
87.3 low 270 2
89.4 med 250 2
89.9 med 260 2
90.3 med 270 2
91.7 high 250 2
93.2 high 260 2
93.7 high 270 2
;

proc print label data = chem;
run;

 proc GLM;
      Title1 'Two-way ANOVA for Chemical Yield Experiment';
	  Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
      class x1 x2;
 	  model y = x1 x2 x1*x2 x3;
	  output out=chem p=yhat r=resid;
	  run;

Proc gplot;
	Title1 'Residual Plots for Chemical Yield Experiment';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*x1='R' / vref=0 ;
	plot resid*x2='R' / vref=0 ;
	plot resid*x3='R'/ vref=0;
run;

proc GLM;
	Title1 'Levene Test for Temperature';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	class x1;
	model y = x1;
	means x1 / hovtest;
run;

proc GLM;
	Title1 'Levene Test for Pressure';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	class x2;
	model y = x2;
	means x2 / hovtest;
run;

proc GLM;
	Title1 'Levene Test for Day';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	class x3;
	model y = x3;
	means x3 / hovtest;
run;

proc GLM;
	Title1 'Tukey Multiple Comparison for Temperature Level Means';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	class x1 x2;
	model y = x1 x2 x1*x2 x3;
	means x1 / tukey cldiff;
output out=chem_out p=yhat r=resid;
run;

proc GLM;
	Title1 'Tukey Multiple Comparison Pressure Level Means';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	class x1 x2;
	model y = x1 x2 x1*x2 x3;
	means x2 / tukey cldiff;
output out=chem_out p=yhat r=resid;
run;

proc univariate normal;
	Title1 'Normal Tests for Chemical Yield Experiment';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	var resid; 
run;

proc rank normal=vw; /* Computing ranked normal scores by residuals*/
	Title1 'Normal Tests for Chemical Yield Experiment';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	var resid;
	ranks nscore; 
run;

proc plot ;
	Title1 'Normal Tests for Chemical Yield Experiment';
	Title2 ' y = Yield, x1 = Temp, x2 = Pressure, x3 = Day';
	plot resid*nscore='R'; /*plotting ranked residual vs. normal score*/
	label nscore='Normal Score'; run;
quit;



ODS Listing;
ODS RTF Close;
ODS Graphics off;
