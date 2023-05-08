cap log close
global path_mahdi = "//wsl$/Ubuntu/home/mahdi/Documents/eitc"
cd $mahdi

log using "$path_mahdi/mahdi_35a.10_DiDRegressions_marstANDadjgincBounded.log", replace 


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
//mvdecode adjginc??, mv(99999)
//foreach var of varlist adjginc?? {
//	replace `var' = . if `var' < 0
//	}

// how many households
distinct cpsid if treat==1
distinct cpsid if treat==0

// by gender
gen female = .
replace female = 1 if sex==2
replace female = 0 if sex==1
tab treat female if !mi(treat), 



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
	//eststo: reg worked treat post treat_x_post, robust cluster(cpsid)

	// intensive margin
	eststo: reg hrs_worked  treat post treat_x_post, robust cluster(cpsid)
	eststo clear

/*
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
*/
forval i = 0/1 {
	
// females/males only
preserve
keep if female == `i'

// basic regressions

	eststo clear

	// extensive margin
	//eststo: reg worked treat post treat_x_post, robust cluster(cpsid)

	// intensive margin
	eststo mhd0_`i': reg hrs_worked  treat post treat_x_post, robust cluster(cpsid)


// only controlling for income	
	local controls adjginc 

	// extensive margin
	//eststo mhd_ex_`i': reg worked treat post treat_x_post `controls', robust cluster(cpsid)

	// intensive margin
	eststo mhd1_`i': reg hrs_worked treat post treat_x_post `controls', robust cluster(cpsid)
		
// with all controls
	local controls adjginc nchild less_hi_schl

	// extensive margin
	//eststo: reg worked treat post treat_x_post `controls', robust cluster(cpsid)

	// intensive margin
	eststo mhd2_`i': reg hrs_worked treat post treat_x_post `controls', robust cluster(cpsid)
	esttab, tex se
	esttab, se

	esttab mhd0_`i' mhd1_`i' mhd2_`i'  using eitc/mhd_`i'.tex, replace tex se title(Main Result for female ==`i' \label{tab::mhd_`i'})
eststo clear
*/	
restore

}



cap log close
