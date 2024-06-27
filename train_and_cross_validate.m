function PERF = train_and_cross_validate(DATASET,EXP)
    PERF = cell(1,7);
    for i = 1:7
        fprintf('Expression ID: %d',i);
        DATAI = cell2mat(DATASET(:,i)')';
        EXPI = double(EXP==i);
        PERF{i} = train_and_cross_validate2(DATAI,EXPI);
    end
end