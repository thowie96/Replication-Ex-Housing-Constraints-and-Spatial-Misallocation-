
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

save $data/CBP/CBP8619_new.dta, replace

*Aggregate counties by MSA
merge m:1 cencty fipstate using $crosswalk/1999_county_msa_csa_map_new.dta
drop _merge

collapse (sum) ap emp, by(cbsa year)

*Calculate Wage
g wage = (ap/emp)*1000

drop if year == .
drop if cbs == .

*Convert to Wide format to compare to MorettiHseih
save $data/CBP/CBP8619_new.dta, replace

#delimit ;
local vlist
ap
emp
wage
;
#delimit cr 

reshape wide `vlist', i(cbsa) j(year) 

save $data/CBP/CBP_new.dta, replace
