close all; clear all;
global uu A B EE Z;
A2=[0 0.002 0;-0.002 0 0;0 0 0];
A=[zeros(3,3) eye(3);diag([0 3*0.001^2 -0.001^2]) A2];B=[zeros(3,3) eye(3)]';
A1=[0 1 0 0 0 0;1 0 1 1 0 1;0 0 0 1 0 0;0 0 0 0 1 0;0 1 0 0 0 1;1 0 0 0 1 0];
L=[1 -1 0 0 0 0;-1 4 -1 -1 0 -1;0 0 1 -1 0 0;0 0 0 1 -1 0;0 -1 0 0 2 -1;-1 0 0 0 -1 2];
K=[0.2795 -0.0007 0 0.7623 0 0;0.0007 0.2795 0 0 0.7623 0;0 0 0.2795 0 0 0.7623];
deta=[2.8 1.2 1.2 2.4 2 1.6]*10^(-3);
pi_i=0.002;
a=1;
eta=[2 2 2 2 2 2]';
x=-3+(3+3)*rand(36,1);
xtk_1=x;
xtk_2=x;
xtk_3=x;
xtk_4=x;
xtk_5=x;
xtk_6=x;
e01=[];de1=[];e02=[];de2=[];e03=[];de3=[];e04=[];de4=[];EEE=[];ZZZ=[];
uc=[];num1=0;num2=0;num3=0;num4=0;num5=0;num6=0;

Rk1=[];Rk2=[];Rk3=[];Rk4=[];Xtk_1=[];Xtk_2=[];Xtk_3=[];Xtk_4=[];
x1=[];x1hat=[];E=[];p1=zeros(4,1);pp=[];Eta=[];
T_1=[];T_2=[];T_3=[];T_4=[];T_5=[];T_6=[];
e=zeros(8,1);
s=0.01;
Ts=0:s:40;
for t=0:s:40
    Eta=[Eta eta];
    x1=[x1,x];
q1=A1(1,1)*(x(1:6)-x(1:6))+A1(1,2)*(x(7:12)-x(1:6))+A1(1,3)*(x(13:18)-x(1:6))+A1(1,4)*(x(19:24)-x(1:6))+A1(1,5)*(x(25:30)-x(1:6))+A1(1,6)*(x(31:36)-x(1:6));
% q1=A1(1,1)*(x([1:6])-x(1:6))+A1(1,2)*(x([1:6]+6)-x(1:6))+A1(1,3)*(x([1:6]+2*6)-x(1:6))+A1(1,4)*(x([1:6]+3*6)-x(1:6))+A1(1,5)*(x([1:6]+4*6)-x(1:6))+A1(1,6)*(x([1:6]+5*6)-x(1:6));
q2=A1(2,1)*(x(1:6)-x(7:12))+A1(2,2)*(x(7:12)-x(7:12))+A1(2,3)*(x(13:18)-x(7:12))+A1(2,4)*(x(19:24)-x(7:12))+A1(2,5)*(x(25:30)-x(7:12))+A1(2,6)*(x(31:36)-x(7:12));
q3=A1(3,1)*(x(1:6)-x(13:18))+A1(3,2)*(x(7:12)-x(13:18))+A1(3,3)*(x(13:18)-x(13:18))+A1(3,4)*(x(19:24)-x(13:18))+A1(3,5)*(x(25:30)-x(13:18))+A1(3,6)*(x(31:36)-x(13:18));
q4=A1(4,1)*(x(1:6)-x(19:24))+A1(4,2)*(x(7:12)-x(19:24))+A1(4,3)*(x(13:18)-x(19:24))+A1(4,4)*(x(19:24)-x(19:24))+A1(4,5)*(x(25:30)-x(19:24))+A1(4,6)*(x(31:36)-x(19:24));
q5=A1(5,1)*(x(1:6)-x(25:30))+A1(5,2)*(x(7:12)-x(25:30))+A1(5,3)*(x(13:18)-x(25:30))+A1(5,4)*(x(19:24)-x(25:30))+A1(5,5)*(x(25:30)-x(25:30))+A1(5,6)*(x(31:36)-x(25:30));
q6=A1(6,1)*(x(1:6)-x(31:36))+A1(6,2)*(x(7:12)-x(31:36))+A1(6,3)*(x(13:18)-x(31:36))+A1(6,4)*(x(19:24)-x(31:36))+A1(6,5)*(x(25:30)-x(31:36))+A1(6,6)*(x(31:36)-x(31:36));

