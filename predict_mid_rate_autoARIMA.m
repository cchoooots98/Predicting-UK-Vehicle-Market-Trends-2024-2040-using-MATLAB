function future_vehicle=predict_mid_rate_autoARIMA(vehicle_total,numYearsAhead)

% numYearsAhead = 2040 - 2023; % 预测 17 年


% 3. 检查数据平稳性（ADF单位根检验）
% [h, ~] = adftest(vehicle_total);
% vehicle_diff=vehicle_total;
% d_pref=0;
% while h==0&& d_pref<5
%     %'数据非平稳，需要进行差分处理'
%     vehicle_diff=diff(vehicle_diff);
%     [h, ~] = adftest(vehicle_diff);
%     d_pref=1+d_pref;
% end

bestAIC=inf;
bestModel = [];
bestP = 0;
bestD = 0;
bestQ = 0;

% 尝试多个 (p, d, q) 组合
for p = 0:3
    for d=0:2
        for q = 0:3
            try
            mdl = arima(p, d, q);
            estMdl = estimate(mdl, vehicle_total, 'Display', 'off');
            
            % 获取似然值（log-likelihood）
                [~, ~, logL] = infer(estMdl, vehicle_total);

                % 计算 AIC
                k = p + q + 1;  % 参数个数（p, q 以及常数项）
                AIC = 2*k - 2*logL;

                % 选择 AIC 最小的模型
                if AIC < bestAIC
                    bestAIC = AIC;
                    bestModel = estMdl;
                    bestP = p;
                    bestD = d;
                    bestQ = q;
                end
            catch
                continue;
            end
        end
    end
end


% 输出最佳 ARIMA 模型

% 4. 输出最佳 ARIMA 模型参数
disp(['Best ARIMA Model: ARIMA(', num2str(bestP), ',', num2str(bestD), ',', num2str(bestQ), ')']);
disp(['Best AIC: ', num2str( bestAIC)]);

future_vehicle = forecast(bestModel, numYearsAhead, 'Y0', vehicle_total);


