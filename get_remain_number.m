function vehicle_remain_number_year=get_remain_number(vehicle_data)
varNames = vehicle_data.Properties.VariableNames;

% 遍历所有列，将非数字值转换为 NaN
% Iterate over all columns, converting non-numeric values to NaN
for i = 1:numel(varNames)
    columnData = vehicle_data.(varNames{i});
    % 如果列是字符串或包含非数字值，则尝试转换为数字
    % If the column is a string or contains non-numeric values, try converting to a number
    if iscell(columnData) || ischar(columnData) || ~isnumeric(columnData)
        % 将非数字值转换为 NaN
        numericColumn = str2double(string(columnData));
        vehicle_data.(varNames{i}) = numericColumn; % 替换为数值列
    end
end
% 转化为矩阵
% Convert to matrix
vehicle_remain_number_year = table2array(vehicle_data);

