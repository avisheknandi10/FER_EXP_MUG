function [bcm,bper,ACC] = train5(INPUT,OUTPUT) 
    netSize = 40;
    net = patternnet(netSize);

    minc = 1;
    minacc = 1;
    counter = 0;
    
    while (counter<20)
        
        net = init(net);
        [ net, tr] = train(net,INPUT,OUTPUT);
        y = net(INPUT);
        [c,cm,~,per] = confusion(OUTPUT,round(y));
        acc = perform(net,OUTPUT,round(y));

        if c < minc
            minc = c;
            bestNet = net;
            bestTr = tr;
            disp((1-c)*100)

            bcm = cm;
            bper = per;
        end
        
        if acc < minacc
            minacc = acc;
            counter = 0;
        else
            counter = counter + 1;
        end
    end

    % Training Accuracy
    indx = bestTr.trainInd;
    y = bestNet(INPUT(:,indx));
    tc = confusion(OUTPUT(:,indx),round(y));

    % Testing Accuracy
    indx = bestTr.testInd;
    y = bestNet(INPUT(:,indx));
    tsc = confusion(OUTPUT(:,indx),round(y));

    % Validation Accuracy
    indx = bestTr.valInd;
    y = bestNet(INPUT(:,indx));
    vc = confusion(OUTPUT(:,indx),round(y));

    % Total Accuracy
    y = bestNet(INPUT);
    c = confusion(OUTPUT,round(y));

    % All errors
    ERR = [tc,tsc,vc,c];
    ACC = (1-ERR)*100;
end

    