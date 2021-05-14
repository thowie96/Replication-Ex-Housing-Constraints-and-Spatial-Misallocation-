/*
*********************************************************************
*In this section I try to identify the method by which Moretti/Hsieh
*calculate the avg housing cost for each MSA. The ACS uses FIPS to 
*identify counties and states, but also uses MSA codes with 1999 delineations. 
*I use MSA codes given by ACS to calculate averages/median  
*********************************************************************



*Note that here there are many key MSA and PMSAs missing (oakland) as
*the MSA/PMSA identification slightly differs from that in the actual
*OBP delineations. In reality many of the counties switched from one MSA
*to its own PMSA over time. For example, "Alameda and Contra Costa counties were split from the San Francisco metropolitan area in 1990 and became the Oakland metropolitan area. Solano County was part of the San Francisco metro area in 1940 and 1950, failed to meet metro criteria in 1960, but emerged as the separate metro area of Vallejo from 1970 to 1990."
*/

*********************************************************************
/*
*Now generate Avg Characteristics and Median Rent with the same MSA classification as Moretti/Hsieh
use $data/ACS/usa_00003.dta, clear

keep age countyfip educ hispan met2013 metarea metaread race rent sex statefip year

*Use 1986, 2009 (for comparison), 2019
replace year = 1986 if year == 1980 | year == 1990
replace year = 2019 if year == 2018 | year == 2019

*Classify MSA by Moretti/Hsieh method of using MSA/PMSA identified by county FIP code from 1999 delineation
rename statefip fipstate
rename countyfip cencty
merge m:1 cencty fipstate using $crosswalk/1999_county_msa_csa_map.dta
drop _merge
*/
/*
merg m:1 year using $data/inflation.dta
drop _merge


*replace valueh = . if valueh == 9999998 | valueh == 9999999
replace rent = . if rent == 0001 | rent == 9998 | rent == 9999
replace rent = . if rent < 2

replace rent = (rent/index)*12

replace sex = sex - 1

g hispanic = 0
replace hispanic = 1 if hispan != 0
g nwhite = 1
replace nwhite = 0 if race == 1

/*
00	N/A or no schooling
01	Nursery school to grade 4
02	Grade 5, 6, 7, or 8
03	Grade 9
04	Grade 10
05	Grade 11
06	Grade 12
07	1 year of college
08	2 years of college
09	3 years of college
10	4 years of college
11	5+ years of college
*/

replace educ = 4 if educ == 1
replace educ = 6 if educ == 2
replace educ = 9 if educ == 3
replace educ = 10 if educ == 4
replace educ = 11 if educ == 5
replace educ = 12 if educ == 6
replace educ = 13 if educ == 7
replace educ = 14 if educ == 8
replace educ = 15 if educ == 9
replace educ = 16 if educ == 10
replace educ = 18 if educ == 11

g hs = 0
g coll = 0
replace hs = 1 if educ >= 12
replace coll = 1 if educ >= 16

drop if year == .
drop if fipstate == .

keep age cencty city_town coll fipstate hispanic hs metarea metaread msa name nwhite rent sex year
*/
/*
save $data/ACS/Replication_Demographics_long.dta, replace

*to get  2019 levels you must use met2013
collapse (median) rent (mean) hs coll hispanic nwhite sex age, by(msa year) 


merge m:1 msa using $base_folder/data3.dta
drop _merge

keep msa year rent hs coll hispanic nwhite sex age name_msa 

save $data/ACS/Replication_Demographics_wide.dta, replace

*/
******************************************************************
*comparison
/*
keep if period == 2009


merge m:1 msa using $base_folder/data3.dta
drop _merge


keep msa metaread period rent educ hs coll hispanic nwhite sex age hs09 coll09 

*Linear, but off due to using 1986 base inflation vs 1964 base
twoway (scatter HP09 rent) (line rent rent)

twoway (scatter female2009 sex) (line sex sex)

twoway (scatter age2009 age) (line age age)

twoway (scatter coll09 coll) (line coll coll)

twoway (scatter hs09 hs) (line hs hs)

twoway (scatter hisp2009 hispanic) (line hispanic hispanic)


*/

