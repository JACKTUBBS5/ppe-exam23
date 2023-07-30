libname ldata '/home/jacktubbs/my_shared_file_links/jacktubbs/2022_Exam';
options center nodate pagesize=120 ls=80;

title 'Meta Studies for CPR Survival';

/***************************************************
****************************************************
Variables are;

Author 			names for the study
Year			date of when the study was published
Total			total number of cases
No_Res			no response to cpr (death)
Surv_to_Adm		survived to admission in hospital
Sur_to_Dis		survived to discharge from hospital (Ultimate success)
Surv_Rate_Dis	survival rate = Sur_to_Dis / Total

****************************************************
***************************************************/;


data survival_data1;
length Author $20.;
input Author $ Year Total No_Res Surv_to_Adm Sur_to_Dis Surv_Rate_Dis;
if 2000 le year le 2004 then c_year = 2000;
if 2005 le year le 2009 then c_year = 2005;
datalines;
Citerio 2002 178 0 . 10 5.6
Fan 2002 320 82 . 4 1.3
Lim 2002 93 0 15 1 1.1
Myerberg 2002 738 0 . 51 6.9
Smith 2002 436 778 82 35 8.0
Goto 2003 203 227 . 20 9.9
Grmec 2003 216 . 128 44 20.4
Haukoos 2003 575 0 . 25 4.3
Nishiuchi 2003 974 176 236 50 5.1
Ong 2003 351 . 30 7 2.0
Horsted 2004 219 233 82 25 11.4
Rudner 2004 147 150 43 15 10.2
Davies 2005 172 4 . 39 22.7
Handel 2005 84 79 26 12 14.3
Hayashi 2005 179 0 . 2 1.1
White 2005 326 0 158 85 26.1
Drezner 2006 9 0 . 1 11.1
Kellum 2006 358 169 . 39 10.9
Pleskot 2006 560 144 149 53 9.5
Davis 2007 1095 46 197 47 4.3
Daya 2007 7478 6052 . 568 7.6
Dunne 2007 471 51 28 1 0.2
Estner 2007 412 277 180 47 11.4
Fairbanks 2007 539 277 . 27 5.0
Herlitz 2007 38413 . . 2114 5.5
Hostler 2007 9886 . . 727 7.4
Iwami 2007 12437 . . 433 3.5
Jasinskas 2007 62 10 11 . .
Ma 2007 1423 86 242 80 5.6
Morrison 2007 4673 40 671 239 5.1
Vadeboncoeur 2007 1097 . . . .
Fleischhackl 2008 62 . . 17 27
;
run;

data survival_data0;
length Author $20.;
input Author $ Year Total No_Res Surv_to_Adm Sur_to_Dis Surv_Rate_Dis;
if 1980 le year le 1989 then c_year = 1985;
if 1990 le year le 1994 then c_year = 1990;
if 1995 le year le 1999 then c_year = 1995;
if 2000 le year le 2004 then c_year = 2000;
datalines;
Wilson 1984 126 0 28 11 8.7
Smith 1985 893 0 79 29 3.2
Aprahamanian 1986 319 126 94 42 13.2
Bachman 1986 512 . 24 14 2.7
Bonnin 1989 232 7 56 22 9.5
Becker 1991 3221 . 241 55 1.7
Brison 1992 1510 . 143 38 2.5
Bonnin 1993 1461 0 . 92 6.3
Kellermann 1993 1068 0 267 85 8.0
Pepe 1993 2404 0 . 193 8.0
Richless 1993 96 0 14 3 3.1
Tresch 1993 196 0 37 10 5.1
Van_der_Hoeven 1993 257 0 39 6 2.3
Kass 1994 599 0 113 24 4.0
Lombardi 1994 2329 . . 52 2.2
Schneider 1994 211 125 50 19 9.0
Crone 1995 1069 0 240 135 12.6
Hodgetts 1995 100 82 . 2 2.0
Rainer 1995 455 0 105 52 11.4
Giraud 1996 113 146 22 8 7.1
Killien 1996 78 2 31 17 21.8
Kuisma 1996 255 68 98 44 17.3
Adams 1997 8651 . . 612 7.1
Fischer 1997 464 82 185 74 15.9
Kuisma 1997 162 43 45 8 4.9
Mitchell 1997 275 . . 27 9.8
Stapczynski 1997 311 0 46 19 6.1
Valenzuela 1997 7635 0 . 1086 14.2
Valenzuela 1997 665 0 . 46 6.9
De_Vreede 1998 288 350 . 47 16.3
Joyce 1998 322 0 83 26 8.1
Kette 1998 344 . 60 23 6.7
Lindholm 1998 832 0 . 67 8.1
Tadel 1998 337 511 78 19 5.6
Waalewijn 1998 1046 400 165 134 12.8
Absalom 1999 260 0 59 26 10.0
Bottinger 1999 338 243 129 48 14.2
Kuilman 1999 898 0 441 276 30.7
Lui 1999 744 0 89 12 1.6
Stiell 1999 5335 0 366 197 3.7
Sunde 1999 326 573 96 30 9.2
Swor 2000 2608 108 538 189 7.2
Valenzuela 2000 148 0 71 56 37.8
Finn 2001 1293 . . 85 6.6
Groh 2001 388 0 61 21 5.4
Jennings 2001 115 96 22 6 5.2
Rea 2001 7265 . . 1112 15.3
;
run;
proc sort data=survival_data0; by year; run;
proc sort data=survival_data1; by year; run;

