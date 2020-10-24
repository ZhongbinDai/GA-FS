function plotEvolutionCurve(i, bestFitnessSet, avgFitnessSet)
%PLOTEVOLUTIONCURVE 此处显示有关此函数的摘要
	X = (1:i);
    Y1 = bestFitnessSet(1:i);
    Y2 = avgFitnessSet(1:i);
    plot(X,Y1,X,Y2);
    legend({'种群最高适应度' '种群平均适应度'});
    xlabel('进化代数');
    ylabel('适应度');
    pngName = [num2str(i) '.png'];
    if i < 10
        pngName = ['00' pngName];
    elseif i < 100
        pngName = ['0' pngName];
    end
    saveas(gcf,pngName)
end

