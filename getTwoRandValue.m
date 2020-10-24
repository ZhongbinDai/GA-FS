function [x, y] = getTwoRandValue(Upper)
% 从1-Upper中随机选取两个不相同的整数
    R = randperm(Upper);
    x = R(1);
    y = R(2);
end

