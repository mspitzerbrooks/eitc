

* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
cd "/Users/matthewspitzer/Desktop/EITC/Input"

quietly infix                        ///
  int     year              1-4      ///
  long    serial            5-9      ///
  byte    month             10-11    ///
  double  cpsid             12-25    ///
  byte    asecflag          26-26    ///
  double  asecwth           27-37    ///
  byte    pernum            38-39    ///
  double  cpsidp            40-53    ///
  double  asecwt            54-64    ///
  byte    nchild            65-65    ///
  byte    empstat           66-67    ///
  int     ahrsworkt         68-70    ///
  byte    qempstat          71-71    ///
  byte    qahrsworkt        72-73    ///
  double  marbasecidp       74-83    ///
  int     eitcred           84-87    ///
  byte    filestat          88-88    ///
  byte    nchild_head       89-89    ///
  byte    nchild_mom        90-90    ///
  byte    nchild_mom2       91-91    ///
  byte    empstat_head      92-93    ///
  byte    empstat_mom       94-95    ///
  byte    empstat_mom2      96-97    ///
  int     ahrsworkt_head    98-100   ///
  int     ahrsworkt_mom     101-103  ///
  int     ahrsworkt_mom2    104-106  ///
  byte    qempstat_head     107-107  ///
  byte    qempstat_mom      108-108  ///
  byte    qempstat_mom2     109-109  ///
  byte    qahrsworkt_head   110-111  ///
  byte    qahrsworkt_mom    112-113  ///
  byte    qahrsworkt_mom2   114-115  ///
  double  marbasecidp_head  116-125  ///
  double  marbasecidp_mom   126-135  ///
  double  marbasecidp_mom2  136-145  ///
  int     eitcred_head      146-149  ///
  int     eitcred_mom       150-153  ///
  int     eitcred_mom2      154-157  ///
  byte    filestat_head     158-158  ///
  byte    filestat_mom      159-159  ///
  byte    filestat_mom2     160-160  ///
  using `"cps_00002.dat"'

replace asecwth          = asecwth          / 10000
replace asecwt           = asecwt           / 10000

format cpsid            %14.0f
format asecwth          %11.4f
format cpsidp           %14.0f
format asecwt           %11.4f
format marbasecidp      %10.0f
format marbasecidp_head %10.0f
format marbasecidp_mom  %10.0f
format marbasecidp_mom2 %10.0f

label var year             `"Survey year"'
label var serial           `"Household serial number"'
label var month            `"Month"'
label var cpsid            `"CPSID, household record"'
label var asecflag         `"Flag for ASEC"'
label var asecwth          `"Annual Social and Economic Supplement Household weight"'
label var pernum           `"Person number in sample unit"'
label var cpsidp           `"CPSID, person record"'
label var asecwt           `"Annual Social and Economic Supplement Weight"'
label var nchild           `"Number of own children in household"'
label var empstat          `"Employment status"'
label var ahrsworkt        `"Hours worked last week"'
label var qempstat         `"Data quality flag for EMPSTAT"'
label var qahrsworkt       `"Data quality flag for AHRSWORKT"'
label var marbasecidp      `"Unique identifier for linking March Basic to ASEC"'
label var eitcred          `"Earned income tax credit"'
label var filestat         `"Tax filer status"'
label var nchild_head      `"Number of own children in household [of Location of householder]"'
label var nchild_mom       `"Number of own children in household [of Person number of first mother (from prog"'
label var nchild_mom2      `"Number of own children in household [of Person number of second mother (from pro"'
label var empstat_head     `"Employment status [of Location of householder]"'
label var empstat_mom      `"Employment status [of Person number of first mother (from programming)]"'
label var empstat_mom2     `"Employment status [of Person number of second mother (from programming)]"'
label var ahrsworkt_head   `"Hours worked last week [of Location of householder]"'
label var ahrsworkt_mom    `"Hours worked last week [of Person number of first mother (from programming)]"'
label var ahrsworkt_mom2   `"Hours worked last week [of Person number of second mother (from programming)]"'
label var qempstat_head    `"Data quality flag for EMPSTAT [of Location of householder]"'
label var qempstat_mom     `"Data quality flag for EMPSTAT [of Person number of first mother (from programmin"'
label var qempstat_mom2    `"Data quality flag for EMPSTAT [of Person number of second mother (from programmi"'
label var qahrsworkt_head  `"Data quality flag for AHRSWORKT [of Location of householder]"'
label var qahrsworkt_mom   `"Data quality flag for AHRSWORKT [of Person number of first mother (from programm"'
label var qahrsworkt_mom2  `"Data quality flag for AHRSWORKT [of Person number of second mother (from program"'
label var marbasecidp_head `"Unique identifier for linking March Basic to ASEC [of Location of householder]"'
label var marbasecidp_mom  `"Unique identifier for linking March Basic to ASEC [of Person number of first mot"'
label var marbasecidp_mom2 `"Unique identifier for linking March Basic to ASEC [of Person number of second mo"'
label var eitcred_head     `"Earned income tax credit [of Location of householder]"'
label var eitcred_mom      `"Earned income tax credit [of Person number of first mother (from programming)]"'
label var eitcred_mom2     `"Earned income tax credit [of Person number of second mother (from programming)]"'
label var filestat_head    `"Tax filer status [of Location of householder]"'
label var filestat_mom     `"Tax filer status [of Person number of first mother (from programming)]"'
label var filestat_mom2    `"Tax filer status [of Person number of second mother (from programming)]"'

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

