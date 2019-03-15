
DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\ex4_4.doc"; 
ODS Listing Close;								

Data ex4_1;
   input y x1 x2;
   /* Lable the dataset */
   label y = "Growth"
   		 x1 = "Solution (treatment)"
		 x2 = "Day (block)"
		 ;
   cards;
13 1 1
22 1 2
18 1 3
39 1 4
16 2 1
24 2 2
17 2 3
44 2 4
5 3 1
4 3 2
1 3 3
22 3 4
;

proc print label data = ex4_1;
run;

 proc GLM;

Title1 'RCBD for Bacteria Growth Experiment';
Title2 'y = Growth, x1 = Solution (treatment), x2 = Day (block)';
class x1 x2;
model y = x1 x2;
means x1 /hovtest tukey scheffe bon lsd cldiff;
means x2 /hovtest tukey scheffe bon lsd cldiff;

	output out=ex4_4 p=yhat r=resid;


Proc GLM;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Solution Levene Test Bacteria Growth Experiment';
Title2 'y = Growth, x1 = Solution (treatment), x2 = Day (block)';
class x1;
model y=x1;
means x1 / hovtest;


Proc GLM;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Day Levene Test Bacteria Growth Experiment';
Title2 'y = Growth, x1 = Solution (treatment), x2 = Day (block)';
class x2;
model y=x2;
means x2 / hovtest;



Proc gplot;
Title1 'Residual Plot Bacteria Growth Experiment';
Title2 'y = Growth, x1 = Solution (treatment), x2 = Day (block)';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*x1='R' / vref=0 ;
	plot resid*x2='R' / vref=0 ;
run;

proc univariate normal;
Title1 'Normal Test for Bacteria Growth Experiment';
Title2 'y = Growth, x1 = Solution (treatment), x2 = Day (block)';
        var resid; 
run;

proc rank normal=vw; /* Computing ranked normal scores by residuals*/
var resid;
ranks nscore; run;
proc plot ;
plot resid*nscore='R'; /*plotting ranked residual vs. normal score*/
label nscore='Normal Score'; run;

ODS Listing;
ODS Graphics off;
ODS RTF Close;

