function mid_rate_all=predict_mid_rate_all(mid_rate,numYearsAhead,epsilon)
mid_rate_predict=predict_mid_rate_autoARIMA(mid_rate,numYearsAhead);
    mid_rate_all=[mid_rate;mid_rate_predict];
    mid_rate_all(mid_rate_all<epsilon)=0;
    mid_rate_all(mid_rate_all>1)=1;
end