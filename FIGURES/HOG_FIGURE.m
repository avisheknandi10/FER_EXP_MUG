I = imread('HA.jpg');
pts = dlmread('HA.pts');
CS = [24 24];
BS = [4 4];
pts2 = pts([18,22,23,27,42,48,55,49,58,52,36,32],:);
[features,validPoints,ptVis] = extractHOGFeatures(I,pts2,'CellSize',CS,'BlockSize',BS); 
figure
imshow(I)
hold on
plot(ptVis,'color','green')