* This file was created in April 2018
* It incorporate the changes requested by AEJ Macro
****************************************************************
version 8
set mem 1000m
set matsize 1000

sysuse auto, clear
set scheme s2color

use $data/Replication.dta, clear 

keep msa emp2019

merge m:1 msa using $data/data3.dta

drop if emp2019 == .
drop if emp1964 == .



***********************************************
****************************************
* Wages conditional on workers characteristics
***************************************
***********************************************
g controlling_for_X = "yes" 
*g controlling_for_X = "no"



***********************************************
****************************************
* Set the model parameters
* alpha and eta are the technology parameters 
* US Labor share: in 2009 is .61 (The Global Decline of the Labor Share Karabarbounis and Neiman QJE 2014;see also piketty)
*                 in 1975 is .65 (same sources)
* US capital share = .25
* beta is the share of housing
* rate is the real interest rate (it does not matter much because we only use it to define TFP in levels)
* theta governs idiosyncratic preferences from location 
*          a) Diamond estimate is .57 for coll grads and .27 for hs grads; population weighted mean =  .43 
*          (note: 1/beta_wage, where her beta wage parameter for college is 1.77 see her Table 3)
*             However, Diamond  conditions on state of birth and therefore absorbes a lot of variation
*          b) Serrano and Zidar, 2013 (Table 5) estimate is between .47 (baseline in panel A) and .76 (baseline in Panel B)
****************************************
***********************************************

g alpha  = .65
g eta    = .25
g beta   = .40
g rate   = .05
g inv_theta = 0.3


***********************************************
****************************************
* Define Brain Hubs, Rust Belt and South
****************************************
***********************************************
* Barin hubs
g        brain = 0
replace  brain = 1  if   msa == 5600 | msa == 7400  | msa == 7360 

*  Rust Belt        
g        rust = 0
replace  rust = 1 if msa == 2640    | msa ==  7610    | msa ==    5280   | msa == 4800   | msa ==    9320   | msa ==    1320   | msa == 4040   | msa == 6960   | msa == 6840 | msa == 3680 | msa == 3200 | msa == 1280 | msa == 4320 | msa == 8680  | msa == 2360 | msa == 960 | msa == 2000   | msa ==    8400    | msa ==   870    | msa ==   80    | msa == 7040    |  msa ==  8160    | msa ==  3720    | msa == 8320 |  msa == 3000    | msa ==    9140     | msa == 3920    | msa ==    1680    | msa ==  2040    | msa ==  2160    | msa ==   6280    | msa ==280    | msa ==   3740   | msa == 7800   | msa ==1280 | msa == 3620  | msa ==  6880  | msa ==  2760  | msa == 8160
g        south = 0
replace  south = 1 if  division == 5 | division ==6 | division ==7

* Other large cities
* These are 19 cities with employment above 600,000
g        other =0
replace  other =1 if emp2009 >= 600000 & brain ==0 & rust ==0 & south ==0


***********************************************
****************************************
* Wages Controlling for Demographics 
*****************************************
***********************************************
g log_wage64_unconditional =logwage64
g log_wage09_unconditional = logwage09
g wage64_unconditional = exp(logwage64)
g wage09_unconditional = exp(logwage09)
replace logwage64 = logwage_condit64          if controlling_for_X == "yes"
replace logwage09 = logwage_condit09          if controlling_for_X == "yes"
replace wage1964  = exp(logwage_condit64)     if controlling_for_X == "yes"
replace wage2009  = exp(logwage_condit09)     if controlling_for_X == "yes"
replace wage1966  = exp(logwage_condit66)     if controlling_for_X == "yes"
replace wage1967  = exp(logwage_condit67)     if controlling_for_X == "yes"
replace wage1968  = exp(logwage_condit68)     if controlling_for_X == "yes"
replace wage1969  = exp(logwage_condit69)     if controlling_for_X == "yes"
replace wage1970 = exp(logwage_condit70)     if controlling_for_X == "yes"
replace wage1971 = exp(logwage_condit71)     if controlling_for_X == "yes"
replace wage1972 = exp(logwage_condit72)     if controlling_for_X == "yes"
replace wage1973 = exp(logwage_condit73)     if controlling_for_X == "yes"
replace wage1977 = exp(logwage_condit77)     if controlling_for_X == "yes"
replace wage1978 = exp(logwage_condit78)     if controlling_for_X == "yes"
replace wage1979 = exp(logwage_condit79)     if controlling_for_X == "yes"
replace wage1980 = exp(logwage_condit80)     if controlling_for_X == "yes"
replace wage1981 = exp(logwage_condit81)     if controlling_for_X == "yes"
replace wage1982 = exp(logwage_condit82)     if controlling_for_X == "yes"
replace wage1983 = exp(logwage_condit83)     if controlling_for_X == "yes"
replace wage1984 = exp(logwage_condit84)     if controlling_for_X == "yes"
replace wage1985 = exp(logwage_condit85)     if controlling_for_X == "yes"
replace wage1986 = exp(logwage_condit86)     if controlling_for_X == "yes"
replace wage1987 = exp(logwage_condit87)     if controlling_for_X == "yes"
replace wage1988 = exp(logwage_condit88)     if controlling_for_X == "yes"
replace wage1989 = exp(logwage_condit89)     if controlling_for_X == "yes"
replace wage1990 = exp(logwage_condit90)     if controlling_for_X == "yes"
replace wage1991 = exp(logwage_condit91)     if controlling_for_X == "yes"
replace wage1992 = exp(logwage_condit92)     if controlling_for_X == "yes"
replace wage1993 = exp(logwage_condit93)     if controlling_for_X == "yes"
replace wage1994 = exp(logwage_condit94)     if controlling_for_X == "yes"
replace wage1995 = exp(logwage_condit95)     if controlling_for_X == "yes"
replace wage1996 = exp(logwage_condit96)     if controlling_for_X == "yes"
replace wage1997 = exp(logwage_condit97)     if controlling_for_X == "yes"
replace wage1998 = exp(logwage_condit98)     if controlling_for_X == "yes"
replace wage1999 = exp(logwage_condit99)     if controlling_for_X == "yes"
replace wage2000 = exp(logwage_condit00)     if controlling_for_X == "yes"
replace wage2001 = exp(logwage_condit01)     if controlling_for_X == "yes"
replace wage2002 = exp(logwage_condit02)     if controlling_for_X == "yes"
replace wage2003 = exp(logwage_condit03)     if controlling_for_X == "yes"
replace wage2004 = exp(logwage_condit04)     if controlling_for_X == "yes"
replace wage2005 = exp(logwage_condit05)     if controlling_for_X == "yes"
replace wage2006 = exp(logwage_condit06)     if controlling_for_X == "yes"
replace wage2007 = exp(logwage_condit07)     if controlling_for_X == "yes"


***********************************************
****************************************
* TFP
****************************************
***********************************************



**** XXXXXXXXXXXXXXXXXXXXXXXXXXX
* the level of conditional wages is not identified. 
* I renormalze wages so that they have same mean in 1964 and 2009  
* Note: relative wage levels are unchnaged, but the level is now cleaned of the arbitrary intercept in the conditional wage 

summ wage2009 wage1964
*egen tmp09 = mean(wage2009)
*egen tmp64 = mean(wage1964)
summarize wage1964 [weight = emp1964]
g tmp64 = r(mean)
summarize wage2009 [weight = emp2009]
g tmp09 = r(mean)
replace wage2009 = (wage2009/tmp09)* tmp64
drop tmp09 tmp64
summ wage2009 wage1964

summ logwage64 logwage09
replace logwage64 = log(wage1964)  
replace logwage09 = log(wage2009)  
summ logwage64 logwage09




* This term is TFP^(1/(1-alpha-eta))*T
g double AT64 = ( (alpha^(1-eta))*(eta^eta) / (rate^eta) ) * emp1964*wage1964^( (1-eta)/(1-alpha-eta) )
g double AT09 = ( (alpha^(1-eta))*(eta^eta) / (rate^eta) ) * emp2009*wage2009^( (1-eta)/(1-alpha-eta) )

