****************************************************************
*This file preserves the same structure as in the Hsieh and Moretti replication code
*The only difference are the the change in years.
*Hsieh and Moretti give instructions on how to run each exercise in the code below. 
*Note: This code can't be run a singular time to derive all results.

use $data/Replication_new.dta, clear



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
replace  brain = 1  if   cbsa == 5602  | cbsa == 7362 

*  Rust Belt        
g        rust = 0
replace  rust = 1 if cbsa == 2162    | cbsa ==  7610    | cbsa ==    5280   | cbsa == 4800   | cbsa ==    9320   | cbsa ==    1320   | cbsa == 4040   | cbsa == 6960   | cbsa == 6840 | cbsa == 3680 | cbsa == 1642 | cbsa == 1280 | cbsa == 4320 | cbsa == 8680  | cbsa == 2360 | cbsa == 960 | cbsa == 2000   | cbsa ==    8400    | cbsa ==   870     | cbsa == 7040    |  cbsa ==  8160    | cbsa ==  3720    | cbsa == 8320 |  cbsa == 3000    | cbsa ==    9140     | cbsa == 3920    | cbsa ==    1692     | cbsa ==  2040   | cbsa ==   6280    | cbsa ==280    | cbsa ==   1602    | cbsa == 7800   | cbsa == 1280 | cbsa == 3620  | cbsa ==  6880  | cbsa ==  2760  | cbsa == 8160
g        south = 0
replace  south = 1 if  division == 5 | division ==6 | division ==7

* Other large cities
* These are 19 cities with employment above 600,000
g        other =0
replace  other =1 if emp2019 >= 600000 & brain ==0 & rust ==0 & south ==0



***********************************************
****************************************
* Wages Controlling for Demographics 
*****************************************
***********************************************
g wage_unconditional1986 = (wage1986)
g wage_unconditional1988 = (wage1988)    
g wage_unconditional1989 = (wage1989)    
g wage_unconditional1990 = (wage1990)    
g wage_unconditional1991 = (wage1991)    
g wage_unconditional1992 = (wage1992)    
g wage_unconditional1993 = (wage1993)    
g wage_unconditional1994 = (wage1994)    
g wage_unconditional1995 = (wage1995)    
g wage_unconditional1996 = (wage1996)    
g wage_unconditional1997 = (wage1997)    
g wage_unconditional1998 = (wage1998)    
g wage_unconditional1999 = (wage1999)    
g wage_unconditional2000 = (wage2000)    
g wage_unconditional2001 = (wage2001)    
g wage_unconditional2002 = (wage2002)    
g wage_unconditional2003 = (wage2003)    
g wage_unconditional2004 = (wage2004)    
g wage_unconditional2005 = (wage2005)    
g wage_unconditional2006 = (wage2006)    
g wage_unconditional2007 = (wage2007)    
g wage_unconditional2008 = (wage2008)    
g wage_unconditional2009 = (wage2009)    
g wage_unconditional2010 = (wage2010)    
g wage_unconditional2011 = (wage2011)    
g wage_unconditional2012 = (wage2012)    
g wage_unconditional2013 = (wage2013)    
g wage_unconditional2014 = (wage2014)    
g wage_unconditional2015 = (wage2015)    
g wage_unconditional2016 = (wage2016)    
g wage_unconditional2017 = (wage2017)
g wage_unconditional2019 = (wage2019)    


g logwage86 = logwage1986
g logwage19 = logwage2019

g log_wage86_unconditional =logwage86
g log_wage19_unconditional = logwage19
g wage86_unconditional = exp(logwage86)
g wage19_unconditional = exp(logwage19)
replace logwage86 = logwage_conditional1986          if controlling_for_X == "yes"
replace logwage19 = logwage_conditional2019         if controlling_for_X == "yes"
replace wage1986  = exp(logwage_conditional1986 )     if controlling_for_X == "yes"
replace wage2019  = exp(logwage_conditional2019 )     if controlling_for_X == "yes"

replace wage1988 = exp(logwage_conditional1988)     if controlling_for_X == "yes"
replace wage1989 = exp(logwage_conditional1989)     if controlling_for_X == "yes"
replace wage1990 = exp(logwage_conditional1990)     if controlling_for_X == "yes"
replace wage1991 = exp(logwage_conditional1991)     if controlling_for_X == "yes"
replace wage1992 = exp(logwage_conditional1992)     if controlling_for_X == "yes"
replace wage1993 = exp(logwage_conditional1993)     if controlling_for_X == "yes"
replace wage1994 = exp(logwage_conditional1994)     if controlling_for_X == "yes"
replace wage1995 = exp(logwage_conditional1995)     if controlling_for_X == "yes"
replace wage1996 = exp(logwage_conditional1996)     if controlling_for_X == "yes"
replace wage1997 = exp(logwage_conditional1997)     if controlling_for_X == "yes"
replace wage1998 = exp(logwage_conditional1998)     if controlling_for_X == "yes"
replace wage1999 = exp(logwage_conditional1999)     if controlling_for_X == "yes"
replace wage2000 = exp(logwage_conditional2000)     if controlling_for_X == "yes"
replace wage2001 = exp(logwage_conditional2001)     if controlling_for_X == "yes"
replace wage2002 = exp(logwage_conditional2002)     if controlling_for_X == "yes"
replace wage2003 = exp(logwage_conditional2003)     if controlling_for_X == "yes"
replace wage2004 = exp(logwage_conditional2004)     if controlling_for_X == "yes"
replace wage2005 = exp(logwage_conditional2005)     if controlling_for_X == "yes"
replace wage2006 = exp(logwage_conditional2006)     if controlling_for_X == "yes"
replace wage2007 = exp(logwage_conditional2007)     if controlling_for_X == "yes"
replace wage2008 = exp(logwage_conditional2008)     if controlling_for_X == "yes"
replace wage2009 = exp(logwage_conditional2009)     if controlling_for_X == "yes"
replace wage2010 = exp(logwage_conditional2010)     if controlling_for_X == "yes"
replace wage2011 = exp(logwage_conditional2011)     if controlling_for_X == "yes"
replace wage2012 = exp(logwage_conditional2012)     if controlling_for_X == "yes"
replace wage2013 = exp(logwage_conditional2013)     if controlling_for_X == "yes"
replace wage2014 = exp(logwage_conditional2014)     if controlling_for_X == "yes"
replace wage2015 = exp(logwage_conditional2015)     if controlling_for_X == "yes"
replace wage2016 = exp(logwage_conditional2016)     if controlling_for_X == "yes"
replace wage2017 = exp(logwage_conditional2017)     if controlling_for_X == "yes"