label define nchild_lbl 0 `"0 children present"'
label define nchild_lbl 1 `"1 child present"', add
label define nchild_lbl 2 `"2"', add
label define nchild_lbl 3 `"3"', add
label define nchild_lbl 4 `"4"', add
label define nchild_lbl 5 `"5"', add
label define nchild_lbl 6 `"6"', add
label define nchild_lbl 7 `"7"', add
label define nchild_lbl 8 `"8"', add
label define nchild_lbl 9 `"9+"', add
label values nchild nchild_lbl

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

label define qempstat_lbl 0 `"No change or children or armed forces"'
label define qempstat_lbl 1 `"Value to blank"', add
label define qempstat_lbl 2 `"Blank to value"', add
label define qempstat_lbl 3 `"Value to value"', add
label define qempstat_lbl 4 `"Allocated"', add
label define qempstat_lbl 5 `"Blank to allocated value"', add
label define qempstat_lbl 6 `"Blank to longitudinal value"', add
label values qempstat qempstat_lbl

label define qahrsworkt_lbl 00 `"No change or children or armed forces"'
label define qahrsworkt_lbl 04 `"Allocated - no method specified"', add
label define qahrsworkt_lbl 10 `"Value to value"', add
label define qahrsworkt_lbl 11 `"Blank to value"', add
label define qahrsworkt_lbl 12 `"Don't know to value"', add
label define qahrsworkt_lbl 13 `"Refused to value"', add
label define qahrsworkt_lbl 21 `"Blank to longitudinal value"', add
label define qahrsworkt_lbl 22 `"Don't know to longitudinal value"', add
label define qahrsworkt_lbl 23 `"Refused to longitudinal value"', add
label define qahrsworkt_lbl 40 `"Value to allocated value"', add
label define qahrsworkt_lbl 41 `"Blank to allocated value"', add
label define qahrsworkt_lbl 42 `"Don't know to allocated value"', add
label define qahrsworkt_lbl 43 `"Refused to allocated value"', add
label define qahrsworkt_lbl 50 `"Value to blank"', add
label define qahrsworkt_lbl 52 `"Don't know to blank"', add
label values qahrsworkt qahrsworkt_lbl

