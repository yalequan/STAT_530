/*******************************/
/* Ch3 Question 10 */
/******************************/

DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;

ODS RTF File="C:\Users\Yale\desktop\Ch3_10.rtf"; *this will make a pdf output file;
ODS Listing Close;
Data Ch3_8;
input cotton_percent strength;
Datalines;
15 7
15 7
15 15
15 11
15 9
20 12
20 17
20 12
20 18
20 18
25 14
25 19
25 19
25 18
25 18
30 19
30 25
30 22
30 19
30 23
35 7
35 10
35 11
35 15
35 11

;
Proc GLM; /* One-way ANOVA and Multiple Comparisons */
class cotton_percent;
model strength = cotton_percent;
means cotton_percent / hovtest tukey scheffe bon lsd cldiff;
contrast 'cotton percent 15 vs 20' cotton_percent 1 -1 0 0 0;
contrast 'cotton percent 15 vs 25' cotton_percent 1 0 -1 0 0;
contrast 'cotton percent 15 vs 30' cotton_percent 1 0 0 -1 0;
contrast 'cotton percent 15 vs 35' cotton_percent 1 0 0 0 -1;
contrast 'cotton percent 20 vs 25' cotton_percent 0 1 -1 0 0;
contrast 'cotton percent 20 vs 30' cotton_percent 0 1 0 -1 0;
contrast 'cotton percent 20 vs 35' cotton_percent 0 1 0 0 -1;
contrast 'cotton percent 25 vs 30' cotton_percent 0 0 1 -1 0;
contrast 'cotton percent 25 vs 35' cotton_percent 0 0 1 0 -1;
contrast 'cotton percent 30 vs 35' cotton_percent 0 0 0 1 -1;

estimate 'cotton percent 15 vs 20' cotton_percent 1 -1 0 0 0;
estimate 'cotton percent 15 vs 25' cotton_percent 1 0 -1 0 0;
estimate 'cotton percent 15 vs 30' cotton_percent 1 0 0 -1 0;
estimate 'cotton percent 15 vs 35' cotton_percent 1 0 0 0 -1;
estimate 'cotton percent 20 vs 25' cotton_percent 0 1 1 0 0;
estimate 'cotton percent 20 vs 30' cotton_percent 0 1 0 -1 0;
estimate 'cotton percent 20 vs 35' cotton_percent 0 1 0 0 -1;
estimate 'cotton percent 25 vs 30' cotton_percent 0 0 1 -1 0;
estimate 'cotton percent 25 vs 35' cotton_percent 0 0 1 0 -1;
estimate 'cotton percent 30 vs 35' cotton_percent 0 0 0 1 -1;

output out=exCh3_8_out p=yhat r=resid student=stndresid LCL=lower UCL=upper; run;
Proc gplot;
plot yhat*cotton_percent ;
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