***********************************************
****************************************
* TFP
****************************************
***********************************************



**** XXXXXXXXXXXXXXXXXXXXXXXXXXX
* the level of conditional wages is not identified. 
* I renormalze wages so that they have same mean in 1964 and 2009  
* Note: relative wage levels are unchnaged, but the level is now cleaned of the arbitrary intercept in the conditional wage 

summ wage2019 wage1986
*egen tmp09 = mean(wage2009)
*egen tmp64 = mean(wage1964)
summarize wage1986 [weight = emp1986]
g tmp86 = r(mean)
summarize wage2019 [weight = emp2019]
g tmp19 = r(mean)
replace wage2019 = (wage2019/tmp19)* tmp86
drop tmp19 tmp86
summ wage2019 wage1986

summ logwage86 logwage19
replace logwage86 = log(wage1986)  
replace logwage19 = log(wage2019)  
summ logwage86 logwage19




* This term is TFP^(1/(1-alpha-eta))*T
g double AT86 = ( (alpha^(1-eta))*(eta^eta) / (rate^eta) ) * emp1986*wage1986^( (1-eta)/(1-alpha-eta) )
g double AT19 = ( (alpha^(1-eta))*(eta^eta) / (rate^eta) ) * emp2019*wage2019^( (1-eta)/(1-alpha-eta) )

* This term is TFP when y=(L,K) with DRTS
g Atfp86 =  ( emp1986^(1-alpha-eta) *  (wage1986^(1-eta)) ) 
g Atfp19 =  ( emp2019^(1-alpha-eta) *  (wage2019^(1-eta)) ) 
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
g Atfp08 =  ( emp2008^(1-alpha-eta) *  (wage2008^(1-eta)) )
g Atfp09 =  ( emp2009^(1-alpha-eta) *  (wage2009^(1-eta)) )
g Atfp10 =  ( emp2010^(1-alpha-eta) *  (wage2010^(1-eta)) )
g Atfp11 =  ( emp2011^(1-alpha-eta) *  (wage2011^(1-eta)) )
g Atfp12 =  ( emp2012^(1-alpha-eta) *  (wage2012^(1-eta)) )
g Atfp13 =  ( emp2013^(1-alpha-eta) *  (wage2013^(1-eta)) )
g Atfp14 =  ( emp2014^(1-alpha-eta) *  (wage2014^(1-eta)) )
g Atfp15 =  ( emp2015^(1-alpha-eta) *  (wage2015^(1-eta)) )
g Atfp16 =  ( emp2016^(1-alpha-eta) *  (wage2016^(1-eta)) )
g Atfp17 =  ( emp2017^(1-alpha-eta) *  (wage2017^(1-eta)) )

g tfp86 =  log(Atfp86)
g tfp19 =  log(Atfp19)



***********************************************
****************************************
* Amenities  
* Follows Albouy (2012)
* Note: relative amenities are identified, but the absolute 
*       levels are not identified because we don't observe V_bar
****************************************
***********************************************
egen ww86 = mean(wage1986)
egen pp86 = mean(rent1986)
egen ww19 = mean(wage2019)
egen pp19 = mean(rent2019)

* Option 1: housing weighst are the same in both years 
g Q86 = (.33 * ( (rent1986 - pp86)/pp86 )) - (.51 * ( (wage1986 - ww86)/ww86 ))
g Q19 = (.33 * ( (rent2019 - pp19)/pp19 )) - (.51 * ( (wage2019 - ww19)/ww19 ))

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
g QQ86 = ww19*(1+Q86) 
g QQ19 = ww19*(1+Q19) 
g logQQ19 = log(QQ19)


* With prefernces for location, the formula for amenities has an added term
egen ee19 = mean(emp2019)
egen ee86 = mean(emp1986)
g B86 = (.33 * ( (rent1986 - pp86)/pp86 )) - (.51 * ( (wage1986-ww86)/ww86 )) + ( inv_theta*((emp1986-ee86)/ee86) )
g B19 = (.33 * ( (rent2019 - pp19)/pp19 )) - (.51 * ( (wage2019-ww19)/ww19 )) + ( inv_theta*((emp2019-ee19)/ee19) )
g BB86 = ww19*(1+B86)
g BB19 = ww19*(1+B19)
drop ww* ee* 


***********************************************
****************************************
* Price of Utility
****************************************
***********************************************
* P
g P86 = wage1986 
g P19 = wage2019 

* employment shares
egen tot86 = sum(emp1986)
egen tot19 = sum(emp2019)
g e1986 = (emp1986 / tot86)
g e2019 = (emp2019 / tot19)

* Pbar
g tmp86 =  e1986*wage1986 
egen Pbar86 = sum(tmp86)
replace Pbar86 = . if tmp86 ==.

g tmp19 =  e2019*wage2019 
egen Pbar19 = sum(tmp19)
replace Pbar19 = . if tmp19 ==.
drop tmp* tot*

* check: it should be the case that the weighted average of P is Pbar
*summ P64 Pbar64 [weight = e1964]
*summ P09 Pbar09 [weight = e2009]

* P / Pbar
g P_Pbar86 = P86 /Pbar86
g P_Pbar19 = P19 /Pbar19





***********************************************
****************************************
* employment shares
****************************************
***********************************************

egen tot86 = sum(emp1986)
g share1986 = emp1986 / tot86
egen tot19 = sum(emp2019)
g share2019 = emp2019 / tot19



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
tabstat logwage86 [weight = emp1986], stat(mean sd iqr range)
tabstat logwage19 [weight = emp2019], stat(mean sd iqr range)

* CENSUS DIVISION
egen tmp = mean(logwage86), by(division)
g y86  = logwage86 - tmp
drop tmp
egen tmp = mean(logwage19), by(division)
g y19  = logwage19 - tmp
drop tmp

tabstat y86 [weight = emp1986], stat(mean sd iqr range)
tabstat y19 [weight = emp2019], stat(mean sd iqr range)
drop y86 y19