* This term is TFP when y=(L,K) with DRTS
g Atfp64 =  ( emp1964^(1-alpha-eta) *  (wage1964^(1-eta)) ) 
g Atfp09 =  ( emp2009^(1-alpha-eta) *  (wage2009^(1-eta)) ) 
g Atfp66 =  ( emp1966^(1-alpha-eta) *  (wage1966^(1-eta)) )
g Atfp67 =  ( emp1967^(1-alpha-eta) *  (wage1967^(1-eta)) )
g Atfp68 =  ( emp1968^(1-alpha-eta) *  (wage1968^(1-eta)) )
g Atfp69 =  ( emp1969^(1-alpha-eta) *  (wage1969^(1-eta)) )
g Atfp70 =  ( emp1970^(1-alpha-eta) *  (wage1970^(1-eta)) )
g Atfp71 =  ( emp1971^(1-alpha-eta) *  (wage1971^(1-eta)) )
g Atfp72 =  ( emp1972^(1-alpha-eta) *  (wage1972^(1-eta)) )
g Atfp73 =  ( emp1973^(1-alpha-eta) *  (wage1973^(1-eta)) )
g Atfp77 =  ( emp1977^(1-alpha-eta) *  (wage1977^(1-eta)) )
g Atfp78 =  ( emp1978^(1-alpha-eta) *  (wage1978^(1-eta)) )
g Atfp79 =  ( emp1979^(1-alpha-eta) *  (wage1979^(1-eta)) )
g Atfp80 =  ( emp1980^(1-alpha-eta) *  (wage1980^(1-eta)) )
g Atfp81 =  ( emp1981^(1-alpha-eta) *  (wage1981^(1-eta)) )
g Atfp82 =  ( emp1982^(1-alpha-eta) *  (wage1982^(1-eta)) )
g Atfp83 =  ( emp1983^(1-alpha-eta) *  (wage1983^(1-eta)) )
g Atfp84 =  ( emp1984^(1-alpha-eta) *  (wage1984^(1-eta)) )
g Atfp85 =  ( emp1985^(1-alpha-eta) *  (wage1985^(1-eta)) )
g Atfp86 =  ( emp1986^(1-alpha-eta) *  (wage1986^(1-eta)) )
g Atfp87 =  ( emp1987^(1-alpha-eta) *  (wage1987^(1-eta)) )
g Atfp88 =  ( emp1988^(1-alpha-eta) *  (wage1988^(1-eta)) )
g Atfp89 =  ( emp1989^(1-alpha-eta) *  (wage1989^(1-eta)) )
g Atfp90 =  ( emp1990^(1-alpha-eta) *  (wage1990^(1-eta)) )
g Atfp91 =  ( emp1991^(1-alpha-eta) *  (wage1991^(1-eta)) )
g Atfp92 =  ( emp1992^(1-alpha-eta) *  (wage1992^(1-eta)) )
g Atfp93 =  ( emp1993^(1-alpha-eta) *  (wage1993^(1-eta)) )
g Atfp94 =  ( emp1994^(1-alpha-eta) *  (wage1994^(1-eta)) )
g Atfp95 =  ( emp1995^(1-alpha-eta) *  (wage1995^(1-eta)) )
g Atfp96 =  ( emp1996^(1-alpha-eta) *  (wage1996^(1-eta)) )
g Atfp97 =  ( emp1997^(1-alpha-eta) *  (wage1997^(1-eta)) )
g Atfp98 =  ( emp1998^(1-alpha-eta) *  (wage1998^(1-eta)) )
g Atfp99 =  ( emp1999^(1-alpha-eta) *  (wage1999^(1-eta)) )
g Atfp00 =  ( emp2000^(1-alpha-eta) *  (wage2000^(1-eta)) )
g Atfp01 =  ( emp2001^(1-alpha-eta) *  (wage2001^(1-eta)) )
g Atfp02 =  ( emp2002^(1-alpha-eta) *  (wage2002^(1-eta)) )
g Atfp03 =  ( emp2003^(1-alpha-eta) *  (wage2003^(1-eta)) )
g Atfp04 =  ( emp2004^(1-alpha-eta) *  (wage2004^(1-eta)) )
g Atfp05 =  ( emp2005^(1-alpha-eta) *  (wage2005^(1-eta)) )
g Atfp06 =  ( emp2006^(1-alpha-eta) *  (wage2006^(1-eta)) )
g Atfp07 =  ( emp2007^(1-alpha-eta) *  (wage2007^(1-eta)) )

g tfp64 =  log(Atfp64)
g tfp09 =  log(Atfp09)



***********************************************
****************************************
* Amenities  
* Follows Albouy (2012)
* Note: relative amenities are identified, but the absolute 
*       levels are not identified because we don't observe V_bar
****************************************
***********************************************
egen ww64 = mean(wage1964)
egen pp64 = mean(HP64)
egen ww09 = mean(wage2009)
egen pp09 = mean(HP09)

* Option 1: housing weighst are the same in both years 
g Q64 = (.33 * ( (HP64 - pp64)/pp64 )) - (.51 * ( (wage1964 - ww64)/ww64 ))
g Q09 = (.33 * ( (HP09 - pp09)/pp09 )) - (.51 * ( (wage2009 - ww09)/ww09 ))

* Option 2: housing weight in 1964 are lower 
*g Q64 = (.15 * ( (HP64 - pp64)/pp64 )) - (.51 * ( (wage1964 - ww64)/ww64 ))


* NOTE: Amenities are not identified in levels, but only as deviaions from mean
* This is because we don't observe utility
* Albouy's definition is a percetage deviation from average consumption
* As such, it has mean 0 by construction. 
* And of course it is negative for some cities. 
* We can't have negative amenities, as we take logs. 
* Here, I rescale it unsing a constant, equal to avearge wages in 2009
* Thus, amenties are to be interpreted as devision from a mean that is the same 
* in 1964 and 2009
g QQ64 = ww09*(1+Q64) 
g QQ09 = ww09*(1+Q09) 
g logQQ09 = log(QQ09)


* With prefernces for location, the formula for amenities has an added term
egen ee09 = mean(emp2009)
egen ee64 = mean(emp1964)
g B64 = (.33 * ( (HP64 - pp64)/pp64 )) - (.51 * ( (wage1964-ww64)/ww64 )) + ( inv_theta*((emp1964-ee64)/ee64) )
g B09 = (.33 * ( (HP09 - pp09)/pp09 )) - (.51 * ( (wage2009-ww09)/ww09 )) + ( inv_theta*((emp2009-ee09)/ee09) )
g BB64 = ww09*(1+B64)
g BB09 = ww09*(1+B09)
drop ww* ee* 


***********************************************
****************************************
* Price of Utility
****************************************
***********************************************
* P
g P64 = wage1964 
g P09 = wage2009 

* employment shares
egen tot64 = sum(emp1964)
egen tot09 = sum(emp2009)
g e1964 = (emp1964 / tot64)
g e2009 = (emp2009 / tot09)

* Pbar
g tmp64 =  e1964*wage1964 
egen Pbar64 = sum(tmp64)
replace Pbar64 = . if tmp64 ==.

g tmp09 =  e2009*wage2009 
egen Pbar09 = sum(tmp09)
replace Pbar09 = . if tmp09 ==.
drop tmp* tot*

* check: it should be the case that the weighted average of P is Pbar
*summ P64 Pbar64 [weight = e1964]
*summ P09 Pbar09 [weight = e2009]

* P / Pbar
g P_Pbar64 = P64 /Pbar64
g P_Pbar09 = P09 /Pbar09





***********************************************
****************************************
* employment shares
****************************************
***********************************************

egen tot64 = sum(emp1964)
g share1964 = emp1964 / tot64
egen tot09 = sum(emp2009)
g share2009 = emp2009 / tot09



*********************************************************************
*********************************************************************
*********************************************************************
* PART A 
* DESCRIPTIVE EVIDENCE
*********************************************************************
*********************************************************************
**********************************************************************


***********************************************
****************************************
* WAGES
****************************************
***********************************************

* TABLE 
****************************
tabstat logwage64 [weight = emp1964], stat(mean sd iqr range)
tabstat logwage09 [weight = emp2009], stat(mean sd iqr range)

* CENSUS DIVISION
egen tmp = mean(logwage64), by(division)
g y64  = logwage64 - tmp
drop tmp
egen tmp = mean(logwage09), by(division)
g y09  = logwage09 - tmp
drop tmp

tabstat y64 [weight = emp1964], stat(mean sd iqr range)
tabstat y09 [weight = emp2009], stat(mean sd iqr range)
drop y64 y09

* SIZE
xtile pct = emp1964, nquantiles(20)
egen tmp = mean(logwage64), by(pct)
g y64  = logwage64 - tmp
drop tmp
egen tmp = mean(logwage09), by(pct)
g y09  = logwage09 - tmp
drop tmp

tabstat y64 [weight = emp1964], stat(mean sd iqr range)
tabstat y09 [weight = emp2009], stat(mean sd iqr range)
drop y64 y09

