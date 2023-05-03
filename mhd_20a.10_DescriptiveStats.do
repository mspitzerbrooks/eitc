cap log close
global path_mahdi = "//wsl$/Ubuntu/home/mahdi/Documents/eitc"

// bring in data
use "$path_mahdi/Intermediate/cps00010.dta", clear

// keep only years of interest 
	// (the rest are for John to do year-by-year comparisons)
keep if inlist(year,1992,1993,1994)
	
// clean missing values
qui ds
local all_vars "`r(varlist)'"
local serial_var serial // don't clean this ID variable
local mvdecode_vars : list all_vars - serial_var
di "`mvdecode_vars'"
mvdecode `mvdecode_vars', mv(9999)
mvdecode `mvdecode_vars', mv(999)

// create variable to answer:
/* How many people are there such that:
(a) in 1992, filed taxes (i.e. were not non-filers) and did not receive EITC
(b) in 1993, filed and received some non-zero amount of EITC */

/* plan:
clean missing values
create year variable with just last two digits
reshape the data wide, using this year variable
only keep the following variables: cpsid filestat eitc
now data will be at cpsid (household) level
create four variables:
- filed 1992 dummy
- filed 1993 dummy
- nonzero EITC 1992 dummy
- nonzero EITC 1993 dummy
tabulate these four
*/

// check level of uniqueness
drop if cpsidp == 0 // can't use these (see data doc for why)
isid year cpsidp


// create 2 digit year variable
tostring year, replace
gen year_2 = substr(year,3,2)
destring year_2, replace
drop year
rename year_2 year
tab year
keep if inlist(year,92,93,94) // only these two years for now, can expand later

// create variable for adjusted gross income in 2013 dollars
	// (for comparison with table in paper)
gen adjginc13 = 1.58*adjginc // rate from BLS March 1994 to March 2013

// keep only variables needed
local keep_vars cpsid year cpsidp educ filestat eitcred adjginc adjginc13 nchild sex marst gqtype relate ahrsworkt majoract intenfwk
keep `keep_vars'

local id_vars year cpsidp

local reshape_vars : list keep_vars - id_vars

// reshape wide
reshape wide `reshape_vars', i(cpsidp) j(year)
isid cpsidp

// now create dummies

	// filed in 1992 
	gen filed92 = 0
	replace filed92 = 1 if filestat92 != 6 & !mi(filestat92)
	tab filed92,m
	
	// filed in 1993
	gen filed93 = 0
	replace filed93 = 1 if filestat93 != 6 & !mi(filestat93)
	tab filed93,m
	
	// filed in 1994
	gen filed94 = 0
	replace filed94 = 1 if filestat94 != 6 & !mi(filestat94)
	tab filed94,m
	
	// nonzero EITC in 1992
	gen eitcpos92 = 0
	replace eitcpos92 = 1 if eitcred92>0 & !mi(eitcred92)
	tab eitcpos92,m
	
	// nonzero EITC in 1993
	gen eitcpos93 = 0
	replace eitcpos93 = 1 if eitcred93>0 & !mi(eitcred93)
	tab eitcpos93,m
	
	// nonzero EITC in 1994
	gen eitcpos94 = 0
	replace eitcpos94 = 1 if eitcred94>0 & !mi(eitcred94)
	tab eitcpos94,m

// comparisons across years

count if filed92 == 1 & filed93 == 1 & filed94 == 1 // noone in all three years
	
// 2 year comparison - 1992 and 1993
preserve
	// keep only people who filed in both years
	keep if filed92 == 1 & filed93 == 1

	// now tabulate receiving EITC in both years
	tab eitcpos92 eitcpos93, 
restore

// 2 year comparison - 1993 and 1994
preserve
	// keep only people who filed in both years
	keep if filed93 == 1 & filed94 == 1

	// now tabulate receiving EITC in both years
	tab eitcpos93 eitcpos94, 
restore

// define treatment variable
gen treat = .
replace treat = 1 if filed93 == 1 & filed94 == 1 & eitcpos93 == 0 & eitcpos94 == 1
replace treat = 0 if filed93 == 1 & filed94 == 1 & eitcpos93 == 0 & eitcpos94 == 0
tab treat,m

// get rid of individuals with no children
//count if nchild94==0 & treat==1 // only 17 or so
//drop if nchild94==0

// check whether treated because newly eligible
	// who are newly eligible people in 1994? 
	/* i.e. how many of the 0 to 1s are newly eligible vs 
	getting EITC for another reason (eg change in income)? */
gen newly_eligible = 0
replace newly_eligible = 1 if adjginc1393>37160 & !mi(adjginc1393) & adjginc1394<39763 	
// #s from Nichols and Rothstein NBER WP 2015 Table 1
	// q - should this use 94 var for both years or 93 var for one of the years?
tab treat newly_eligible , 

// get rid of people treated not because newly eligible
replace treat = . if newly_eligible == 0 & treat == 1

tab treat,m 

// investigation about characteristics of treatment group and control group

// characteristics of treatment group
	// number of children 
	tab nchild94 if treat==1
	tab nchild94 if treat==0
	
	// married vs not
	tab marst94 if treat==1
	tab marst94 if treat==0
	
	// women vs not
	tab sex94 if treat==1
	tab sex94 if treat==0

// keep only treatment and control group
//keep if !mi(treat)

// final diagnostics
count
qui compress
isid cpsidp

// save the data
save "$path_mahdi/Output/cps00010_wide.dta", replace

cap log close
