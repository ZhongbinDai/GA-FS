clear;                                                                     % 清空工作区
clc;                                                                       % 清空命令行窗口

load('BaseData.mat');                                                      % 载入基数据
% BaseData数据介绍：3838*55，3838条记录，54个特征，第一列表示类型0/1，二分类问题，正反样例不均衡，3253:585
testNumber = 50;                                                           % 每个个体测试次数
% 注：因为分类准确率对训练集和测试集敏感，故对个体计算准确率（适应度）时，求50组训练集/测试集的平均值；
trainingSetAndTestSet = getTrainingSetAndTestSet(testNumber, BaseData);    % 划分训练集和测试集
save('trainingSetAndTestSet.mat', 'trainingSetAndTestSet');                % 保存测试集和训练集

%% 参数配置
populationSize = 100;                                                       % 种群规模
numOfDecVariables = 54;                                                    % 决策变量维度
maxGeneration = 400;                                                       % 最大进化代数
crossoverRate = 0.6;                                                       % 交叉概率，SparseGA不需要
mutationRate = 0.02;                                                       % 变异概率，SparseGA不需要

bestIndividualSet = zeros(maxGeneration, numOfDecVariables);               % 每代最优个体集合
bestFitnessSet = zeros(maxGeneration, 1);                                  % 每代最高适应度集合
avgFitnessSet = zeros(maxGeneration, 1);                                   % 每代平均适应度集合
historyIndividualRecord = zeros(1, 12);                                    % 历史个体库，第1列为个体ID，2、3列为正负事件预测的准确率，4-12列为混淆矩阵的各项值
% 注：个体适应度计算代价大，为防止重复计算，每个个体计算适应度前先到历史库找，找到的话直接取结果；否则，计算适应度；

%% 初始化
featureMat = eye(numOfDecVariables);                                       % 单位矩阵
[featureScore,~,~,historyIndividualRecord] = GetFitness(featureMat, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
% featureScore为每个特征评分


population = sparseInitialPopulation(populationSize, numOfDecVariables, featureScore);    % 初始化种群
% 计算种群个体适应度
[popFitness,~,~,historyIndividualRecord] = GetFitness(population, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
ratioOfSelectedFeatures = sum(population') / numOfDecVariables;



% % 传统遗传算法初始化种群
% population1 = initialPopulation(populationSize, numOfDecVariables);
% [popFitness1,~,~,historyIndividualRecord] = GetFitness(population1, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
% ratioOfSelectedFeatures1 = sum(population1') / numOfDecVariables;
% 
% % 绘图，初始种群对比
% plot(ratioOfSelectedFeatures,popFitness,'o',ratioOfSelectedFeatures1,popFitness1,'o');
% legend({'SparseGA' '传统遗传算法'});
% xlabel('特征选择比');
% ylabel('适应度');
% % 盒图
% boxplot([popFitness popFitness1], {'SparseGA' '传统遗传算法'});
% ylabel('适应度');

%% 进化
for i = 1 : maxGeneration
    
    pop1 = selectionOperation(population, popFitness);                     % 选择操作
    pop2 = selectionOperation(population, popFitness);
    P = [pop1; pop2];                                                      % 规模为2N的种群
    newPopulation = variation(P, featureScore);                            % 交叉变异操作，生成子代种群
    
    % 计算子代种群个体适应度
	[newPopFitness,~,~,historyIndividualRecord] = GetFitness(newPopulation, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
    [population, popFitness] = eliteStrategy(newPopulation, newPopFitness, population, popFitness);         %精英策略
    
    bestFitness = max(popFitness);                                         % 获取种群中最高适应度
    avgFitness = mean(popFitness);                                         % 计算种群平均适应度
    index = find(popFitness == bestFitness);                               % 获取最高适应度个体下标
    bestIndividual = population(index(1),:);                               % 获取最优个体
    
    bestFitnessSet(i) = bestFitness;                                       % 写入每代最高适应度集合
    avgFitnessSet(i) = avgFitness;                                         % 写入每代平均适应度集合
    bestIndividualSet(i,:) = bestIndividual;                               % 写入每代最优个体集合
    save('bestFitness.mat', 'bestFitness');                                % 保存数据
    save('avgFitness.mat', 'avgFitness');
    save('bestIndividual.mat', 'bestIndividual');
    
    fprintf("第%3d代最高适应度为%.4f\n",i,bestFitness);
    
    % 每隔5代出张图
    if mod(i,5) == 0
        plotEvolutionCurve(i, bestFitnessSet, avgFitnessSet);
    end   
end


%% 

[bestIndividualFitness1,bestIndividualFitness0,~,historyIndividualRecord] = GetFitness(bestIndividualSet, BaseData, trainingSetAndTestSet, 1, historyIndividualRecord);
plot([1:100],bestIndividualFitness1(1:100,:));
plot([1:100],bestIndividualFitness0(1:100,:));






