* SIZE
xtile pct = emp1986, nquantiles(20)
egen tmp = mean(logwage86), by(pct)
g y86  = logwage86 - tmp
drop tmp
egen tmp = mean(logwage19), by(pct)
g y19  = logwage19 - tmp
drop tmp

tabstat y86 [weight = emp1986], stat(mean sd iqr range)
tabstat y19 [weight = emp2019], stat(mean sd iqr range)
drop y86 y19

* DROPPING Brain hubs
tabstat logwage86 [weight = emp1986] if brain==0, stat(mean sd iqr range)
tabstat logwage19 [weight = emp2019] if brain==0, stat(mean sd iqr range)


* FIGURE 
****************************
* First, I de-mean
egen tmp = mean(logwage86)
g y86 = logwage86 - tmp
drop tmp

egen tmp = mean(logwage19)
g y19 = logwage19 - tmp
drop tmp

* Unweighted
kdensity y86, legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.03) addplot(kdensity y19,  lpattern(--) bwidth(0.03)) title(" ") ytitle(" ") xtitle("Wage") xlabel(-.5 0 .5) note(" ") caption(" ") legend(label(1 "1986") label(2 "2019") position(2) ring(0)) saving(fig1, replace)
graph export fig1.eps, replace logo(off)
!ps2pdf fig1.eps
drop y86 y19

* Weighted
* Needs weights that are integer for graphs
g ww86 = round(emp1986)
g ww19 = round(emp2019)


* I need weighted averages in 86 and 19
* egen does not allow for weights, so I do it brute force
save tmp, replace
collapse t86 = logwage86 [weight = ww86]
save tmp86, replace
clear
u tmp
collapse t19 = logwage19 [weight = ww19]
save tmp19, replace
clear
u tmp
merge using tmp86
drop _merge
merge using tmp19
drop _merge
egen tmp86 = max(t86)
egen tmp19 = max(t19)
drop t19 t86

g y19 = logwage19 - tmp19
drop tmp19

g y86 = logwage86 - tmp86 
drop tmp86

kdensity y86 [weight = ww86], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white)  bwidth(0.03) addplot(kdensity y19 [weight = ww19],  lpattern(--) bwidth(0.03)) title(" ") ytitle(" ") xtitle("Wage") xlabel(-.5 0 .5) xscale(r(-.6 .6)) ylabel(0 1 2 3 4 5)  note(" ") caption(" ") legend(label(1 "1986")   label(2 "2019")  position(2) ring(0)  ) saving(fig2, replace)
graph export fig2.eps, replace logo(off)
!ps2pdf fig2.eps




* MEANS
***********************
summ y86 [weight = emp1986] if brain ==1
summ y19 [weight = emp2019] if brain ==1

summ y86 [weight = emp1986] if south ==1
summ y19 [weight = emp2019] if south ==1

summ y86 [weight = emp1986] if rust ==1
summ y19 [weight = emp2019] if rust ==1

summ y86 [weight = emp1986] if other ==1
summ y19 [weight = emp2019] if other ==1

egen hh = rank(y86)
g top86 = 1 if hh >=200
drop hh
egen hh = rank(y19)
g top19 = 1 if hh >=200
summ y86 [weight = emp1986] if top86 ==1
summ y19 [weight = emp2019] if top19 ==1
drop hh top*



* LIST
**************************
sort y86
g n = _n
list name y86 y19 if  n >=200
*outsheet name y64 y09  if  n >=200 using tables/list_wages.csv, replace comma

drop n y86 y19
rm tmp.dta
rm tmp19.dta
rm tmp86.dta




******************************************
***************************
* RENTS
****************************
******************************************
g logHP86 = log(rent1986)
g logHP19 = log(rent2019)
g HP = log(rent1986)
egen tmp = mean(HP)
g y86 = HP - tmp
drop tmp HP
g HP = log(rent2019)
egen tmp = mean(HP)
g y19 = HP-tmp
drop HP

summ y86 [weight = emp1986] 
summ y19 [weight = emp2019] 

kdensity y86 [weight = ww86], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.04)  addplot(kdensity y19 [weight = ww19],  lpattern(--) ) title(" ") ytitle(" ") xtitle("Housing Costs") note(" ") caption(" ") legend(label(1 "1986") label(2 "2019")  position(2) ring(0)  ) saving(fig59, replace)
graph export fig59.eps, replace logo(off)
!ps2pdfwr fig59.eps fig59.pdf


* MEANS
***********************
summ y86 [weight = emp1986] if brain ==1
summ y19 [weight = emp2019] if brain ==1

summ y86 [weight = emp1986] if south ==1
summ y19 [weight = emp2019] if south ==1

summ y86 [weight = emp1986] if rust ==1
summ y19 [weight = emp2019] if rust ==1

summ y86 [weight = emp1986] if other ==1
summ y19 [weight = emp2019] if other ==1

egen hh = rank(y86)
g top86 = 1 if hh >=200
drop hh
egen hh = rank(y19)
g top19 = 1 if hh >=200
summ y86 [weight = emp1986] if top86 ==1
summ y19 [weight = emp2019] if top19 ==1
drop top* hh


*************************************************************************************************************************************************************************************************************************************************




* LIST
**************************
sort y86
g n = _n
list name y86 y19 if  n >=200
*list name y64 y09 emp1964 emp2009 if y64 >.15 & y64 <.25
drop n tmp y86 y19


******************************************
***************************
* EMPLOYMENT
****************************
******************************************
g emp=log(emp1986)
egen tmp = mean(emp) 
g y86 = emp - tmp
drop tmp emp
g emp = log(emp2019)
egen tmp = mean(emp)
g y19 = emp - tmp
drop emp 

kdensity y86 , legend(region(lwidth(none)))  graphregion(color(white)) bgcolor(white) addplot(kdensity y19 ,  lpattern(--) ) title(" ") ytitle(" ") xtitle("Employment") note(" ") caption(" ") legend(label(1 "1986") label(2 "2019")  position(2) ring(0)  ) saving(fig69, replace)
graph export fig69.eps, replace logo(off)
!ps2pdf fig69.eps


* MEANS
***********************
summ y86 if brain ==1
summ y19 if brain ==1
summ y86 if south ==1
summ y19 if south ==1
summ y86 if rust ==1
summ y19 if rust ==1
summ y86 if other ==1
summ y19 if other ==1


