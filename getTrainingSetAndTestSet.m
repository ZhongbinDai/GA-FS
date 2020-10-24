function [trainingSetAndTestSet] = getTrainingSetAndTestSet(testNumber, BaseData)
% 划分测试集和训练集，将原记录编号顺序随机置乱，前部分记录作训练集，前部分记录作测试集
    [N, ~] = size(BaseData);
    trainingSetAndTestSet = zeros(testNumber,N);
    for i = 1 : testNumber
        X = randperm(N);                                                   % 置乱
        trainingSetAndTestSet(i,:) = X;
    end
end