data survival_data; merge survival_data0 survival_data1; by year;
run;

data survival_data; set survival_data;
if surv_rate_dis ne '.';
run;

*proc print data=survival_data; run;

title2 'Survival Rates to Discharge';

proc sgplot data=survival_data;
scatter y=Surv_Rate_Dis x=year;
loess y=Surv_Rate_Dis x=year;
reg y=Surv_Rate_Dis x=year;
run;

proc sgplot data=survival_data;
histogram Surv_Rate_Dis;
density Surv_Rate_Dis/type=kernel;
run;

proc sgplot data=survival_data;
*  xaxis discreteorder=data;
  yaxis label="Survival Rate (%)";
*  scatter y=c_year x= Surv_Rate_Dis/jitter;
  vbox Surv_Rate_Dis/ group=c_year;* / lineattrs=(color=blue thickness=2);
*  highlow y = c_year low=q1 high=q3;
*  scatter y=Time_Period x=Survival_Rate / markerattrs=(symbol=circlefilled color=blue size=8);
run;


/* Create example dataset with OHCA survival rates by 5-year time periods */;
proc sort  data=survival_data;by c_year;run;
proc means data=survival_data n q1 median q3;
output out=a n=n q1=q1 median=median q3=q3; var Surv_Rate_Dis;  by c_year;
run;

proc means data=survival_data n q1 median q3;
output out=b n=n q1=q1 median=median q3=q3; var Surv_Rate_Dis;
run;


data b; set b; c_year=2015; run;

data ohca; set a b; by c_year; run;


/*
length Time_Period $10.;
input Time_Period $ Survival_Rate;
datalines;
1980-1984 5.4
1985-1989 6.8
1990-1994 8.3
1995-1999 10.1
2000-2004 12.5
2005-2009 14.2
2010-2014 16.8
;
run;
*/;
title "OHCA Survival to Hospital Discharge";

proc sgplot data=ohca;
  yaxis discreteorder=data;
  xaxis label="Survival Rate (%)";
*  scatter y=c_year x= Surv_Rate_Dis/jitter;
  scatter y=c_year x=median;* / lineattrs=(color=blue thickness=2);
  highlow y = c_year low=q1 high=q3;
*  scatter y=Time_Period x=Survival_Rate / markerattrs=(symbol=circlefilled color=blue size=8);
run;


*ods graphics off;


/*
proc export data=survival_data
            outfile=_dataout
            dbms=csv replace;
run;

%let _DATAOUT_MIME_TYPE=text/csv;
%let _DATAOUT_NAME=cpr_survival.csv;

