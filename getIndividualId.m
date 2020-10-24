function id = getIndividualId(individual)
% 为每个个体算出唯一id
% 例：个体"1011"其id为13
    N = size(individual, 2);
    id = 0;
    for  i = 1 : N
        id = id + individual(i) * 2^(i-1);
    end
end
