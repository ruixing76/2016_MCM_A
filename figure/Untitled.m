clear all;
for jb=2
    
    ZJS=[];
    HJS=0;
     %元胞自动机程序：三维浴缸温度场的模拟
  %参数的初始化
ft=30;   %水上空气的温度
bt=25;  %浴缸壁的温度
wt0=45;  %初始水的温度
 %c代表真个浴缸空间，包括浴缸壁和浴缸里面的空间和部分浴缸周围的空气
 %浴缸空间的参数L长，W宽，H高
L=160;W=60;H=60;
L=L+1;W=W+1;H=H+1;
c(H,W,L)=0;
 %原点O的坐标Ox,Oy,Oz;
Ox=(H+1)/2;
Oy=(W+1)/2;
Oz=(L+1)/2;
 %浴缸的形状大小参长l,w,h,及温度初始化；
l=150; w =50; h =50;
l=l+1;w=w+1;h=h+1;
c(1:(Ox-(h-1)/2)-1,:,:)=ft;
c((Ox+(h-1)/2)+1:H,:,:)=bt;
c(:,1:(Oy-(w-1)/2)-1,:)=bt;
c(:,(Oy+(w-1)/2)+1:W,:)=bt;
c(:,:,1:(Oz-(l-1)/2)-1)=bt;
c(:,:,(Oz+(l-1)/2)+1:L)=bt;

%计算浴缸壁的位置坐标x_tub,y_tub,z_tub
x_tub=[Ox-floor(h/2)-1,Ox+floor(h/2)+1];
y_tub=[Oy-floor(w/2)-1,Oy+floor(w/2)+1];
z_tub=[Oz-floor(l/2)-1,Oz+floor(l/2)+1]; 

 %水温的初始化和水的地址
C(H,W,L)=0; %水的地址矩阵
for i=1:L
CC=zeros(H,W);
CC(find(c(:,:,i)==0))=1;
C(:,:,i)=CC;
end
c=C.*wt0+c;
  %人体的建模初始化
  %人体腿部参数的输入
  %r腿的直径，lg腿的长度，tp0人体表面的初始温度，tp1人体表面的平衡温度
  tp0=37;tp1=40;
  r=15;lg=100;
  for i=floor(((Oz-(l-1)/2)-1)+(l-lg)/2):floor(((Oz-(l-1)/2)-1)+(l-lg)/2)+lg-1
      c([floor((Ox+(h-1)/2)):-1:floor((Ox+(h-1)/2))-(r-1)],[floor((Oy-(w-1)/2)-1+(w-r)/2):floor((Oy-(w-1)/2)-1+(w-r)/2)+r-1],i)=tp0;
  end
  %人体上半身的数据输入和初始化
 a=20,b=30;
      c([x_tub(1)+1:x_tub(2)-1],[Oy-floor(b/2):Oy+floor(b/2)],[z_tub(1)+1:z_tub(1)+a])=tp0;
   
C1(H,W,L)=0; %人的地址
for i=1:L
    CC=zeros(H,W);
    CC(find(c(:,:,i)==tp0))=1;
    C1(:,:,i)=CC;
end
C=C-C1;
%空气的地址

C2(H,W,L)=0; %空气的地址
for i=1:L
    CC=zeros(H,W);
    CC(find(c(:,:,i)==ft))=1;
    C2(:,:,i)=CC;
end

%浴缸壁的地址
C3(H,W,L)=0; %人的地址
for i=1:L
    CC=zeros(H,W);
    CC(find(c(:,:,i)==bt))=1;
    C3(:,:,i)=CC;
end

%温度场的模拟
%参数的输ru
 k=0.7;
 %进水半径wr
 wr=10;
 %记录温度观测点的温度：
