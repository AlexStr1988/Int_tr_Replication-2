*Replication 2


****************************************************************************
*1.Aggregating the US imports into 7 sectors

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\US_Imports.xlsx", clear firstrow

* Step 1: Extract the HS 2-digit code
gen hs_code = substr(Commodity, 1, 2)
destring hs_code, replace

* Step 2: Create sector variable based on HS code
gen sector = ""

replace sector = "Agriculture" if inrange(hs_code, 1, 24)
replace sector = "Minerals" if inrange(hs_code, 25, 27) | inrange(hs_code, 68, 71)
replace sector = "Chemicals" if inrange(hs_code, 28, 38) | inrange(hs_code, 39, 40)
replace sector = "Textiles" if inrange(hs_code, 41, 43) | inrange(hs_code, 50, 67)
replace sector = "Machinery" if inrange(hs_code, 84, 85)
replace sector = "Transport" if inrange(hs_code, 86, 89)
replace sector = "Other" if inrange(hs_code, 44, 49) | inrange(hs_code, 72, 83) | inrange(hs_code, 90, 99)

* Step 3: Aggregate by country, time, and sector
collapse (sum) value, by(country time sector)

* Generate the 3-letter country code
gen cou = ""

replace cou = "aus" if country == "Australia"
replace cou = "can" if country == "Canada"
replace cou = "cze" if country == "Czech Republic"
replace cou = "fin" if country == "Finland"
replace cou = "fra" if country == "France"
replace cou = "deu" if country == "Germany"
replace cou = "hun" if country == "Hungary"
replace cou = "jpn" if country == "Japan"
replace cou = "kor" if country == "Korea, South" | country == "Korea"
replace cou = "nzl" if country == "New Zealand"
replace cou = "gbr" if country == "United Kingdom" | country == "UK"

drop country
rename value usimp

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports.dta", replace




*******************************************************************************
*2. Merging with value added

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\Value Added.xlsx", clear firstrow

drop cou

* Generate the 3-letter country code
gen cou = ""

replace cou = "aus" if country == "Australia"
replace cou = "can" if country == "Canada"
replace cou = "cze" if country == "Czech Republic" | country == "Czechia"
replace cou = "fin" if country == "Finland"
replace cou = "fra" if country == "France"
replace cou = "deu" if country == "Germany"
replace cou = "hun" if country == "Hungary"
replace cou = "jpn" if country == "Japan"
replace cou = "kor" if country == "Korea, Republic of" | country == "Korea"
replace cou = "nzl" if country == "New Zealand"
replace cou = "gbr" if country == "United Kingdom" | country == "UK"
replace cou = "usa" if country == "United States"

drop country

*Renaming activities

gen sector = ""

replace sector = "Agriculture" if activ == "Agriculture, forestry and fishing"
replace sector = "Chemicals" if activ == "Manufacture of chemicals and non-metallic mineral products"
replace sector = "Machinery" if activ == "Manufacture of computer, electronic and optical products, electrical equipment, machinery and equipment n.e.c."
replace sector = "Textiles" if activ == "Manufacture of textiles, wearing apparel, leather and related products"
replace sector = "Minerals" if activ == "Mining and quarrying"
replace sector = "Transport" if activ == "Manufacture of motor vehicles, trailers, semi-trailers and of other transport equipment"
replace sector = "Other" if activ == "Manufacture of wood and of products of wood and cork, except furniture; manufacture of articles of straw and plaiting materials; manufacture of paper and paper products; printing and reproduction of recorded media"

drop activ
drop Unitofmeasure
drop OBS_VALUE
rename value va

*Merging two files - US_Imports + Value added
merge m:m time cou sector using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports.dta"

drop _merge

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA.dta", replace



*******************************************************************************
*3. Working with the GDP data

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\GDP.xlsx", clear firstrow

drop cou OBS_VALUE Unitmultiplier CURRENCY
rename Referencearea country

* Generate the 3-letter country code
gen cou = ""

