cap log close
log using "/Users/matthewspitzer/Desktop/EITC/Programs/20a.8_DescriptiveStats.log", replace 

// bring in data
use "/Users/matthewspitzer/Desktop/EITC/Output/cps00008_wide.dta", clear

// basic checks
isid serial_pernum
tab treat,m

// create variable just for serial
gen serial = substr(serial_pernum,1,5)

// more missing value cleaning
mvdecode adjginc??, mv(99999)
foreach var of varlist adjginc?? {
	replace `var' = . if `var' < 0
	}

// more restrictive treatment variable (otherside of max income for EITC)
gen treat2 = treat
replace treat2 = . if adjginc94 > `=39763 + (39763-37160)' & !mi(adjginc94)
replace treat2 = . if adjginc94 < `=37160 - (39763-37160)' & treat==0 // just other side of range
tab treat2
tablist treat treat2, s(v)


// how many households
distinct cpsid94 if treat2==1
distinct cpsid94 if treat2==0

// create outcome variables

	// hours worked (intensive margin)
	gen hrs_worked94 = ahrsworkt94

	// worked (extensive margin)
	gen worked94 = 0
	replace worked94 = 1 if !mi(hrs_worked94)

// basic regressions

// extensive margin
reg worked94 treat2, robust cluster(cpsid94)

// intensive margin
reg hrs_worked94 treat2, robust cluster(cpsid94)


cap log close