* DROPPING Brain hubs
tabstat logwage64 [weight = emp1964] if brain==0, stat(mean sd iqr range)
tabstat logwage09 [weight = emp2009] if brain==0, stat(mean sd iqr range)


* FIGURE 
****************************
* First, I de-mean
egen tmp = mean(logwage64)
g y64 = logwage64 - tmp
drop tmp

egen tmp = mean(logwage09)
g y09 = logwage09 - tmp
drop tmp

* Unweighted
kdensity y64, legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.03) addplot(kdensity y09,  lpattern(--) bwidth(0.03)) title(" ") ytitle(" ") xtitle("Wage") xlabel(-.5 0 .5) note(" ") caption(" ") legend(label(1 "1964") label(2 "2009") position(2) ring(0)) saving(fig1, replace)
graph export fig1.eps, replace logo(off)
!ps2pdf fig1.eps
drop y64 y09

* Weighted
* Needs weights that are integer for graphs
g ww64 = round(emp1964)
g ww09 = round(emp2009)


* I need weighted averages in 64 and 09
* egen does not allow for weights, so I do it brute force
save tmp, replace
collapse t64 = logwage64 [weight = ww64]
save tmp64, replace
clear
u tmp
collapse t09 = logwage09 [weight = ww09]
save tmp09, replace
clear
u tmp
merge using tmp64
drop _merge
merge using tmp09
drop _merge
egen tmp64 = max(t64)
egen tmp09 = max(t09)
drop t09 t64

g y09 = logwage09 - tmp09
drop tmp09

g y64 = logwage64 - tmp64 
drop tmp64

kdensity y64 [weight = ww64], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white)  bwidth(0.03) addplot(kdensity y09 [weight = ww09],  lpattern(--) bwidth(0.03)) title(" ") ytitle(" ") xtitle("Wage") xlabel(-.5 0 .5) xscale(r(-.6 .6)) ylabel(0 1 2 3 4 5)  note(" ") caption(" ") legend(label(1 "1964")   label(2 "2009")  position(2) ring(0)  ) saving(fig2, replace)
graph export fig2.eps, replace logo(off)
!ps2pdf fig2.eps




* MEANS
***********************
summ y64 [weight = emp1964] if brain ==1
summ y09 [weight = emp2009] if brain ==1

summ y64 [weight = emp1964] if south ==1
summ y09 [weight = emp2009] if south ==1

summ y64 [weight = emp1964] if rust ==1
summ y09 [weight = emp2009] if rust ==1

summ y64 [weight = emp1964] if other ==1
summ y09 [weight = emp2009] if other ==1

egen hh = rank(y64)
g top64 = 1 if hh >=200
drop hh
egen hh = rank(y09)
g top09 = 1 if hh >=200
summ y64 [weight = emp1964] if top64 ==1
summ y09 [weight = emp2009] if top09 ==1
drop hh top*


* LIST
**************************
sort y64
g n = _n
list name y64 y09 if  n >=200
*outsheet name y64 y09  if  n >=200 using tables/list_wages.csv, replace comma

drop n y64 y09
rm tmp.dta
rm tmp09.dta
rm tmp64.dta




******************************************
***************************
* RENTS
****************************
******************************************
g logHP64 = log(HP64)
g logHP09 = log(HP09)
g HP = log(HP64)
egen tmp = mean(HP)
g y64 = HP - tmp
drop tmp HP
g HP = log(HP09)
egen tmp = mean(HP)
g y09 = HP-tmp
drop HP

summ y64 [weight = emp1964] 
summ y09 [weight = emp2009] 

kdensity y64 [weight = ww64], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.04)  addplot(kdensity y09 [weight = ww09],  lpattern(--) ) title(" ") ytitle(" ") xtitle("Housing Costs") note(" ") caption(" ") legend(label(1 "1964") label(2 "2009")  position(2) ring(0)  ) saving(fig59, replace)
graph export fig59.eps, replace logo(off)
!ps2pdfwr fig59.eps fig59.pdf


* MEANS
***********************
summ y64 [weight = emp1964] if brain ==1
summ y09 [weight = emp2009] if brain ==1

summ y64 [weight = emp1964] if south ==1
summ y09 [weight = emp2009] if south ==1

summ y64 [weight = emp1964] if rust ==1
summ y09 [weight = emp2009] if rust ==1

summ y64 [weight = emp1964] if other ==1
summ y09 [weight = emp2009] if other ==1

egen hh = rank(y64)
g top64 = 1 if hh >=200
drop hh
egen hh = rank(y09)
g top09 = 1 if hh >=200
summ y64 [weight = emp1964] if top64 ==1
summ y09 [weight = emp2009] if top09 ==1
drop top* hh

* LIST
**************************
sort y64
g n = _n
list name y64 y09 if  n >=200
*list name y64 y09 emp1964 emp2009 if y64 >.15 & y64 <.25
drop n tmp y64 y09


******************************************
***************************
* EMPLOYMENT
****************************
******************************************
g emp=log(emp1964)
egen tmp = mean(emp) 
g y64 = emp - tmp
drop tmp emp
g emp = log(emp2009)
egen tmp = mean(emp)
g y09 = emp - tmp
drop emp 

kdensity y64 , legend(region(lwidth(none)))  graphregion(color(white)) bgcolor(white) addplot(kdensity y09 ,  lpattern(--) ) title(" ") ytitle(" ") xtitle("Employment") note(" ") caption(" ") legend(label(1 "1964") label(2 "2009")  position(2) ring(0)  ) saving(fig69, replace)
graph export fig69.eps, replace logo(off)
!ps2pdf fig69.eps


* MEANS
***********************
summ y64 if brain ==1
summ y09 if brain ==1
summ y64 if south ==1
summ y09 if south ==1
summ y64 if rust ==1
summ y09 if rust ==1
summ y64 if other ==1
summ y09 if other ==1


* Weighted
summ y64 [weight = emp1964] if brain ==1
summ y09 [weight = emp2009] if brain ==1
summ y64 [weight = emp1964] if south ==1
summ y09 [weight = emp2009] if south ==1
summ y64 [weight = emp1964] if rust ==1
summ y09 [weight = emp2009] if rust ==1
summ y64 [weight = emp1964] if other ==1
summ y09 [weight = emp2009] if other ==1



* LIST
**************************
sort y64
g n = _n
list name y64 y09 if  n >=200
list name y64  y09 if  n <=20
drop n

sort y09
g n = _n
list name y09 if  n >=200
list name y09  if  n <=20
drop n

g D= (emp2009-emp1964)/emp1964
summ D 
summ D if south ==1
sort D
g n = _n
*list name D emp1964 
drop n tmp y64 y09 D



****************************************
**********************************
* AMENITIES
* PEREFECT MOBILITY
**********************************
*****************************************
g QQ = log(QQ64)
egen tmp = mean(QQ)
g y64 = QQ - tmp
drop tmp QQ
g QQ = log(QQ09)
egen tmp = mean(QQ)
g y09 = QQ-tmp
drop QQ

summ y64 [weight = emp1964] 
summ y09 [weight = emp2009] 

kdensity y64 [weight = ww64], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.04) addplot(kdensity y09 [weight = ww09],  lpattern(--) ) title(" ") ytitle(" ") xtitle("Amenities") note(" ") caption(" ") legend(label(1 "1964") label(2 "2009")  position(2) ring(0)  ) saving(fig79, replace)
graph export fig79.eps, replace logo(off)
!ps2pdf fig79.eps


* MEANS
***********************
summ y64 [weight = emp1964] if brain ==1
summ y09 [weight = emp2009] if brain ==1

summ y64 [weight = emp1964] if south ==1
summ y09 [weight = emp2009] if south ==1

summ y64 [weight = emp1964] if rust ==1
summ y09 [weight = emp2009] if rust ==1

summ y64 [weight = emp1964] if other ==1
summ y09 [weight = emp2009] if other ==1

egen hh = rank(y64)
g top64 = 1 if hh >=200
drop hh
egen hh = rank(y09)
g top09 = 1 if hh >=200
summ y64 [weight = emp1964] if top64 ==1
summ y09 [weight = emp2009] if top09 ==1
drop hh top*

* LIST
**************************
sort y64
g n = _n
list name y64 y09 if  n >=200
list name y64 y09  if  n <=20
drop n
sort y09
g n = _n
list name y09 if  n >=200
list name y09  if  n <=20

drop n y64 y09 tmp


