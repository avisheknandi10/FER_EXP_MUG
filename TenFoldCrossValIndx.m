function foldInd = TenFoldCrossValIndx(N)
    %N = 327; 
    vN = floor(N/10);
    %indx = 1:N;
    indx = randperm(N);
    foldInd = cell(10,2);

    for i = 1:10

        indx2 = indx;
        foldInd{i,2} = indx((i-1)*vN+1:i*vN);
        indx2((i-1)*vN+1:i*vN) = 0;
        foldInd{i,1} = nonzeros(indx2);

    end
end
