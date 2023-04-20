// bring in data
use "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00001.dta", clear

// check level of uniqueness
isid year_1 month_1 serial_1 pernum_1
isid year_2 month_2 serial_2 pernum_2

tablist year_1   year_2,   s(v)
tablist month_1  month_2,  s(v)

tablist cpsid serial_1 serial_2 if _n<=20, s(v) 
	// looks like there are multiple serials for the same cpsid
	// does this mean the same household is interviewed multiple times?


// create dummy for employed (extensive margin)
forval i = 1/2 {
	gen     employed_`i'=0
	replace employed_`i'=1 if inlist(empstat_`i',10,12)
}

// create variable for hours worked (intensive margin)
forval i = 1/2 {
	gen hrs_worked_`i' = ahrsworkt_`i'
	replace hrs_worked_`i' = . if ahrsworkt_`i' == 999
}

// create variable for eitc amount
forval i = 1/2 {
	gen eitc_amount_`i' = eitcred_`i'
	replace eitc_amount_`i' = . if eitcred_`i' == 9999
}

// create variable for number of children
forval i = 1/2 {
	gen num_child_`i' = nchild_`i' 
		// note: includes a category for 9+, effectively topcoding these to 9
}


// look at these variables by year
local stat_choices n mean sd min p25 p50 p75 max
forval i = 1/2{
	foreach name in employed hrs_worked eitc_amount num_child {
		tabstat `name'_`i', stat(`stat_choices') by(year_`i')
	}	
}
	// the values are not the same for a given year across variables. why?
	
// filing status
tab filestat_1
tab filestat_2

save "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00001_constructs.dta", replace