****************************************
**********************************
* AMENITIES
* IMPEREFECT MOBILITY
*
* WITH IMPERFECT MOBILITY, AMENITIES 
* DEPEND ON CITY SIZE
**********************************
*****************************************
g BB = log(BB64)
summ BB [weight = emp1964]
egen tmp = mean(BB) 
g y64 = BB - tmp
drop tmp BB 
g BB = log(BB09)
summ BB [weight = emp2009]
egen tmp = mean(BB)  
g y09 = BB-tmp
drop BB 

summ y64 [weight = emp1964]
summ y09 [weight = emp2009]

drop y64 y09 tmp


****************************************
**********************************
* TFP
**********************************
*****************************************
g AT = log(AT64)
egen tmp = mean(AT)
g y64 = (AT) - tmp
drop tmp AT
g AT = log(AT09)
egen tmp = mean(AT)
g y09 = AT-tmp
drop AT

kdensity y64 [weight = ww64], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.5) addplot(kdensity y09 [weight = ww09],  lpattern(--) ) title(" ") ytitle(" ") xtitle("TFP") note(" ") caption(" ") legend(label(1 "1964") label(2 "2009")  position(2) ring(0)  ) saving(fig89, replace)
graph export fig89.eps, replace logo(off)
!ps2pdf fig89.eps


* MEANS
***********************
summ y64 [weight = emp1964] if brain ==1
summ y09 [weight = emp2009] if brain ==1

summ y64 [weight = emp1964] if south ==1
summ y09 [weight = emp2009] if south ==1

summ y64 [weight = emp1964] if rust ==1
summ y09 [weight = emp2009] if rust ==1

summ y64 [weight = emp1964] if other ==1
summ y09 [weight = emp2009] if other ==1

egen hh = rank(y64)
g top64 = 1 if hh >=200
drop hh
egen hh = rank(y09)
g top09 = 1 if hh >=200
summ y64 [weight = emp1964] if top64 ==1
summ y09 [weight = emp2009] if top09 ==1
drop hh top*

* LIST
**************************
sort y64
g n = _n
list name y64 if  n >=200
list name y64  if  n <=20
drop n

sort y09
g n = _n
list name y09 if  n >=200
list name y09  if  n <=20

drop n y64 y09 tmp


*********************************************************************
*********************************************************************
*********************************************************************
* PART B: 
* COUNTERFACTUALS 
*********************************************************************
*********************************************************************
**********************************************************************

*************************************************
*************************************************
*************************************************
* XX First counterfactual:
* I set 2009 wages = to 1964 wages
*************************************************
*************************************************
*************************************************

*******************
* Identify the city involved in the counterfactual
******************

* OPTION 0: all cities
g        XX = 1

* OPTION 1: Brain Hubs
g        XX = 0
replace  XX = 1 if  brain ==1


* OPTION 2: Rust Belt
g        XX = 0
replace  XX = 1 if rust ==1


*  OPTION 3: South
g        XX = 0
replace  XX = 1 if  south ==1

*  OPTION 4: Others
g        XX = 0
replace  XX = 1 if  other ==1

* Average wage in 64 and 09 (weighted by employment)
summarize wage1964 [weight = emp1964], detail
g jj = r(mean)
summarize wage2009 [weight = emp2009], detail
g zz = r(mean)


* Set counterfactual: 2009 relative wage is set equal to 64 relative wage (relative to weighted average)
g r64 = wage1964/jj
g       x   = wage2009
replace x   = Pbar09 * P_Pbar64 if XX ==1
drop x



*************************************************
***********************************************
***********************************************
* XX Second counterfactual : Amenities
*
***********************************************
***********************************************
*************************************************

* OPTION 0: All cities
g XX = 1

* OPTION 1: Brain Hubs
*g        XX = 0
*replace  XX = 1 if  brain ==1


* OPTION 2: Rust Belt
*g        XX = 0
*replace  XX = 1 if rust ==1


*  OPTION 3: South
*g        XX = 0
*replace  XX = 1 if  south ==1

*  OPTION 4: Others
*g        XX = 0
*replace  XX = 1 if  other ==1


*******************************************************
* Counterfactual wage 
* This is the counterfactual wage that would exist in 2009 if amenities weere at their 1964 level
* NOTE: there is a problem of scale, because QQ is off by a constant
*       estimates are sensitive to the scale of QQ (they are noot sensitive to the scale of x)
*******************************************************
g c1 = ( beta*inver + inv_theta)     / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
g c2 = ( 1-alpha -eta)               / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
summ c1 c2

* Insert the following lines in the case of preferences for location
replace QQ09 = BB09
replace QQ64 = BB64

g  double      x = wage2009 * ( (QQ09/QQ64) )^(c2)        if XX ==1
replace        x = wage2009                               if XX ==0










*************************************************
***********************************************
***********************************************
* XX Third counterfactual : Housing prices
*
***********************************************
***********************************************
*************************************************

* OPTION 0: All cities
*g XX = 1


* OPTION 1: Brain Hubs
*g        XX = 0
*replace  XX = 1 if  brain ==1


* OPTION 2: Rust Belt
*g        XX = 0
*replace  XX = 1 if rust ==1


*  OPTION 3: South
*g        XX = 0
*replace  XX = 1 if  south ==1

*  OPTION 4: Others
*g        XX = 0
*replace  XX = 1 if  other ==1



*******************************************************
* Counterfactual wage
*******************************************************
* This is the first counterfactual, holding housing prices and amenities fixed
g       x1   = wage2009
replace x1   = Pbar09 * P_Pbar64 if XX ==1

* This is second cpountercatual, holding amenities fixed
* I am replicating it here from above
g c2 = ( 1-alpha -eta)               / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
g  double      x2 = wage2009 * ( (QQ09/QQ64) )^(c2)        if XX ==1
replace        x2 = wage2009                               if XX ==0

*This is the third one , which is equal to the first one net of the second one: it is equal to 
* counterfactual wages in the first one, but allowing for amenties to be equal to their observed levels
g       x   = wage2009
replace x   = x1 *( (QQ64/QQ09) )^(c2)          if XX ==1







*************************************************
***********************************************
***********************************************
* Fourth counterfactual : Change housing supply elasticity
*
***********************************************
***********************************************
*************************************************

* First define the counterfactual

* CASE 1:  I assign brain hubs  the level of regulations  of the median city keeping the available land equal to actual available land
* include the line below and comment out the next lines below 
drop XX
g  XX = 1 if brain ==1

* CASE 2, 3 and 4: I assign Southern cities,Rust Belt or Other Cities  the level of regulations  of the brain hubs keeping the available land equal to actual available land
* include the line below and comment out the line above
* g  XX = 2 if south ==1
*g  XX = 3 if rust ==1
*g  XX = 4 if other ==1



* Insert the following lines in the case of preferences for location
replace QQ09 = BB09
replace QQ64 = BB64


* These are the wage parameters
* c1 is the parameter on log tfp and c2 is the parameter on log amenities
g c1 = ( beta*inver + inv_theta)     / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
g c2 = ( 1-alpha -eta)  / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)

* Fillin missing values for saiz variables
egen g1 = mean(unav), by(state)
egen g2 = mean(pop),  by(state)
egen g3 = mean(WR),   by(state)
replace unav = g1 if unav ==.
replace pop  = g2 if pop==.
replace WR   = g3 if WR ==.

* Are brain hubs more constrained? Are they more constrained by regulations?
summ inver, detail
summ inver if brain ==1
list name inver if brain ==1
sum inver if south ==1
sum inver if other ==1

sort inver
g n = _n
summ n, detail
summ n if brain ==1
sum n if south ==1
sum n if other ==1

drop n

summ WR, detail
summ WR if brain ==1
summ WR if south ==1
list name WR if brain ==1


* First I check that I can reproduce saiz's ealsticities using his parameters 
* I use parameters in Saiz table 5, column 2
g tmp =  -5.260*unav + .475*(log(popul)*unav) + .280*WR
summ tmp inver if tmp ~=.
corr inver tmp if tmp ~=.

* I can reprodduce Saiz elasticity with high precision (corr is .95), but for some reason I am off by a constant
* d3 measures how much I am off by relative to saiz (it is a constant)
egen d1 = mean(tmp)
egen d2 = mean(inverse)
g d3 = d2 - d1  
drop tmp

* CASE 1:  I assign the relevant group the level of regulations  of the median city keeping the available land equal to actual available land
* I add d3, to account for the fact that I am off by a constat
* WRI index is defined so that it is large for cities with more regulations, and small for cities  wiith less regulation
egen mean_WRI = pctile(WR), p(50)
g        new_inver = inver
replace  new_inver =  d3 -5.260*unav + .475*(log(popul)*unav) + .280*((mean_WR)) if XX ==1

