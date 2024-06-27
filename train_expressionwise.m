function EXP_PERF = train_expressionwise(HOG_POINTWISE,EXP)
    noEXP = max(EXP);
    EXP_PERF = cell(1,noEXP);
    for i = 1:noEXP
        fprintf('Iteration Number: %d',i);
        EXPI = double(EXP==i);
        EXP_PERF{i} = train_pointwise(HOG_POINTWISE,EXPI,10);
    end
end