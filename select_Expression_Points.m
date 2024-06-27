function POINT_SEL = select_Expression_Points(EXP_PERF,noPoint)
    noEXP = length(EXP_PERF);
    POINT_SEL = cell(1,noEXP);
    for i = 1:noEXP
       [~,POINT_SEL{i}] = mink(EXP_PERF{i},noPoint);  
    end
end