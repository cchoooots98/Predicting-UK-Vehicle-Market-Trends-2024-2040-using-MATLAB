function all_matrix=fulfil_lowerR_all_matrix(all_matrix,mid_rate_all,predict_years_num,years_col_num,years_raw_num,epsilon)
mid_rate_index=1;
for col=predict_years_num+1:predict_years_num+years_col_num
    if ~isnan(all_matrix(years_raw_num,col)) && all_matrix(years_raw_num,col)>epsilon...
            &&mid_rate_all(mid_rate_index)>0
        firstNonNaNIndex = find(~isnan(all_matrix(:,col)), 1, 'first');
        numNonNan=years_raw_num-firstNonNaNIndex+1;
        all_matrix(years_raw_num+1:end,col)=...
            sum(all_matrix(firstNonNaNIndex:years_raw_num,col)./mid_rate_all(mid_rate_index-numNonNan+1:mid_rate_index))/numNonNan...
            .*mid_rate_all(mid_rate_index+1:mid_rate_index+predict_years_num);
    else
        all_matrix(years_raw_num+1:end,col)=zeros(predict_years_num,1);
    end
    mid_rate_index=mid_rate_index+1;
end
end