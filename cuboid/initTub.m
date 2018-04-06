%初始温度确定
function initTub
global tcell;
global tcell_type;
global length;      %元胞体的长宽高
global width;
global height;
global humanX_start;global humanX_end;
global humanY_start;global humanY_end;
global humanZ_start;global humanZ_end;
global isHeat;
global isWater;
isWater=1;
for a=2:length-1  
    for b=2:width-1
        for c=2:height-1
            tcell(a,b,c)=randi([40 41]);
            tcell_type(a,b,c)=isWater;
        end
    end
end
%空气温度
air_temperature=20;
%浴缸壁温度
tub_temperature=30;
%边缘细胞的状态规则
tcell(1,:,:)=tub_temperature;  %与浴缸接触部分元胞的温度
tcell(:,1,:)=tub_temperature;
tcell(:,:,1)=tub_temperature;
tcell(length:length+1,:,:)=tub_temperature;
tcell(:,width:width+1,:)=tub_temperature;
tcell(:,:,height:height+1)=air_temperature; %与空气直接接触部分元胞的温度

%添加水龙头热源
isHeat=37;
hs_temperature=47.5;      %热源的温度
hs_x=3;hs_y=3;   %热源的起始坐标
hs_length=2;hs_width=3;hs_height=7; %热源的尺寸
% 创建热源0
for i=hs_x:hs_x+hs_length
    for j=hs_y:hs_width+hs_y
        for k=height:-1:height-hs_height
            tcell(i,j,k)=hs_temperature;
            tcell_type(i,j,k)=isHeat;
        end
    end
end
% hs_x=length/2;hs_y=3;   %热源的起始坐标
% hs_length=2;hs_width=2;hs_height=2; %热源的尺寸
% for i=hs_x:hs_x+hs_length
%     for j=hs_y:hs_width+hs_y
%         for k=height:-1:height-hs_height
%             tcell(i,j,k)=hs_temperature;
%             tcell_type(i,j,k)=isHeat;
%         end
%     end
% end
% hs_x=length-3;hs_y=3;   %热源的起始坐标
% hs_length=2;hs_width=2;hs_height=2; %热源的尺寸
% for i=hs_x:hs_x+hs_length
%     for j=hs_y:hs_width+hs_y
%         for k=height:-1:height-hs_height
%             tcell(i,j,k)=hs_temperature;
%             tcell_type(i,j,k)=isHeat;
%         end
%     end
% end
% hs_x=3;hs_y=width-3;   %热源的起始坐标
% hs_length=2;hs_width=2;hs_height=2; %热源的尺寸
% for i=hs_x:hs_x+hs_length
%     for j=hs_y:hs_width+hs_y
%         for k=height:-1:height-hs_height
%             tcell(i,j,k)=hs_temperature;
%             tcell_type(i,j,k)=isHeat;
%         end
%     end
% end
% hs_x=length/2;hs_y=width-3;   %热源的起始坐标
% hs_length=2;hs_width=2;hs_height=2; %热源的尺寸
% for i=hs_x:hs_x+hs_length
%     for j=hs_y:hs_width+hs_y
%         for k=height:-1:height-hs_height
%             tcell(i,j,k)=hs_temperature;
%             tcell_type(i,j,k)=isHeat;
%         end
%     end
% end
% hs_x=length-3;hs_y=width-3;   %热源的起始坐标
% hs_length=2;hs_width=2;hs_height=2; %热源的尺寸
% for i=hs_x:hs_x+hs_length
%     for j=hs_y:hs_width+hs_y
%         for k=height:-1:height-hs_height
%             tcell(i,j,k)=hs_temperature;
%             tcell_type(i,j,k)=isHeat;
%         end
%     end
% end

%人体
% humanX_start=20;humanX_end=24;
% humanY_start=width/2-3;humanY_end=width/2+3;
% humanZ_start=2;humanZ_end=height;
% tcell(humanX_start:humanX_end,humanY_start:humanY_end,humanZ_start:humanZ_end)=37.5;
end
