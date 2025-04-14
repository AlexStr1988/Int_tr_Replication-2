*Code for 3SLS 
**************************************************

use "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication 2\Stata\stata data\Final_Complete.dta"

encode sector, gen(sector_num)


eststo: reg3 (s_ith = s_it interact log_P_tf_P_th log_labor_ratio) if sector == "Agriculture", 3sls
eststo: reg3 (s_ith = s_it interact log_P_tf_P_th log_labor_ratio) if sector == "Chemicals", 3sls
eststo: reg3 (s_ith = s_it interact log_P_tf_P_th log_labor_ratio) if sector == "Machinery", 3sls
eststo: reg3 (s_ith = s_it interact log_P_tf_P_th log_labor_ratio) if sector == "Minerals", 3sls
eststo: reg3 (s_ith = s_it interact log_P_tf_P_th log_labor_ratio) if sector == "Textiles", 3sls
eststo: reg3 (s_ith = s_it interact log_P_tf_P_th log_labor_ratio) if sector == "Transport", 3sls
* eststo: reg3 (s_ith = s_it interact log_P_tf_P_th log_labor_ratio) if sector == "Other", 3sls - does not work

*Outputting the table with results	
esttab using Table_3_results.csv, replace r2 se keep(interact log_P_tf_P_th log_labor_ratio)





*Another try
****************************************************************

*gen s_agriculture = s_ith if sector == "Agriculture"
*gen s_textiles    = s_ith if sector == "Textiles"
*gen s_wood        = s_ith if sector == "Other"
*gen s_petroleum   = s_ith if sector == "Chemicals"
*gen s_mining      = s_ith if sector == "Minerals"
*gen s_machinery   = s_ith if sector == "Transport"
*gen s_electronics = s_ith if sector == "Machinery"

*gen interact_agri = interact if sector == "Agriculture"
*gen interact_text = interact if sector == "Textiles"
*gen interact_wood = interact if sector == "Other"
*gen interact_petro = interact if sector == "Chemicals"
*gen interact_mine = interact if sector == "Minerals"
*gen interact_mach = interact if sector == "Transport"
*gen interact_elec = interact if sector == "Machinery"


*eststo: reg3 (s_agriculture = s_it interact_agri interact_text interact_petro interact_mine interact_mach  log_P_tf_P_th log_labor_ratio), 3sls
              *(s_textiles = s_it interact_text log_P_tf_P_th log_labor_ratio)
              *(s_wood = s_it interact_wood log_P_tf_P_th log_labor_ratio)
              *(s_petroleum = s_it interact_petro log_P_tf_P_th log_labor_ratio)
              *(s_mining = s_it interact_mine log_P_tf_P_th log_labor_ratio)
              *(s_machinery = s_it interact_mach log_P_tf_P_th log_labor_ratio)
              *(s_electronics = s_it interact_elec log_P_tf_P_th log_labor_ratio)
              *(adj_tfp = interact_agri interact_text interact_wood interact_petro ///
                        interact_mine interact_mach interact_elec log_P_tf_P_th log_labor_ratio), 3sls









