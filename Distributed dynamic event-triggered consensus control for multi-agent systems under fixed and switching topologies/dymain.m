close all; clear all;
global uu agent A B Z EE;
A=[0 1;-1 0];deta=1;B=[1 1]';
A1=[0 1 0 0 0 1;
    1 0 0 0 1 0;
    0 1 0 0 0 0;
    0 1 1 0 0 0;
    0 0 0 1 0 1;
    0 1 0 0 1 0];
L=[2 -1 0 0 0 -1;
    -1 2 0 0 -1 0;
    0 -1 1 0 0 0;
    0 -1 -1 2 0 0;
    0 0 0 -1 2 -1;
    0 -1 0 0 -1 2];
agent=size(A1,2);
P=[0.4654 0;0 0.2668];

 x=[2 -4 -4 2 4 2 5 0 3 -1 -5 -3]';
 eta=[2 0.5 3 3 1 1]';
 etta=[];
 K=-B'*P;
 c=3.6;
 a1s=100;
 a2=1;
 X=0.1;
 kx=20;
 tha=30;
 uu=zeros(agent,1);a=1;num1=0;num2=0;num3=0;num4=0;num5=0;num6=0;
Rk1=[];Rk2=[];Rk3=[];Rk4=[];Rk5=[];Rk6=[];
x1=[];x1hat=[];E=[];e1=[];de1=[];e2=[];de2=[];e3=[];de3=[];e4=[];de4=[];
tk=zeros(agent,1);%触发时刻序列
ttx=[];uc=[];
w=zeros(12,1);f=zeros(12,1);
xhat=x;
x1=[];x1hat=[];E=[];p1=zeros(4,1);pp=[];
T_1=[];T_2=[];T_3=[];T_4=[];T_5=[];T_6=[];

s=0.01;
Ts=0:s:20;
for t=0:s:20
    x1=[x1,x];
    x1hat=[x1hat,xhat];
    etta=[etta eta];
    
  u=cat(3,[0;0],[0;0],[0;0],[0;0],[0;0],[0;0]);%三维1*2*6
    for i=1:agent
        for j=1:agent
            u(:,:,i)=u(:,:,i)+A1(i,j)*(expm(A*(t-tk(i)))*[xhat(2*i-1);xhat(2*i)]-expm(A*(t-tk(j)))*[xhat(2*j-1);xhat(2*j)]);
        end
    end
    
    for i=1:agent
        uu(i)=1*K*u(:,:,i);%u控制输入
        
    end
    uc=[uc uu];                                                                                                                                             
    
e1=expm(A*(t-tk(1)))*xhat(1:2)-x(1:2);
e2=expm(A*(t-tk(2)))*xhat(3:4)-x(3:4);
e3=expm(A*(t-tk(3)))*xhat(5:6)-x(5:6);
e4=expm(A*(t-tk(4)))*xhat(7:8)-x(7:8);
e5=expm(A*(t-tk(5)))*xhat(9:10)-x(9:10);
e6=expm(A*(t-tk(6)))*xhat(11:12)-x(11:12);

EE=[norm(e1)^2 norm(e2)^2 norm(e3)^2 norm(e4)^2 norm(e5)^2 norm(e6)^2]';
z=u;
Z=[norm(z(1:2))^2 norm(z(3:4))^2 norm(z(5:6))^2 norm(z(7:8))^2 norm(z(9:10))^2 norm(z(11:12))^2]';

   [tc1,xc]=ode45('x00',[t-s,t],x);%微分得xc值
    x=xc(end,:)';
    

     if norm(e1)^2<=a2/a1s*norm(z(1:2))^2+eta(1)/tha
     xhat(1:2)=x(1:2);
     t1=a;
     T_1=[T_1;t1];
        num1=num1+1;
        tk(1)=t;
    end

    if norm(e2)^2<=a2/a1s*norm(z(3:4))^2+eta(2)/tha
     xhat(3:4)=x(3:4);
     t1=a;
     T_2=[T_2;t1];
        num2=num2+1;
        tk(2)=t;
    end
    
    if norm(e3)^2<=a2/a1s*norm(z(5:6))^2+eta(3)/tha
     xhat(5:6)=x(5:6);
     t1=a;
     T_3=[T_3;t1];
        num3=num3+1;
        tk(3)=t;
    end
    
    if norm(e4)^2<=a2/a1s*norm(z(7:8))^2+eta(4)/tha
     xhat(7:8)=x(7:8);
     t1=a;
     T_4=[T_4;t1];
        num4=num4+1;
         tk(4)=t;
    end

      if norm(e5)^2<=a2/a1s*norm(z(9:10))^2+eta(5)/tha
     xhat(9:10)=x(9:10);
     t1=a;
     T_5=[T_5;t1];
        num5=num5+1;
        tk(5)=t;
    end

    if norm(e6)^2<=a2/a1s*norm(z(11:12))^2+eta(6)/tha
     xhat(11:12)=x(11:12);
     t1=a;
     T_6=[T_6;t1];
        num6=num6+1;
        tk(6)=t;
    end
    
     a=a+1;
     
     [tc1,et1]=ode45('eeta11',[t-s,t],eta);%微分得et1值
     eta=et1(end,:)';
     ttx=[ttx,tk];
       
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
 axis([0 15 0 5])      



figure%第一个分量的轨迹图
for i=1:6
plot(Ts,x1(2*i-1,:));
hold on
end
xlabel('time(s)');
ylabel('$x_{i1}(t)$','interpreter','latex','FontSize',12);
xp1=legend('i=1','i=2','i=3','i=4','i=5');

figure%第二个分量的轨迹图
for i=1:6
plot(Ts,x1(2*i,:));
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');   



figure%控制输入轨迹图
for i=1:6
plot(Ts,uc(i,:),'LineWidth',1);
hold on
end
xlabel('time(s)');
xp1=legend('i=1','i=2','i=3','i=4','i=5','i=6');   


 
    