replace cou = "aus" if country == "Australia"
replace cou = "can" if country == "Canada"
replace cou = "cze" if country == "Czech Republic" | country == "Czechia"
replace cou = "fin" if country == "Finland"
replace cou = "fra" if country == "France"
replace cou = "deu" if country == "Germany"
replace cou = "hun" if country == "Hungary"
replace cou = "jpn" if country == "Japan"
replace cou = "kor" if country == "Korea, Republic of" | country == "Korea"
replace cou = "nzl" if country == "New Zealand"
replace cou = "gbr" if country == "United Kingdom" | country == "UK"
replace cou = "usa" if country == "United States"

drop country

*Merging two files - US_Imports + Value added + GDP
merge m:m time cou using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA.dta"

drop _merge

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP.dta", replace





*********************************************************************
*4. Working with Export Price index

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\Export Index.xlsx", clear firstrow

* Generate the 3-letter country code
gen cou = ""

replace cou = "aus" if country == "Australia"
replace cou = "can" if country == "Canada"
replace cou = "cze" if country == "Czech Republic" | country == "Czechia"
replace cou = "fin" if country == "Finland"
replace cou = "fra" if country == "France"
replace cou = "deu" if country == "Germany"
replace cou = "hun" if country == "Hungary"
replace cou = "jpn" if country == "Japan"
replace cou = "kor" if country == "Korea, Republic of" | country == "Korea"
replace cou = "nzl" if country == "New Zealand"
replace cou = "gbr" if country == "United Kingdom" | country == "UK"
replace cou = "usa" if country == "United States"

drop country
rename value exin

*Merging two files - US_Imports + Value added + GDP
merge m:m time cou using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP.dta"

drop _merge

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP +ExIn.dta", replace





*****************************************************************************
*5. Working on Imp index

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\Import Index.xlsx", clear firstrow

* Generate the 3-letter country code
gen cou = ""

replace cou = "aus" if country == "Australia"
replace cou = "can" if country == "Canada"
replace cou = "cze" if country == "Czech Republic" | country == "Czechia"
replace cou = "fin" if country == "Finland"
replace cou = "fra" if country == "France"
replace cou = "deu" if country == "Germany"
replace cou = "hun" if country == "Hungary"
replace cou = "jpn" if country == "Japan"
replace cou = "kor" if country == "Korea, Republic of" | country == "Korea"
replace cou = "nzl" if country == "New Zealand"
replace cou = "gbr" if country == "United Kingdom" | country == "UK"
replace cou = "usa" if country == "United States"

drop country

*Merging two files - US_Imports + Value added + GDP
merge m:m time cou using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP +ExIn.dta"

drop _merge

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP +ExIn + ImIn.dta", replace




******************************************************************************
* 6. Working with labor

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\Labor.xlsx", clear firstrow

replace cou = lower(cou)

*Formatting data for future reshaping from the wide to a long format
rename (B C D E F G H I J K L M N O P Q R S T U V) (yo_2003 yo_2004 yo_2005 yo_2006 yo_2007 yo_2008 yo_2009 yo_2010 yo_2011 yo_2012 yo_2013 yo_2014 yo_2015 yo_2016 yo_2017 yo_2018 yo_2019 yo_2020 yo_2021 yo_2022 yo_2023)

*Fromatting for the long format
reshape long yo_, i(cou) j(year)

rename yo_ labor
rename year time

*Merging two files - US_Imports + Value added + GDP
merge m:m time cou using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP +ExIn + ImIn.dta"

drop _merge

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP +ExIn + ImIn + Labor.dta", replace



***************************************************************************
*7. Working with Gravity data

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\geodist.xlsx", clear firstrow

replace cou = lower(cou)

*Merging two files - US_Imports + Value added + GDP
merge m:m cou using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\US_imports + VA + GDP +ExIn + ImIn + Labor.dta"

drop _merge

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\Final1.dta", replace




*************************************************************************
* 8. Working with exports for all countries

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\data\Exports.xlsx", clear firstrow

