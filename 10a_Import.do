* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
cd "/Users/matthewspitzer/Desktop/EITC/Input"
quietly infix                   ///
  int     year_1       1-4      ///
  int     year_2       5-8      ///
  long    serial_1     9-13     ///
  long    serial_2     14-18    ///
  byte    month_1      19-20    ///
  byte    month_2      21-22    ///
  double  cpsid        23-36    ///
  byte    asecflag_1   37-37    ///
  byte    asecflag_2   38-38    ///
  double  asecwth_1    39-49    ///
  double  asecwth_2    50-60    ///
  byte    pernum_1     61-62    ///
  byte    pernum_2     63-64    ///
  double  cpsidp       65-78    ///
  double  asecwt_1     79-89    ///
  double  asecwt_2     90-100   ///
  byte    nchild_1     101-101  ///
  byte    nchild_2     102-102  ///
  byte    empstat_1    103-104  ///
  byte    empstat_2    105-106  ///
  int     ahrsworkt_1  107-109  ///
  int     ahrsworkt_2  110-112  ///
  int     eitcred_1    113-116  ///
  int     eitcred_2    117-120  ///
  byte    filestat_1   121-121  ///
  byte    filestat_2   122-122  ///
  using `"cps_00001.dat"'

replace asecwth_1   = asecwth_1   / 10000
replace asecwth_2   = asecwth_2   / 10000
replace asecwt_1    = asecwt_1    / 10000
replace asecwt_2    = asecwt_2    / 10000

format cpsid       %14.0f
format asecwth_1   %11.4f
format asecwth_2   %11.4f
format cpsidp      %14.0f
format asecwt_1    %11.4f
format asecwt_2    %11.4f

label var year_1      `"Survey year"'
label var year_2      `"Survey year"'
label var serial_1    `"Household serial number"'
label var serial_2    `"Household serial number"'
label var month_1     `"Month"'
label var month_2     `"Month"'
label var cpsid       `"CPSID, household record"'
label var asecflag_1  `"Flag for ASEC"'
label var asecflag_2  `"Flag for ASEC"'
label var asecwth_1   `"Annual Social and Economic Supplement Household weight"'
label var asecwth_2   `"Annual Social and Economic Supplement Household weight"'
label var pernum_1    `"Person number in sample unit"'
label var pernum_2    `"Person number in sample unit"'
label var cpsidp      `"CPSID, person record"'
label var asecwt_1    `"Annual Social and Economic Supplement Weight"'
label var asecwt_2    `"Annual Social and Economic Supplement Weight"'
label var nchild_1    `"Number of own children in household"'
label var nchild_2    `"Number of own children in household"'
label var empstat_1   `"Employment status"'
label var empstat_2   `"Employment status"'
label var ahrsworkt_1 `"Hours worked last week"'
label var ahrsworkt_2 `"Hours worked last week"'
label var eitcred_1   `"Earned income tax credit"'
label var eitcred_2   `"Earned income tax credit"'
label var filestat_1  `"Tax filer status"'
label var filestat_2  `"Tax filer status"'

label define month_1_lbl 01 `"January"'
label define month_1_lbl 02 `"February"', add
label define month_1_lbl 03 `"March"', add
label define month_1_lbl 04 `"April"', add
label define month_1_lbl 05 `"May"', add
label define month_1_lbl 06 `"June"', add
label define month_1_lbl 07 `"July"', add
label define month_1_lbl 08 `"August"', add
label define month_1_lbl 09 `"September"', add
label define month_1_lbl 10 `"October"', add
label define month_1_lbl 11 `"November"', add
label define month_1_lbl 12 `"December"', add
label values month_1 month_1_lbl

label define month_2_lbl 01 `"January"'
label define month_2_lbl 02 `"February"', add
label define month_2_lbl 03 `"March"', add
label define month_2_lbl 04 `"April"', add
label define month_2_lbl 05 `"May"', add
label define month_2_lbl 06 `"June"', add
label define month_2_lbl 07 `"July"', add
label define month_2_lbl 08 `"August"', add
label define month_2_lbl 09 `"September"', add
label define month_2_lbl 10 `"October"', add
label define month_2_lbl 11 `"November"', add
label define month_2_lbl 12 `"December"', add
label values month_2 month_2_lbl

label define asecflag_1_lbl 1 `"ASEC"'
label define asecflag_1_lbl 2 `"March Basic"', add
label values asecflag_1 asecflag_1_lbl

label define asecflag_2_lbl 1 `"ASEC"'
label define asecflag_2_lbl 2 `"March Basic"', add
label values asecflag_2 asecflag_2_lbl

label define nchild_1_lbl 0 `"0 children present"'
label define nchild_1_lbl 1 `"1 child present"', add
label define nchild_1_lbl 2 `"2"', add
label define nchild_1_lbl 3 `"3"', add
label define nchild_1_lbl 4 `"4"', add
label define nchild_1_lbl 5 `"5"', add
label define nchild_1_lbl 6 `"6"', add
label define nchild_1_lbl 7 `"7"', add
label define nchild_1_lbl 8 `"8"', add
label define nchild_1_lbl 9 `"9+"', add
label values nchild_1 nchild_1_lbl

label define nchild_2_lbl 0 `"0 children present"'
label define nchild_2_lbl 1 `"1 child present"', add
label define nchild_2_lbl 2 `"2"', add
label define nchild_2_lbl 3 `"3"', add
label define nchild_2_lbl 4 `"4"', add
label define nchild_2_lbl 5 `"5"', add
label define nchild_2_lbl 6 `"6"', add
label define nchild_2_lbl 7 `"7"', add
label define nchild_2_lbl 8 `"8"', add
label define nchild_2_lbl 9 `"9+"', add
label values nchild_2 nchild_2_lbl

label define empstat_1_lbl 00 `"NIU"'
label define empstat_1_lbl 01 `"Armed Forces"', add
label define empstat_1_lbl 10 `"At work"', add
label define empstat_1_lbl 12 `"Has job, not at work last week"', add
label define empstat_1_lbl 20 `"Unemployed"', add
label define empstat_1_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_1_lbl 22 `"Unemployed, new worker"', add
label define empstat_1_lbl 30 `"Not in labor force"', add
label define empstat_1_lbl 31 `"NILF, housework"', add
label define empstat_1_lbl 32 `"NILF, unable to work"', add
label define empstat_1_lbl 33 `"NILF, school"', add
label define empstat_1_lbl 34 `"NILF, other"', add
label define empstat_1_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_1_lbl 36 `"NILF, retired"', add
label values empstat_1 empstat_1_lbl

label define empstat_2_lbl 00 `"NIU"'
label define empstat_2_lbl 01 `"Armed Forces"', add
label define empstat_2_lbl 10 `"At work"', add
label define empstat_2_lbl 12 `"Has job, not at work last week"', add
label define empstat_2_lbl 20 `"Unemployed"', add
label define empstat_2_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_2_lbl 22 `"Unemployed, new worker"', add
label define empstat_2_lbl 30 `"Not in labor force"', add
label define empstat_2_lbl 31 `"NILF, housework"', add
label define empstat_2_lbl 32 `"NILF, unable to work"', add
label define empstat_2_lbl 33 `"NILF, school"', add
label define empstat_2_lbl 34 `"NILF, other"', add
label define empstat_2_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_2_lbl 36 `"NILF, retired"', add
label values empstat_2 empstat_2_lbl

label define filestat_1_lbl 0 `"No data"'
label define filestat_1_lbl 1 `"Joint, both less than 65"', add
label define filestat_1_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_1_lbl 3 `"Joint, both 65+"', add
label define filestat_1_lbl 4 `"Head of household"', add
label define filestat_1_lbl 5 `"Single"', add
label define filestat_1_lbl 6 `"Nonfiler"', add
label values filestat_1 filestat_1_lbl

label define filestat_2_lbl 0 `"No data"'
label define filestat_2_lbl 1 `"Joint, both less than 65"', add
label define filestat_2_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_2_lbl 3 `"Joint, both 65+"', add
label define filestat_2_lbl 4 `"Head of household"', add
label define filestat_2_lbl 5 `"Single"', add
label define filestat_2_lbl 6 `"Nonfiler"', add
label values filestat_2 filestat_2_lbl

save cps00001.dta
