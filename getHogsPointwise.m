function [EXP,EXP2,HOG_POINTWISE] = getHogsPointwise(PATH,CS,BS)
    FILES = dir([PATH,'*.pts']);    
    EXP = zeros(length(FILES),1);
    emotions = {'an','di','fe','ha','sa','su','ne'}; 
    h1 = waitbar(0,'Please wait computing Signatures ...');
    HOG = cell(length(FILES),1);

    for i = 1:length(FILES)
        disp(i)

        name = FILES(i).name;
        % Get Emotions
        for j = 1:length(emotions)
            if contains(name,emotions{j})
                EXP(i) = j;
            end
        end
        %get landmarks
        pts = round(dlmread([PATH,name]));
        pts = pts(2:end,:);
        %read image
        img = imread([PATH,strrep(name,'.pts','.jpg')]);

        if length(size(img)) == 3
            img = rgb2gray(img);
        end

        %Extend imge
        [h,w] = size(img);
        img1 = ones([h+200,w+200],'uint8')*255;
        % copy image inside extended image
        for j = 1:h
            for k = 1:w
                img1(j+100,k+100) = img(j,k);
            end
        end
        % shift points
        pts = pts + 100;
        [HOG{i},~] = extractHOGFeatures(img1,pts,'CellSize',CS,'BlockSize',BS);
        waitbar(i / length(FILES))

    end
    close(h1)
    %preprocess output
    I = eye(7);
    EXP2 = I(EXP,:);
    
    % check if size did not match
    HOG2 = HOG;
    [noPoint, noFeature] = size(HOG2{i});
    noSample = length(HOG2);
    flag = true;
    for i = 1:noSample
        [r,c] = size(HOG2{i});
        if r ~= noPoint && c~= noFeature
            fprintf('Dimention mismattch at %d',i)
            flag = flase;
        end
    end
    % preprocess data for training
    noPoints = length(pts);
    if flag
        HOG2 = cell2mat(HOG2');
        HOG_POINTWISE = cell(noPoints,1);
        for i = 1:noPoints
            DAT = HOG2(i,:);
            HOG_POINTWISE{i} = reshape(DAT,[noFeature,noSample]);
        end
    end
end