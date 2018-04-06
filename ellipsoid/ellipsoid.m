%椭球浴缸液体三维元胞自动机模型
global tcell;
global length;global width;global height;
global tcell_type;
clc,clear;
%椭球外切长方体
length=100;width=60;height=40;
%元胞之间的距离
dis=1;
%更新的时间周期
t=1;
%每周期的平均温度
avg_t=zeros(t,1);
%设定温度的变化范围
min_temperature=20;
max_temperature=42;
%椭球的中心位置，同时也是椭球参数a,b,c的值
center_length=length/2; 
center_width=width/2;
center_height=height/2;
[x,y,z]=meshgrid(1:dis:width+1,1:dis:length+1,1:dis:height+1);
[m,n,p]=size(x);
length=m-1;width=n-1;height=p-1;
tcell=zeros(m,n,p);
%椭球判别矩阵
tcell_type=ones(m,n,p);
%初始温度的确定
% for a=1:length   
%     for b=1:width
%         for c=1:height
%             tcell(a,b,c)=randi([40 41]);
%         end
%     end
% end
%椭球的建立
for a=1:m   
    for b=1:n
        for c=1:p
            %构造椭球体
            %处于椭球体外部的元胞
            if power((a-center_length),2)/center_length^2+power((b-center_width),2)/center_width^2+power((c-center_height),2)/center_height^2>1
                tcell(a,b,c)=NaN;
                tcell_type(a,b,c)=0;
            %处于椭球体面上的元胞
            elseif power((a-center_length),2)/center_length^2+power((b-center_width),2)/center_width^2+power((c-center_height),2)/center_height^2<1 &&...
                power((a-center_length),2)/center_length^2+power((b-center_width),2)/center_width^2+power((c-center_height),2)/center_height^2>0.9
                tcell_type(a,b,c)=1;
                tcell(a,b,c)=15;
            %处于椭球体内部的元胞
            else
                tcell_type(a,b,c)=2;
                tcell(a,b,c)=randi([40,41]);
            end
            %去除上半面
            if (isnan(tcell(a,b,c))==0)&&c>center_height+1   
                tcell(a,b,c)=NaN;
                tcell_type(a,b,c)=0;
            end
            if( isnan(tcell(a,b,c))==0 &&c==height/2)  %与空气接触
                tcell(a,b,c)=10;
            end
        end
        
    end
end
% initTub();
%开始模拟散热
for s=1:t
    fprintf('第%d时刻\n',s);
    slice(x,y,z,tcell,[-1:length+1],[],[],'linear');
%     axis([1 length,1 width+1,1 height/2]);
    axis equal;
    shading flat;
    caxis([min_temperature max_temperature]); %控制水温与颜色映射关系
    colormap jet;
    colorbar;
    grid on;
    drawnow;
    for i=1:length
        for j=1:width
            for k=1:height/2
                if (tcell_type(i,j,k)==1)
                    tcell(i,j,k)=tcell(i,j,k)-1;
                end
            end
        end
    end
%     tcell=tcell-1;
    avg_t(s)=getAvgTemp();
end

