* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off
cd "/Users/matthewspitzer/Desktop/EITC/Input"

clear
quietly infix                 ///
  int     year       1-4      ///
  long    serial     5-9      ///
  byte    month      10-11    ///
  double  cpsid      12-25    ///
  byte    asecflag   26-26    ///
  double  asecwth    27-37    ///
  byte    gqtype     38-39    ///
  byte    pernum     40-41    ///
  double  cpsidp     42-55    ///
  double  asecwt     56-66    ///
  int     relate     67-70    ///
  byte    age        71-72    ///
  byte    sex        73-73    ///
  int     race       74-76    ///
  byte    marst      77-77    ///
  byte    nchild     78-78    ///
  byte    empstat    79-80    ///
  int     ahrsworkt  81-83    ///
  byte    majoract   84-84    ///
  byte    intenfwk   85-85    ///
  double  ftotval    86-95    ///
  double  inctot     96-104   ///
  double  incwage    105-112  ///
  double  adjginc    113-120  ///
  int     eitcred    121-124  ///
  byte    filestat   125-125  ///
  long    taxinc     126-132  ///
  using `"cps_00009.dat"'

replace asecwth   = asecwth   / 10000
replace asecwt    = asecwt    / 10000

format cpsid     %14.0f
format asecwth   %11.4f
format cpsidp    %14.0f
format asecwt    %11.4f
format ftotval   %10.0f
format inctot    %9.0f
format incwage   %8.0f
format adjginc   %8.0f

label var year      `"Survey year"'
label var serial    `"Household serial number"'
label var month     `"Month"'
label var cpsid     `"CPSID, household record"'
label var asecflag  `"Flag for ASEC"'
label var asecwth   `"Annual Social and Economic Supplement Household weight"'
label var gqtype    `"Household type"'
label var pernum    `"Person number in sample unit"'
label var cpsidp    `"CPSID, person record"'
label var asecwt    `"Annual Social and Economic Supplement Weight"'
label var relate    `"Relationship to household head"'
label var age       `"Age"'
label var sex       `"Sex"'
label var race      `"Race"'
label var marst     `"Marital status"'
label var nchild    `"Number of own children in household"'
label var empstat   `"Employment status"'
label var ahrsworkt `"Hours worked last week"'
label var majoract  `"Major activity preceding week"'
label var intenfwk  `"Intend to find work in the next 12 months"'
label var ftotval   `"Total family income"'
label var inctot    `"Total personal income"'
label var incwage   `"Wage and salary income"'
label var adjginc   `"Adjusted gross income"'
label var eitcred   `"Earned income tax credit"'
label var filestat  `"Tax filer status"'
label var taxinc    `"Taxable income amount"'

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

label define gqtype_lbl 00 `"Non-interview household"'
label define gqtype_lbl 01 `"Husband/wife primary family (neither Armed Forces)"', add
label define gqtype_lbl 02 `"Husband/wife primary family (either/both Armed Forces)"', add
label define gqtype_lbl 03 `"Unmarried civilian male - primary family householder"', add
label define gqtype_lbl 04 `"Unmarried civilian female - primary family householder"', add
label define gqtype_lbl 05 `"Primary family householder - respondent in Armed Forces, unmarried"', add
label define gqtype_lbl 06 `"Civilian male primary individual"', add
label define gqtype_lbl 07 `"Civilian female primary individual"', add
label define gqtype_lbl 08 `"Primary individual householder - respondent in Armed Forces"', add
label define gqtype_lbl 09 `"Group quarters with family"', add
label define gqtype_lbl 10 `"Group quarters without family"', add
label define gqtype_lbl 99 `"Blank"', add
label values gqtype gqtype_lbl

