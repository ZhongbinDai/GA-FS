function index = searchIndex(y,X)
% 从一维矩阵X中找到y的位置
    N = size(X);
    index = -1;
    for i = 1 : N
       if  y == X(i)
           index = i;
           break;
       end
    end
end

