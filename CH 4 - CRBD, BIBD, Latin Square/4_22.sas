DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;

ODS RTF File="C:\Users\Yale\Desktop\ex4_22.doc"; 
ODS Listing Close;								

Data ex4_22;
   input y x1 $ x2 x3;
   label y = 'Reaction Time'
   		 x1 = 'Ingredient'
		 x2 = 'Batch'
		 x3 = 'Day'
		 ;
   cards;
8 A 1 1
7 B 1 2
1 D 1 3
7 C 1 4
3 E 1 5
11 C 2 1
2 E 2 2
7 A 2 3
3 D 2 4
8 B 2 5
4 B 3 1
9 A 3 2
10 C 3 3
1 E 3 4
5 D 3 5
6 D 4 1
8 C 4 2
6 E 4 3
6 B 4 4
10 A 4 5
4 E 5 1
2 D 5 2
3 B 5 3
8 A 5 4
8 C 5 5
;

proc print label data = ex4_22;
run;

 proc GLM;

Title1 'Latin Square for Reaction Time Experiment';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';
class x1 x2 x3;
model y = x1 x2 x3;
means x1 / hovtest tukey scheffe bon lsd cldiff;
output out=ex4_22 p=yhat r=resid;

 proc GLM;

Title1 'Interaction Plot for Reaction Time Experiment';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';
class x1 x2;
model y = x1 x2;

proc GLM;

Title1 'Interaction Plot for Reaction Time Experiment';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';
class x1 x3;
model y = x1 x3;

proc GLM;

Title1 'Interaction Plot for Reaction Time Experiment';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';
class x2 x3;
model y = x2 x3;

Proc GLM;

/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Ingredient Levene Test';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';;
class x1;
model y=x1;
means x1 / hovtest;

Proc GLM;

/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Batch Levene Test';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';;
class x2;
model y=x2;
means x2 / hovtest;

Proc GLM;

/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Day Levene Test';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';;
class x3;
model y=x3;
means x3 / hovtest;

Proc gplot;
Title1 'Residual Plot for Latin Square for Reaction Time Experiment';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';
plot resid*yhat='R' / vref=0 ;
plot resid*x2='R' / vref=0 ;
plot resid*x3='R' / vref=0 ;
run;

proc univariate normal;
Title1 'Normal Tests for Latin Square for Reaction Time Experiment';
Title2 'y = Reaction Time, x1 = Ingredient, x2 = Batch, x3 = Day';
        var resid;
run;

proc rank normal=vw; /* Computing ranked normal scores by residuals*/
var resid;
ranks nscore; run;
proc plot ;
plot resid*nscore='R'; /*plotting ranked residual vs. normal score*/
label nscore='Normal Score'; run;

ODS Listing;
ODS RTF Close;
