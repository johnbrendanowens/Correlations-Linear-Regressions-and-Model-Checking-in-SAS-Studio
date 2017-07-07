data electric;

infile'H:\Apps\MinitabFiles\Morrell\ST710\Elliott\electric.dat';
input housesize 1-3 apindex 19-23 famnumber 26-28 income 6-11 pload 31-35 ac 14-16;
run;

proc corr data=electric; *Correlating Variables;
var housesize apindex famnumber income pload ac;
title "Correlation of House Size, Appliance Index, Number in Family, Peak Load,Air Capacity, and Income";
label housesize = "House Size" apindex = "appliance Index" famnumber = "Family Number" pload= "Peak Load" ac ="Air Capacity";

run;

proc reg data = electric; *Plotting Estimated Regression Line with peak load as the response 
						   variable and air capacity as the explanatory variable;

model pload=ac;
plot pload*ac;
title "Estimated Regrssion Line of Peak Load vs. Air Capacity";

run;

proc reg data=electric;

model pload= ac;
plot pload*ac; *Plot of data with fitted Line;
title "Peak Load versus Air Capacity";
run;
plot student.*P.; *Plot standardized residuals versus predicted;
title "Standardized Residuals versus Predicted";
run;
plot R.*P.; *Plot residuals versus predicted; 
title "Residuals versus Predicted";
run;
output out = pload_out p = yhat r= resid student = std_resid; *Create New data set with 
															   original values, residuals, 
															   and predicted;

run;

proc univariate data = pload_out normal; *Checking normailty of residuals;
var resid;
histogram resid / normal;
probplot resid / normal (mu =est sigma =est) square;
title "Checking Normality of Residual";
run;

