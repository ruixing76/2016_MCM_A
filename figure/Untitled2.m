clear all;
dis=1;
length=50;width=30;height=20;
[x,y,z]=meshgrid(1:dis:length+1,1:dis:width+1,1:dis:height+1);
[m,n,p]=size(x);
v=zeros(m,n,p);
slice(x,y,z,v,2,[],[],'linear');