* Weighted
summ y86 [weight = emp1986] if brain ==1
summ y19 [weight = emp2019] if brain ==1
summ y86 [weight = emp1986] if south ==1
summ y19 [weight = emp2019] if south ==1
summ y86 [weight = emp1986] if rust ==1
summ y19 [weight = emp2019] if rust ==1
summ y86 [weight = emp1986] if other ==1
summ y19 [weight = emp2019] if other ==1


* LIST
**************************
sort y86
g n = _n
list name y86 y19 if  n >=200
list name y86  y19 if  n <=20
drop n

sort y19
g n = _n
list name y19 if  n >=200
list name y19  if  n <=20
drop n

g D= (emp2019-emp1986)/emp1986
summ D 
summ D if south ==1
sort D
g n = _n
*list name D emp1986 
drop n tmp y86 y19 D



****************************************
**********************************
* AMENITIES
* PEREFECT MOBILITY
**********************************
*****************************************
g QQ = log(QQ86)
egen tmp = mean(QQ)
g y86 = QQ - tmp
drop tmp QQ
g QQ = log(QQ19)
egen tmp = mean(QQ)
g y19 = QQ-tmp
drop QQ

summ y86 [weight = emp1986] 
summ y19 [weight = emp2019] 

kdensity y86 [weight = ww86], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.04) addplot(kdensity y19 [weight = ww19],  lpattern(--) ) title(" ") ytitle(" ") xtitle("Amenities") note(" ") caption(" ") legend(label(1 "1986") label(2 "2019")  position(2) ring(0)  ) saving(fig79, replace)
graph export fig79.eps, replace logo(off)
!ps2pdf fig79.eps


* MEANS
***********************
summ y86 [weight = emp1986] if brain ==1
summ y19 [weight = emp2019] if brain ==1

summ y86 [weight = emp1986] if south ==1
summ y19 [weight = emp2019] if south ==1

summ y86 [weight = emp1986] if rust ==1
summ y19 [weight = emp2019] if rust ==1

summ y86 [weight = emp1986] if other ==1
summ y19 [weight = emp2019] if other ==1

egen hh = rank(y86)
g top86 = 1 if hh >=200
drop hh
egen hh = rank(y19)
g top19 = 1 if hh >=200
summ y86 [weight = emp1986] if top86 ==1
summ y19 [weight = emp2019] if top19 ==1
drop hh top*

* LIST
**************************
sort y86
g n = _n
list name y86 y19 if  n >=200
list name y86 y19  if  n <=20
drop n
sort y19
g n = _n
list name y19 if  n >=200
list name y19  if  n <=20

drop n y86 y19 tmp


****************************************
**********************************
* AMENITIES
* IMPEREFECT MOBILITY
*
* WITH IMPERFECT MOBILITY, AMENITIES 
* DEPEND ON CITY SIZE
**********************************
*****************************************
g BB = log(BB86)
summ BB [weight = emp1986]
egen tmp = mean(BB) 
g y86 = BB - tmp
drop tmp BB 
g BB = log(BB19)
summ BB [weight = emp2019]
egen tmp = mean(BB)  
g y19 = BB-tmp
drop BB 

summ y86 [weight = emp1986] if brain ==1
summ y19 [weight = emp2019] if brain ==1

summ y86 [weight = emp1986] if south ==1
summ y19 [weight = emp2019] if south ==1

summ y86 [weight = emp1986] if rust ==1
summ y19 [weight = emp2019] if rust ==1

summ y86 [weight = emp1986] if other ==1
summ y19 [weight = emp2019] if other ==1

drop y86 y19 tmp


****************************************
**********************************
* TFP
**********************************
*****************************************
g AT = log(AT86)
egen tmp = mean(AT)
g y86 = (AT) - tmp
drop tmp AT
g AT = log(AT19)
egen tmp = mean(AT)
g y19 = AT-tmp
drop AT

kdensity y86 [weight = ww86], legend(region(lwidth(none))) graphregion(color(white)) bgcolor(white) bwidth(0.5) addplot(kdensity y19 [weight = ww19],  lpattern(--) ) title(" ") ytitle(" ") xtitle("TFP") note(" ") caption(" ") legend(label(1 "1986") label(2 "2019")  position(2) ring(0)  ) saving(fig89, replace)
graph export fig89.eps, replace logo(off)
!ps2pdf fig89.eps


* MEANS
***********************
summ y86 [weight = emp1986] if brain ==1
summ y19 [weight = emp2019] if brain ==1

summ y86 [weight = emp1986] if south ==1
summ y19 [weight = emp2019] if south ==1

summ y86 [weight = emp1986] if rust ==1
summ y19 [weight = emp2019] if rust ==1

summ y86 [weight = emp1986] if other ==1
summ y19 [weight = emp2019] if other ==1

egen hh = rank(y86)
g top86 = 1 if hh >=200
drop hh
egen hh = rank(y19)
g top19 = 1 if hh >=200
summ y86 [weight = emp1986] if top86 ==1
summ y19 [weight = emp2019] if top19 ==1
drop hh top*

* LIST
**************************
sort y86
g n = _n
list name y86 if  n >=200
list name y86  if  n <=20
drop n

sort y19
g n = _n
list name y19 if  n >=200
list name y19  if  n <=20

drop n y86 y19 tmp

***********************************


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
* I set 2019 wages = to 1986 wages
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

* Average wage in 86 and 19 (weighted by employment)
summarize wage1986 [weight = emp1986], detail
g jj = r(mean)
summarize wage2019 [weight = emp2019], detail
g zz = r(mean)


* Set counterfactual: 2019 relative wage is set equal to 86 relative wage (relative to weighted average)
g r86 = wage1986/jj
g       x   = wage2019
replace x   = Pbar19 * P_Pbar86 if XX ==1
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
* This is the counterfactual wage that would exist in 2009 if amenities weere at their 1964 level
* NOTE: there is a problem of scale, because QQ is off by a constant
*       estimates are sensitive to the scale of QQ (they are noot sensitive to the scale of x)
*******************************************************
g c1 = ( beta*inver + inv_theta)     / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
g c2 = ( 1-alpha -eta)               / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
summ c1 c2

* Insert the following lines in the case of preferences for location
replace QQ19 = BB19
replace QQ86 = BB86

