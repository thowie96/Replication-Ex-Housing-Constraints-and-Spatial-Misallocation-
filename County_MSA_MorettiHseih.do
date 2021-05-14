clear all
set maxvar 30000
set more off
 
import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/crosswalk/1999county_msa.txt", clear


drop alt_fips
drop if countycode == .
keep if v6 == .

*The following is to attempt to clean the code for the MSA Boston-Worcester-Lowell-Brockton
replace name = "" if msa == 1122
replace pmsa = 1123 if pmsa == 9240 | pmsa == 4160
replace pmsa = 1123 if pmsa== 1200   | pmsa == 4560 
replace pmsa = 1123 if pmsa == 1120
drop if msa == 1122 & pmsa != 1123
sort msa countycode
quietly by msa countycode:  gen dup = cond(_N==1,0,_n)
drop if dup > 1
drop dup
drop if strpos(name , "(pt.)") 

*Seperate State and County Code
g work = string(countycode, "%12.0f")
g fipstate = real(substr(work, 1, length(work) - 3)) 
g cencty = real(substr(work, -3, 3)) 

*RULE: Use PMSA as identifier of msa, if pmsa is not available use MSA
replace pmsa = msa if pmsa == .
replace msa = pmsa
drop countycode work v6

save $crosswalk/1999_county_msa_csa_map.dta, replace
