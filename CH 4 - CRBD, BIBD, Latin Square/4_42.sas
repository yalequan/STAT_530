
DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\ex4_42.doc";
ODS Listing Close;								

Data ex4_42;
   input y x1 x2;
   label y = 'Strength'
         x1 = 'Hardwood Concentration %'
		 x2 = 'Days';
   cards;
114 2 1
120 2 5
117 2 7
126 4 1
120 4 2
119 4 6
137 6 2
117 6 3
134 6 7
141 8 1
129 8 3
149 8 4
145 10 2
150 10 4
143 10 5
120 12 3
118 12 5
123 12 6
136 14 4
130 14 6
127 14 7
;

proc print label data = ex4_42;
run;

 proc GLM;
      Title1 'BIBD for Hardwood Concentration Percent Experiment';
	  Title2 'y = Strength x1 = Hardwood Concentration % x2 = Days';
      class x2 x1;
 	  model y= x2 x1;
	  means x1 / hovtest tukey scheffe bon lsd cldiff;
	  output out=ex4_42 p=yhat r=resid;

Proc gplot;
    Title1 'Residual Plot for Hardwood Concentration Percent Experiment';
	Title2 'y = Strength x1 = Hardwood Concentration % x2 = Days';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*catalyst='R' / vref=0 ;
	plot resid*batch='R' / vref=0 ;
run;

Proc GLM;

/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Hardwood Concentration Levene Test';
Title2 'y = Strength x1 = Hardwood Concentration % x2 = Days';
class x1;
model y=x1;
means x1 / hovtest;

Proc GLM;

/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Days Levene Test';
Title2 'y = Strength x1 = Hardwood Concentration % x2 = Days';
class x2;
model y=x2;
means x2 / hovtest;

proc univariate normal;
    Title1 'Normal Tests for Hardwood Concentration Percent Experiment';
	Title2 'y = Strength x1 = Hardwood Concentration % x2 = Days';
        var resid; 
run;

proc rank normal=vw; /* Computing ranked normal scores by residuals*/
var resid;
ranks nscore; run;
proc plot ;
plot resid*nscore='R'; /*plotting ranked residual vs. normal score*/
label nscore='Normal Score'; run;
quit;



ODS Listing;
ODS RTF Close;
ODS Graphics off;

