%求液体内部的平均温度
function avg_temp=getAvgTemp
global tcell;global tcell_type;
global length;global width;global height;
global isHuman;global isHeat;global isWater;
sum_temp=0;
water_cell_num=0;
for i=1:length
    for j=1:width
        for k=1:height
            if(tcell_type(i,j,k)==isWater)
                sum_temp=sum_temp+tcell(i,j,k);
                water_cell_num=water_cell_num+1;
            end
        end
    end
end
avg_temp=sum_temp/water_cell_num;
end
            