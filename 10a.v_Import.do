* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off
cd "/Users/matthewspitzer/Desktop/EITC/Input"

clear
quietly infix              ///
  int     year      1-4    ///
  long    serial    5-9    ///
  byte    month     10-11  ///
  double  cpsid     12-25  ///
  byte    asecflag  26-26  ///
  double  asecwth   27-37  ///
  byte    pernum    38-39  ///
  double  cpsidp    40-53  ///
  double  asecwt    54-64  ///
  byte    empstat   65-66  ///
  double  ftotval   67-76  ///
  double  inctot    77-85  ///
  double  incwage   86-93  ///
  int     eitcred   94-97  ///
  byte    filestat  98-98  ///
  using `"cps_00005.dat"'

replace asecwth  = asecwth  / 10000
replace asecwt   = asecwt   / 10000

format cpsid    %14.0f
format asecwth  %11.4f
format cpsidp   %14.0f
format asecwt   %11.4f
format ftotval  %10.0f
format inctot   %9.0f
format incwage  %8.0f

label var year     `"Survey year"'
label var serial   `"Household serial number"'
label var month    `"Month"'
label var cpsid    `"CPSID, household record"'
label var asecflag `"Flag for ASEC"'
label var asecwth  `"Annual Social and Economic Supplement Household weight"'
label var pernum   `"Person number in sample unit"'
label var cpsidp   `"CPSID, person record"'
label var asecwt   `"Annual Social and Economic Supplement Weight"'
label var empstat  `"Employment status"'
label var ftotval  `"Total family income"'
label var inctot   `"Total personal income"'
label var incwage  `"Wage and salary income"'
label var eitcred  `"Earned income tax credit"'
label var filestat `"Tax filer status"'

label define month_lbl 01 `"January"'
label define month_lbl 02 `"February"', add
label define month_lbl 03 `"March"', add
label define month_lbl 04 `"April"', add
label define month_lbl 05 `"May"', add
label define month_lbl 06 `"June"', add
label define month_lbl 07 `"July"', add
label define month_lbl 08 `"August"', add
label define month_lbl 09 `"September"', add
label define month_lbl 10 `"October"', add
label define month_lbl 11 `"November"', add
label define month_lbl 12 `"December"', add
label values month month_lbl

label define asecflag_lbl 1 `"ASEC"'
label define asecflag_lbl 2 `"March Basic"', add
label values asecflag asecflag_lbl

label define empstat_lbl 00 `"NIU"'
label define empstat_lbl 01 `"Armed Forces"', add
label define empstat_lbl 10 `"At work"', add
label define empstat_lbl 12 `"Has job, not at work last week"', add
label define empstat_lbl 20 `"Unemployed"', add
label define empstat_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_lbl 22 `"Unemployed, new worker"', add
label define empstat_lbl 30 `"Not in labor force"', add
label define empstat_lbl 31 `"NILF, housework"', add
label define empstat_lbl 32 `"NILF, unable to work"', add
label define empstat_lbl 33 `"NILF, school"', add
label define empstat_lbl 34 `"NILF, other"', add
label define empstat_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_lbl 36 `"NILF, retired"', add
label values empstat empstat_lbl

label define filestat_lbl 0 `"No data"'
label define filestat_lbl 1 `"Joint, both less than 65"', add
label define filestat_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_lbl 3 `"Joint, both 65+"', add
label define filestat_lbl 4 `"Head of household"', add
label define filestat_lbl 5 `"Single"', add
label define filestat_lbl 6 `"Nonfiler"', add
label values filestat filestat_lbl

save "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00005.dta"

