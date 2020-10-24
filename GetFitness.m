function [fitness1, fitness0, CTable, historyRecord] = GetFitness(population, BaseData, trainingSetAndTestSet, minleaf, historyRecord)
% 种群适应度计算
% 输入：种群、基础数据、训练集和测试集的划分、决策树最小叶子数、历史个体库
% 输出：正事件的分类精度（个体适应度）、负事件的分类精度、混淆矩阵、更新后的历史个体库
    N = size(population, 1);                                               % 种群规模
    fitness1 = zeros(N, 1);                                                % 用来存储每个个体，正事件的分类精度（个体适应度）
    fitness0 = zeros(N, 1);                                                % 用来存储每个个体，负事件的分类精度
    CTable = zeros(N,9);                                                   % 用来存储每个个体，分类的混淆矩阵
    for  i = 1 : N
        individual = population(i,:);                                      % 取出第i号个体
        id = getIndividualId(individual);                                  % 计算个体id,不同个体有唯一id与之对应
        index = searchIndex(id, historyRecord(:,1));                       % 查找个体是否存在历史个体库中，返回值>0则存在，否则不存在
        
        if index == -1                                                     % 如果该个体不在历史个体库中，则通过构造决策树分类计算适应度
            data = BaseData(:,[1,individual]==1);                          % 提取数据，表中数据转成二维矩阵数据
            [accuracyRate_1, accuracyRate_0, CT] = GetAccuracyRate(data, trainingSetAndTestSet, minleaf);	% 通过构造决策树分类，计算适应度
            fitness1(i) = accuracyRate_1;                                  % 正事件的分类精度（个体适应度）
            fitness0(i) = accuracyRate_0;                                  % 负事件的分类精度
            CTable(i,:) = CT;                                              % 混淆矩阵
            
            numOfhistoryRecord = size(historyRecord,1);                    % 历史库中个体数目
            historyRecord(numOfhistoryRecord + 1, 1) = id;                % 增加新记录
            historyRecord(numOfhistoryRecord + 1, 2) = accuracyRate_1;
            historyRecord(numOfhistoryRecord + 1, 3) = accuracyRate_0;
            historyRecord(numOfhistoryRecord + 1, 4:12) = CT;
        else                                                               % 如果该个体在历史个体库中，直接取出结果
            fitness1(i) = historyRecord(index, 2);
            fitness0(i) = historyRecord(index, 3);
            CTable(i,:) = historyRecord(index, 4:12);
        end
        fprintf('%d --->>%5.4f\n',i,fitness1(i)); 
    end
end