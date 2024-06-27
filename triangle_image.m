function HOG = triangle_image(pts)

    len = length(pts);
    di = zeros(len,len,len);
    for i = 1:len
        for j = 1:len
            for k = 1:len
                x = pts(i,:);
                y = pts(j,:);
                z = pts(k,:);
                
                a = sum(sqrt((x - y).^2));
                b = sum(sqrt((y - z).^2));
                c = sum(sqrt((z - x).^2));
                
                di(i,j,k) = (max([a,b,c]) - min([a,b,c]))/(a+b+c);
                
                
            end
        end  
    end

    HOG = cell(1,len);
    for i = 1:len
        HOG{1,i} = extractHOGFeatures(di(:,:,i),'CellSize',[8 8]);
    end
    HOG = cell2mat(HOG);
end
    
    