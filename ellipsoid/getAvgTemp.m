%求液体内部的平均温度
function avg_temp=getAvgTemp
global tcell;global sum_cell;
global length;global width;global height;
sum_temp=0;
for i=1:length
    for j=1:width
        for k=1:height
            if(isnan(tcell(i,j,k))==0)
                sum_temp=sum_temp+tcell(i,j,k);
            end
        end
    end
end
avg_temp=sum_temp/sum_cell;
end
            