label define filestat_lbl 0 `"No data"'
label define filestat_lbl 1 `"Joint, both less than 65"', add
label define filestat_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_lbl 3 `"Joint, both 65+"', add
label define filestat_lbl 4 `"Head of household"', add
label define filestat_lbl 5 `"Single"', add
label define filestat_lbl 6 `"Nonfiler"', add
label values filestat filestat_lbl

label define nchild_head_lbl 0 `"0 children present"'
label define nchild_head_lbl 1 `"1 child present"', add
label define nchild_head_lbl 2 `"2"', add
label define nchild_head_lbl 3 `"3"', add
label define nchild_head_lbl 4 `"4"', add
label define nchild_head_lbl 5 `"5"', add
label define nchild_head_lbl 6 `"6"', add
label define nchild_head_lbl 7 `"7"', add
label define nchild_head_lbl 8 `"8"', add
label define nchild_head_lbl 9 `"9+"', add
label values nchild_head nchild_head_lbl

label define nchild_mom_lbl 0 `"0 children present"'
label define nchild_mom_lbl 1 `"1 child present"', add
label define nchild_mom_lbl 2 `"2"', add
label define nchild_mom_lbl 3 `"3"', add
label define nchild_mom_lbl 4 `"4"', add
label define nchild_mom_lbl 5 `"5"', add
label define nchild_mom_lbl 6 `"6"', add
label define nchild_mom_lbl 7 `"7"', add
label define nchild_mom_lbl 8 `"8"', add
label define nchild_mom_lbl 9 `"9+"', add
label values nchild_mom nchild_mom_lbl

label define nchild_mom2_lbl 0 `"0 children present"'
label define nchild_mom2_lbl 1 `"1 child present"', add
label define nchild_mom2_lbl 2 `"2"', add
label define nchild_mom2_lbl 3 `"3"', add
label define nchild_mom2_lbl 4 `"4"', add
label define nchild_mom2_lbl 5 `"5"', add
label define nchild_mom2_lbl 6 `"6"', add
label define nchild_mom2_lbl 7 `"7"', add
label define nchild_mom2_lbl 8 `"8"', add
label define nchild_mom2_lbl 9 `"9+"', add
label values nchild_mom2 nchild_mom2_lbl

label define empstat_head_lbl 00 `"NIU"'
label define empstat_head_lbl 01 `"Armed Forces"', add
label define empstat_head_lbl 10 `"At work"', add
label define empstat_head_lbl 12 `"Has job, not at work last week"', add
label define empstat_head_lbl 20 `"Unemployed"', add
label define empstat_head_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_head_lbl 22 `"Unemployed, new worker"', add
label define empstat_head_lbl 30 `"Not in labor force"', add
label define empstat_head_lbl 31 `"NILF, housework"', add
label define empstat_head_lbl 32 `"NILF, unable to work"', add
label define empstat_head_lbl 33 `"NILF, school"', add
label define empstat_head_lbl 34 `"NILF, other"', add
label define empstat_head_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_head_lbl 36 `"NILF, retired"', add
label values empstat_head empstat_head_lbl

label define empstat_mom_lbl 00 `"NIU"'
label define empstat_mom_lbl 01 `"Armed Forces"', add
label define empstat_mom_lbl 10 `"At work"', add
label define empstat_mom_lbl 12 `"Has job, not at work last week"', add
label define empstat_mom_lbl 20 `"Unemployed"', add
label define empstat_mom_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_mom_lbl 22 `"Unemployed, new worker"', add
label define empstat_mom_lbl 30 `"Not in labor force"', add
label define empstat_mom_lbl 31 `"NILF, housework"', add
label define empstat_mom_lbl 32 `"NILF, unable to work"', add
label define empstat_mom_lbl 33 `"NILF, school"', add
label define empstat_mom_lbl 34 `"NILF, other"', add
label define empstat_mom_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_mom_lbl 36 `"NILF, retired"', add
label values empstat_mom empstat_mom_lbl

