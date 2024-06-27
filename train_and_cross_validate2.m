function perf = train_and_cross_validate2(INPUT,OUTPUT,netSize)
    % Train and cross validate 
    INPUT(isnan(INPUT))= 0;
    INPUT(isinf(INPUT)) = 0;
    INPUT(INPUT>1) = 1;
    % create patterent recognition network
    net = patternnet(netSize);
    N = size(INPUT,2);
    % generate index set for 10 fold of training
    fold_index = TenFoldCrossValIndx(N);
    % Save performance for each fold
    perf = zeros(1,10);

    % train and vlidate for each fold
    for i = 1:10

        disp(i)
        % training and validation indices for i'th fold
        training_index = fold_index{i,1};
        validation_index = fold_index{i,2};
        % traing input and output data for i'th fold
        train_input =   INPUT(:,training_index);
        train_output = OUTPUT(:,training_index);
        % validation input and output data for i'th fold
        validation_input =   INPUT(:,validation_index);
        validation_output = OUTPUT(:,validation_index);
        % Combine reordered data
        INPUT2 =  [train_input,validation_input];
        OUTPUT2 = [train_output,validation_output];


        
        minperf = 1;
        counter = 0;


        while (counter<6)
            % train netwok with training data
            net = init(net);
            net.divideFcn = 'divideblock';
            net.divideParam.trainRatio = 0.9;
            net.divideParam.valRatio = 0.1;
            net.divideParam.testRatio = 0;
            [net,~] = train(net,INPUT2,OUTPUT2);        
            % simulate netwok for validation_data
            y = sim(net,validation_input);
            % Compute perfomance for each fold

            tperf = perform(net,validation_output,y);

            if  tperf < minperf
                minperf = tperf;
                counter = 0;
            else
                counter = counter + 1;
            end
            disp(tperf)
        end
        perf(i) = minperf;
    end
end
    


    