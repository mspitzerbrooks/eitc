cap log close
global path_mahdi = "//wsl$/Ubuntu/home/mahdi/Documents/eitc"

// bring in data
use "$path_mahdi/Output/cps00010_wide.dta", clear

// new treatment variable
gen treat_did = .
replace treat_did = 1 if nchild93 > 0 & nchild93 < 99 // alternatively it can be nchild94 (assuming no chnage)
replace treat_did = 0 if nchild93 == 0 // 
tab treat treat_did
drop treat
rename treat_did treat
keep if !mi(treat)

// reshape long
reshape long

// keep only years of interest
keep if inlist(year,93,94) // 92 can be consiedered as a pre-period also, no?

// make post variable
gen post = 0
replace post = 1 if year==94
tab year post

// make variable for less than high school
gen less_hi_schl = 0
replace less_hi_schl = 1 if educ<=71

// save
isid year cpsidp
qui compress
save "$path_mahdi/Output/cps00010_did.dta", replace

cap log close