* Step 1: Extract the HS 2-digit code
*gen hs_code = substr(Commodity, 1, 2)
destring hs_code, replace

* Step 2: Create sector variable based on HS code
gen sector = ""

replace sector = "Agriculture" if inrange(hs_code, 1, 24)
replace sector = "Minerals" if inrange(hs_code, 25, 27) | inrange(hs_code, 68, 71)
replace sector = "Chemicals" if inrange(hs_code, 28, 38) | inrange(hs_code, 39, 40)
replace sector = "Textiles" if inrange(hs_code, 41, 43) | inrange(hs_code, 50, 67)
replace sector = "Machinery" if inrange(hs_code, 84, 85)
replace sector = "Transport" if inrange(hs_code, 86, 89)
replace sector = "Other" if inrange(hs_code, 44, 49) | inrange(hs_code, 72, 83) | inrange(hs_code, 90, 99)

* Step 3: Aggregate by country, time, and sector
collapse (sum) value, by(country time sector)

* Generate the 3-letter country code
gen cou = ""

replace cou = "aus" if country == "Australia"
replace cou = "can" if country == "Canada"
replace cou = "cze" if country == "Czechia"
replace cou = "fin" if country == "Finland"
replace cou = "fra" if country == "France"
replace cou = "deu" if country == "Germany"
replace cou = "hun" if country == "Hungary"
replace cou = "jpn" if country == "Japan"
replace cou = "kor" if country == "Rep. of Korea" | country == "Korea"
replace cou = "nzl" if country == "New Zealand"
replace cou = "gbr" if country == "United Kingdom" | country == "UK"
replace cou = "usa" if country == "United States" | country == "USA"


drop country
rename value exp

*Merging two files - US_Imports + Value added
merge m:m time cou sector using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\Final1.dta"

drop _merge

* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\Final_2.dta", replace


* 9. Generating other variables

gen s_it = va/gdp

*Elasticity and p_i

gen sigma = .

replace sigma = 12.02 if sector == "Agriculture"
replace sigma = 15.46 if sector == "Chemicals"
replace sigma = 16.39 if sector == "Transport"
replace sigma = 6.63  if sector == "Minerals"
replace sigma = 7.43  if sector == "Machinery"
replace sigma = 127.75 if sector == "Other"
replace sigma = 43.51 if sector == "Textiles"

gen p_i = (sigma-1)/sigma

*Log labor ratio

* Step 1: Create a variable that captures USA labor by sector and year
egen usa_labor = max(cond(cou == "usa", labor, .)), by(time sector)

* Step 2: Compute the log ratio of USA labor to importing country's labor
gen log_labor_ratio = log(usa_labor / labor)

drop usa_labor

*Generating S_it

gen S_it = exp/va

*Generating P_tf/P_th

* Step 1:
egen P_th = max(cond(cou == "usa", imin, .)), by(time)

* Step 2:
gen log_P_tf_P_th = log(exin / P_th)

drop P_th


*Generating W_it - REALLY A BIG QUESTION

egen S_ith = max(cond(cou == "usa", S_it, .)), by(time sector)

* Step 2:
gen W_it = (((S_ith - S_it)/(log(S_ith) - log(S_it)))/(((S_ith-S_it)/(log(S_ith)-log(S_it))) + (((1-S_ith) - (1-S_it))/(log(1-S_ith)- log(1-S_it)))))

*Generating the variety variables

* Step 1: Calculate total US imports per sector and year
egen total_usimp_sector_year = total(usimp), by(sector time)

* Step 2: Calculate total US imports per sector across all years
egen total_usimp_sector_all = total(usimp), by(sector)

* Step 3: Generate the 'variety' variable
gen variety = total_usimp_sector_year / total_usimp_sector_all

gen log_var = log(variety)


*Dropping data for 2023
drop if time == 2023


*Generating s_ith
egen s_ith = max(cond(cou == "usa", s_it, .)), by(time sector)

gen interact = p_i * W_it * log_var


* Saving the aggregated dataset
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\Final_Complete.dta", replace











