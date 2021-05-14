

clear all
set maxvar 30000
set more off
 
 
*******************************************************************************
*This file uses the County_MSA_MorettiHseih Mapping replication that i built using 
*the 1999 CB Historical Dilineation of mapping from county to MSA to aggregate 
*payroll and employment for each MSA. I then compare my estimates to MorrettiHseih
*for the years 1986-2009, as those are the only dates I have available in relation 
* to MorettiHseih.
*******************************************************************************
 
/*
import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP86co.txt", clear

keep if sic == "----"

save $data/CBP/CBP86.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP87co.txt", clear

keep if sic == "----"

save $data/CBP/CBP87.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP88co.txt", clear

keep if sic == "----"

save $data/CBP/CBP88.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP89co.txt", clear

keep if sic == "----"

save $data/CBP/CBP89.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP90co.txt", clear

keep if sic == "----"

save $data/CBP/CBP90.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP91co.txt", clear

keep if sic == "----"

save $data/CBP/CBP91.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP92co.txt", clear

keep if sic == "----"

save $data/CBP/CBP92.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP93co.txt", clear

keep if sic == "----"

save $data/CBP/CBP93.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP94co.txt", clear

keep if sic == "----"

save $data/CBP/CBP94.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP95co.txt", clear

keep if sic == "----"

save $data/CBP/CBP95.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP96co.txt", clear

keep if sic == "----"

save $data/CBP/CBP96.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP97co.txt", clear

keep if sic == "----"

save $data/CBP/CBP97.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP98co.txt", clear

keep if naics == "------"

save $data/CBP/CBP98.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP99co.txt", clear

keep if naics == "------"

save $data/CBP/CBP99.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP00co.txt", clear

keep if naics == "------"

save $data/CBP/CBP00.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP01co.txt", clear

keep if naics == "------"

save $data/CBP/CBP01.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP02co.txt", clear

keep if naics == "------"

save $data/CBP/CBP02.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP03co.txt", clear

keep if naics == "------"

save $data/CBP/CBP03.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP04co.txt", clear

keep if naics == "------"

save $data/CBP/CBP04.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP05co.txt", clear

keep if naics == "------"

save $data/CBP/CBP05.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP06co.txt", clear

keep if naics == "------"

save $data/CBP/CBP06.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP07co.txt", clear

keep if naics == "------"

save $data/CBP/CBP07.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP08co.txt", clear

keep if naics == "------"

save $data/CBP/CBP08.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP09co.txt", clear

keep if naics == "------"

save $data/CBP/CBP09.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP10co.txt", clear

keep if naics == "------"

save $data/CBP/CBP10.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP11co.txt", clear

keep if naics == "------"

save $data/CBP/CBP11.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP12co.txt", clear

keep if naics == "------"

save $data/CBP/CBP12.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP13co.txt", clear

keep if naics == "------"

save $data/CBP/CBP13.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP14co.txt", clear

keep if naics == "------"

save $data/CBP/CBP14.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP15co.txt", clear

keep if naics == "------"

save $data/CBP/CBP15.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP16co.txt", clear

keep if naics == "------"

save $data/CBP/CBP16.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP17co.txt", clear

keep if naics == "------"

save $data/CBP/CBP17.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP18co.txt", clear

keep if naics == "------"

save $data/CBP/CBP18.dta, replace

import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data/CBP/CBP19co.txt", clear

keep if naics == "------"

save $data/CBP/CBP19.dta, replace



use $data/CBP/CBP86.dta, clear
g year = 1986
save $data/CBP/CBP86.dta, replace
use $data/CBP/CBP87.dta, clear
g year = 1987
save $data/CBP/CBP87.dta, replace
use $data/CBP/CBP88.dta, clear
g year = 1988
save $data/CBP/CBP88.dta, replace
use $data/CBP/CBP89.dta, clear
g year = 1989
save $data/CBP/CBP89.dta, replace
use $data/CBP/CBP90.dta, clear
g year = 1990
save $data/CBP/CBP90.dta, replace
use $data/CBP/CBP91.dta, clear
g year = 1991
save $data/CBP/CBP91.dta, replace
use $data/CBP/CBP92.dta, clear
g year = 1992
save $data/CBP/CBP92.dta, replace
use $data/CBP/CBP93.dta, clear
g year = 1993
save $data/CBP/CBP93.dta, replace
use $data/CBP/CBP94.dta, clear
g year = 1994
save $data/CBP/CBP94.dta, replace
use $data/CBP/CBP95.dta, clear
g year = 1995
save $data/CBP/CBP95.dta, replace
use $data/CBP/CBP96.dta, clear
g year = 1996
save $data/CBP/CBP96.dta, replace
use $data/CBP/CBP97.dta, clear
g year = 1997
save $data/CBP/CBP97.dta, replace
use $data/CBP/CBP98.dta, clear
g year = 1998
save $data/CBP/CBP98.dta, replace
use $data/CBP/CBP99.dta, clear
g year = 1999
save $data/CBP/CBP99.dta, replace
use $data/CBP/CBP00.dta, clear
g year = 2000
save $data/CBP/CBP00.dta, replace
use $data/CBP/CBP01.dta, clear
g year = 2001
save $data/CBP/CBP01.dta, replace
use $data/CBP/CBP02.dta, clear
g year = 2002
save $data/CBP/CBP02.dta, replace
use $data/CBP/CBP03.dta, clear
g year = 2003
save $data/CBP/CBP03.dta, replace
use $data/CBP/CBP04.dta, clear
g year = 2004
save $data/CBP/CBP04.dta, replace
use $data/CBP/CBP05.dta, clear
g year = 2005
save $data/CBP/CBP05.dta, replace
use $data/CBP/CBP06.dta, clear
g year = 2006
save $data/CBP/CBP06.dta, replace
use $data/CBP/CBP07.dta, clear
g year = 2007
save $data/CBP/CBP07.dta, replace
use $data/CBP/CBP08.dta, clear
g year = 2008
save $data/CBP/CBP08.dta, replace
use $data/CBP/CBP09.dta, clear
g year = 2009
save $data/CBP/CBP09.dta, replace
use $data/CBP/CBP10.dta, clear
g year = 2010
save $data/CBP/CBP10.dta, replace
use $data/CBP/CBP11.dta, clear
g year = 2011
save $data/CBP/CBP11.dta, replace
use $data/CBP/CBP12.dta, clear
g year = 2012
save $data/CBP/CBP12.dta, replace
use $data/CBP/CBP13.dta, clear
g year = 2013
save $data/CBP/CBP13.dta, replace
use $data/CBP/CBP14.dta, clear
g year = 2014
save $data/CBP/CBP14.dta, replace
use $data/CBP/CBP15.dta, clear
g year = 2015
save $data/CBP/CBP15.dta, replace
use $data/CBP/CBP16.dta, clear
g year = 2016
save $data/CBP/CBP16.dta, replace
use $data/CBP/CBP17.dta, clear
g year = 2017
save $data/CBP/CBP17.dta, replace
use $data/CBP/CBP18.dta, clear
g year = 2018
save $data/CBP/CBP18.dta, replace
use $data/CBP/CBP19.dta, clear
g year = 2019
save $data/CBP/CBP19.dta, replace
*/

