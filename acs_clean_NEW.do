*****Map CBSA (mistake-actually called CMSA) to individual level****************
/*
use $data/ACS/Replication_Demographics_long.dta, clear

merge m:1 cencty fipstate using $crosswalk/1999_county_msa_csa_map_new.dta
drop _merge

save $data/ACS/Replication_Demographics_long_new.dta, replace

collapse (median) rent (mean) hs coll hispanic nwhite sex age, by(cbsa year) 

drop if year == .
drop if cbsa == .

save $data/ACS/Replication_Demographics_wide_new.dta, replace
*/
*************************(START HERE)*********************************************************
*************Interpolate Avg Characteristics for missing years************
use $data/ACS/Replication_Demographics_wide_new.dta, clear

sort cbsa year

egen count = count(cbsa), by(cbsa)

drop if count < 16

save $data/ACS/Replication_Demographics_widetmp_new.dta, replace
save $data/ACS/Replication_Demographics_widetmp2_new.dta, replace

use $data/ACS/Replication_Demographics_widetmp_new.dta, clear

levelsof cbsa, local(levels)
foreach i of local levels{

use $data/ACS/Replication_Demographics_widetmp_new.dta, clear
display "CBSA = `i'"
keep if cbsa == `i'
scalar c = count
keep if year == 1986 | year == 2000
if c == 16 {
collapse (mean) rent age sex nwhite coll hs hispanic, by(cbsa)

g year = 1993 

merge m:1 cbsa year using $data/ACS/Replication_Demographics_widetmp2_new.dta 
drop _merge 

save $data/ACS/Replication_Demographics_widetmp2_new.dta, replace
}
}



sort cbsa year
save $data/ACS/Replication_Demographics_widetmp3_new.dta, replace
save $data/ACS/Replication_Demographics_widetmp4_new.dta, replace

forvalues i = 1986/1991{
	use $data/ACS/Replication_Demographics_widetmp4_new.dta, clear
	display "Year = `i'"
	keep if year == `i'
	replace year = `i'+1
	
	merge m:1 cbsa year using $data/ACS/Replication_Demographics_widetmp3_new.dta 
	drop _merge 

	save $data/ACS/Replication_Demographics_widetmp4_new.dta, replace
	save $data/ACS/Replication_Demographics_widetmp3_new.dta, replace
}

sort cbsa year
save $data/ACS/Replication_Demographics_widetmp5_new.dta, replace
save $data/ACS/Replication_Demographics_widetmp6_new.dta, replace


forvalues i = 1993/1998{
	use $data/ACS/Replication_Demographics_widetmp6_new.dta, clear
	display "Year = `i'"
	keep if year == `i'
	replace year = `i'+1
	
	merge m:1 cbsa year using $data/ACS/Replication_Demographics_widetmp5_new.dta 
	drop _merge 

	save $data/ACS/Replication_Demographics_widetmp6_new.dta, replace
	save $data/ACS/Replication_Demographics_widetmp5_new.dta, replace
}



sort cbsa year
save $data/ACS/Replication_Demographics_widetmp7_new.dta, replace
save $data/ACS/Replication_Demographics_widetmp8_new.dta, replace


forvalues i = 2000/2003{
	use $data/ACS/Replication_Demographics_widetmp8_new.dta, clear
	display "Year = `i'"
	keep if year == `i'
	replace year = `i'+1
	
	merge m:1 cbsa year using $data/ACS/Replication_Demographics_widetmp7_new.dta 
	drop _merge 

	save $data/ACS/Replication_Demographics_widetmp8_new.dta, replace
	save $data/ACS/Replication_Demographics_widetmp7_new.dta, replace
}

sort cbsa year
save $data/ACS/Replication_Demographics_widetmp_new.dta, replace
***All we need from here is union data****

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/crosswalk/1999county_msa.txt", clear


*Seperate State and County Code
g work = string(countycode, "%12.0f")
g fipstate = real(substr(work, 1, length(work) - 3)) 
g cencty = real(substr(work, -3, 3)) 

drop countycode work v6

g cbsa = msa 

replace msa = pmsa if pmsa != .

keep if cencty == .
drop if name == ""

merge m:1 msa using $base_folder/data3.dta
drop _merge

keep cbsa msa pmsa name division union09 union64

drop if division == .

keep cbsa name division union09 union64

rename union09 union19
rename union64 union86

save $data/ACS/msa_cba.dta, replace

**********Calculate Residual Wages*********

merge m:m cbsa using $data/ACS/Replication_Demographics_widetmp_new.dta
drop _merge