e1=A1(1,1)*(xtk_1(1:6)-xtk_1(1:6))+A1(1,2)*(xtk_1(7:12)-xtk_1(1:6))+A1(1,3)*(xtk_1(13:18)-xtk_1(1:6))+A1(1,4)*(xtk_1(19:24)-xtk_1(1:6))+A1(1,5)*(xtk_1(25:30)-xtk_1(1:6))+A1(1,6)*(xtk_1(31:36)-xtk_1(1:6));
e2=A1(2,1)*(xtk_2(1:6)-xtk_2(7:12))+A1(2,2)*(xtk_2(7:12)-xtk_2(7:12))+A1(2,3)*(xtk_2(13:18)-xtk_2(7:12))+A1(2,4)*(xtk_2(19:24)-xtk_2(7:12))+A1(2,5)*(xtk_2(25:30)-xtk_2(7:12))+A1(2,6)*(xtk_2(31:36)-xtk_2(7:12));
e3=A1(3,1)*(xtk_3(1:6)-xtk_3(13:18))+A1(3,2)*(xtk_3(7:12)-xtk_3(13:18))+A1(3,3)*(xtk_3(13:18)-xtk_3(13:18))+A1(3,4)*(xtk_3(19:24)-xtk_3(13:18))+A1(3,5)*(xtk_3(25:30)-xtk_3(13:18))+A1(3,6)*(xtk_3(31:36)-xtk_3(13:18));
e4=A1(4,1)*(xtk_4(1:6)-xtk_4(19:24))+A1(4,2)*(xtk_4(7:12)-xtk_4(19:24))+A1(4,3)*(xtk_4(13:18)-xtk_4(19:24))+A1(4,4)*(xtk_4(19:24)-xtk_4(19:24))+A1(4,5)*(xtk_4(25:30)-xtk_4(19:24))+A1(4,6)*(xtk_4(31:36)-xtk_4(19:24));
e5=A1(5,1)*(xtk_5(1:6)-xtk_5(25:30))+A1(5,2)*(xtk_5(7:12)-xtk_5(25:30))+A1(5,3)*(xtk_5(13:18)-xtk_5(25:30))+A1(5,4)*(xtk_5(19:24)-xtk_5(25:30))+A1(5,5)*(xtk_5(25:30)-xtk_5(25:30))+A1(5,6)*(xtk_5(31:36)-xtk_5(25:30));
e6=A1(6,1)*(xtk_6(1:6)-xtk_6(31:36))+A1(6,2)*(xtk_6(7:12)-xtk_6(31:36))+A1(6,3)*(xtk_6(13:18)-xtk_6(31:36))+A1(6,4)*(xtk_6(19:24)-xtk_6(31:36))+A1(6,5)*(xtk_6(25:30)-xtk_6(31:36))+A1(6,6)*(xtk_6(31:36)-xtk_6(31:36));
   
e11=e1-q1;
e22=e2-q2;
e33=e3-q3;
e44=e4-q4;
e55=e5-q5;
e66=e6-q6;

u1=K*e1;
u2=K*e2;
u3=K*e3;
u4=K*e4;
u5=K*e5;
u6=K*e6;

uu=[u1;u2;u3;u4;u5;u6];
uc=[uc uu];

EE=[norm(e11)^2 norm(e22)^2 norm(e33)^2 norm(e44)^2 norm(e55)^2 norm(e66)^2]';
EEE=[EEE EE];


Z=[norm(q1)^2 norm(q2)^2 norm(q3)^2 norm(q4)^2 norm(q5)^2 norm(q6)^2]';
ZZZ=[ZZZ Z];

    [~,xc]=ode45('x111',[t-s,t],x);%微分得xc值
    x=xc(end,:)';
    
f1=norm(e11)^2-deta(1)*norm(q1)^2-pi_i*eta(1);
if f1>=0
        e01=[e01 norm(e11)^2];
        de1=[de1 deta(1)*norm(q1)^2];
     xtk_1=x;
     t1=a;
     T_1=[T_1;t1];
        num1=num1+1;
end
f2=norm(e22)^2-deta(2)*norm(q2)^2-pi_i*eta(2);
    if f2>=0
%         e02=[e02 norm(e(2:4))];
%         de2=[de2 rr(2)*norm(deta(2:4))];
     xtk_2=x;
     t1=a;
     T_2=[T_2;t1];
        num2=num2+1;
    end
  f3=norm(e33)^2-deta(3)*norm(q3)^2-pi_i*eta(3);  
    if f3>=0
%         e03=[e03 norm(e(5:6))];
%         de3=[de3 rr(3)*norm(deta(5:6))];
     xtk_3=x;
     t1=a;
     T_3=[T_3;t1];
        num3=num3+1;
    end
 f4=norm(e44)^2-deta(4)*norm(q4)^2-pi_i*eta(4);
    if f4>=0