* CASE 2: I assign Southern cities  the level of regulations  of the brain hubs keeping the available land equal to actual available land
g tmp = WR if brain ==1
egen brain_WR = mean(tmp)
summ brain_WR 
replace  new_inver =  d3 -5.260*unav + .475*(log(popul)*unav) + .280*((brain_WR)) if XX ==2
replace  new_inver =  d3 -5.260*unav + .475*(log(popul)*unav) + .280*((brain_WR)) if XX ==3
replace  new_inver =  d3 -5.260*unav + .475*(log(popul)*unav) + .280*((brain_WR)) if XX ==4
drop tmp



* Counterfactual wage parameters
* h1 is the parameter on log tfp and h2 is the parameter on log amenities
*********************************
g h1 = ( beta*new_inv + inv_theta) / ( beta*new_inv + 1-alpha -eta - beta*new_inv*eta +inv_theta - eta*inv_theta)
g h2 = ( 1-alpha -eta)  / ( beta*new_inv + 1-alpha -eta - beta*new_inv*eta +inv_theta - eta*inv_theta)

* diff1 and diff2 is the diffeerence between counterfactual and actual wage parameters
g diff1 = (h1 - c1)    
g diff2 = (h2 - c2) 

* Counterfactual wage 
************************
* Note: one problem with the equation below is that the level of QQ is not identified
*       another problem is that the level of TFP depends on the interest rate

g logx = logwage09 + diff1*log(Atfp09) - diff2*logQQ09
g x = exp(logx)

summ logwage09 logx if brain ==0
summ logwage09 logx if brain ==1
list name logwage09 logx if brain ==1

summ logwage09 logx if south ==0
summ logwage09 logx if south ==1


drop diff* h1 h2 new_* 




*********************************************************************
*********************************************************************
*********************************************************************
* COUNTERFACTUAL OUTPUT AND WELFARE
* 
* Note: relative gdp is fine, but the level of gdp is off by a constant. This constant is 
* different in 64 and 09 (it is a function of L)
*********************************************************************
*********************************************************************
*********************************************************************

********************
* Actual GDP 
********************
g double h09a = AT09 * ( (Pbar09/P09)^((1-eta)/(1-alpha-eta))  )
egen double hh09a = sum(h09a)
g double y09 = (eta/rate)^(eta/(1-eta))*(  hh09a^((1-alpha-eta)/(1-eta))  )  / 1000000


* XXXXXXXXXXX
*g kk = 1.1
*g double AT09kk = ( (alpha^(1-eta))*(eta^eta) / (rate^eta) ) * emp2009*(wage2009*kk)^( (1-eta)/(1-alpha-eta) )
*g double h09akk = AT09kk * ( (Pbar09/P09)^((1-eta)/(1-alpha-eta))  )
*egen double hh09akk = sum(h09akk)
*g double y09kk = (eta/rate)^(eta/(1-eta))*(  hh09akk^((1-alpha-eta)/(1-eta))  )  / 1000000
*drop h09akk hh09akk 



*********************
* Counterfactual employment 
*********************
* Provisional counterfactual employment (from FOC)
g double emp09c =  ( ( ( alpha^(1-eta)*(eta^eta)/(rate^eta) )/(x^(1-eta)) )^(1/(1-alpha-eta)) )*AT09

* As expected, employment in treated cities is larger than actual 
g DDx = emp09c - emp2009
summ DDx if XX ==1
summ DDx if XX ~=1


*********************************
* Add up constraint
* The sum of workers is not = to total number of workers available in the economy (D is not equal to S)
********************************
egen  sumDDx = sum(DDx)
* This is the sum of all workers 
egen sum = sum(emp09c) 
* This is by how much I need to rescale eac city size for the add up constraint to hold
g h = sumDDx /sum

* I  change employment in all cities proportionally 
g       new_emp09c = (1-h) * emp09c  

* I check that new_emp09c has the same mean as actual employment emp09
* This means that D = S
summ new_emp09c emp2009
drop h sum sumDDx emp09c


* Counterfactual total employment  
egen double tot09c = sum(new_emp09c)

* Counterfactual employment share
g e2009c = (new_emp09c / tot09c )

*********************
* Counterfactual Pbar  
*********************
g tmp =  e2009c*x
egen Pbar64c = sum(tmp)
replace Pbar64c = . if tmp ==.
drop tmp


*********************
* Counterfactual GDP 
*********************
* I need to divide by 1000000 because the number is too big and stata crashes
g double h09 = AT09 * ( (Pbar64c/x)^((1-eta)/(1-alpha-eta))  )
egen double hh09 = sum(h09)
g double yy09 = (eta/rate)^(eta/(1-eta))*(  hh09^((1-alpha-eta)/(1-eta))  )  / 1000000


* XXXXXXXXXXX
*g double h09kk = AT09kk * ( (Pbar64c/x)^((1-eta)/(1-alpha-eta))  )
*egen double hh09kk = sum(h09kk)
*g double yy09kk = (eta/rate)^(eta/(1-eta))*(  hh09kk^((1-alpha-eta)/(1-eta))  )  / 1000000

g growth = (wage09_unconditional - wage64_unconditional)/wage64_unconditional
g growth2 = .
*summarize growth [w=emp2009]
*summarize growth 
replace growth2 = r(mean)
*summ growth*
*g y64 = y09 / (1+growth2)
* drop y64



*** XXXXXXXXXXXXX
g double h64a = AT64 * ( (Pbar64/P64)^((1-eta)/(1-alpha-eta))  )
egen double hh64a = sum(h64a)
g double y64 = (eta/rate)^(eta/(1-eta))*(  hh64a^((1-alpha-eta)/(1-eta))  )  / 1000000
drop h64a hh64
summ yy09 y64 y09





* Now I can compute the percent difference between actual and counterfactual growth
* [(yy09 - y64)/y64] / [(y09 - y64)/y64] = (yy09 - y64) / (y09 - y64)
g diff09 = ( (yy09 - y64) / (y09 - y64) ) - 1
summ diff09


*********************
* Welfare
* V = y/Pbar
* where Pbar is the price of utility
*
* The same issue arises: the level of Pbar is not identified because the level of amenities is not identified
* (In addition the level of conditional wages is not identified.)
* Just like before, I need to make an assumption to scale it. 
*********************
save tmp, replace