sort cbsa year

drop if year  == .
drop if cbsa == .

save $data/ACS/Replication_Demographics_widetmp_new.dta, replace

use  $data/ACS/msa_cba.dta, clear

merge m:m cbsa using $data/ACS/Replication_Demographics_widetmp_new.dta,
drop _merge

drop if division == .
drop if name == ""

sort cbsa year

g res_wage = .
replace res_wage = .47*hs + .425*col -.79*sex -.255*nwhite + .00055*age + .14*union19 if year > 2003
replace res_wage = .47*hs + .425*col -.79*sex -.255*nwhite + .00055*age + .14*union86 if year <= 2003

save $data/ACS/Replication_Demographics_widetmp_new.dta, replace

****Interpolate Conditional Wages*******
use $data/CBP/CBP8619_new.dta, clear

drop if cbsa == .

merge m:m cbsa year using $data/ACS/Replication_Demographics_widetmp_new.dta
drop _merge

g logwage = log(wage)
g logwage_conditional = logwage - res_wage

sort cbsa year
replace logwage_conditional = logwage_conditional[_n+1] if year == 2018

levelsof cbsa, local(levels)
foreach i of local levels{
sort cbsa year
ipolate logwage_conditional year if cbsa == `i', generate(logwage_conditional2)
replace logwage_conditional = logwage_conditional2 if logwage_conditional == .
drop logwage_conditional2
}

drop name division union19 union86

save $data/ACS/Replication_Demographics_widetmp_new.dta, replace
***************Convert to Wide***********
sort cbsa year

drop if logwage_conditional == .
drop count res_wage

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

reshape wide `vlist', i(cbsa) j(year) 

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


save $data/ACS/Replication_widetmp_new.dta, replace

*************Get Regulation, Unavailable land, 1970 population, Name, division
import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/crosswalk/1999county_msa.txt", clear


*Seperate State and County Code
g work = string(countycode, "%12.0f")
g fipstate = real(substr(work, 1, length(work) - 3)) 
g cencty = real(substr(work, -3, 3)) 

drop countycode work v6

g cbsa = msa 

replace msa = pmsa if pmsa != .

keep if cencty == .
drop if name == ""

merge m:1 msa using $base_folder/data3.dta
drop _merge

keep cbsa unaval name WRLURI elasticity inverse c populat_saiz division 

drop if division == .

merge m:m cbsa using $data/ACS/Replication_widetmp_new.dta
drop _merge

sort cbsa 

drop if emp1986 == .

save $data/ACS/Replication_widetmp_new.dta, replace

save $data/Replication_new.dta, replace

*****Weighted average of regulations across PMSA that are in the same CMSA
/*
egen mpop = total(populat_saiz), by(cbsa)

g popwheight = populat_saiz/mpop

g regulation_weighted = popwheight*WRLURI
g unaval_weighted = popwheight*unaval

replace WRLURI = regulation_weighted
replace unaval = popwheight*unaval

sort cbsa
quietly by cbsa:  gen dup = cond(_N==1,0,_n)

keep if dup < 2
*/
*names were assigned by PMSA but are are all assigned to the same CMSA so we only need one
drop if name == "Riverside-San Bernardino, CA PMSA"
drop if name == "Racine, WI PMSA"
drop if name == "Newburgh, NY-PA PMSA"
drop if name == "Trenton, NJ PMSA"
drop if name == "Vineland-Millville-Bridgeton, NJ PMSA"
drop if name == "Atlantic-Cape May, NJ PMSA"
drop if name == "Wilmington-Newark, DE-MD PMSA"
drop if name == "Salem, OR PMSA"
drop if name == "Santa Rosa, CA PMSA"
drop if name == "San Jose, CA PMSA"
drop if name == "Olympia, WA PMSA"
drop if name == "Tacoma, WA PMSA"
drop if name == "Bremerton, WA PMSA"
drop if name == "Hagerstown, MD PMSA"
drop if name == "Baltimore, MD PMSA"

/*
save $data/Replication_new.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/crosswalk/1999county_msa.txt", clear


*Seperate State and County Code
g work = string(countycode, "%12.0f")
g fipstate = real(substr(work, 1, length(work) - 3)) 
g cencty = real(substr(work, -3, 3)) 

drop countycode work v6

g cbsa = msa 

replace msa = pmsa if pmsa != .

keep if cencty == .
drop if name == ""
keep if pmsa == .

keep cbsa name

merge m:1 cbsa using $data/Replication_new.dta
drop _merge

drop if division == .
*/

save $data/Replication_new.dta, replace
