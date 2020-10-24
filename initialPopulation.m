function [population] = initialPopulation(populationSize, numOfDecVariables)
% 传统遗传算法，初始化种群，
% 生成populationSize个个体，每个个体由numOfDecVariables个0/1组成，每行为一个个体
	population = round(rand(populationSize, numOfDecVariables));
    
%     total = sum(population') / numOfDecVariables;
%     avgTotal = sum(total) / size(total,2);                                 % 决策变量为1的数学期望为0.5
end
