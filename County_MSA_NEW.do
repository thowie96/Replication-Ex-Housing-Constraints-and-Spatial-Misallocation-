

clear all
set maxvar 30000
set more off
 
import delimited using "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/crosswalk/1999county_msa.txt", clear


drop alt_fips
drop if countycode == .
keep if v6 == .


*Seperate State and County Code
g work = string(countycode, "%12.0f")
g fipstate = real(substr(work, 1, length(work) - 3)) 
g cencty = real(substr(work, -3, 3)) 

drop countycode work v6

g cbsa = msa
drop msa pmsa city_town


sort fipstate cencty 
quietly by fipstate cencty:  gen dup = cond(_N==1,0,_n)
keep if dup <= 1
drop dup

save $crosswalk/1999_county_msa_csa_map_new.dta, replace
