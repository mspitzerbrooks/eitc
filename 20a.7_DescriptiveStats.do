cap log close
log using "/Users/matthewspitzer/Desktop/EITC/Programs/20a.7_DescriptiveStats.log", replace 

// bring in data
use "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00007.dta", clear

// clean missing values
mvdecode _all, mv(9999)

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

// keep only variables needed
*keep cpsidp year filestat eitcred adjginc nchild

// make sure only one person per year
// create dummy ID for people with cpsid of 0 
	/* documentation:
	Respondents who are part of the ASEC oversample (as indicated by ASECOVERP) 
	have a CPSIDP value of 0. For further information about the relationship 
	between the March Basic and the ASEC, 
	please see our additional documentation.
	*/
set seed 2023
sort cpsidp year
gen dummy_id = _n
replace cpsid = dummy_id if cpsidp == 0
drop dummy_id
isid cpsidp year


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


// reshape wide
reshape wide filestat eitcred adjginc adjginc13 nchild sex marst gqtype relate, i(cpsidp) j(year)
isid cpsid

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
	tablist eitcpos92 eitcpos93, s(v)
restore

// 2 year comparison - 1993 and 1994
preserve
	// keep only people who filed in both years
	keep if filed93 == 1 & filed94 == 1

	// now tabulate receiving EITC in both years
	tablist eitcpos93 eitcpos94, s(v)
restore

// define treatment variable
gen treat = .
replace treat = 1 if filed93 == 1 & filed94 == 1 & eitcpos93 == 0 & eitcpos94 == 1
replace treat = 0 if filed93 == 1 & filed94 == 1 & eitcpos93 == 0 & eitcpos94 == 0

// get rid of individuals with no children
count if nchild94==0 & treat==1 // only 9 or so
drop if nchild94==0

exit

// investigation about characteristics of treatment group and control group

// question - what is meaning of EITC for joint filers? (see data doc)

// characteristics of treatment group
	// number of children
	// married vs not
	// women vs not

// who are newly eligible people in 1994? 
/* i.e. how many of the 0 to 1s are newly eligible vs 
getting EITC for another reason (eg change in income)? */

cap log close
