/*******************************/
/* Ch3 Question 14 */
/******************************/

DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;

ODS RTF File="C:\Users\Yale\desktop\Ch3_14.rtf"; *this will make a pdf output file;
ODS Listing Close;
Data Ch3_8;
input season /*1 = Summer, 2 = Sholder, 3 = Winter */ score; 
Datalines;
1 83
1 85
1 85
1 87
1 90
1 88
1 88
1 84
1 91
1 90
2 91
2 87
2 84
2 87
2 85
2 86
2 83
3 94
3 91
3 87
3 85
3 87
3 91
3 92
3 86

;
Proc GLM; /* One-way ANOVA and Multiple Comparisons */
class season;
model score = season;
means season / hovtest tukey scheffe bon lsd;
contrast 'season 1 vs 2' season 1 -1 0;
contrast 'season 1 vs 3' season 1 0 -1;
contrast 'season 2 vs 3' season 0 1 -1;

estimate 'season 1 vs 2' season 1 -1 0;
estimate 'season 1 vs 3' season 1 0 -1;
estimate 'season 2 vs 3' season 0 1 -1;

output out=exCh3_14_out p=yhat r=resid student=stndresid LCL=lower UCL=upper; run;
Proc gplot;
plot yhat*season ;
plot resid*yhat='R' / vref=0 ; run;
proc univariate normal plot;
var resid; run;
proc rank normal=vw; /* Computing ranked normal scores by residuals*/
var resid;
ranks nscore; run;
proc plot ;
plot resid*nscore='R'; /*plotting ranked residual vs. normal score*/
label nscore='Normal Score'; run;
proc corr; /* calculate correlation efficient btwn resid and nscore */
var resid nscore; run;


ODS Listing;
ODS RTF Close;
