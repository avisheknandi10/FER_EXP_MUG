function Per = train_pointwise(HOG_POINTWISE,EXP2,netSize)
    OUTPUT = EXP2';
    Per = zeros(68,7);
    net = patternnet(netSize);
    h = waitbar(0,'Please wait computing Signatures ...');
    for i = 1:68

        disp(i);
        INPUT = HOG_POINTWISE{i};
        
        
        net = init(net);
        [net,tr] = train(net,INPUT,OUTPUT);
        
        valInd = tr.valInd;
        testInd = tr.testInd;
        tInd = [valInd,testInd];
        tINPUT = INPUT(:,tInd);
        tOUTPUT = OUTPUT(:,tInd);
        
        y = sim(net,tINPUT);
        
        Perf = perform(net,tOUTPUT,y);
        [~,~,~,per] = confusion(tOUTPUT,round(y));
        
        
        disp(Perf)
        Per(i,:) = (per(:,3)+per(:,4))/2;
        waitbar(i / 68)
    end
    close(h)
end