use $data/CBP/CBP86.dta, clear
merge m:1 cencty fipstate year using $data/CBP/CBP87.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP88.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP89.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP90.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP91.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP92.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP93.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP94.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP95.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP96.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP97.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP98.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP99.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP00.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP01.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP02.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP03.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP04.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP05.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP06.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP07.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP08.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP09.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP10.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP11.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP12.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP13.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP14.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP15.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP16.dta
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP17.dta, force
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP18.dta, force
drop _merge
merge m:1 cencty fipstate year using $data/CBP/CBP19.dta, force
drop _merge


sort fipstate cencty year
save $data/CBP/CBP8619_all.dta, replace

*IGNORE THIS
/*
 A 0-19
B 20-99
C 100-249
 E 250-499
 F 500-999
 G 1,000-2,499
H 2,500-4,999
I 5,000-9,999
J 10,000-24,999
K 25,000-49,999
L 50,000-99,999
 M 100,000 or More

replace emp = 10 if empflag == "A"
replace emp = 55 if empflag == "B"
replace emp = 175 if empflag == "C"
replace emp = 375 if empflag == "E"
replace emp = 1750 if empflag == "G"
replace emp = 3750 if empflag == "H"
replace emp = 7500 if empflag == "I"
replace emp = 17500 if empflag == "J"
replace emp = 37500 if empflag == "K"
replace emp = 75000 if empflag == "L"
replace emp = 100000 if empflag == "M"

*keep if sic == "098/" | sic == "179/" |sic == "149/" | sic == "399/" | sic == "497/" | sic == "519/" | sic == "599/" |sic == "679/" | sic == "899/"

*drop if sic == "07--" | sic == "10--" |  sic =="15--" |  sic =="20--" |  sic =="40--" |  sic =="50--" |  sic =="52--" |  sic =="60--" |  sic =="70--" | sic =="99--" |sic == "098/" | sic == "179/" |sic == "149/" | sic == "399/" | sic == "497/" | sic == "519/" | sic == "599/" |sic == "679/" | sic == "899/" | sic == "----"


g gov = 0
replace gov = 1 if sic == "098/" | sic == "179/" |sic == "149/" | sic == "399/" | sic == "497/" | sic == "519/" | sic == "599/" |sic == "679/" | sic == "899/"

egen gov_emp = total(emp), by(gov fipstate cencty)
g gov_emp2 = gov_emp if gov == 1
egen gov_empmean = mean(gov_emp2), by(fipstate cencty)

drop gov_emp gov_emp2

replace emp = emp-gov_empmean
*/