g  double      x = wage2019 * ( (QQ19/QQ86) )^(c2)        if XX ==1
replace        x = wage2019                               if XX ==0










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
g       x1   = wage2019
replace x1   = Pbar19 * P_Pbar86 if XX ==1

* This is second cpountercatual, holding amenities fixed
* I am replicating it here from above
g c2 = ( 1-alpha -eta)               / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
g  double      x2 = wage2019 * ( (QQ19/QQ86) )^(c2)        if XX ==1
replace        x2 = wage2019                               if XX ==0

*This is the third one , which is equal to the first one net of the second one: it is equal to 
* counterfactual wages in the first one, but allowing for amenties to be equal to their observed levels
g       x   = wage2019
replace x   = x1 *( (QQ86/QQ19) )^(c2)          if XX ==1







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
replace QQ19 = BB19
replace QQ86 = BB86


* These are the wage parameters
* c1 is the parameter on log tfp and c2 is the parameter on log amenities
g c1 = ( beta*inver + inv_theta)     / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)
g c2 = ( 1-alpha -eta)  / ( beta*inver + 1-alpha -eta - beta*inver*eta +inv_theta - eta*inv_theta)

* Fillin missing values for saiz variables
egen g1 = mean(unaval), by(division)
egen g2 = mean(populat_saiz),  by(division)
egen g3 = mean(WRLURI),   by(division)
replace unaval = g1 if unaval ==.
replace populat_saiz  = g2 if populat_saiz==.
replace WRLURI   = g3 if WRLURI ==.
g WR = WRLURI 
g popul = populat_saiz 
g unav = unaval

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

g logx = logwage19 + diff1*log(Atfp19) - diff2*logQQ19
g x = exp(logx)

summ logwage19 logx if brain ==0
summ logwage19 logx if brain ==1
list name logwage19 logx if brain ==1

summ logwage19 logx if south ==0
summ logwage19 logx if south ==1


drop diff* h1 h2 new_* 




*********************************************************************
*********************************************************************
*********************************************************************
* COUNTERFACTUAL OUTPUT AND WELFARE
* 
* Note: relative gdp is fine, but the level of gdp is off by a constant. This constant is 
* different in 86 and 19 (it is a function of L)
*********************************************************************
*********************************************************************
*********************************************************************

********************
* Actual GDP 
********************
g double h19a = AT19 * ( (Pbar19/P19)^((1-eta)/(1-alpha-eta))  )
egen double hh19a = sum(h19a)
g double y19 = (eta/rate)^(eta/(1-eta))*(  hh19a^((1-alpha-eta)/(1-eta))  )  / 1000000

* XXXXXXXXXXX
*g kk = 1.1
*g double AT19kk = ( (alpha^(1-eta))*(eta^eta) / (rate^eta) ) * emp2019*(wage2019*kk)^( (1-eta)/(1-alpha-eta) )
*g double h19akk = AT19kk * ( (Pbar19/P19)^((1-eta)/(1-alpha-eta))  )
*egen double hh19akk = sum(h19akk)
*g double y19kk = (eta/rate)^(eta/(1-eta))*(  hh19akk^((1-alpha-eta)/(1-eta))  )  / 1000000
*drop h19akk hh19akk 



*********************
* Counterfactual employment 
*********************
* Provisional counterfactual employment (from FOC)
g double emp19c =  ( ( ( alpha^(1-eta)*(eta^eta)/(rate^eta) )/(x^(1-eta)) )^(1/(1-alpha-eta)) )*AT19

* As expected, employment in treated cities is larger than actual 
g DDx = emp19c - emp2019
summ DDx if XX ==1
summ DDx if XX ~=1


*********************************
* Add up constraint
* The sum of workers is not = to total number of workers available in the economy (D is not equal to S)
********************************
egen  sumDDx = sum(DDx)
* This is the sum of all workers 
egen sum = sum(emp19c) 
* This is by how much I need to rescale eac city size for the add up constraint to hold
g h = sumDDx /sum

* I  change employment in all cities proportionally 
g       new_emp19c = (1-h) * emp19c  

* I check that new_emp19c has the same mean as actual employment emp19
* This means that D = S
summ new_emp19c emp2019
drop h sum sumDDx emp19c


* Counterfactual total employment  
egen double tot19c = sum(new_emp19c)

* Counterfactual employment share
g e2019c = (new_emp19c / tot19c )

*********************
* Counterfactual Pbar  
*********************
g tmp =  e2019c*x
egen Pbar86c = sum(tmp)
replace Pbar86c = . if tmp ==.
drop tmp


*********************
* Counterfactual GDP 
*********************
* I need to divide by 1000000 because the number is too big and stata crashes
g double h19 = AT19 * ( (Pbar86c/x)^((1-eta)/(1-alpha-eta))  )
egen double hh19 = sum(h19)
g double yy19 = (eta/rate)^(eta/(1-eta))*(  hh19^((1-alpha-eta)/(1-eta))  )  / 1000000


* XXXXXXXXXXX
*g double h19kk = AT19kk * ( (Pbar86c/x)^((1-eta)/(1-alpha-eta))  )
*egen double hh19kk = sum(h19kk)
*g double yy19kk = (eta/rate)^(eta/(1-eta))*(  hh19kk^((1-alpha-eta)/(1-eta))  )  / 1000000

g growth = (wage19_unconditional - wage86_unconditional)/wage86_unconditional
g growth2 = .
*summarize growth [w=emp2019]
*summarize growth 
replace growth2 = r(mean)
*summ growth*
*g y64 = y19 / (1+growth2)
* drop y64



*** XXXXXXXXXXXXX
g double h86a = AT86 * ( (Pbar86/P86)^((1-eta)/(1-alpha-eta))  )
egen double hh86a = sum(h86a)
g double y86 = (eta/rate)^(eta/(1-eta))*(  hh86a^((1-alpha-eta)/(1-eta))  )  / 1000000
drop h86a hh86
summ yy19 y86 y19





* Now I can compute the percent difference between actual and counterfactual growth
* [(yy19 - y64)/y64] / [(y19 - y64)/y64] = (yy19 - y64) / (y19 - y64)
g diff19 = ( (yy19 - y86) / (y19 - y86) ) - 1
summ diff19


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
replace Pbar19  = Pbar19  / 1000000
replace Pbar86c = Pbar86c / 1000000
replace Pbar86  = Pbar86  / 1000000
summ Pbar*


