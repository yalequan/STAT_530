DM "output;clear;log;clear";
Options pagesize=45 linesize=80 PageNo=1 NoDate;
ODS Graphics;
ODS RTF File="C:\Users\Yale\Desktop\HW7_6.doc"; 
ODS Listing Close;	

Data chemical;
    input A B C D Y Block Rep;
	AB = A*B; AC = A*C; AD = A*D; BC = B*C; BD = B*D; CD = C*D; ABC=AB*C; ABD = AB*D; ACD = AC*D; BCD = BC*D; ABCD = ABC*D;
	Cards;
	-1 -1 -1 -1 90 1 1
	1 -1 -1 -1 74 4 1
	-1 1 -1 -1 81 4 1
	1 1 -1 -1 83 1 1
	-1 -1 1 -1 77 2 1
	1 -1 1 -1 81 3 1
   -1 1 1 -1 88 3 1
	1 1 1 -1 73 2 1
	-1 -1 -1 1 98 3 1
	1 -1 -1 1 72 2 1
	-1 1 -1 1 87 2 1
	1 1 -1 1 85 3 1
	-1 -1 1 1 99 4 1
	1 -1 1 1 79 1 1
	-1 1 1 1 87 1 1
	1 1 1 1 80 4 1
;
run;

proc print data = chemical;
run;

proc glm data = chemical; 
Title 'Testing for importance HW 7.6';
class Rep Block A B C D;
model Y = Rep Block(Rep) A|B|C|D;
output out=chemical_out p=yhat r=resid;
run;

proc glm data = chemical; 
Title 'ANOVA with Significant Factors HW 7.6';
class Rep Block A B C D;
model Y = Rep Block(Rep) A B C D AB AD ABCD;
output out=chemical_out p=yhat r=resid;
run;


ODS Listing;
ODS RTF Close;
