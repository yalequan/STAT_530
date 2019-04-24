DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW7_5.doc"; 
ODS Listing Close;	

Data chemical;
input A B C D Block Rep Y;
AB = A*B; AC = A*C; BC = B*C; ABC = A*B*C; AD = A*D; BD = B*D; ABD = A*B*D; 
CD = C*D; ACD = A*C*D; BCD = B*C*D; ABCD = A*B*C*D;
cards;
-1 -1 -1 -1 1 1 90
1 -1 -1 -1 2 1 74
-1 1 -1 -1 2 1 81
1 1 -1 -1 1 1 83
-1 -1 1 -1 2 1 77
1 -1 1 -1 1 1 81
-1 1 1 -1 1 1 88
1 1 1 -1 2 1 73
-1 -1 -1 1 2 1 98
1 -1 -1 1 1 1 72
-1 1 -1 1 1 1 87
1 1 -1 1 2 1 85
-1 -1 1 1 1 1 99
1 -1 1 1 2 1 79
-1 1 1 1 2 1 87
1 1 1 1 1 1 80
;
run;

proc print data = chemical;
run;

proc glm data = chemical; 
Title 'Testing for importance HW 7.5';
class Rep Block A B C D;
model Y = Rep Block(Rep) A|B|C|D;
output out=chemical_out p=yhat r=resid;
run;

proc glm data = chemical; 
Title 'ANOVA with Significant Factors HW 7.5';
class Rep Block A B C D;
model Y = Rep Block(Rep) A B C AB ABC D AD ABD BCD;
output out=chemical_out p=yhat r=resid;
run;


ODS Listing;
ODS RTF Close;
