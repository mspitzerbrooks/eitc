cap log close
log using "/Users/matthewspitzer/Desktop/EITC/Programs/20a.ii_DescriptiveStats.log", replace 

// bring in data
use "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00002.dta", clear

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
keep cpsidp year filestat eitcred

// make sure only one person per year
drop if cpsidp == 0 // figure out what exactly this means
isid cpsidp year

// create 2 digit year variable
tostring year, replace
gen year_2 = substr(year,3,2)
destring year_2, replace
drop year
rename year_2 year
tab year
keep if inlist(year,92,93) // only these two years for now, can expand later

// reshape wide
reshape wide filestat eitcred, i(cpsidp) j(year)
isid cpsid

// now create dummies

	// filed in 1992 
	gen filed92 = 0
	replace filed92 = 1 if filestat92 != 6 & !mi(filestat92)
	tab filed92,m
	
	// filed in 1993
	gen filed93 = 0
	replace filed93 = 1 if filestat93 != 6 & !mi(filestat92)
	tab filed93,m
	
	// nonzero EITC in 1992
	gen eitcpos92 = 0
	replace eitcpos92 = 1 if eitcred92>0 & !mi(eitcred92)
	tab eitcpos92,m
	
	// nonzero EITC in 1993
	gen eitcpos93 = 0
	replace eitcpos93 = 1 if eitcred93>0 & !mi(eitcred93)
	tab eitcpos93,m
	
// keep only people who filed in both years
keep if filed92 == 1 & filed93 == 1

// now tabulate receiving EITC in both years
tablist eitcpos92 eitcpos93, s(v)	
	
exit

*count if filestat != 6 & eitc == 0

foreach year in 1992 1993 {
	gen temp = 1 if year == `year'
	bysort cpsid : egen in_`year' = min(temp)
	drop temp
}
tablist in_1992 in_1993, s(v)

distinct cpsid
distinct cpsid if in_1992==1 & in_1993==1

// new
gen received_eitc = 1 if eitcred > 0 & eitcred < 9999

// old
foreach year in 1992 1993 1994 {
	bysort cpsid year : egen received_eitc_in`year' = min(received_eitc)
}

tablist received_eitc_in*, s(v)
exit

gen temp = filestat!=6 if year == `year'
bysort cpsid : egen filedin_`year' = min(temp)
drop temp


/* treated - 0 eitc in 1992, but positive eitc in 1993 AND filed in both years */
/* control - 0 eitc in 1992, and 0 eitc in 1993 AND filed in both years */

cap log close
