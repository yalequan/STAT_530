/*******************************/
/* Ch3 Question 18 */
/******************************/

DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;

ODS RTF File="C:\Users\Yale\desktop\Ch3_18.rtf"; *this will make a pdf output file;
ODS Listing Close;
Data Ch3_8;
input coating_type conductivity;
Datalines;
1 143
1 141
1 150
1 146
2 152
2 149
2 137
2 143
3 134
3 136
3 132
3 127
4 129
4 127
4 132
4 129
;

run;
Proc GLM; /* One-way ANOVA and Multiple Comparisons */
class coating_type;
model conductivity = coating_type;
means coating_type / hovtest tukey scheffe bon lsd cldiff;
contrast 'coating type 1 vs 2' coating_type 1 -1 0 0;
contrast 'coating type 1 vs 3' coating_type 1 0 -1 0;
contrast 'coating type 1 vs 4' coating_type 1 0 0 -1;
contrast 'coating type 2 vs 3' coating_type 0 1 -1 0;
contrast 'coating type 2 vs 4' coating_type 0 1 0 -1;
contrast 'coating type 3 vs 4' coating_type 0 0 1 -1;

estimate 'coating type 1 vs 2' coating_type 1 -1 0 0;
estimate 'coating type 1 vs 3' coating_type 1 0 -1 0;
estimate 'coating type 1 vs 4' coating_type 1 0 0 -1;
estimate 'coating type 2 vs 3' coating_type 0 1 -1 0;
estimate 'coating type 2 vs 4' coating_type 0 1 0 -1;
estimate 'coating type 3 vs 4' coating_type 0 0 1 -1;

output out=exCh3_18_out p=yhat r=resid student=stndresid LCL=lower UCL=upper; run;
Proc gplot;
plot yhat*coating_type ;
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