label define empstat_mom2_lbl 00 `"NIU"'
label define empstat_mom2_lbl 01 `"Armed Forces"', add
label define empstat_mom2_lbl 10 `"At work"', add
label define empstat_mom2_lbl 12 `"Has job, not at work last week"', add
label define empstat_mom2_lbl 20 `"Unemployed"', add
label define empstat_mom2_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_mom2_lbl 22 `"Unemployed, new worker"', add
label define empstat_mom2_lbl 30 `"Not in labor force"', add
label define empstat_mom2_lbl 31 `"NILF, housework"', add
label define empstat_mom2_lbl 32 `"NILF, unable to work"', add
label define empstat_mom2_lbl 33 `"NILF, school"', add
label define empstat_mom2_lbl 34 `"NILF, other"', add
label define empstat_mom2_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_mom2_lbl 36 `"NILF, retired"', add
label values empstat_mom2 empstat_mom2_lbl

label define qempstat_head_lbl 0 `"No change or children or armed forces"'
label define qempstat_head_lbl 1 `"Value to blank"', add
label define qempstat_head_lbl 2 `"Blank to value"', add
label define qempstat_head_lbl 3 `"Value to value"', add
label define qempstat_head_lbl 4 `"Allocated"', add
label define qempstat_head_lbl 5 `"Blank to allocated value"', add
label define qempstat_head_lbl 6 `"Blank to longitudinal value"', add
label values qempstat_head qempstat_head_lbl

label define qempstat_mom_lbl 0 `"No change or children or armed forces"'
label define qempstat_mom_lbl 1 `"Value to blank"', add
label define qempstat_mom_lbl 2 `"Blank to value"', add
label define qempstat_mom_lbl 3 `"Value to value"', add
label define qempstat_mom_lbl 4 `"Allocated"', add
label define qempstat_mom_lbl 5 `"Blank to allocated value"', add
label define qempstat_mom_lbl 6 `"Blank to longitudinal value"', add
label values qempstat_mom qempstat_mom_lbl

label define qempstat_mom2_lbl 0 `"No change or children or armed forces"'
label define qempstat_mom2_lbl 1 `"Value to blank"', add
label define qempstat_mom2_lbl 2 `"Blank to value"', add
label define qempstat_mom2_lbl 3 `"Value to value"', add
label define qempstat_mom2_lbl 4 `"Allocated"', add
label define qempstat_mom2_lbl 5 `"Blank to allocated value"', add
label define qempstat_mom2_lbl 6 `"Blank to longitudinal value"', add
label values qempstat_mom2 qempstat_mom2_lbl

label define qahrsworkt_head_lbl 00 `"No change or children or armed forces"'
label define qahrsworkt_head_lbl 04 `"Allocated - no method specified"', add
label define qahrsworkt_head_lbl 10 `"Value to value"', add
label define qahrsworkt_head_lbl 11 `"Blank to value"', add
label define qahrsworkt_head_lbl 12 `"Don't know to value"', add
label define qahrsworkt_head_lbl 13 `"Refused to value"', add
label define qahrsworkt_head_lbl 21 `"Blank to longitudinal value"', add
label define qahrsworkt_head_lbl 22 `"Don't know to longitudinal value"', add
label define qahrsworkt_head_lbl 23 `"Refused to longitudinal value"', add
label define qahrsworkt_head_lbl 40 `"Value to allocated value"', add
label define qahrsworkt_head_lbl 41 `"Blank to allocated value"', add
label define qahrsworkt_head_lbl 42 `"Don't know to allocated value"', add
label define qahrsworkt_head_lbl 43 `"Refused to allocated value"', add
label define qahrsworkt_head_lbl 50 `"Value to blank"', add
label define qahrsworkt_head_lbl 52 `"Don't know to blank"', add
label values qahrsworkt_head qahrsworkt_head_lbl

