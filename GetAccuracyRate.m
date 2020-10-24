function [accuracyRate_1,accuracyRate_0,CTable] = GetAccuracyRate(data,trainingAndTestSet,minleaf)
%GETACCURACYRATE 此处显示有关此函数的摘要
%   此处显示详细说明
    CTable = zeros(1, 9);
    It = size(trainingAndTestSet,1);
    parfor i = 1 : It
        X = trainingAndTestSet(i,:);
        [CT] = GetContingencyTable(data, X,minleaf);
        CTable = CTable + CT;
    end
    CTable = CTable ./ It;
    accuracyRate_0 = CTable(5) ./ CTable(6) * 100;
    accuracyRate_1 = CTable(1) ./ CTable(3) * 100;
end