* I first divide by 100000 to be consistent with the scale of output  (recall that output had to be divided by 1000000
replace Pbar09  = Pbar09  / 1000000
replace Pbar64c = Pbar64c / 1000000
replace Pbar64  = Pbar64  / 1000000
summ Pbar*


g diff09_welf_adj=( (yy09/(Pbar64c) ) - (y64/(Pbar64) ) ) /  ( (y09/(Pbar09) ) - (y64/(Pbar64) ) ) -1
summ diff09_welf_adj
drop diff09_wel*


* Robustness analysis: Different scaling for price of utility
g kk = 1.01
g diff09_welf_adj=( (yy09/(Pbar64c*kk) ) - (y64/(Pbar64) ) ) /  ( (y09/(Pbar09*kk) ) - (y64/(Pbar64) ) ) -1
summ diff09_welf_adj
drop kk diff09_wel*



* Robustness analysis: Different scaling for price of utility
* This one shifts yy and y as well
*g diff09_welf_adj=( (yy09kk/(Pbar64c*kk) ) - (y64/(Pbar64) ) ) /  ( (y09kk/(Pbar09*kk) ) - (y64/(Pbar64) ) ) -1
*summ diff09_welf_adj
*drop kk diff09_wel*

clear
u tmp
rm tmp.dta


*/






/*
*****************************************
*************************************
* What fraction of workers change city
*************************************
*****************************************
* absolute number of workers who move under the counterfactual
g DD = ( new_emp09c   - emp2009)
g DDD = abs(DD)
egen DDDD = sum(DDD)
* avoid double counting
g movers = 100*(DDDD /  tot09) /(2*35)
summ movers


*************************************
* TABLE: cities that gain emploiment and cities that lose employment
*************************************
g ratio =  100* ( (new_emp09c - emp1964)/(emp2009 - emp1964) - 1) 
g tmp = - ratio
sort tmp
g n = _n
list name ratio if  n <=10
list name ratio  if  n ==110
list name ratio if  n >=210
outsheet name ratio  if  n <=10 using tables/list_employment_changes_top.csv, replace comma
outsheet name ratio  if  n >210 using tables/list_employment_changes_bottom.csv, replace comma
drop ratio n  h09*  hh* tmp* y09 yy09 diff09 y64
*/


*************************************
*************************************
*************************************
*************************************
* PART C
* Effect of Shutting down TFP growth
*************************************
*************************************
*************************************
*************************************
/*
save tmp, replace

* levels of TFP are not identified. Here it matters. Fitrst, I scale TFP so
* that aggregate TFP growth is consistent with unconditional wage growth
egen double bb09 = mean(AT09)
egen double bb64 = mean(AT64)
g bb      = .795*35
replace  AT09 = AT09*bb*( bb64 / bb09 )

********************
* Actual GDP
********************
g double h09a = AT09 * ( (Pbar09/P09)^((1-eta)/(1-alpha-eta))  )
egen double hh09a = sum(h09a)
g double y09 = (eta/rate)^(eta/(1-eta))*(  hh09a^((1-alpha-eta)/(1-eta))  )  / 1000000
drop hh* h09*

g double h64a = AT64 * ( (Pbar64/P64)^((1-eta)/(1-alpha-eta))  )
egen double hh64a = sum(h64a)
g double y64 = (eta/rate)^(eta/(1-eta))*(  hh64a^((1-alpha-eta)/(1-eta))  )  / 1000000


********************
* Counterfactual GDP
********************
g  double CC = AT09
*replace CC = AT64
*replace CC = AT64 if brain ==1
replace CC = AT64 if south ==1
*replace CC = AT64 if rust ==1
*replace CC = AT64 if other ==1

g double h09a = CC * ( (Pbar09/P09)^((1-eta)/(1-alpha-eta))  )
egen double hh09a = sum(h09a)
g double yy09 = (eta/rate)^(eta/(1-eta))*(  hh09a^((1-alpha-eta)/(1-eta))  )  / 1000000


* Now I can compute the percent difference between actual and counterfactual growth
* [(yy09 - y64)/y64] / [(y09 - y64)/y64] = (yy09 - y64) / (y09 - y64)
g diff09 = ( (yy09 - y64) / (y09 - y64) ) - 1
summ diff09


*********************
* Welfare
*********************

* Counterfactual employment
*********************
drop DDx new_emp09c tot09c e2009c Pbar64c
g double emp09c =  ( ( ( alpha^(1-eta)*(eta^eta)/(rate^eta) )/(wage2009^(1-eta)) )^(1/(1-alpha-eta)) )*CC
g DDx = emp09c - emp2009
* Add up constraint
* The sum of workers is not = to total number of workers available in the economy (D is not equal to S)
* This is the number of eccess workers
egen  sumDDx = sum(DDx)
* This is the sum of all workers
egen sum = sum(emp09c)
* This is by how much I need to rescale eac city size for the add up constraint to hold
g h = sumDDx /sum
* I  change employment in all cities proportionally
g       new_emp09c = (1-h) * emp09c
* I check that new_emp09c has the same mean as actual employment emp09
* This means that D = S
*summ new_emp09c emp2009
drop h sum sumDDx emp09c
* Counterfactual total employment
egen double tot09c = sum(new_emp09c)
* Counterfactual employment share
g e2009c = (new_emp09c / tot09c )
* Counterfactual Pbar
g tmp =  e2009c*wage2009
egen Pbar64c = sum(tmp)
replace Pbar64c = . if tmp ==.
drop tmp

*Normalize Pbar so that it's measued like income
replace Pbar09  = Pbar09  / 1000000
replace Pbar64c = Pbar64c / 1000000
replace Pbar64  = Pbar64  / 1000000
* Scale of Pbar is not identified. 
replace Pbar64 = Pbar09 


g kk =1
g diff09_welf_adj=( (yy09*Pbar64*Pbar09*kk) - (y64*Pbar64c*Pbar09*(kk^2)) ) / ( (y09*Pbar64*Pbar64c*kk) - (y64*Pbar64c*Pbar09*(kk^2)) ) -1
summ diff09_welf_adj
drop kk diff09_wel*

g kk =1.35
g diff09_welf_adj=( (yy09*Pbar64*Pbar09*kk) - (y64*Pbar64c*Pbar09*(kk^2)) ) / ( (y09*Pbar64*Pbar64c*kk) - (y64*Pbar64c*Pbar09*(kk^2)) ) -1
summ diff09_welf_adj
drop kk diff09_wel*
g kk =.7
g diff09_welf_adj=( (yy09*Pbar64*Pbar09*kk) - (y64*Pbar64c*Pbar09*(kk^2)) ) / ( (y09*Pbar64*Pbar64c*kk) - (y64*Pbar64c*Pbar09*(kk^2)) ) -1
summ diff09_welf_adj


clear
u tmp
rm tmp.dta
*/


*************************************
*************************************
*************************************
*************************************
* PART D
* Which cities contribute most to growth (naive vs model) 
* The formula for output dlogY/dt is in Equation 7 in file text67.doc
* The formula for welfare is dV/dt = dlogY/dt - dlogQbar/dt 
*
*
* Note: This part should be run using unconditional wages
*       (go back at the beginning to set it)
*************************************
*************************************
*************************************
*************************************
save tmp, replace


local i=66
while `i' <=73 {
g P`i' = wage19`i'
egen tot`i' = sum(emp19`i')
g e19`i' = (emp19`i' / tot`i')
g tmp`i' =  e19`i'*wage19`i'
egen Pbar`i' = sum(tmp`i')
replace Pbar`i' = . if tmp`i' ==.
g P_Pbar`i' = P`i' /Pbar`i'
g alpha`i' = 1 / (1 - e19`i')
g Gbar`i' =  log( (Pbar`i' - tmp`i') * alpha`i')
replace Gbar`i' = . if tmp`i' ==.
local i = `i'+1
}


local i=77
while `i' <=99 {
g P`i' = wage19`i' /* wages */
egen tot`i' = sum(emp19`i') /* total emp */
g e19`i' = (emp19`i' / tot`i') /* emp share */
g tmp`i' =  e19`i'*wage19`i' /*  weighted wage=earnings */
egen Pbar`i' = sum(tmp`i') /* total weighted earnings */
replace Pbar`i' = . if tmp`i' ==.
g P_Pbar`i' = P`i' /Pbar`i' /* earnings share */
g alpha`i' = 1 / (1 - e19`i') /*inverse employ share*/
g Gbar`i' =  log( (Pbar`i' - tmp`i') * alpha`i' )
replace Gbar`i' = . if tmp`i' ==.
local i = `i'+1
}


local i=0
while `i' <=7 {
g P0`i' = wage200`i' 
egen tot0`i' = sum(emp200`i')
g e200`i' = (emp200`i' / tot0`i')
g tmp0`i' =  e200`i'*wage200`i'
egen Pbar0`i' = sum(tmp0`i')
replace Pbar0`i' = . if tmp0`i' ==.
g P_Pbar0`i' = P0`i' /Pbar0`i'
g alpha`i' = 1 / (1 - e200`i')
g Gbar10`i' =  log( (Pbar0`i' - tmp0`i') * alpha`i')
replace Gbar10`i' = . if tmp0`i' ==.
local i = `i'+1
}
g Gbar64 = Gbar66
g Gbar109 = Gbar107



***********
local i=1966
while `i' <=1973 {
egen tot`i' = sum(emp`i')
g share`i' = emp`i' / tot`i' /* empl share */
local i = `i'+1
}

local i=1977
while `i' <=2007 {
egen tot`i' = sum(emp`i')
g share`i' = emp`i' / tot`i'
local i = `i'+1
}
drop tot* tmp*


* now share based on wage bill
egen tot64 = sum(ap1964)
g share_ap1964 = ap1964 / tot64  /*actual weighted avg earnings*/
egen tot09 = sum(ap2009)
g share_ap2009 = ap2009 / tot09

local i=1966
while `i' <=1973 {
egen tot`i' = sum(ap`i')
g share_ap`i' = ap`i' / tot`i'
local i = `i'+1
}

local i=1977
while `i' <=2007 {
egen tot`i' = sum(ap`i')
g share_ap`i' = ap`i' / tot`i'
local i = `i'+1
}


****************

* Model based /* TFP growth */
g ddd1 = log( Atfp66 ) - log( Atfp64)
g ddd2 = log( Atfp67 ) - log( Atfp66)
g ddd3 = log( Atfp68 ) - log( Atfp67)
g ddd4 = log( Atfp69 ) - log( Atfp68)
g ddd5 = log( Atfp70 ) - log( Atfp69)
g ddd6 = log( Atfp71 ) - log( Atfp70)
g ddd7 = log( Atfp72 ) - log( Atfp71)
g ddd8 = log( Atfp73 ) - log( Atfp72)
g ddd9 = log( Atfp77 ) - log( Atfp73)
g ddd10 = log( Atfp78 ) - log( Atfp77)
g ddd11 = log( Atfp79 ) - log( Atfp78)
g ddd12 = log( Atfp80 ) - log( Atfp79)
g ddd13 = log( Atfp81 ) - log( Atfp80)
g ddd14 = log( Atfp82 ) - log( Atfp81)
g ddd15 = log( Atfp83 ) - log( Atfp82)
g ddd16 = log( Atfp84 ) - log( Atfp83)
g ddd17 = log( Atfp85 ) - log( Atfp84)
g ddd18 = log( Atfp86 ) - log( Atfp85)
g ddd19 = log( Atfp87 ) - log( Atfp86)
g ddd20 = log( Atfp88 ) - log( Atfp87)
g ddd21 = log( Atfp89 ) - log( Atfp88)
g ddd22 = log( Atfp90 ) - log( Atfp89)
g ddd23 = log( Atfp91 ) - log( Atfp90)
g ddd24 = log( Atfp92 ) - log( Atfp91)
g ddd25 = log( Atfp93 ) - log( Atfp92)
g ddd26 = log( Atfp94 ) - log( Atfp93)
g ddd27 = log( Atfp95 ) - log( Atfp94)
g ddd28 = log( Atfp96 ) - log( Atfp95)
g ddd29 = log( Atfp97 ) - log( Atfp96)
g ddd30 = log( Atfp98 ) - log( Atfp97)
g ddd31 = log( Atfp99 ) - log( Atfp98)
g ddd32 = log( Atfp00 ) - log( Atfp99)
g ddd33 = log( Atfp01 ) - log( Atfp00)
g ddd34 = log( Atfp02 ) - log( Atfp01)
g ddd35 = log( Atfp03 ) - log( Atfp02)
g ddd36 = log( Atfp04 ) - log( Atfp03)
g ddd37 = log( Atfp05 ) - log( Atfp04)
g ddd38 = log( Atfp06 ) - log( Atfp05)
g ddd39 = log( Atfp07 ) - log( Atfp06)
g ddd40 = log( Atfp09 ) - log( Atfp07)

g hhh1 = log( P_Pbar66 ) - log( P_Pbar64)/* weighted earnings growth */
g hhh2 = log( P_Pbar67 ) - log( P_Pbar66)
g hhh3 = log( P_Pbar68 ) - log( P_Pbar67)
g hhh4 = log( P_Pbar69 ) - log( P_Pbar68)
g hhh5 = log( P_Pbar70 ) - log( P_Pbar69)
g hhh6 = log( P_Pbar71 ) - log( P_Pbar70)
g hhh7 = log( P_Pbar72 ) - log( P_Pbar71)
g hhh8 = log( P_Pbar73 ) - log( P_Pbar72)
g hhh9 = log( P_Pbar77 ) - log( P_Pbar73)
g hhh10 = log( P_Pbar78 ) - log( P_Pbar77)
g hhh11 = log( P_Pbar79 ) - log( P_Pbar78)
g hhh12 = log( P_Pbar80 ) - log( P_Pbar79)
g hhh13 = log( P_Pbar81 ) - log( P_Pbar80)
g hhh14 = log( P_Pbar82 ) - log( P_Pbar81)
g hhh15 = log( P_Pbar83 ) - log( P_Pbar82)
g hhh16 = log( P_Pbar84 ) - log( P_Pbar83)
g hhh17 = log( P_Pbar85 ) - log( P_Pbar84)
g hhh18 = log( P_Pbar86 ) - log( P_Pbar85)
g hhh19 = log( P_Pbar87 ) - log( P_Pbar86)
g hhh20 = log( P_Pbar88 ) - log( P_Pbar87)
g hhh21 = log( P_Pbar89 ) - log( P_Pbar88)
g hhh22 = log( P_Pbar90 ) - log( P_Pbar89)
g hhh23 = log( P_Pbar91 ) - log( P_Pbar90)
g hhh24 = log( P_Pbar92 ) - log( P_Pbar91)
g hhh25 = log( P_Pbar93 ) - log( P_Pbar92)
g hhh26 = log( P_Pbar94 ) - log( P_Pbar93)
g hhh27 = log( P_Pbar95 ) - log( P_Pbar94)
g hhh28 = log( P_Pbar96 ) - log( P_Pbar95)
g hhh29 = log( P_Pbar97 ) - log( P_Pbar96)
g hhh30 = log( P_Pbar98 ) - log( P_Pbar97)
g hhh31 = log( P_Pbar99 ) - log( P_Pbar98)
g hhh32 = log( P_Pbar00 ) - log( P_Pbar99)
g hhh33 = log( P_Pbar01 ) - log( P_Pbar00)
g hhh34 = log( P_Pbar02 ) - log( P_Pbar01)
g hhh35 = log( P_Pbar03 ) - log( P_Pbar02)
g hhh36 = log( P_Pbar04 ) - log( P_Pbar03)
g hhh37 = log( P_Pbar05 ) - log( P_Pbar04)
g hhh38 = log( P_Pbar06 ) - log( P_Pbar05)
g hhh39 = log( P_Pbar07 ) - log( P_Pbar06)
g hhh40 = log( P_Pbar09 ) - log( P_Pbar07)


g www1 = ( share1966 + share1964)/2 /*avg empl share*/
g www2 = ( share1967 + share1966)/2
g www3 = ( share1968 + share1967)/2
g www4 = ( share1969 + share1968)/2
g www5 = ( share1970 + share1969)/2
g www6 = ( share1971 + share1970)/2
g www7 = ( share1972 + share1971)/2
g www8 = ( share1973 + share1972)/2
g www9 = ( share1977 + share1973)/2
g www10 = ( share1978 + share1977)/2
g www11 = ( share1979 + share1978)/2
g www12 = ( share1980 + share1979)/2
g www13 = ( share1981 + share1980)/2
g www14 = ( share1982 + share1981)/2
g www15 = ( share1983 + share1982)/2
g www16 = ( share1984 + share1983)/2
g www17 = ( share1985 + share1984)/2
g www18 = ( share1986 + share1985)/2
g www19 = ( share1987 + share1986)/2
g www20 = ( share1988 + share1987)/2
g www21 = ( share1989 + share1988)/2
g www22 = ( share1990 + share1989)/2
g www23 = ( share1991 + share1990)/2
g www24 = ( share1992 + share1991)/2
g www25 = ( share1993 + share1992)/2
g www26 = ( share1994 + share1993)/2
g www27 = ( share1995 + share1994)/2
g www28 = ( share1996 + share1995)/2
g www29 = ( share1997 + share1996)/2
g www30 = ( share1998 + share1997)/2
g www31 = ( share1999 + share1998)/2
g www32 = ( share2000 + share1999)/2
g www33 = ( share2001 + share2000)/2
g www34 = ( share2002 + share2001)/2
g www35 = ( share2003 + share2002)/2
g www36 = ( share2004 + share2003)/2
g www37 = ( share2005 + share2004)/2
g www38 = ( share2006 + share2005)/2
g www39 = ( share2007 + share2006)/2
g www40 = ( share2009 + share2007)/2

g www_ap1 = ( share_ap1966 + share_ap1964)/2  /*avg earnings share*/
g www_ap2 = ( share_ap1967 + share_ap1966)/2
g www_ap3 = ( share_ap1968 + share_ap1967)/2
g www_ap4 = ( share_ap1969 + share_ap1968)/2
g www_ap5 = ( share_ap1970 + share_ap1969)/2
g www_ap6 = ( share_ap1971 + share_ap1970)/2
g www_ap7 = ( share_ap1972 + share_ap1971)/2
g www_ap8 = ( share_ap1973 + share_ap1972)/2
g www_ap9 = ( share_ap1977 + share_ap1973)/2
g www_ap10 = ( share_ap1978 + share_ap1977)/2
g www_ap11 = ( share_ap1979 + share_ap1978)/2
g www_ap12 = ( share_ap1980 + share_ap1979)/2
g www_ap13 = ( share_ap1981 + share_ap1980)/2
g www_ap14 = ( share_ap1982 + share_ap1981)/2
g www_ap15 = ( share_ap1983 + share_ap1982)/2
g www_ap16 = ( share_ap1984 + share_ap1983)/2
g www_ap17 = ( share_ap1985 + share_ap1984)/2
g www_ap18 = ( share_ap1986 + share_ap1985)/2
g www_ap19 = ( share_ap1987 + share_ap1986)/2
g www_ap20 = ( share_ap1988 + share_ap1987)/2
g www_ap21 = ( share_ap1989 + share_ap1988)/2
g www_ap22 = ( share_ap1990 + share_ap1989)/2
g www_ap23 = ( share_ap1991 + share_ap1990)/2
g www_ap24 = ( share_ap1992 + share_ap1991)/2
g www_ap25 = ( share_ap1993 + share_ap1992)/2
g www_ap26 = ( share_ap1994 + share_ap1993)/2
g www_ap27 = ( share_ap1995 + share_ap1994)/2
g www_ap28 = ( share_ap1996 + share_ap1995)/2
g www_ap29 = ( share_ap1997 + share_ap1996)/2
g www_ap30 = ( share_ap1998 + share_ap1997)/2
g www_ap31 = ( share_ap1999 + share_ap1998)/2
g www_ap32 = ( share_ap2000 + share_ap1999)/2
g www_ap33 = ( share_ap2001 + share_ap2000)/2
g www_ap34 = ( share_ap2002 + share_ap2001)/2
g www_ap35 = ( share_ap2003 + share_ap2002)/2
g www_ap36 = ( share_ap2004 + share_ap2003)/2
g www_ap37 = ( share_ap2005 + share_ap2004)/2
g www_ap38 = ( share_ap2006 + share_ap2005)/2
g www_ap39 = ( share_ap2007 + share_ap2006)/2
g www_ap40 = ( share_ap2009 + share_ap2007)/2


g qqq1  = Gbar66 - Gbar64
g qqq2  = Gbar67 - Gbar66
g qqq3  = Gbar68 - Gbar67
g qqq4  = Gbar69 - Gbar68
g qqq5  = Gbar70 - Gbar69
g qqq6  = Gbar71 - Gbar70
g qqq7  = Gbar72 - Gbar71
g qqq8  = Gbar73 - Gbar72
g qqq9  = Gbar77 - Gbar73
g qqq10  = Gbar78 - Gbar77
g qqq11  = Gbar79 - Gbar78
g qqq12  = Gbar80 - Gbar79
g qqq13  = Gbar81 - Gbar80
g qqq14  = Gbar82 - Gbar81
g qqq15  = Gbar83 - Gbar82
g qqq16  = Gbar84 - Gbar83
g qqq17  = Gbar85 - Gbar84
g qqq18  = Gbar86 - Gbar85
g qqq19  = Gbar87 - Gbar86
g qqq20  = Gbar88 - Gbar87
g qqq21  = Gbar89 - Gbar88
g qqq22  = Gbar90 - Gbar89
g qqq23  = Gbar91 - Gbar90
g qqq24  = Gbar92 - Gbar91
g qqq25  = Gbar93 - Gbar92
g qqq26  = Gbar94 - Gbar93
g qqq27  = Gbar95 - Gbar94
g qqq28  = Gbar96 - Gbar95
g qqq29  = Gbar97 - Gbar96
g qqq30  = Gbar98 - Gbar97
g qqq31  = Gbar99 - Gbar98
g qqq32  = Gbar100 - Gbar99
g qqq33  = Gbar101 - Gbar100
g qqq34  = Gbar102 - Gbar101
g qqq35  = Gbar103 - Gbar102
g qqq36  = Gbar104 - Gbar103
g qqq37  = Gbar105 - Gbar104
g qqq38  = Gbar106 - Gbar105
g qqq39  = Gbar107 - Gbar106
g qqq40  = Gbar109 - Gbar107

keep ddd* hhh* www* qqq*  emp2009 name msa brain rust south other alpha
reshape long ddd hhh www qqq www_ap , i(name) j(t)

* Welfare levels are not identified. Here I allow for differences in overall growth of welfare
* Include one of the two lines below to see what happens to welfare growth under different assumptions
* Note: when kk=0, it's  the baseline case
*g kk = 0.02
*g kk = -0.02
*replace qqq = qqq *(1+ kk)


* Data are now at the city-year level
* I have 220 cities and 40 years, so there are 8800 obs
* The two lines below give us the contribution of 
* each city to aggregate growth in each year
* More precisely, they give us the 
* change of aggregate output over time (d output / d t)
* for  each city and year
* The first one is based on the model, the second one is naive
* It is measured in percentage change. For example,
* the entry for SF in 1990 tell us 
* how different  US gdp growth between 1989 and 1990  
* would have been if SF had not existed that year
g growth_model = www*(ddd - hhh) /* employmentshare x (TFPgrowth - weighted nominalwagegrowth) */
g growth_naive = www_ap*(ddd - (alpha*hhh) ) /* residualearningsshare x (TFPgrowth - inverse empshare x weighted nominalwagegrowth) */
g welfare_model = growth_model - www*qqq /* employmentshare x (TFPgrowth - weighted nominalwagegrowth - ) */


* Now I sum the contribution of each city across all years
* So that I have the total contributiion of each city between
* 1964 and 2009
sort name brain rust south other
collapse emp2009 (sum) growth_model growth_naive welfare_model, by(name brain rust south other)

* Now I divide by overall growth in the US, so that
* I can measure the fraction of overall growth in the US
* that can be attributed to each city or group of 
* cities
egen tot_model = sum(growth_model)
egen tot_naive = sum(growth_naive)
egen tot_welfare = sum(welfare_model)
g ratio_model = growth_model / tot_model
g ratio_naive = growth_naive / tot_naive
g ratio_welfare = welfare_model / tot_welfare

egen fraction_model = sum(ratio_model) if brain ==1
egen fraction_naive = sum(ratio_naive) if brain ==1
egen fraction_welfare = sum(ratio_welfare) if brain ==1
summ fraction_*
drop fraction_*

egen fraction_model = sum(ratio_model) if south ==1
egen fraction_naive = sum(ratio_naive) if south ==1
egen fraction_welfare = sum(ratio_welfare) if south ==1
summ fraction_*
drop fraction_*

egen fraction_model = sum(ratio_model) if rust ==1
egen fraction_naive = sum(ratio_naive) if rust ==1
egen fraction_welfare = sum(ratio_welfare) if rust ==1
summ fraction_*
drop fraction_*

egen fraction_model = sum(ratio_model) if other ==1
egen fraction_naive = sum(ratio_naive) if other ==1
egen fraction_welfare = sum(ratio_welfare) if other ==1
summ fraction_*


keep if other ==1
sort ratio_naive
list name ratio_naive ratio_model

clear
u tmp
rm tmp.dta



*****************************************************************************************************************
*****************************************************************************************************************
*****************************************************************************************************************
* PART E:
* SUMMARY STATS AND
* DATA QUALITY CHECKS
*****************************************************************************************************************
*****************************************************************************************************************
*****************************************************************************************************************

****************************************
* SUMMARY STATS
****************************************
replace ap1964 = ap1964 / 1000000
replace ap2009 = ap2009 / 1000000
summ wage64_uncond HP64 emp1964 ap1964 hs64 coll64 female64   hisp64   nonwhite60   age60   union64
summ wage09_uncond HP09 emp2009 ap2009 hs09 coll09 female2009 hisp2009 nonwhite00 age2009   union09


****************************************
* DO OUR WAGES MATCH IPUMS WAGE IN 2009
* 
* Problem log average is not average log 
****************************************
* RESIDUALS
* Residual wage by MSA from individual level IPUMS data
summ msa
sort msa
merge msa using individual_wage_reg/census/data_residual
tab _merge
keep if _merge == 3 | _merge ==1
drop _merge
g log_residual_ipums  = 9.6 + (residual)

correlate logwage_condit09 log_residual_ipums [weight = emp2009]
regress   logwage_condit09 log_residual_ipums [weight = emp2009]
predict fit25b

* APPENDIX FIGURES: ESTIMATED WAGES VS TRUE WAGES
sort log_residual_ipums
graph7 logwage_condit09 fit25b log_residual_ipums  ,  title("  ") key1("   ")  key2("   ") l2title("Estimated Wage Residuals") l1title(" ") b2title("Wage Residuals") c(.l)  s(oi) xscale(9,10.4) yscale(8.9,10.9) xlabel(9,9.7,10.4) ylabel(9,9.7,10.4) saving(figure25b, replace)
graph export fig25b.eps, replace logo(off)
! ps2pdf fig25b.eps

* IS MEASUREMENT ERROR SYSTEMATIC?
*g me = logwage_condit09 - log_residual_ipums 
*reg me log_residual_ipums [weight = emp2009]
*reg me HP09               [weight = emp2009]
*reg me log_residual_ipums 
*reg me HP09               
*reg me emp2009