*****Interpolate Data fro missing years
use $data/ACS/Replication_Demographics_wide.dta, clear

egen count = count(msa), by(msa)

drop if count < 16

save $data/ACS/Replication_Demographics_widetmp.dta, replace

levelsof msa, local(levels)
foreach i of local levels{

use $data/ACS/Replication_Demographics_widetmp.dta, clear
display "MSA = `i'"
keep if msa == `i'
scalar c = count
keep if year == 1986 | year == 2000
if c == 16 {
collapse (mean) rent age sex nwhite coll hs hispanic, by(msa)

g year = 1993 

merge m:1 msa year using $data/ACS/Replication_Demographics_widetmp2.dta 
drop _merge 

save $data/ACS/Replication_Demographics_widetmp2.dta, replace
}
}

sort msa year
save $data/ACS/Replication_Demographics_widetmp3.dta, replace
save $data/ACS/Replication_Demographics_widetmp4.dta, replace

forvalues i = 1986/1991{
	use $data/ACS/Replication_Demographics_widetmp4.dta, clear
	display "Year = `i'"
	keep if year == `i'
	replace year = `i'+1
	
	merge m:1 msa year using $data/ACS/Replication_Demographics_widetmp3.dta 
	drop _merge 

	save $data/ACS/Replication_Demographics_widetmp4.dta, replace
	save $data/ACS/Replication_Demographics_widetmp3.dta, replace
}

sort msa year
save $data/ACS/Replication_Demographics_widetmp5.dta, replace
save $data/ACS/Replication_Demographics_widetmp6.dta, replace


forvalues i = 1993/1998{
	use $data/ACS/Replication_Demographics_widetmp6.dta, clear
	display "Year = `i'"
	keep if year == `i'
	replace year = `i'+1
	
	merge m:1 msa year using $data/ACS/Replication_Demographics_widetmp5.dta 
	drop _merge 

	save $data/ACS/Replication_Demographics_widetmp6.dta, replace
	save $data/ACS/Replication_Demographics_widetmp5.dta, replace
}



sort msa year
save $data/ACS/Replication_Demographics_widetmp7.dta, replace
save $data/ACS/Replication_Demographics_widetmp8.dta, replace


forvalues i = 2000/2003{
	use $data/ACS/Replication_Demographics_widetmp8.dta, clear
	display "Year = `i'"
	keep if year == `i'
	replace year = `i'+1
	
	merge m:1 msa year using $data/ACS/Replication_Demographics_widetmp7.dta 
	drop _merge 

	save $data/ACS/Replication_Demographics_widetmp8.dta, replace
	save $data/ACS/Replication_Demographics_widetmp7.dta, replace
}

sort msa year
save $data/ACS/Replication_Demographics_widetmp.dta, replace


merge m:1 msa using $base_folder/data3.dta
drop _merge

keep msa year rent hs coll hispanic nwhite sex age name_msa WRLURI elasticity inverse c populat_saiz division union09 union64

rename union64 union86
rename union09 union19

egen munion86 = mean(union86)
egen munion19 = mean(union19)
replace union86 = munion86 if union86 == .
replace union19 = munion19 if union19 == .
drop munion19
drop munion86

save $data/ACS/Replication_Demographics_widetmp.dta, replace


******Calculate Residual Wages****

use $data/ACS/Replication_Demographics_widetmp.dta, clear


g res_wage = .
replace res_wage = .47*hs + .425*col -.79*sex -.255*nwhite + .00055*age + .14*union19 if year > 2003
replace res_wage = .47*hs + .425*col -.79*sex -.255*nwhite + .00055*age + .14*union86 if year <= 2003

save $data/ACS/Replication_Demographics_widetmp.dta, replace

use $data/CBP/CBP8619.dta, clear

drop if msa == .

rename ap_mine ap
rename wage_mine wage
rename emp_mine emp


merge m:1 msa year using $data/ACS/Replication_Demographics_widetmp.dta
drop _merge

g logwage = log(wage)
g logwage_conditional = logwage - res_wage

