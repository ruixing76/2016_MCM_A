clc,clear;
%人的起始点坐标，人的厚度，人体的温度
human_start=10; human_v=3; human_temperature=37;
%类型标记
ishuman=30;
%元胞之间的距离
dis=1;
%时间间隔
time=5000; 
%用切片函数构出长方体，构造长宽高
length=30;width=30;height=30;
[x,y,z]=meshgrid(1:dis:length,1:dis:width,1:dis:height);
sum_cell=length*width*height;
%设定温度的变化范围
min_temperature=1;
max_temperature=50;
%测量周期
t=1000;
%每周期的平均温度
avg_t=zeros(t,1);
%设定初始温度
tcell=zeros(length,width,height);
%判别矩阵
tcell_type=5*zeros(length,width,height);
%初始化人体形状数据
% for thick=human_start-1:human_start+human_v
%     for i=1:height
%         tcell(human_start-1,thick,i)=human_temperature;
%         tcell(human_start,thick,i)=human_temperature;
%         tcell(human_start+1,thick,i)=human_temperature;
%         tcell(human_start+2,thick,i)=human_temperature;
%     end
%     for i=height:-1:height/2
%         tcell(human_start-2,thick,i)=human_temperature;
%         tcell(human_start-1,thick,i)=human_temperature;
%         tcell(human_start+2,thick,i)=human_temperature;
%         tcell(human_start+3,thick,i)=human_temperature;
%     end
% end
for thick=4:6
    for i=6:15
        for j=1:3
            tcell(i,thick,j)=human_temperature;
        end
    end
    for i=13:15
        for j=1:height
            tcell(i,thick,j)=human_temperature;
        end
    end
end
%初始化判别矩阵
for i=1:length
    for j=1:width
        for k=1:height
            if tcell(i,j,k)==ishuman
                tcell_type(i,j,k)=ishuman;
            end
        end
    end
end
             
slice(x,y,z,tcell,[5],[],[],'linear');
caxis([min_temperature max_temperature]); %控制水温与颜色映射关系
shading flat;
colormap jet    %标准颜色对照
colorbar
drawnow;  %当前立刻绘制