*Adjust Payroll for Inflation
import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/data/inflation.txt", clear
gen first = index if year == 1986
egen base = mean(first)
replace index = index/base
save $data/inflation.dta, replace 

use $data/CBP/CBP8619_all.dta, clear

merg m:1 year using $data/inflation.dta
drop _merge

replace ap = 1.5*ap/index


*Aggregate counties by MSA
merge m:m cencty fipstate using $crosswalk/1999_county_msa_csa_map.dta
drop _merge

collapse (sum) ap emp, by(msa year)

*Calculate Wage
g wage = (ap/emp)*1000

rename wage wage_mine
rename ap ap_mine
rename emp emp_mine

drop if year == .


*Convert to Wide format to compare to MorettiHseih
save $data/CBP/CBP8619.dta, replace

#delimit ;
local vlist
ap_mine
emp_mine
wage_mine
;
#delimit cr 

reshape wide `vlist', i(msa) j(year) 

save $data/CBP/CBP_rep.dta, replace


*Merge with MorettiHseih
use $base_folder/data3.dta, clear

merge m:1 msa using $data/CBP/CBP_rep.dta
drop _merge

**************************************************************************
*Here I take the difference between MorettiHseih employment and my employment 
*calculation. Here The numbers are almost exact except for a few cases (Boston
*Washington DC, Charlotte, Columbus AL-GA, Lynchburg, Norfolk, Roanoke) 
**************************************************************************
 g emp_1986_1987 = (emp_mine1986+emp_mine1987)/2
 g emp_2008_2009 = (emp_mine2008+emp_mine2009)/2
 g emp_2018_2019 = (emp_mine2018+emp_mine2019)/2

forvalues i = 1986/2007{
	g difference_emp_`i' = emp`i'-emp_mine`i'
}

g difference_emp_2009 = emp2009-emp_2008_2009


/*
forvalues i = 1986/2007{
	drop difference_emp_`i' 
}

**************************************************************************
*Here I do the same comparison for payroll. The difference here seems to be a 
*time varying constant, most likely inflation. Need to convert back to nominal
*terms
**************************************************************************

forvalues i = 1986/2007{
	g ratio_ap_`i' = ap`i'/ap_mine`i'
}

*scatter wage1986 wage_mine1986
*scatter wage2007 wage_mine2007
/*
forvalues i = 1986/2007{
	drop ratio_ap_`i' 
}


twoway (scatter emp1986 emp) (line emp emp)