sort msa year
replace logwage_conditional = logwage_conditional[_n+1] if year == 2018

********Interpolate Conditional Wage********************************************
levelsof msa, local(levels)
foreach i of local levels{
sort msa year
ipolate logwage_conditional year if msa == `i', generate(logwage_conditional2)
replace logwage_conditional = logwage_conditional2 if logwage_conditional == .
drop logwage_conditional2
}

*******Convert to Wide*******************************************************

drop if year == .
drop name_msa WRLURI elasticity inverse c populat_saiz division union19 union86 res_wage 

#delimit ;
local vlist
ap
emp
wage
logwage 
logwage_conditional
rent
hs
coll
hispanic
nwhite
sex
age
;
#delimit cr 

reshape wide `vlist', i(msa) j(year) 

replace emp2019 = (emp2018+emp2019)/2
replace emp1986 = (emp1986+emp1987)/2
drop emp2018 emp1987

replace wage2019 = (wage2019+wage2018)/2
replace wage1986 = (wage1986+wage1987)/2
drop wage2018 wage1987

replace ap2019 = (ap2019+ap2018)/2
replace ap1986 = (ap1986+ap1987)/2
drop ap2018 ap1987

replace logwage_conditional2019 = (logwage_conditional2019+logwage_conditional2018)/2
replace logwage_conditional1986 = (logwage_conditional1986+logwage_conditional1987)/2
drop logwage_conditional1987 logwage_conditional2018

drop if logwage_conditional1986 == .
drop if logwage_conditional2019 == .

*************Get Regulation, Unavailable land, 1970 population, Name, division
save $data/ACS/Replication_widetmp.dta, replace

use $base_folder/data3.dta, clear
keep msa unaval name_msa WRLURI elasticity inverse c populat_saiz division unaval state  

rename WRLURI WRLURI1

merge m:1 msa using $data/ACS/Replication_widetmp.dta
drop _merge

drop if emp1986 == .

save $data/ACS/Replication_widetmp.dta, replace

*merge with regulations
use $data/Wharton/WHARTON_LAND_REGULATION_DATA_1_24_2008.dta, clear


egen sum_w = total(weight_metro), by(msa99)

g w = weight_metro/sum_w

g reg_w = WRLURI*w

egen sum_reg = total(reg_w), by(msa99)

replace WRLURI = sum_reg

collapse (mean) WRLURI, by(msa99)

rename msa99 msa 

merge m:1 msa using $data/ACS/Replication_widetmp.dta
drop _merge

rename WRLURI WRLURI2

drop if logwage_conditional1986 == .
drop if logwage_conditional2019 == .

replace state = 2 if msa == 380
replace state = 37 if msa == 480
replace state = 34 if msa == 875
replace state = 48 if msa == 1145
replace state = 48 if msa == 1260
replace state = 10 if msa == 2190
replace state = 18 if msa == 2330
replace state = 12 if msa == 2710
replace state = 48 if msa == 2800
replace state = 18 if msa == 2960
replace state = 37 if msa == 2980
replace state = 37 if msa == 3150
replace state = 15 if msa == 3320
replace state = 36 if msa == 3610
replace state = 34 if msa == 3640
replace state = 6 if msa == 4940
replace state = 34 if msa == 5015
replace state = 34 if msa == 5190
replace state = 45 if msa == 5330
replace state = 36 if msa == 5380
replace state = 34 if msa == 5640
replace state = 6  if msa == 5775
replace state = 6  if msa == 5945
replace state = 25 if msa ==  6480
replace state = 6 if msa == 7460
replace state = 6 if msa == 7485
replace state = 6 if msa == 8720
replace state = 6 if msa == 8735
replace state = 6 if msa == 9270
replace state = 4 if msa == 9360
replace state = 18 if msa == 1020
replace state = 35 if msa == 4100
replace state = 12 if msa == 6580
replace state = 27 if msa == 6820



replace division = 7 if state == 48
replace division = 5 if state == 12
replace division = 5 if state == 45

replace WRLURI1 = WRLURI2 if WRLURI1 == .

rename WRLURI1 WRLURI

save $data/Replication.dta, replace



