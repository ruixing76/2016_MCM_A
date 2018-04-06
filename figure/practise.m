%计算液体内部传热规律的三维元胞自动机模型
clc,clear;
global tcell;       %本状态的元胞
global next_tcell;  %更新状态的元胞
global length;      %元胞体的长宽高
global width;
global height;
global sum_cell;         %元胞的总个数
global m;global n;global p; %元胞尺寸
%元胞之间的距离
dis=1;
%时间间隔
time=1;
%用切片函数构出长方体，构造长宽高
length=20;width=20;height=20;
[x,y,z]=meshgrid(1:dis:length,1:dis:width,1:dis:height);
% [m,n,p]=size(x);
sum_cell=length*width*height;
%设定温度的变化范围
min_temperature=10;
max_temperature=50;
%设定参数
lambda=0.6265;
rho=995.6;
c=4174;
%测量周期
t=100;
%每周期的平均温度
avg_t=zeros(t,1);
%设定初始温度
tcell=zeros(length,width,height);
for a=1:length-1  
    for b=1:width-1
        for c=1:height-1
            tcell(a,b,c)=randi([40,41]);
        end
    end
end
initTub;
% tcell(1:3,1:3:1:3)=NaN;
next_tcell=tcell;
%CA运行
for i=1:t
%     format=sprintf('第%d时刻',i);
%     text(1,1,1,format,'fontsize',10);
    fprintf('第%d时刻\n',i);
%     axis([-7 7 -7 7 -8 8]);
    slice(x,y,z,tcell,length/2,width/2,[],'linear');
    shading flat;
    caxis([min_temperature max_temperature]); %控制水温与颜色映射关系
    colormap jet    %标准颜色对照
    colorbar
    drawnow;  %当前立刻绘制
    %更新元胞的状态
    %液体内部热对流模型的元胞状态更新
    for x1=2:length-1
        for y1=2:width-1
            for z1=2:height-1
                next_tcell(x1,y1,z1)=(lambda/(rho*c))*(time/(dis*dis))*(tcell(x1+1,y1,z1)+...
                    +tcell(x1-1,y1,z1)+tcell(x1,y1+1,z1)+...
                    tcell(x1,y1-1,z1)+tcell(x1,y1,z1+1)+tcell(x1,y1,z1-1)-6*tcell(x1,y1,z1))+...
                    +tcell(x1,y1,z1);
            end
        end
    end
    tcell=next_tcell; 
    avg_t(i)=getAvgTemp();
end