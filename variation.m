function newPopulation = variation(P,maskFitness)
%VARIATION 此处显示有关此函数的摘要
%   此处显示详细说明
    [populationSize, numOfVariables] = size(P);
    O = zeros(populationSize/2, numOfVariables);
    
    i = 1;
    while size(P,1) > 0
        populationSize = size(P,1);
        [m,n] = getTwoRandValue(populationSize);
        p = P(m,:);
        q = P(n,:);
        if m < n
            P(n,:)=[];
            P(m,:)=[];
        else
            P(m,:)=[];
            P(n,:)=[];
        end
        o = p;
        
        % 交叉
        if rand() < 0.5
            goal = p & (1-q);
            num = sum(goal);
            if num >0
                Y = find(goal==1);
                X = randperm(num);

                m = Y(X(1));
                n = Y(X(end));
                if maskFitness(m) > maskFitness(n)
                    o(m) = 0;
                else
                    o(n) = 0;
                end
            end
        else
            goal = (1-p) & q;
            num = sum(goal);
            if num >0
                Y = find(goal==1);
                X = randperm(num);
                m = Y(X(1));
                n = Y(X(end));
                if maskFitness(m) < maskFitness(n)
                    o(m) = 1;
                else
                    o(n) = 1;
                end
            end
        end
            
        % 变异
        if rand() < 0.5
            goal = o;
            num = sum(goal);
            if num >0
                Y = find(goal==1);
                X = randperm(num);
                m = Y(X(1));
                n = Y(X(end));
                if maskFitness(m) > maskFitness(n)
                    o(m) = 0;
                else
                    o(n) = 0;
                end
            end
        else
            goal = 1 - o;
            num = sum(goal);
            if num >0
                Y = find(goal==1);
                X = randperm(num);
                m = Y(X(1));
                n = Y(X(end));
                if maskFitness(m) < maskFitness(n)
                    o(m) = 1;
                else
                    o(n) = 1;
                end
            end
        end
        
        O(i,:)=o;
        i=i+1;
    end
    newPopulation = O;
    
end

