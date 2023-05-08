cap log close
log using "/Users/matthewspitzer/Desktop/EITC/Programs/25a.10_CreateDiDData.log", replace 

// bring in data
use "/Users/matthewspitzer/Desktop/EITC/Output/cps00010_wide.dta", clear

// new treatment variable
gen treat_did = .
replace treat_did = 1 if inrange(adjginc1394,37160,39763)
replace treat_did = 0 if inrange(adjginc1394,39763,`=39763 + (39763-37160)')
tablist treat treat_did, s(v)
drop treat
rename treat_did treat
keep if !mi(treat)

// restrict to families with at least 2 children
drop if nchild94==1
tab nchild94,m

// reshape long
reshape long

// keep only years of interest
keep if inlist(year,93,94)

// make post variable
gen post = 0
replace post = 1 if year==94
tablist year post, s(v)

// make variable for less than high school
gen less_hi_schl = 0
replace less_hi_schl = 1 if educ<=71

// save
isid year cpsidp
qui compress
save "/Users/matthewspitzer/Desktop/EITC/Output/cps00010_did.dta", replace

cap log close
