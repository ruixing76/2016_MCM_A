%长方体浴缸液体三维元胞自动机模型
clc,clear;
global tcell;       %本状态的元胞
global next_tcell;  %更新状态的元胞
global length;global width;global height;      %元胞体的长宽高
global sum_cell;    %元胞的总个数 
global P;           %热对流元胞移动概率
global P_hit;       %人做动作的概率
global humanX_start;global humanX_end;  %人体
global humanY_start;global humanY_end;
global humanZ_start;global humanZ_end;
global tcell_type;
global isHuman;         %人体判别标记
global isHeat;          %热源判别标记
global isWater;         %水的标记
%判别矩阵
tcell_type=zeros(length,width,height);
%元胞之间的距离
dis=1;
%时间间隔
time=1500; 
%用切片函数构出长方体，构造长宽高
length=40;width=60;height=20;
[x,y,z]=meshgrid(1:dis:length+1,1:dis:width+1,1:dis:height+1);
[m,n,p]=size(x);
length=m-1;width=n-1;height=p-1;
sum_cell=length*width*height;
%设定温度的变化范围
min_temperature=20;
max_temperature=45;
%热对流概率
P=0.1;   
P_hit=0.5;
%不同传热介质间的元胞厚度（元胞层数）
disslayer_num=4;
%设定参数
lambda=0.6265;  %液体之间的热导率
% lambda=0.677;
lambda2=2.3;    %液体与气体之间的热导率
lambda3=0.2;    %液体与固体之间的热导率
lambda_human=0.1; %液体与人体之间的热导率
rho=995.6;
c=4174;
%测量周期
t=35;
%每周期的平均温度
avg_t=zeros(t,1);
%设定初始温度
tcell=zeros(length,width,height);
%初始化水温
for a=1:length
    for b=1:width
        for c=1:height
            tcell(a,b,c)=randi([0 0]);
        end
    end
end

initTub();
initHuman();

next_tcell=tcell;
%CA运行
for i=1:t
%     format=sprintf('第%d时刻',i);
%     text(1,1,1,format,'fontsize',10);
    fprintf('第%d时刻\n',i);
    slice(x,y,z,tcell,[3],[],[],'cubic');  
%     axis([1 length+5 1 width+5 1 height+5]);
      axis equal;
    view(90,10);
    shading flat;
    caxis([min_temperature max_temperature]); %控制水温与颜色映射关系
    colormap jet    %标准颜色对照
    colorbar
    drawnow;  %当前立刻绘制
   
    %液体内部热传递以及散热过程
    for x1=2:length-1
        for y1=2:width-1
            for z1=2:height-1     
                if(tcell_type(x1,y1,z1)==isHuman ||tcell_type(x1,y1,z1)==isHeat)
                      continue;
                else
                  %与人体的热传递   
                  if(tcell_type(x1+1,y1,z1)==isHuman||tcell_type(x1-1,y1,z1)==isHuman||...
                         tcell_type(x1,y1+1,z1)==isHuman||tcell_type(x1,y1-1,z1)==isHuman||...
                         tcell_type(x1,y1,z1+1)==isHuman||tcell_type(x1,y1,z1-1)==isHuman)
                    next_tcell(x1,y1,z1)=(lambda_human/(rho*c))*(time/(dis*dis))*(tcell(x1+1,y1,z1)+...
                    +tcell(x1-1,y1,z1)+tcell(x1,y1+1,z1)+...
                    tcell(x1,y1-1,z1)+tcell(x1,y1,z1+1)+tcell(x1,y1,z1-1)-6*tcell(x1,y1,z1))+...
                    +tcell(x1,y1,z1);
                  end
                    %左右壁散热
                  if(x1>1&&x1<disslayer_num||x1>length-disslayer_num && x1<length) 
                       next_tcell(x1,y1,z1)=(lambda/(rho*c))*(time/dis*dis)*...
                        (lambda*(tcell(x1,y1+1,z1)+tcell(x1,y1-1,z1)+tcell(x1,y1,z1+1)+tcell(x1,y1,z1-1)-4*tcell(x1,y1,z1))+...
                        lambda3*(tcell(x1-1,y1,z1)+tcell(x1+1,y1,z1)-2*tcell(x1,y1,z1)))+tcell(x1,y1,z1);
                   end
                   %前后壁散热
                   if(y1>1&&y1<disslayer_num||y1>width-disslayer_num && y1<width) 
                       next_tcell(x1,y1,z1)=(lambda/(rho*c))*(time/dis*dis)*...
                        (lambda*(tcell(x1+1,y1,z1)+tcell(x1-1,y1,z1)+tcell(x1,y1,z1+1)+tcell(x1,y1,z1-1)-4*tcell(x1,y1,z1))+...
                        lambda3*(tcell(x1,y1+1,z1)+tcell(x1,y1-1,z1)-2*tcell(x1,y1,z1)))+tcell(x1,y1,z1);
                   end
                   %底壁散热
                   if(z1>1&&z1<disslayer_num)  
                       next_tcell(x1,y1,z1)=(lambda/(rho*c))*(time/dis*dis)*...
                        (lambda*(tcell(x1+1,y1,z1)+tcell(x1-1,y1,z1)+tcell(x1,y1+1,z1)+tcell(x1,y1-1,z1)-4*tcell(x1,y1,z1))+...
                        lambda3*(tcell(x1,y1,z1+1)+tcell(x1,y1,z1-1)-2*tcell(x1,y1,z1)))+tcell(x1,y1,z1);
                   end
                   %与空气之间的散热
                   if(z1>height-disslayer_num &&z1<height) 
                       next_tcell(x1,y1,z1)=(lambda/(rho*c))*(time/dis*dis)*...
                        (lambda*(tcell(x1+1,y1,z1)+tcell(x1-1,y1,z1)+tcell(x1,y1+1,z1)+tcell(x1,y1-1,z1)-4*tcell(x1,y1,z1))+...
                        lambda2*(tcell(x1,y1,z1+1)+tcell(x1,y1,z1-1)-2*tcell(x1,y1,z1)))+tcell(x1,y1,z1);
                   end
                   %液体内部的处理
                      next_tcell(x1,y1,z1)=(lambda/(rho*c))*(time/(dis*dis))*(tcell(x1+1,y1,z1)+...
                        +tcell(x1-1,y1,z1)+tcell(x1,y1+1,z1)+...
                        tcell(x1,y1-1,z1)+tcell(x1,y1,z1+1)+tcell(x1,y1,z1-1)-6*tcell(x1,y1,z1))+...
                        +tcell(x1,y1,z1);
                end
            end
        end
     end
    heatConvection(); %热对流过程
    humanHit();     %人的扰动过程
    
    tcell=next_tcell; 
    avg_t(i)=getAvgTemp(); %求平均温度
end