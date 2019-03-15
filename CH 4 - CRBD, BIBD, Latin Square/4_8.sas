
DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\ex4_8.doc"; 
ODS Listing Close;								

Data ex4_8;
   input y x1 x2;
   /* Lable the dataset */
   label y = "Response"
   		 x1 = "Design (treatment)"
		 x2 = "Region (block) 1 = NE 2 = NW 3 = SE 4 = SW"
		 ;
   cards;
250 1 1
350 1 2
219 1 3
375 1 4
400 2 1
525 2 2
390 2 3
580 2 4
275 3 1
340 3 2
200 3 3
310 3 4
;

proc print label data = ex4_8;
run;

 proc GLM;

      Title1 'RCBD for Brochure Design';
	  Title2 'y = Response Number, x1 = Design (treatment), x2 = Region (block)';
	  title3 'Region: 1 = NE 2 = NW 3 = SE 4 = SW';
      class x1 x2;
 	  model y = x1 x2;
 	  means x1 /hovtest tukey scheffe bon lsd cldiff;
	  means x2 /hovtest tukey scheffe bon lsd cldiff;

	output out=ex4_8 p=yhat r=resid;

Proc GLM;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Design Levene Test Brochure Design Experiment';
Title2 'y = Growth, x1 = Solution (treatment), x2 = Day (block)';
class x1;
model y=x1;
means x1 / hovtest;


Proc GLM;
/* Fit one way ANOVA to obtain Levene Test */
Title1 'Fitting One-Way ANOVA for Region Levene Test Brochure Design Experiment';
Title2 'y = Growth, x1 = Solution (treatment), x2 = Day (block)';
class x2;
model y=x2;
means x2 / hovtest;


Proc gplot;
      Title1 'Residual Plot for Brochure Design';
	  Title2 'y = Response Number, x1 = Design (treatment), x2 = Region (block)';
	  title3 'Region: 1 = NE 2 = NW 3 = SE 4 = SW';
 	plot resid*yhat='R' / vref=0 ;
	plot resid*x1='R' / vref=0 ;
	plot resid*x2='R' / vref=0 ;
run;

proc univariate normal;
      Title1 'Normal Tests for Brochure Design';
	  Title2 'y = Response Number, x1 = Design (treatment), x2 = Region (block)';
	  title3 'Region: 1 = NE 2 = NW 3 = SE 4 = SW';
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
