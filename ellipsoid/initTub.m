%初始温度确定
function initTub
global tcell;
global length;      %元胞体的长宽高
global width;
global height;
global tcell_type;
%空气温度
air_temperature=15;
%浴缸壁温度
tub_temperature=25;
%初始化浴缸温度
for a=1:length
    for b=1:width
        for c=1:height/2
            if(tcell_type(a,b,c)==2)  %液体内部
                tcell(a,b,c)=randi([40,41]);
            elseif(tcell_type(a,b,c)==1) %浴缸表面
                tcell(a,b,c)=tub_temperature;
            end
            if( isnan(tcell(a,b,c))==0 &&c==height/2)  %与空气接触
                tcell(a,b,c)=air_temperature;
            end
        end
    end
end


end
