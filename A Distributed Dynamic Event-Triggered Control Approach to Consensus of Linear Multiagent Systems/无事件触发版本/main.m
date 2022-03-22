close all; clear all;
global uu  A B ;
A2=[0 0.002 0;-0.002 0 0;0 0 0];
A=[zeros(3,3) eye(3);diag([0 3*0.001^2 -0.001^2]) A2];B=[zeros(3,3) eye(3)]';
K=[0.2795 -0.0007 0 0.7623 0 0;
   0.0007 0.2795 0 0 0.7623 0;
   0 0 0.2795 0 0 0.7623];
aij=[0 1 0 0 0 0;
     1 0 1 1 0 1;
     0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 1 0 0 0 1;
     1 0 0 0 1 0];
 x=-3+(3+3)*rand(36,1);
X1=[];uc=[];
s=0.01;
Ts=0:s:20;
for t=0:s:20
    X1=[X1,x];
e1=aij(1,1)*(x(1:6)-x(1:6))+aij(1,2)*(x(7:12)-x(1:6))+aij(1,3)*(x(13:18)-x(1:6))+aij(1,4)*(x(19:24)-x(1:6))+aij(1,5)*(x(25:30)-x(1:6))+aij(1,6)*(x(31:36)-x(1:6));
e2=aij(2,1)*(x(1:6)-x(7:12))+aij(2,2)*(x(7:12)-x(7:12))+aij(2,3)*(x(13:18)-x(7:12))+aij(2,4)*(x(19:24)-x(7:12))+aij(2,5)*(x(25:30)-x(7:12))+aij(2,6)*(x(31:36)-x(7:12));
e3=aij(3,1)*(x(1:6)-x(13:18))+aij(3,2)*(x(7:12)-x(13:18))+aij(3,3)*(x(13:18)-x(13:18))+aij(3,4)*(x(19:24)-x(13:18))+aij(3,5)*(x(25:30)-x(13:18))+aij(3,6)*(x(31:36)-x(13:18));
e4=aij(4,1)*(x(1:6)-x(19:24))+aij(4,2)*(x(7:12)-x(19:24))+aij(4,3)*(x(13:18)-x(19:24))+aij(4,4)*(x(19:24)-x(19:24))+aij(4,5)*(x(25:30)-x(19:24))+aij(4,6)*(x(31:36)-x(19:24));
e5=aij(5,1)*(x(1:6)-x(25:30))+aij(5,2)*(x(7:12)-x(25:30))+aij(5,3)*(x(13:18)-x(25:30))+aij(5,4)*(x(19:24)-x(25:30))+aij(5,5)*(x(25:30)-x(25:30))+aij(5,6)*(x(31:36)-x(25:30));
e6=aij(6,1)*(x(1:6)-x(31:36))+aij(6,2)*(x(7:12)-x(31:36))+aij(6,3)*(x(13:18)-x(31:36))+aij(6,4)*(x(19:24)-x(31:36))+aij(6,5)*(x(25:30)-x(31:36))+aij(6,6)*(x(31:36)-x(31:36));

u1=K*e1;
u2=K*e2;
u3=K*e3;
u4=K*e4;
u5=K*e5;
u6=K*e6;

uu=[u1;u2;u3;u4;u5;u6];
uc=[uc uu];
[~,X_1]=ode45('x111',[t-s,t],x);%微分得X_1值
x=X_1(end,:)';%生成行向量，转置成列向量
end
    


figure(1)%第一个分量的轨迹图
for i=1:6
plot(Ts,X1(6*i-5,:));
hold on
end
xlabel('time(s)');
% set(gca,'XTickLabel',(0:10:40));
ylabel('$x_{i1}(t)$','interpreter','latex','FontSize',12);
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');


figure(2)%第二个分量的轨迹图
for i=1:6
plot(Ts,X1(6*i-4,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  


figure(3)%第三个分量的轨迹图
for i=1:6
plot(Ts,X1(6*i-3,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  



figure(4)%第四个分量的轨迹图
for i=1:6
plot(Ts,X1(6*i-2,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6'); 

figure(5)%第五个分量的轨迹图
for i=1:6
plot(Ts,X1(6*i-1,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  


figure(6)%第六个分量的轨迹图
for i=1:6
plot(Ts,X1(6*i,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6'); 


figure%控制输入轨迹图
for i=1:6
plot(Ts,uc(i,:),'LineWidth',1.2);
hold on
end
xlabel('time(s)');
xp1=legend('u1','u2','u3','u4','u5','u6');   








 
    



