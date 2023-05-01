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

// by gender
gen female94 = .
replace female94 = 1 if sex94==2
replace female94 = 0 if sex94==1
tablist treat2 female94 if !mi(treat2), s(v)

// by married
gen married94 = .
replace married94 = 1 if inlist(marst94,1,2)
replace married94 = 0 if !inlist(marst94,1,2)
tablist treat2 married94 if !mi(treat2), s(v)

// create outcome variables

	// hours worked (intensive margin)
	gen hrs_worked94 = ahrsworkt94

	// worked (extensive margin)
	gen worked94 = 0
	replace worked94 = 1 if !mi(hrs_worked94)

// basic regressions

	eststo clear

	// extensive margin
	eststo: reg worked94 treat2, robust cluster(cpsid94)

	// intensive margin
	eststo: reg hrs_worked94 treat2, robust cluster(cpsid94)

	esttab, tex se
	esttab, se

// only controlling for income	
	local controls adjginc94 

	// extensive margin
	eststo: reg worked94 treat2 `controls', robust cluster(cpsid94)

	// intensive margin
	eststo: reg hrs_worked94 treat2 `controls', robust cluster(cpsid94)

	esttab, tex se
	esttab, se
	
// with all controls
	local controls adjginc94 female94 married94 nchild94

	eststo clear

	// extensive margin
	eststo: reg worked94 treat2 `controls', robust cluster(cpsid94)

	// intensive margin
	eststo: reg hrs_worked94 treat2 `controls', robust cluster(cpsid94)

	esttab, tex se
	esttab, se

// females only
keep if female == 1

// basic regressions

	eststo clear

	// extensive margin
	eststo: reg worked94 treat2, robust cluster(cpsid94)

	// intensive margin
	eststo: reg hrs_worked94 treat2, robust cluster(cpsid94)

	esttab, tex se
	esttab, se

// only controlling for income	
	local controls adjginc94 

	// extensive margin
	eststo: reg worked94 treat2 `controls', robust cluster(cpsid94)

	// intensive margin
	eststo: reg hrs_worked94 treat2 `controls', robust cluster(cpsid94)

	esttab, tex se
	esttab, se
	
// with all controls
	local controls adjginc94 married94 nchild94

	eststo clear

	// extensive margin
	eststo: reg worked94 treat2 `controls', robust cluster(cpsid94)

	// intensive margin
	eststo: reg hrs_worked94 treat2 `controls', robust cluster(cpsid94)

	esttab, tex se
	esttab, se

cap log close