label define relate_lbl 0101 `"Head/householder"'
label define relate_lbl 0201 `"Spouse"', add
label define relate_lbl 0202 `"Opposite sex spouse"', add
label define relate_lbl 0203 `"Same sex spouse"', add
label define relate_lbl 0301 `"Child"', add
label define relate_lbl 0303 `"Stepchild"', add
label define relate_lbl 0501 `"Parent"', add
label define relate_lbl 0701 `"Sibling"', add
label define relate_lbl 0901 `"Grandchild"', add
label define relate_lbl 1001 `"Other relatives, n.s."', add
label define relate_lbl 1113 `"Partner/roommate"', add
label define relate_lbl 1114 `"Unmarried partner"', add
label define relate_lbl 1116 `"Opposite sex unmarried partner"', add
label define relate_lbl 1117 `"Same sex unmarried partner"', add
label define relate_lbl 1115 `"Housemate/roomate"', add
label define relate_lbl 1241 `"Roomer/boarder/lodger"', add
label define relate_lbl 1242 `"Foster children"', add
label define relate_lbl 1260 `"Other nonrelatives"', add
label define relate_lbl 9900 `"Relationship unknown"', add
label define relate_lbl 9999 `"NIU"', add
label values relate relate_lbl

label define age_lbl 00 `"Under 1 year"'
label define age_lbl 01 `"1"', add
label define age_lbl 02 `"2"', add
label define age_lbl 03 `"3"', add
label define age_lbl 04 `"4"', add
label define age_lbl 05 `"5"', add
label define age_lbl 06 `"6"', add
label define age_lbl 07 `"7"', add
label define age_lbl 08 `"8"', add
label define age_lbl 09 `"9"', add
label define age_lbl 10 `"10"', add
label define age_lbl 11 `"11"', add
label define age_lbl 12 `"12"', add
label define age_lbl 13 `"13"', add
label define age_lbl 14 `"14"', add
label define age_lbl 15 `"15"', add
label define age_lbl 16 `"16"', add
label define age_lbl 17 `"17"', add
label define age_lbl 18 `"18"', add
label define age_lbl 19 `"19"', add
label define age_lbl 20 `"20"', add
label define age_lbl 21 `"21"', add
label define age_lbl 22 `"22"', add
label define age_lbl 23 `"23"', add
label define age_lbl 24 `"24"', add
label define age_lbl 25 `"25"', add
label define age_lbl 26 `"26"', add
label define age_lbl 27 `"27"', add
label define age_lbl 28 `"28"', add
label define age_lbl 29 `"29"', add
label define age_lbl 30 `"30"', add
label define age_lbl 31 `"31"', add
label define age_lbl 32 `"32"', add
label define age_lbl 33 `"33"', add
label define age_lbl 34 `"34"', add
label define age_lbl 35 `"35"', add
label define age_lbl 36 `"36"', add
label define age_lbl 37 `"37"', add
label define age_lbl 38 `"38"', add
label define age_lbl 39 `"39"', add
label define age_lbl 40 `"40"', add
label define age_lbl 41 `"41"', add
label define age_lbl 42 `"42"', add
label define age_lbl 43 `"43"', add
label define age_lbl 44 `"44"', add
label define age_lbl 45 `"45"', add
label define age_lbl 46 `"46"', add
label define age_lbl 47 `"47"', add
label define age_lbl 48 `"48"', add
label define age_lbl 49 `"49"', add
label define age_lbl 50 `"50"', add
label define age_lbl 51 `"51"', add
label define age_lbl 52 `"52"', add
label define age_lbl 53 `"53"', add
label define age_lbl 54 `"54"', add
label define age_lbl 55 `"55"', add
label define age_lbl 56 `"56"', add
label define age_lbl 57 `"57"', add
label define age_lbl 58 `"58"', add
label define age_lbl 59 `"59"', add
label define age_lbl 60 `"60"', add
label define age_lbl 61 `"61"', add
label define age_lbl 62 `"62"', add
label define age_lbl 63 `"63"', add
label define age_lbl 64 `"64"', add
label define age_lbl 65 `"65"', add
label define age_lbl 66 `"66"', add
label define age_lbl 67 `"67"', add
label define age_lbl 68 `"68"', add
label define age_lbl 69 `"69"', add
label define age_lbl 70 `"70"', add
label define age_lbl 71 `"71"', add
label define age_lbl 72 `"72"', add
label define age_lbl 73 `"73"', add
label define age_lbl 74 `"74"', add
label define age_lbl 75 `"75"', add
label define age_lbl 76 `"76"', add
label define age_lbl 77 `"77"', add
label define age_lbl 78 `"78"', add
label define age_lbl 79 `"79"', add
label define age_lbl 80 `"80"', add
label define age_lbl 81 `"81"', add
label define age_lbl 82 `"82"', add
label define age_lbl 83 `"83"', add
label define age_lbl 84 `"84"', add
label define age_lbl 85 `"85"', add
label define age_lbl 86 `"86"', add
label define age_lbl 87 `"87"', add
label define age_lbl 88 `"88"', add
label define age_lbl 89 `"89"', add
label define age_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_lbl 91 `"91"', add
label define age_lbl 92 `"92"', add
label define age_lbl 93 `"93"', add
label define age_lbl 94 `"94"', add
label define age_lbl 95 `"95"', add
label define age_lbl 96 `"96"', add
label define age_lbl 97 `"97"', add
label define age_lbl 98 `"98"', add
label define age_lbl 99 `"99+"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"NIU"', add
label values sex sex_lbl

label define race_lbl 100 `"White"'
label define race_lbl 200 `"Black"', add
label define race_lbl 300 `"American Indian/Aleut/Eskimo"', add
label define race_lbl 650 `"Asian or Pacific Islander"', add
label define race_lbl 651 `"Asian only"', add
label define race_lbl 652 `"Hawaiian/Pacific Islander only"', add
label define race_lbl 700 `"Other (single) race, n.e.c."', add
label define race_lbl 801 `"White-Black"', add
label define race_lbl 802 `"White-American Indian"', add
label define race_lbl 803 `"White-Asian"', add
label define race_lbl 804 `"White-Hawaiian/Pacific Islander"', add
label define race_lbl 805 `"Black-American Indian"', add
label define race_lbl 806 `"Black-Asian"', add
label define race_lbl 807 `"Black-Hawaiian/Pacific Islander"', add
label define race_lbl 808 `"American Indian-Asian"', add
label define race_lbl 809 `"Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 810 `"White-Black-American Indian"', add
label define race_lbl 811 `"White-Black-Asian"', add
label define race_lbl 812 `"White-American Indian-Asian"', add
label define race_lbl 813 `"White-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 814 `"White-Black-American Indian-Asian"', add
label define race_lbl 815 `"American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 816 `"White-Black--Hawaiian/Pacific Islander"', add
label define race_lbl 817 `"White-American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 818 `"Black-American Indian-Asian"', add
label define race_lbl 819 `"White-American Indian-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 820 `"Two or three races, unspecified"', add
label define race_lbl 830 `"Four or five races, unspecified"', add
label define race_lbl 999 `"Blank"', add
label values race race_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label define marst_lbl 7 `"Widowed or Divorced"', add
label define marst_lbl 9 `"NIU"', add
label values marst marst_lbl

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

label define majoract_lbl 0 `"NIU, Children or armed forces"'
label define majoract_lbl 1 `"Working"', add
label define majoract_lbl 2 `"With a job but not at work"', add
label define majoract_lbl 3 `"Looking for work"', add
label define majoract_lbl 4 `"Keeping house"', add
label define majoract_lbl 5 `"At school"', add
label define majoract_lbl 6 `"Unable to work"', add
label define majoract_lbl 7 `"Retired"', add
label define majoract_lbl 8 `"Other"', add
label values majoract majoract_lbl

label define intenfwk_lbl 0 `"NIU"'
label define intenfwk_lbl 1 `"Yes"', add
label define intenfwk_lbl 2 `"It depends"', add
label define intenfwk_lbl 3 `"No"', add
label define intenfwk_lbl 4 `"Do not know"', add
label values intenfwk intenfwk_lbl

label define filestat_lbl 0 `"No data"'
label define filestat_lbl 1 `"Joint, both less than 65"', add
label define filestat_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_lbl 3 `"Joint, both 65+"', add
label define filestat_lbl 4 `"Head of household"', add
label define filestat_lbl 5 `"Single"', add
label define filestat_lbl 6 `"Nonfiler"', add
label values filestat filestat_lbl


save "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00009.dta"