%设置温度观测点的位置
gc1=[floor(Ox-h/2)+2,Oy,z_tub(1)+a+2];
gc2=[Ox,Oy,z_tub(1)+a+2];
gc3=[floor(Ox+h/2-r)-2,Oy,z_tub(1)+a+2];
gc4=[floor(Ox+h/2-r)-2,Oy,Oz];
gc5=[floor(Ox+h/2-r)-2,Oy,floor(Oz+l/2)];
gc6=[x_tub(1)+17,y_tub(2)-floor(wr/2),z_tub(1)+floor(wr/2)];
gc7=[x_tub(2)-5,y_tub(1)+floor(wr/2),z_tub(1)+floor(wr/2)];
sj=90;
 %产生123456计算温度矩阵
 fjs=0; %初始状态下令进水标示为0
 
 %设置水量调节的模式jb=1为一级调节，jb=2为3级调节
  
 
 for t=1:sj
     
 D1(:,:,1:L-1)=c(:,:,2:L);
 D1(:,:,L)=c(:,:,1);
  D2(:,:,1)=c(:,:,L);
 D2(:,:,2:L)=c(:,:,1:L-1);
 D3(:,1:W-1,:)=c(:,2:W,:);
 D3(:,W,:)=c(:,1,:);
 D4(:,1,:)=c(:,W,:);
 D4(:,2:W,:)=c(:,1:W-1,:);
 D5(1:H-1,:,:)=c(2:H,:,:);
 D5(H,:,:)=c(1,:,:);
 D6(1,:,:)=c(H,:,:);
 D6(2:H,:,:)=c(1:H-1,:,:);
 
  %计算热传导
  
 c=(((D1+D2+D3+D4+D5+D6)-6*c).*k.*C)/6+c;
 %记录观测点的温度
  GC1(t)=c(gc1(1),gc1(2),gc1(3));
  GC2(t)=c(gc2(1),gc2(2),gc2(3));
  GC3(t)=c(gc3(1),gc3(2),gc3(3));
  GC4(t)=c(gc4(1),gc4(2),gc4(3));
  GC5(t)=c(gc5(1),gc5(2),gc5(3));
  GC6(t)=c(gc6(1),gc6(2),gc6(3));
  GC7(t)=c(gc7(1),gc7(2),gc7(3));
  GC(t)= (GC1(t)+GC2(t)+GC3(t)+GC4(t)+GC5(t)+GC6(t)+GC7(t))/7;    
 %判断是否进水

if jb==1

 if GC(t)<43
     fjs=1;
     lv=3;
 end
end
if jb==2
    
     if GC(t)<43
     fjs=1;
     lv=1;
     end
     if GC(t)<40
     fjs=1;
     lv=2;
     end
     if GC(t)<37
     fjs=1;
     lv=3;
     end
    
    
end

 if GC(t)>45&fjs==1
     fjs=0;
 end
    
 if fjs==1
%进水和出水模型
%由测量点的温度来决定是否进水和出水，进水的量和温度可以根据测量点的温度决定
%进水量分为3档
lever=[5,10,15];
 %一分钟的进水半径
 wr=10;
 %进水水温
  tjw=60;
 %进水模型是在已有c上进行操作
 %一分钟的进水量
 %进出水操作
 
 c(x_tub(1)+1:x_tub(1)+lever(lv),y_tub(1)+1:y_tub(2)-1-wr,z_tub(2)-wr:z_tub(2)-1)=c(x_tub(1)+1:x_tub(1)+lever(lv),y_tub(1)+wr+1:y_tub(2)-1,z_tub(2)-wr:z_tub(2)-1);
 c(x_tub(1)+1:x_tub(1)+lever(lv),y_tub(2)-wr:y_tub(2)-1,z_tub(1)+1+wr:z_tub(2)-1)=c(x_tub(1)+1:x_tub(1)+lever(lv),y_tub(2)-wr:y_tub(2)-1,z_tub(1)+1:z_tub(2)-1-wr);
 c(x_tub(1)+1:x_tub(1)+lever(lv),y_tub(2)-wr:y_tub(2)-1,z_tub(1)+1:z_tub(1)+wr)=ones(lever(lv),wr,wr).*tjw;
 %统计进水量
 JS(t)=wr*wr*lever(lv);
 ZJS(t)=HJS+JS(t);
 HJS=ZJS(t);
 end 
  if fjs==0
      JS(t)=0;
      ZJS(t)=HJS+JS(t);
      HJS=ZJS(t);
  end
  end
 if jb==1
     subplot(3,1,1);plot(1:sj,GC,'r');ylim([30,50]);hold on;
     subplot(3,1,2); plot(1:sj,JS/1000);ylim([0,2]);hold on;
     subplot(3,1,3);plot(1:sj,ZJS/1000);hold on;
 end
 
 
 if jb==2
     
     subplot(3,1,1);plot(1:sj,GC,'r');ylim([30,50]);hold on;
     subplot(3,1,2); plot(1:sj,JS/1000);ylim([0,2]);hold on;
     subplot(3,1,3);plot(1:sj,ZJS/1000);hold on;
     
 end
end