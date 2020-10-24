N = 100;

bestIndividualSetTest = bestIndividualSet(1:N, :);

trainingSetAndTestSet1 = getTrainingSetAndTestSet(testNumber, BaseData);    % 划分训练集和测试集
historyIndividualRecord1 = zeros(1, 12);
[Fitness11,Fitness10,~,historyIndividualRecord1] = GetFitness(bestIndividualSetTest, BaseData, trainingSetAndTestSet1, 1, historyIndividualRecord1);

trainingSetAndTestSet2 = getTrainingSetAndTestSet(testNumber, BaseData);    % 划分训练集和测试集
historyIndividualRecord1 = zeros(1, 12);
[Fitness21,Fitness20,~,historyIndividualRecord1] = GetFitness(bestIndividualSetTest, BaseData, trainingSetAndTestSet2, 1, historyIndividualRecord1);


trainingSetAndTestSet3 = getTrainingSetAndTestSet(testNumber, BaseData);    % 划分训练集和测试集
historyIndividualRecord1 = zeros(1, 12);
[Fitness31,Fitness30,~,historyIndividualRecord1] = GetFitness(bestIndividualSetTest, BaseData, trainingSetAndTestSet3, 1, historyIndividualRecord1);


trainingSetAndTestSet4 = getTrainingSetAndTestSet(testNumber, BaseData);    % 划分训练集和测试集
historyIndividualRecord1 = zeros(1, 12);
[Fitness41,Fitness40,~,historyIndividualRecord1] = GetFitness(bestIndividualSetTest, BaseData, trainingSetAndTestSet4, 1, historyIndividualRecord1);


trainingSetAndTestSet5 = getTrainingSetAndTestSet(testNumber, BaseData);    % 划分训练集和测试集
historyIndividualRecord1 = zeros(1, 12);
[Fitness51,Fitness50,~,historyIndividualRecord1] = GetFitness(bestIndividualSetTest, BaseData, trainingSetAndTestSet5, 1, historyIndividualRecord1);



plot((1:N),bestIndividualFitness1(1:100,:), (1:N),Fitness11, (1:N),Fitness21, (1:N),Fitness31, (1:N),Fitness41, (1:N),Fitness51);


plot((1:N),bestIndividualFitness0(1:100,:),(1:N),Fitness10, (1:N),Fitness20, (1:N),Fitness30, (1:N),Fitness40, (1:N),Fitness50);







