function [all_V_diesel,all_V_petrol,all_V_BE]=fulfil_car_LGV_all(future_V,all_V_diesel,all_V_petrol,all_V_BE,V_diesel_mid_rate,V_petrol_mid_rate, ...
    V_BE_register_rate,predict_years_num,years_col_num,years_raw_num,epsilon)
numYearsAhead=predict_years_num+years_col_num-years_raw_num;

% Step 1: soomth rate 预测补全至0 

if V_diesel_mid_rate(end)>epsilon
    V_diesel_mid_rate_all=predict_mid_rate_all(V_diesel_mid_rate,numYearsAhead,epsilon);
end

if V_petrol_mid_rate(end)>epsilon
    V_petrol_mid_rate_all=predict_mid_rate_all(V_petrol_mid_rate,numYearsAhead,epsilon);
end 

% BE use the rate of petrol
V_BE_mid_rate_all=V_petrol_mid_rate_all;


%Step 2: fulfil the colums of the all_car_BE matrix, which presents the year before 2023
% row number = years_raw_num+1:years_raw_num+predict_years_num

all_V_diesel=fulfil_lowerR_all_matrix(all_V_diesel,V_diesel_mid_rate_all,predict_years_num,years_col_num,years_raw_num,epsilon);

all_V_petrol=fulfil_lowerR_all_matrix(all_V_petrol,V_petrol_mid_rate_all,predict_years_num,years_col_num,years_raw_num,epsilon);

all_V_BE=fulfil_lowerR_all_matrix(all_V_BE,V_BE_mid_rate_all,predict_years_num,years_col_num,years_raw_num,epsilon);

% Step 3: predict the precent of diesel's register number among non-zeros

V_diesel_new_register= flipud(diag(flipud(all_V_diesel(1:years_raw_num,predict_years_num+1:predict_years_num+years_raw_num))));
V_petrol_new_register= flipud(diag(flipud(all_V_petrol(1:years_raw_num,predict_years_num+1:predict_years_num+years_raw_num))));

V_diesel_2nonZ_rate=V_diesel_new_register./(V_diesel_new_register+V_petrol_new_register);

[V_diesel_2nonZ_rate_predict,~]=predict_vehicle_number_autoARIMA(V_diesel_2nonZ_rate,predict_years_num);
V_diesel_2nonZ_rate_predict(V_diesel_2nonZ_rate_predict<epsilon)=0;
% Step 4: predict all furture


for year=1:predict_years_num
    % corresponding column=predict_years_num:-1:1
    % corresponding raw=years_raw_num+1:years_raw_num+predict_years_num

    all_register_number=future_V(year)-sum(all_V_diesel(years_raw_num+year,:),'omitnan')...
        -sum(all_V_petrol(years_raw_num+year,:),'omitnan')-sum(all_V_BE(years_raw_num+year,:),'omitnan');
    if all_register_number<0
        year
        disp('The number of new register is negative!')
        pause
    end
    BE_register=all_register_number*V_BE_register_rate(year);
    nonZ_register=all_register_number-BE_register;
    diesel_register=nonZ_register*V_diesel_2nonZ_rate_predict(year);
    petrol_register=nonZ_register-diesel_register;

    all_V_diesel(years_raw_num+year:end, predict_years_num-year+1)=...
        diesel_register*V_diesel_mid_rate_all(1:predict_years_num-year+1);

    all_V_petrol(years_raw_num+year:end, predict_years_num-year+1)=...
        petrol_register * V_petrol_mid_rate_all(1:predict_years_num-year+1);

    all_V_BE(years_raw_num+year:end, predict_years_num-year+1)=...
        BE_register * V_BE_mid_rate_all(1:predict_years_num-year+1);

end

end