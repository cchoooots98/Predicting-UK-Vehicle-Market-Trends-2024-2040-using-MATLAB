function all_V=fulfil_total_all(future_V,all_V,V_mid_rate, ...
    predict_years_num,years_col_num,years_raw_num,epsilon)
numYearsAhead=predict_years_num+years_col_num-years_raw_num;

% Step 1: soomth rate 预测补全至0 

if V_mid_rate(end)>epsilon
    V_mid_rate_all=predict_mid_rate_all(V_mid_rate,numYearsAhead,epsilon);
end

%Step 2: fulfil the colums of the all_car_BE matrix, which presents the year before 2023
% row number = years_raw_num+1:years_raw_num+predict_years_num

all_V=fulfil_lowerR_all_matrix(all_V,V_mid_rate_all,predict_years_num,years_col_num,years_raw_num,epsilon);

% Step 4: predict all furture
for year=1:predict_years_num
    % corresponding column=predict_years_num:-1:1
    % corresponding raw=years_raw_num+1:years_raw_num+predict_years_num

    all_register_number=future_V(year)-sum(all_V(years_raw_num+year,:),'omitnan');
    if all_register_number<0
       all_register_number=0; 
    end
    
    all_V(years_raw_num+year:end, predict_years_num-year+1)=...
        all_register_number*V_mid_rate_all(1:predict_years_num-year+1);
   
end

end