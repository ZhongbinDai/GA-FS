function [population] = sparseInitialPopulation(populationSize, numOfDecVariables, featureScore)
% SparseGA，初始化种群，
% 生成populationSize个个体，每个个体由numOfDecVariables个0/1组成，每行为一个个体
    population = zeros(populationSize, numOfDecVariables);
    
    for i = 1 : populationSize
        for j = 1 : numOfDecVariables * rand
            [m, n] = getTwoRandValue(numOfDecVariables);                   % 随机选取两个不相同的整数
            if featureScore(m) < featureScore(n)
                population(i, m) = 1;
            else
                population(i, n) = 1;
            end
        end
    end

% 	total = sum(population') / numOfDecVariables;
% 	avgTotal = sum(total) / size(total,2);
% 	% 决策变量为1的数学期望为0.33
end

