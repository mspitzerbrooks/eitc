cap log close
global path_mahdi = "//wsl$/Ubuntu/home/mahdi/Documents/eitc"
log using "$path_mahdi/mahdi_35a.10_DiDRegressions.log", replace 



// bring in data
use "$path_mahdi/Output/cps00010_did.dta", clear

// basic checks
isid year cpsidp
tab treat,m

/*
// create variable just for serial
gen serial = substr(serial_pernum,1,5)
*/

// more missing value cleaning
mvdecode adjginc??, mv(99999)
foreach var of varlist adjginc?? {
	replace `var' = . if `var' < 0
	}

// how many households
distinct cpsid if treat==1
distinct cpsid if treat==0

// by gender
gen female = .
replace female = 1 if sex==2
replace female = 0 if sex==1
tab treat female if !mi(treat), 

// by married
gen married = .
replace married = 1 if inlist(marst,1,2)
replace married = 0 if !inlist(marst,1,2)
tab treat married if !mi(treat), 

// create outcome variables

	// hours worked (intensive margin)
	gen hrs_worked = ahrsworkt

	// worked (extensive margin)
	gen worked = 0
	replace worked = 1 if !mi(hrs_worked)

// create interaction term
gen treat_x_post = treat*post
	
// basic regressions

	eststo clear

	// extensive margin
	eststo: reg worked treat post treat_x_post, robust cluster(cpsid)

	// intensive margin
	eststo: reg hrs_worked  treat post treat_x_post, robust cluster(cpsid)
	

// only controlling for income	
	local controls adjginc 

	// extensive margin
	eststo: reg worked treat post treat_x_post `controls', robust cluster(cpsid)

	// intensive margin
	eststo: reg hrs_worked treat post treat_x_post `controls', robust cluster(cpsid)

	esttab, tex se
	esttab, se
	
// with all controls
	local controls adjginc female married nchild less_hi_schl

	eststo clear

	// extensive margin
	eststo: reg worked treat post treat_x_post `controls', robust cluster(cpsid)

	// intensive margin
	eststo: reg hrs_worked treat post treat_x_post `controls', robust cluster(cpsid)

	esttab, tex se
	esttab, se

forval i = 0/1 {
	
// females/males only
preserve
keep if female == `i'

// basic regressions

	eststo clear

	// extensive margin
	eststo: reg worked treat post treat_x_post, robust cluster(cpsid)

	// intensive margin
	eststo: reg hrs_worked  treat post treat_x_post, robust cluster(cpsid)
	

// only controlling for income	
	local controls adjginc 

	// extensive margin
	eststo: reg worked treat post treat_x_post `controls', robust cluster(cpsid)

	// intensive margin
	eststo: reg hrs_worked treat post treat_x_post `controls', robust cluster(cpsid)

	esttab, tex se
	esttab, se
	
// with all controls
	local controls adjginc female married nchild less_hi_schl

	eststo clear

	// extensive margin
	eststo: reg worked treat post treat_x_post `controls', robust cluster(cpsid)

	// intensive margin
	eststo: reg hrs_worked treat post treat_x_post `controls', robust cluster(cpsid)

	esttab, tex se
	esttab, se
	
restore

}



cap log close
