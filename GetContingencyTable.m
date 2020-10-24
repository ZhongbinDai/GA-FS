function [CTable] = GetContingencyTable(data,trainingAndTest,minleaf)
%% 
    %% 随机产生训练集/测试集
    trainNum = 3000;                                                        %训练集数据数
    Train = data(trainingAndTest(1:trainNum),:);                            %训练集
    Test = data(trainingAndTest(trainNum + 1:end),:);                       %测试集

    %% 训练数据
    P_train = Train(:,2:end);
    T_train = Train(:,1);

    %% 测试数据
    P_test = Test(:,2:end);
    T_test = Test(:,1);

    %% 创建决策树分类器
    ctree = ClassificationTree.fit(P_train,T_train,'minleaf',minleaf);
    % view(ctree);
    % view(ctree,'mode','graph');

    %% 仿真测试
    T_sim = predict(ctree, P_test);
    
    %%
    hits =                  length(find(T_sim == 1 & table2array(T_test) == 1));
    misses =                length(find(T_sim == 0 & table2array(T_test) == 1));
    observed_yes =          hits + misses;
    false_alarms =          length(find(T_sim == 1 & table2array(T_test) == 0));
    correct_negatives =     length(find(T_sim == 0 & table2array(T_test) == 0));
    observed_no =           false_alarms + correct_negatives;
    
    forecast_yes =          hits + false_alarms;
    forecast_no =           misses + correct_negatives;
    total =                 forecast_yes + forecast_no;
    
    precision_0 = correct_negatives ./ observed_no * 100;
    precision_1 = hits ./ observed_yes * 100;
    
    CTable = [hits misses observed_yes false_alarms correct_negatives observed_no forecast_yes forecast_no total];
    
end