g diff19_welf_adj=( (yy19/(Pbar86c) ) - (y86/(Pbar86) ) ) /  ( (y19/(Pbar19) ) - (y86/(Pbar86) ) ) -1
summ diff19_welf_adj
drop diff19_wel*


* Robustness analysis: Different scaling for price of utility
g kk = 1.01
g diff19_welf_adj=( (yy19/(Pbar86c*kk) ) - (y86/(Pbar86) ) ) /  ( (y19/(Pbar19*kk) ) - (y86/(Pbar86) ) ) -1
summ diff19_welf_adj
drop kk diff19_wel*



* Robustness analysis: Different scaling for price of utility
* This one shifts yy and y as well
*g diff19_welf_adj=( (yy19kk/(Pbar86c*kk) ) - (y86/(Pbar86) ) ) /  ( (y19kk/(Pbar19*kk) ) - (y86/(Pbar86) ) ) -1
*summ diff19_welf_adj
*drop kk diff19_wel*

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

save tmp, replace

* levels of TFP are not identified. Here it matters. Fitrst, I scale TFP so
* that aggregate TFP growth is consistent with unconditional wage growth
egen double bb19 = mean(AT19)
egen double bb86 = mean(AT86)
g bb      = .795*35
replace  AT19 = AT19*bb*( bb86 / bb19 )

********************
* Actual GDP
********************
g double h19a = AT19 * ( (Pbar19/P19)^((1-eta)/(1-alpha-eta))  )
egen double hh19a = sum(h19a)
g double y19 = (eta/rate)^(eta/(1-eta))*(  hh19a^((1-alpha-eta)/(1-eta))  )  / 1000000
drop hh* h19*

g double h86a = AT86 * ( (Pbar86/P86)^((1-eta)/(1-alpha-eta))  )
egen double hh86a = sum(h86a)
g double y86 = (eta/rate)^(eta/(1-eta))*(  hh86a^((1-alpha-eta)/(1-eta))  )  / 1000000


********************
* Counterfactual GDP
********************
g  double CC = AT19
*replace CC = AT64
*replace CC = AT64 if brain ==1
replace CC = AT86 if south ==1
*replace CC = AT64 if rust ==1
*replace CC = AT64 if other ==1

g double h19a = CC * ( (Pbar19/P19)^((1-eta)/(1-alpha-eta))  )
egen double hh19a = sum(h19a)
g double yy19 = (eta/rate)^(eta/(1-eta))*(  hh19a^((1-alpha-eta)/(1-eta))  )  / 1000000


* Now I can compute the percent difference between actual and counterfactual growth
* [(yy19 - y86)/y86] / [(y19 - y86)/y86] = (yy19 - y86) / (y19 - y86)
g diff19 = ( (yy19 - y86) / (y19 - y86) ) - 1
summ diff19


*********************
* Welfare
*********************

* Counterfactual employment
*********************
drop DDx new_emp19c tot19c e2019c Pbar86c
g double emp19c =  ( ( ( alpha^(1-eta)*(eta^eta)/(rate^eta) )/(wage2019^(1-eta)) )^(1/(1-alpha-eta)) )*CC
g DDx = emp19c - emp2019
* Add up constraint
* The sum of workers is not = to total number of workers available in the economy (D is not equal to S)
* This is the number of eccess workers
egen  sumDDx = sum(DDx)
* This is the sum of all workers
egen sum = sum(emp19c)
* This is by how much I need to rescale eac city size for the add up constraint to hold
g h = sumDDx /sum
* I  change employment in all cities proportionally
g       new_emp19c = (1-h) * emp19c
* I check that new_emp09c has the same mean as actual employment emp09
* This means that D = S
*summ new_emp09c emp2009
drop h sum sumDDx emp19c
* Counterfactual total employment
egen double tot19c = sum(new_emp19c)
* Counterfactual employment share
g e2019c = (new_emp19c / tot19c )
* Counterfactual Pbar
g tmp =  e2019c*wage2019
egen Pbar86c = sum(tmp)
replace Pbar86c = . if tmp ==.
drop tmp

*Normalize Pbar so that it's measued like income
replace Pbar19  = Pbar19  / 1000000
replace Pbar86c = Pbar86c / 1000000
replace Pbar86  = Pbar86  / 1000000
* Scale of Pbar is not identified. 
replace Pbar86 = Pbar19 


g kk =1
g diff19_welf_adj=( (yy19*Pbar86*Pbar19*kk) - (y86*Pbar86c*Pbar19*(kk^2)) ) / ( (y19*Pbar86*Pbar86c*kk) - (y86*Pbar86c*Pbar19*(kk^2)) ) -1
summ diff19_welf_adj
drop kk diff19_wel*

g kk =1.35
g diff19_welf_adj=( (yy19*Pbar86*Pbar19*kk) - (y86*Pbar86c*Pbar19*(kk^2)) ) / ( (y19*Pbar86*Pbar86c*kk) - (y86*Pbar86c*Pbar19*(kk^2)) ) -1
summ diff19_welf_adj
drop kk diff19_wel*
g kk =.7
g diff19_welf_adj=( (yy19*Pbar86*Pbar19*kk) - (y86*Pbar86c*Pbar19*(kk^2)) ) / ( (y19*Pbar86*Pbar86c*kk) - (y86*Pbar86c*Pbar19*(kk^2)) ) -1
summ diff19_welf_adj


clear
u tmp
rm tmp.dta
*/

**************************************************************************************************************************
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


