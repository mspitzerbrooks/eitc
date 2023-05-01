cap log close
log using "/Users/matthewspitzer/Desktop/EITC/Programs/20a.8_DescriptiveStats.log", replace 

// bring in data
use "/Users/matthewspitzer/Desktop/EITC/Output/cps00008_wide.dta", clear

isid serial_pernum
tab treat,m

// create outcome variables

	// hours worked (intensive margin)
	gen hrs_worked94 = ahrsworkt94

	// worked (extensive margin)
	gen worked94 = 0
	replace worked94 = 1 if !mi(hrs_worked94)

// basic regressions
reg worked94 treat, robust
reg hrs_worked94 treat, robust


cap log close
