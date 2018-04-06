% clear all;
% %导热率分析
% %没有添加热对流和人为扰动
% lambda1=[0.635 0.648 0.659 0.668 0.674 0.680 1 5 10 15];
% T1=[35.6618 35.6470 35.6283 35.6174 35.6094 35.6051 35.2134 32.3222 30.3356 28.9391];
% %添加了热对流和人为扰动
% lambda2=[0.635 0.640 0.648 0.659 0.662 0.668 0.671 0.674 0.677 0.680];
% T2=[35.6466 35.6400 35.6275 35.6112 35.6072 35.5984 35.5970 35.5930 35.5881 35.5849];
% m1=size(lambda1,2);
% n1=size(T1,2);
% m2=size(lambda2,2);
% n2=size(T2,2);
% sensitivity1=ones(m1,1);
% sensitivity2=ones(m2,1);
% %计算
% delta_lambda1=ones(m1,1);
% delta_T1=ones(n1,1);
% delta_lambda2=ones(m2,1);
% delta_T2=ones(n2,1);
% for i1=2:m1
%     delta_lambda1(i1)=lambda1(i1)-lambda1(i1-1); 
% end
% for i2=2:m2
%     delta_lambda2(i2)=lambda2(i2)-lambda2(i2-1);
% end
% for j1=2:n1
%     delta_T1(j1)=T1(j1)-T1(j1-1);
% end
% for j2=2:n2
%     delta_T2(j2)=T2(j2)-T2(j2-1);
% end
% sensitivity1=delta_T1./delta_lambda1;
% sensitivity2=delta_T2./delta_lambda2;
% % plot(lambda1(2:m1),sensitivity1(2:m1));
% % figure;
% plot(lambda2(2:m2),sensitivity2(2:m1));
% figure;
% plot(lambda2,T2);

%
% clc,clear;
% load('v_t');
% for i=2:5
% plot(v_t(2:6,1),v_t(2:6,i));
% hold on;
% end

% 
% plot(v_t(2:6,1),v_t(2:6,1));
% plot(v_t(2:6,1),v_t(2:6,2),'*');
% plot(v_t(2:6,1),v_t(2:6,3),'.');
% plot(v_t(2:6,1),v_t(2:6,4),'-');
% legend('at the temperature 37\circC',...
%     'at the temperature 50\circC',...
%     'at the temperature 47.5\circC',...
%     'at the temperature 62.5\circC');

%配置面积比例解二元一次方程
% z=60;
% eq1=(x*y)/(x*y+2*x*z+2*y*z)=0.473;
% eq2=(x*y*z=24000);
% [y,z] = solve('(50*y)/(50*y+2*50*z+2*y*z)=0.375','50*y*z=48000')

%不同面积比下温差随体积增长的图
% load('v_s');
% hold on;
% plot(v_s(1,:),v_s(2,:),'-*');
% plot(v_s(1,:),v_s(3,:),'-*');
% plot(v_s(1,:),v_s(4,:),'-*');
% % plot(v_s(1,:),v_s(5,:),'-*');
% xlabel('V');ylabel('\DeltaT');
% l=legend('area ratio=0.473','area ratio=0.300','area ratio=0.176','area ratio=0.375');
% set(l,'fontsize',15);

% load('bubble');
% hold on;
% plot(bubble(:,2),'markersize',0.8,'LineWidth',3,'color','yellow');
% plot(bubble(:,1),':','LineWidth',3,'color','red');
% legend('with bubble bath additive','without bubble bath additive');

% load('faucet');
% hold on;
% plot(faucet(:,1),'markersize',0.8,'LineWidth',5,'color','yellow');
% plot(faucet(:,2),'*','LineWidth',3,'color','red');
% plot(faucet(:,3),':','LineWidth',3,'color','blue');
% legend('faucet on the left','faucet in the middle','faucet on the right');
load('divide_faucet');
hold on;
plot(divide_faucet(:,1),'markersize',0.8,'LineWidth',2,'color','blue');
plot(divide_faucet(:,2),'LineWidth',2,'color','red');
legend('single faucet','water channel with even-distributed holes');







        