local i=88
while `i' <=99 {
g P`i' = wage_unconditional19`i'/* wages */
egen tot`i' = sum(emp19`i')/* total emp */
g e19`i' = (emp19`i' / tot`i')/* emp share */
g tmp`i' =  e19`i'*wage19`i'/*  weighted wage=earnings */
egen Pbar`i' = sum(tmp`i')
replace Pbar`i' = . if tmp`i' ==./* earnings share */
g P_Pbar`i' = P`i' /Pbar`i'/*inverse employ share*/
g alpha`i' = 1 / (1 - e19`i')
g Gbar`i' =  log( (Pbar`i' - tmp`i') * alpha`i')
replace Gbar`i' = . if tmp`i' ==.
local i = `i'+1
}


local i=0
while `i' <=9 {
g P0`i' = wage200`i' 
egen tot0`i' = sum(emp200`i')
g e200`i' = (emp200`i' / tot0`i')
g tmp0`i' =  e200`i'*wage200`i'
egen Pbar0`i' = sum(tmp0`i')
replace Pbar0`i' = . if tmp0`i' ==.
g P_Pbar0`i' = P0`i' /Pbar0`i'
g alpha`i' = 1 / (1 - e200`i')
g Gbar0`i' =  log( (Pbar0`i' - tmp0`i') * alpha`i')
replace Gbar0`i' = . if tmp0`i' ==.
local i = `i'+1
}

local i=10
while `i' <=17 {
g P`i' = wage20`i' 
egen tot`i' = sum(emp20`i')
g e20`i' = (emp20`i' / tot`i')
g tmp`i' =  e20`i'*wage20`i'
egen Pbar`i' = sum(tmp`i')
replace Pbar`i' = . if tmp`i' ==.
g P_Pbar`i' = P`i' /Pbar`i'
g alpha`i' = 1 / (1 - e20`i')
g Gbar`i' =  log( (Pbar`i' - tmp`i') * alpha`i')
replace Gbar`i' = . if tmp`i' ==.
local i = `i'+1
}

g Gbar86 = Gbar88
g Gbar19 = Gbar17



***********
local i=1988
while `i' <=1999 {
egen tot`i' = sum(emp`i')
g share`i' = emp`i' / tot`i' /* empl share */
local i = `i'+1
}

local i=2000
while `i' <=2017 {
egen tot`i' = sum(emp`i')
g share`i' = emp`i' / tot`i'
local i = `i'+1
}
drop tot* tmp*


* now share based on wage bill
egen tot86 = sum(ap1986)
g share_ap1986 = ap1986 / tot86  /*actual weighted avg earnings*/
egen tot19 = sum(ap2019)
g share_ap2019 = ap2019 / tot19

local i=1988
while `i' <=1999 {
egen tot`i' = sum(ap`i')
g share_ap`i' = ap`i' / tot`i'
local i = `i'+1
}

local i=2000
while `i' <=2017 {
egen tot`i' = sum(ap`i')
g share_ap`i' = ap`i' / tot`i'
local i = `i'+1
}


****************

* Model based /* TFP growth */
g ddd1 = log( Atfp88 ) - log( Atfp86)
g ddd2 = log( Atfp89 ) - log( Atfp88)
g ddd3 = log( Atfp90 ) - log( Atfp89)
g ddd4 = log( Atfp91 ) - log( Atfp90)
g ddd5 = log( Atfp92 ) - log( Atfp91)
g ddd6 = log( Atfp93 ) - log( Atfp92)
g ddd7 = log( Atfp94 ) - log( Atfp93)
g ddd8 = log( Atfp95 ) - log( Atfp94)
g ddd9 = log( Atfp96 ) - log( Atfp95)
g ddd10 = log( Atfp97 ) - log( Atfp96)
g ddd11 = log( Atfp98 ) - log( Atfp97)
g ddd12 = log( Atfp99 ) - log( Atfp98)
g ddd13 = log( Atfp00 ) - log( Atfp99)
g ddd14 = log( Atfp01 ) - log( Atfp00)
g ddd15 = log( Atfp02 ) - log( Atfp01)
g ddd16 = log( Atfp03 ) - log( Atfp02)
g ddd17 = log( Atfp04 ) - log( Atfp03)
g ddd18 = log( Atfp05 ) - log( Atfp04)
g ddd19 = log( Atfp06 ) - log( Atfp05)
g ddd20 = log( Atfp07 ) - log( Atfp06)
g ddd21 = log( Atfp08 ) - log( Atfp07)
g ddd22 = log( Atfp09 ) - log( Atfp08)
g ddd23 = log( Atfp10 ) - log( Atfp09)
g ddd24 = log( Atfp11 ) - log( Atfp10)
g ddd25 = log( Atfp12 ) - log( Atfp11)
g ddd26 = log( Atfp13 ) - log( Atfp12)
g ddd27 = log( Atfp14 ) - log( Atfp13)
g ddd28 = log( Atfp15 ) - log( Atfp14)
g ddd29 = log( Atfp16 ) - log( Atfp15)
g ddd30 = log( Atfp17 ) - log( Atfp16)
g ddd31 = log( Atfp19 ) - log( Atfp17)

g hhh1 = log( P_Pbar88 ) - log( P_Pbar86)/* weighted earnings growth */
g hhh2 = log( P_Pbar89 ) - log( P_Pbar88)
g hhh3 = log( P_Pbar90 ) - log( P_Pbar89)
g hhh4 = log( P_Pbar91 ) - log( P_Pbar90)
g hhh5 = log( P_Pbar92 ) - log( P_Pbar91)
g hhh6 = log( P_Pbar93 ) - log( P_Pbar92)
g hhh7 = log( P_Pbar94 ) - log( P_Pbar93)
g hhh8 = log( P_Pbar95 ) - log( P_Pbar94)
g hhh9 = log( P_Pbar96 ) - log( P_Pbar95)
g hhh10 = log( P_Pbar97 ) - log( P_Pbar96)
g hhh11 = log( P_Pbar98 ) - log( P_Pbar97)
g hhh12 = log( P_Pbar99 ) - log( P_Pbar98)
g hhh13 = log( P_Pbar00 ) - log( P_Pbar99)
g hhh14 = log( P_Pbar01 ) - log( P_Pbar00)
g hhh15 = log( P_Pbar02 ) - log( P_Pbar01)
g hhh16 = log( P_Pbar03 ) - log( P_Pbar02)
g hhh17 = log( P_Pbar04 ) - log( P_Pbar03)
g hhh18 = log( P_Pbar05 ) - log( P_Pbar04)
g hhh19 = log( P_Pbar06 ) - log( P_Pbar05)
g hhh20 = log( P_Pbar07 ) - log( P_Pbar06)
g hhh21 = log( P_Pbar08 ) - log( P_Pbar07)
g hhh22 = log( P_Pbar09 ) - log( P_Pbar08)
g hhh23 = log( P_Pbar10 ) - log( P_Pbar09)
g hhh24 = log( P_Pbar11 ) - log( P_Pbar10)
g hhh25 = log( P_Pbar12 ) - log( P_Pbar11)
g hhh26 = log( P_Pbar13 ) - log( P_Pbar12)
g hhh27 = log( P_Pbar14 ) - log( P_Pbar13)
g hhh28 = log( P_Pbar15 ) - log( P_Pbar14)
g hhh29 = log( P_Pbar16 ) - log( P_Pbar15)
g hhh30 = log( P_Pbar17 ) - log( P_Pbar16)
g hhh31 = log( P_Pbar19 ) - log( P_Pbar17)

g www1 = ( share1988 + share1986)/2 /*avg empl share*/
g www2 = ( share1989 + share1988)/2
g www3 = ( share1990 + share1989)/2
g www4 = ( share1991 + share1990)/2
g www5 = ( share1992 + share1991)/2
g www6 = ( share1993 + share1992)/2
g www7 = ( share1994 + share1993)/2
g www8 = ( share1995 + share1994)/2
g www9 = ( share1996 + share1995)/2
g www10 = ( share1997 + share1996)/2
g www11 = ( share1998 + share1997)/2
g www12 = ( share1999 + share1998)/2
g www13 = ( share2000 + share1999)/2
g www14 = ( share2001 + share2000)/2
g www15 = ( share2002 + share2001)/2
g www16 = ( share2003 + share2002)/2
g www17 = ( share2004 + share2003)/2
g www18 = ( share2005 + share2004)/2
g www19 = ( share2006 + share2005)/2
g www20 = ( share2007 + share2006)/2
g www21 = ( share2008 + share2007)/2
g www22 = ( share2009 + share2008)/2
g www23 = ( share2010 + share2009)/2
g www24 = ( share2011 + share2010)/2
g www25 = ( share2012 + share2011)/2
g www26 = ( share2013 + share2012)/2
g www27 = ( share2014 + share2013)/2
g www28 = ( share2015 + share2014)/2
g www29 = ( share2016 + share2015)/2
g www30 = ( share2017 + share2016)/2
g www31 = ( share2019 + share2017)/2

g www_ap1 = ( share_ap1988 + share_ap1986)/2  /*avg earnings share*/
g www_ap2 = ( share_ap1989 + share_ap1988)/2
g www_ap3 = ( share_ap1990 + share_ap1989)/2
g www_ap4 = ( share_ap1991 + share_ap1990)/2
g www_ap5 = ( share_ap1992 + share_ap1991)/2
g www_ap6 = ( share_ap1993 + share_ap1992)/2
g www_ap7 = ( share_ap1994 + share_ap1993)/2
g www_ap8 = ( share_ap1995 + share_ap1994)/2
g www_ap9 = ( share_ap1996 + share_ap1995)/2
g www_ap10 = ( share_ap1997 + share_ap1996)/2
g www_ap11 = ( share_ap1998 + share_ap1997)/2
g www_ap12 = ( share_ap1999 + share_ap1998)/2
g www_ap13 = ( share_ap2000 + share_ap1999)/2
g www_ap14 = ( share_ap2001 + share_ap2000)/2
g www_ap15 = ( share_ap2002 + share_ap2001)/2
g www_ap16 = ( share_ap2003 + share_ap2002)/2
g www_ap17 = ( share_ap2004 + share_ap2003)/2
g www_ap18 = ( share_ap2005 + share_ap2004)/2
g www_ap19 = ( share_ap2006 + share_ap2005)/2
g www_ap20 = ( share_ap2007 + share_ap2006)/2
g www_ap21 = ( share_ap2008 + share_ap2007)/2
g www_ap22 = ( share_ap2009 + share_ap2008)/2
g www_ap23 = ( share_ap2010 + share_ap2009)/2
g www_ap24 = ( share_ap2011 + share_ap2010)/2
g www_ap25 = ( share_ap2012 + share_ap2011)/2
g www_ap26 = ( share_ap2013 + share_ap2012)/2
g www_ap27 = ( share_ap2014 + share_ap2013)/2
g www_ap28 = ( share_ap2015 + share_ap2014)/2
g www_ap29 = ( share_ap2016 + share_ap2015)/2
g www_ap30 = ( share_ap2017 + share_ap2016)/2
g www_ap31 = ( share_ap2019 + share_ap2017)/2


g qqq1  = Gbar88 - Gbar86
g qqq2  = Gbar89 - Gbar88
g qqq3  = Gbar90 - Gbar89
g qqq4  = Gbar91 - Gbar90
g qqq5  = Gbar92 - Gbar91
g qqq6  = Gbar93 - Gbar92
g qqq7  = Gbar94 - Gbar93
g qqq8  = Gbar95 - Gbar94
g qqq9  = Gbar96 - Gbar95
g qqq10  = Gbar97 - Gbar96
g qqq11  = Gbar98 - Gbar97
g qqq12  = Gbar99 - Gbar98
g qqq13  = Gbar00 - Gbar99
g qqq14  = Gbar01 - Gbar00
g qqq15  = Gbar02 - Gbar01
g qqq16  = Gbar03 - Gbar02
g qqq17  = Gbar04 - Gbar03
g qqq18  = Gbar05 - Gbar04
g qqq19  = Gbar06 - Gbar05
g qqq20  = Gbar07 - Gbar06
g qqq21  = Gbar08 - Gbar07
g qqq22  = Gbar09 - Gbar08
g qqq23  = Gbar10 - Gbar09
g qqq24  = Gbar11 - Gbar10
g qqq25  = Gbar12 - Gbar11
g qqq26  = Gbar13 - Gbar12
g qqq27  = Gbar14 - Gbar13
g qqq28  = Gbar15 - Gbar14
g qqq29  = Gbar16 - Gbar15
g qqq30  = Gbar17 - Gbar16
g qqq31  = Gbar19 - Gbar17
 


keep ddd* hhh* www* qqq*  emp2019 name cbsa brain rust south other alpha
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
* 1986 and 2019
sort name brain rust south other
collapse emp2019 (sum) growth_model growth_naive welfare_model, by(name brain rust south other)

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
replace ap1986 = ap1986 / 1000000
replace ap2019 = ap2019 / 1000000
summ wage_unconditional1986 rent1986 emp1986 ap1986 hs1986 coll1986 sex1986   hispanic1986   nwhite1986   age1986  
summ wage_unconditional2019 rent2019 emp2019 ap2019 hs2019 coll2019 sex2019 hispanic2019 nwhite2019 age2019  


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