%         e04=[e04 norm(e(7:8))];
%         de4=[de4 rr(4)*norm(deta(7:8))];
     xtk_4=x;
     t1=a;
     T_4=[T_4;t1];
        num4=num4+1;
    end
    f5=norm(e55)^2-deta(5)*norm(q5)^2-pi_i*eta(5);
     if f5>=0
%         e04=[e04 norm(e(7:8))];
%         de4=[de4 rr(4)*norm(deta(7:8))];
     xtk_5=x;
     t1=a;
     T_5=[T_5;t1];
        num5=num5+1; 
     end
     f6=norm(e66)^2-deta(6)*norm(q6)^2-pi_i*eta(6);
     if f6>=0
%         e04=[e04 norm(e(7:8))];
%         de4=[de4 rr(4)*norm(deta(7:8))];
     xtk_6=x;
     t1=a;
     T_6=[T_6;t1];
     num6=num6+1;
      end
     a=a+1;
    [tc1,xc1]=ode45('eta1',[t-s,t],eta);%微分得xc值
    eta=xc1(end,:)';
       
end

T1=s*T_1;
T2=s*T_2;
T3=s*T_3;
T4=s*T_4;
T5=s*T_5;
T6=s*T_6;

B1=ones(size(T_1,1),1);
B2=2*ones(size(T_2,1),1);
B3=3*ones(size(T_3,1),1);
B4=4*ones(size(T_4,1),1);
B5=5*ones(size(T_5,1),1);
B6=6*ones(size(T_6,1),1);
figure

% plot(T1,B1,'+r',T2,B2,'.b',T3,B3,'ok',T4,B4,'squarem');
plot(T1,B1,'.r',T2,B2,'.b',T3,B3,'.k',T4,B4,'.m',T5,B5,'.m',T6,B6,'.m');
h3=legend('Agent 1','Agent 2','Agent 3','Agent 4','Agent 5','Agent 6','Interpreter','latex');
set(h3,'Box','off','Interpreter','latex');
axis([0 40 0 6]) 
xlabel('time(s)');
ylabel('trigger instants of foour agents','interpreter','latex','FontSize',12);

figure%第一个分量的轨迹图
for i=1:6
plot(Ts,x1(6*i-5,:));
hold on
end
xlabel('time(s)');
% set(gca,'XTickLabel',(0:10:40));
ylabel('$x_{i1}(t)$','interpreter','latex','FontSize',12);
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');


figure%第二个分量的轨迹图
for i=1:6
plot(Ts,x1(6*i-4,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  

figure%第三个分量的轨迹图
for i=1:6
plot(Ts,x1(6*i-3,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  

figure%第四个分量的轨迹图
for i=1:6
plot(Ts,x1(6*i-2,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  

figure%第五个分量的轨迹图
for i=1:6
plot(Ts,x1(6*i-1,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  

figure%第六个分量的轨迹图
for i=1:6
plot(Ts,x1(6*i,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');  

figure%位置状态误差
f1=x1(1,:)-x1(7,:);%e12
plot(Ts,f1)
hold on
f2=x1(7,:)-x1(13,:);%e23
plot(Ts,f2)
hold on
f3=x1(13,:)-x1(19,:);%e34
plot(Ts,f3)
hold on
f4=x1(19,:)-x1(25,:);%e45
plot(Ts,f4)
hold on
f5=x1(25,:)-x1(31,:);%e56
plot(Ts,f5)
hold on
f6=x1(31,:)-x1(1,:);%e61
plot(Ts,f6)
hold on
xlabel('time(s)');
xp1=legend('e12','e23','e34','e45','e56','e61');  

figure%速度v
for i=1:6
plot(Ts,x1(6*i-2,:));
hold on
end
xlabel('time(s)');
xp1=legend('v1','v2','v3','v4','v5','v6'); 



figure%控制输入轨迹图
for i=1:6
plot(uc(i,:),'LineWidth',1.2);
hold on
end
xlabel('time(s)');
xp1=legend('u1','u2','u3','u4','u5','u6');   


figure(12)
plot(Ts,EEE(1,:),Ts,deta(1)*ZZZ(1,:)+pi_i*Eta(1,:))

figure(13)
plot(Ts,EEE(2,:),Ts,deta(2)*ZZZ(2,:)+pi_i*Eta(2,:))

figure(14)
plot(Ts,EEE(3,:),Ts,deta(3)*ZZZ(3,:)+pi_i*Eta(3,:))

figure(15)
plot(Ts,EEE(4,:),Ts,deta(4)*ZZZ(4,:)+pi_i*Eta(4,:))


figure(16)
plot(Ts,EEE(5,:),Ts,deta(5)*ZZZ(5,:)+pi_i*Eta(5,:))

figure(17)
plot(Ts,EEE(6,:),Ts,deta(6)*ZZZ(6,:)+pi_i*Eta(6,:))





 
    