label define qahrsworkt_mom_lbl 00 `"No change or children or armed forces"'
label define qahrsworkt_mom_lbl 04 `"Allocated - no method specified"', add
label define qahrsworkt_mom_lbl 10 `"Value to value"', add
label define qahrsworkt_mom_lbl 11 `"Blank to value"', add
label define qahrsworkt_mom_lbl 12 `"Don't know to value"', add
label define qahrsworkt_mom_lbl 13 `"Refused to value"', add
label define qahrsworkt_mom_lbl 21 `"Blank to longitudinal value"', add
label define qahrsworkt_mom_lbl 22 `"Don't know to longitudinal value"', add
label define qahrsworkt_mom_lbl 23 `"Refused to longitudinal value"', add
label define qahrsworkt_mom_lbl 40 `"Value to allocated value"', add
label define qahrsworkt_mom_lbl 41 `"Blank to allocated value"', add
label define qahrsworkt_mom_lbl 42 `"Don't know to allocated value"', add
label define qahrsworkt_mom_lbl 43 `"Refused to allocated value"', add
label define qahrsworkt_mom_lbl 50 `"Value to blank"', add
label define qahrsworkt_mom_lbl 52 `"Don't know to blank"', add
label values qahrsworkt_mom qahrsworkt_mom_lbl

label define qahrsworkt_mom2_lbl 00 `"No change or children or armed forces"'
label define qahrsworkt_mom2_lbl 04 `"Allocated - no method specified"', add
label define qahrsworkt_mom2_lbl 10 `"Value to value"', add
label define qahrsworkt_mom2_lbl 11 `"Blank to value"', add
label define qahrsworkt_mom2_lbl 12 `"Don't know to value"', add
label define qahrsworkt_mom2_lbl 13 `"Refused to value"', add
label define qahrsworkt_mom2_lbl 21 `"Blank to longitudinal value"', add
label define qahrsworkt_mom2_lbl 22 `"Don't know to longitudinal value"', add
label define qahrsworkt_mom2_lbl 23 `"Refused to longitudinal value"', add
label define qahrsworkt_mom2_lbl 40 `"Value to allocated value"', add
label define qahrsworkt_mom2_lbl 41 `"Blank to allocated value"', add
label define qahrsworkt_mom2_lbl 42 `"Don't know to allocated value"', add
label define qahrsworkt_mom2_lbl 43 `"Refused to allocated value"', add
label define qahrsworkt_mom2_lbl 50 `"Value to blank"', add
label define qahrsworkt_mom2_lbl 52 `"Don't know to blank"', add
label values qahrsworkt_mom2 qahrsworkt_mom2_lbl

label define filestat_head_lbl 0 `"No data"'
label define filestat_head_lbl 1 `"Joint, both less than 65"', add
label define filestat_head_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_head_lbl 3 `"Joint, both 65+"', add
label define filestat_head_lbl 4 `"Head of household"', add
label define filestat_head_lbl 5 `"Single"', add
label define filestat_head_lbl 6 `"Nonfiler"', add
label values filestat_head filestat_head_lbl

label define filestat_mom_lbl 0 `"No data"'
label define filestat_mom_lbl 1 `"Joint, both less than 65"', add
label define filestat_mom_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_mom_lbl 3 `"Joint, both 65+"', add
label define filestat_mom_lbl 4 `"Head of household"', add
label define filestat_mom_lbl 5 `"Single"', add
label define filestat_mom_lbl 6 `"Nonfiler"', add
label values filestat_mom filestat_mom_lbl

label define filestat_mom2_lbl 0 `"No data"'
label define filestat_mom2_lbl 1 `"Joint, both less than 65"', add
label define filestat_mom2_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_mom2_lbl 3 `"Joint, both 65+"', add
label define filestat_mom2_lbl 4 `"Head of household"', add
label define filestat_mom2_lbl 5 `"Single"', add
label define filestat_mom2_lbl 6 `"Nonfiler"', add
label values filestat_mom2 filestat_mom2_lbl

save "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00002.dta"
