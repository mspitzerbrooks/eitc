cap log close
log using "/Users/matthewspitzer/Desktop/EITC/Programs/20a.ii_DescriptiveStats.log", replace 

// bring in data
use "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00002.dta", clear

// create variable to answer:
/* How many people are there who in 1992 
(a) filed taxes (i.e. where not non-filers) and 
(b) received zero EITC but in 1993 (c ) did receive EITC */

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
