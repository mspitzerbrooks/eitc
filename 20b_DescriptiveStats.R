# bring in data
data <- read.dta("/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00001.dta")

# check level of uniqueness
unique_vars <- c("year_1", "month_1", "serial_1", "pernum_1", "year_2", "month_2", "serial_2", "pernum_2")
sapply(unique_vars, function(x) length(unique(data[[x]])))

table(data$year_1, data$year_2)
table(data$month_1, data$month_2)

head(data[, c("cpsid", "serial_1", "serial_2")], n = 20)
# looks like there are multiple serials for the same cpsid
# does this mean the same household is interviewed multiple times?

# create dummy for employed (extensive margin)
for(i in 1:2){
  data[paste0("employed_", i)] <- as.numeric(data[[paste0("empstat_", i)]] %in% c(10, 12))
}

# create variable for hours worked (intensive margin)
for(i in 1:2){
  data[paste0("hrs_worked_", i)] <- data[[paste0("ahrsworkt_", i)]]
  data[paste0("hrs_worked_", i)][data[[paste0("ahrsworkt_", i)]] == 999] <- NA
}

# create variable for eitc amount
for(i in 1:2){
  data[paste0("eitc_amount_", i)] <- data[[paste0("eitcred_", i)]]
  data[paste0("eitc_amount_", i)][data[[paste0("eitcred_", i)]] == 9999] <- NA
}

# create variable for number of children
for(i in 1:2){
  data[paste0("num_child_", i)] <- data[[paste0("nchild_", i)]]
  # note: includes a category for 9+, effectively topcoding these to 9
}

# look at these variables by year
stat_choices <- c("n", "mean", "sd", "min", "p25", "p50", "p75", "max")
for(i in 1:2){
  for(name in c("employed", "hrs_worked", "eitc_amount", "num_child")){
    tab <- aggregate(data[[paste0(name, "_", i)]], list(data$year_1), FUN = function(x) c(length(x), mean(x, na.rm = TRUE), sd(x, na.rm = TRUE), min(x, na.rm = TRUE), quantile(x, probs = 0.25, na.rm = TRUE), median(x, na.rm = TRUE), quantile(x, probs = 0.75, na.rm = TRUE), max(x, na.rm = TRUE)))
    names(tab) <- c("year", paste0(name, "_", stat_choices))
    print(tab)
  }
}
# the values are not the same for a given year across variables. why?

# filing status
table(data$filestat_1)
table(data$filestat_2)

write.dta(data, "/Users/matthewspitzer/Desktop/EITC/Intermediate/cps00001_constructs.dta")
