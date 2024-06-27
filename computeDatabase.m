function DATAH = computeDatabase(PATH,POINT_SEL)
    FILES = dir([PATH,'*.pts']);
    h = waitbar(0,'Please wait computing Signatures ...');
    HOG = cell(length(FILES),1);

    for i = 1:length(FILES)
        disp(i)
        name = FILES(i).name;
        %get landmarks
        pts = round(dlmread([PATH,name]));
        
        pts2 = pts(POINT_SEL,:);
        HOG{i} = triangle_image(pts2);
        
        waitbar(i / length(FILES))
    end
    close(h)
    DATAH = cell2mat(HOG);
    DATAH(isnan(DATAH)) = 0;
end

        
        