function PointSelectionSaveImage(POINT_SEL,path_to_images)
    TAG = {'AN','DI','FE','HA','SA','SU','NE'};
    for i = 1:size(POINT_SEL,2)
        I = imread([path_to_images,TAG{i},'.jpg']);
        pts = dlmread([path_to_images,TAG{i},'.pts']);
        sel_pts = pts(POINT_SEL(:,i),:);
        %I2 = insertMarker(I,sel_pts,'s','size',6,'Color','yellow');
        I2 = insertText(I,sel_pts,POINT_SEL(:,i),'AnchorPoint', 'Center');
        imwrite(I2,[path_to_images,TAG{i},'.png'])
    end
end
