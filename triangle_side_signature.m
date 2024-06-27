function tss = triangle_side_signature(data)
    len = length(data);
    tss = zeros(nchoosek(len,3),1);
 
    m = 1;

    for i = 1:len
        for j = i+1:len
            for k = j+1:len
                
                x = data(i,:);
                y = data(j,:);
                z = data(k,:);
                
                a = sqrt(sum((x - y).^2));
                b = sqrt(sum((y - z).^2));
                c = sqrt(sum((z - x).^2));
                
                tss(m,:) = (max([a,b,c]) - min([a,b,c]))/(a+b+c);
                
                m = m + 1;

            end
        end
    end
end