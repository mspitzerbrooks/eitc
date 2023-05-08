cap log close
global path_mahdi = "//wsl$/Ubuntu/home/mahdi/Documents/eitc"

// bring in data
use "$path_mahdi/Output/cps00010_wide.dta", clear

// defining set of conditions, some of them are being used
global child_t (nchild93>0 & nchild93<9999) 
//|(nchild92>0 & nchild92<2) ///
//| (nchild94>0 & nchild94<2)
global child_c (nchild92==0 |nchild93 == 0| nchild94==0)
global eitc    (eitcpos92+eitcpos93+eitcpos94>0)
global eitc94  (eitcpos94==1)
global eitc93  (eitcpos93==1)
global eitc92  (eitcpos92==1)
global mar     (inlist(marst92,1,2)|inlist(marst93,1,2) | inlist(marst94,1,2))  
global inc     ((adjginc1392<35000|adjginc1393<35000|adjginc1394<35000))  
global inc94   (adjginc1394<12500)
global inc93   (adjginc1393<12500)
global inc92   (adjginc1392<12500)


// some more data cleaning for income variable, and outocme variables
forvalues i = 92/94 {
replace adjginc`i'=. if adjginc`i'<=0 | adjginc`i'==99999999 
replace adjginc13`i'=. if adjginc13`i'<=0 | adjginc13`i'==99999999
//replace ahrsworkt`i'=. if ahrsworkt`i'==99
}

// make variable for less than high school
gen less_hi_schl = 0
replace less_hi_schl = 1 if (educ92<=71|educ93<=71 |educ94<=71 )

// by married
gen married = .
replace married = 1 if $mar
replace married = 0 if !$mar

/*
//Q1 Do we have anyone with income who hasn't filed taxes? answer is no.
tabstat adjginc93 adjginc1393, by(filed93) stat(mean sd min max)

//Q2 Is it the case that someone in the eligibility range has eitcpos93==0? 
// based in the figure 1 in Nr2015 I take the maximum as 40000\
//Conclusion: there are many people in eligibility range, who has not received taxes. 
// I decide to use income as an indicator of "recieving eitc". 
tabulate eitcpos93 if adjginc1393<40000
tabstat adjginc93 adjginc1393, by(eitcpos93) stat(mean sd min max)
codebook adjginc93 if !eitcpos93

//Q3 Income consistency -- defining low income groups 
// want to mkae sure that it is not the case that if someone is in min-credit range 
// for 93, moves far away in the year after.

count if $inc93 & adjginc1394<15000
count if $inc93 & adjginc1394>30000 & adjginc1394 <.

count if adjginc1394 - adjginc1393>1000 & adjginc1394 <.
count if adjginc1394 - adjginc1393<1000 & adjginc1394 <.

count if adjginc1394 - adjginc1393>3000 & adjginc1394 <. & $inc93

br if $inc93 & adjginc1394>30000 & adjginc1394 <.
tabstat adjginc93 adjginc1393, by(filed93) stat(mean sd min max)

sort adjginc94
*/

// new treatment variable
gen treat_did = .
replace treat_did = 1 if $child_t & ($inc92|$inc93|$inc94) & $mar   
replace treat_did = 0 if $child_c & ($inc92|$inc93|$inc94) & $mar  
drop treat
rename treat_did treat
keep if !mi(treat)
tab treat
tab treat, sum(ahrsworkt92) 
tab treat, sum(ahrsworkt93) 
tab treat, sum(ahrsworkt94) 

// Summary statistics for treatment and control cohorts

tabstat ahrsworkt93 ahrsworkt94 adjginc1393 adjginc1394 sex93 married, by(treat) stat(mean n)

tab treat if $eitc93, sum(adjginc1393) 

//Option 1
estpost tabstat ahrsworkt93 ahrsworkt94 adjginc1393 adjginc1394, ///
by(treat) stat(mean sd min max n) columns(statistics) 

esttab using mhd.tex,replace  ///
not nostar unstack nomtitle nonumber nonote noobs ///
label title(Summary statistics \label{tab::mhdstat})
eststo clear

//Option 3
outreg2 ahrsworkt93 using results, word replace sum(log)

//Option 4
bys treat: eststo: estpost summarize ahrsworkt93 ahrsworkt94 adjginc1393 adjginc1394, listwise
esttab using mhdstat.tex, ///
replace cells("mean sd") label nodepvar title(Summary statistics \label{tab::mhdstat})
eststo clear

//Option 4
bys treat: eststo: estpost tabstat ahrsworkt92 ahrsworkt93 ahrsworkt94 adjginc1392 adjginc1393 adjginc1394, ///
stat(mean sd min max n) columns(statistics)
eststo clear

* controls: adjginc sex married nchild less_hi_schl



**************************************************************
**************************************************************
**************************************************************

// reshape long
reshape long
// keep only years of interest
keep if inlist(year,92,93,94) // 92 can be consiedered as a pre-period also, no?

// make post variable
gen post = 0
replace post = 1 if year==94
tab year post


//Option 5
bys treat post: eststo: estpost tabstat ahrsworkt adjginc marst nchild if ahrsworkt!=., ///
stat(mean sd min max n) columns(statistics)
eststo clear


bys post: eststo: estpost tabstat ahrsworkt adjginc if treat == 0 & ahrsworkt!=., ///
stat(mean sd min max n) columns(statistics)
esttab using eitc/mhdstat_cntrl.tex, ///
replace cells("mean(fmt(a3))" sd(par fmt(2))) ///
label nodepvar title(Summary statistics for Control group \label{tab::mhdstat_c})
eststo clear

bys post: eststo: estpost tabstat ahrsworkt adjginc if treat == 1 & ahrsworkt!=., ///
stat(mean sd min max n) columns(statistics)
esttab using eitc/mhdstat_treat.tex, ///
replace cells("mean(fmt(a3))" sd(par fmt(2))) ///
label nodepvar title(Summary statistics for treatment group \label{tab::mhdstat_t})
eststo clear

///cells("mean sd")



// save
isid year cpsidp
qui compress
save "$path_mahdi/Output/cps00010_did.dta", replace

cap log close
