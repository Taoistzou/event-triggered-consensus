clear 
close All
clc
x=[-3 -2 0 2 4];%初始值
xtk_1=x;
xtk_2=x;
xtk_3=x;
xtk_4=x;
xtk_5=x;
X=[];U=[];
Xtk_1=[];Xtk_2=[];Xtk_3=[];Xtk_4=[];Xtk_5=[];W=[];
E1=[];E2=[];E3=[];E4=[];E5=[];
Y1=[];Y2=[];Y3=[];Y4=[];Y5=[];
T_1=[];T_2=[];T_3=[];T_4=[];T_5=[];
t=4;
h=0.001;
A=1;
Ts=0:h:t;
c4=0.5;c5=0.5;c6=1.2;alpha=3/5;beta=7/5;
aij=[0 1 1 0 0;
     1 0 1 0 1;
     1 1 0 1 0;
     0 0 1 0 1;
     0 1 0 1 0];
L=diag(sum(aij,2))-aij;
for P=0:h:t
    X=[X;x];
    w=1/2*x*L*x';
    W=[W w];
    Xtk_1=[Xtk_1;xtk_1];
    Xtk_2=[Xtk_2;xtk_2];
    Xtk_3=[Xtk_3;xtk_3];
    Xtk_4=[Xtk_4;xtk_4];
    Xtk_5=[Xtk_5;xtk_5];
    
    x1tk_1=xtk_1(1);
    x2tk_1=xtk_1(2);
    x3tk_1=xtk_1(3);
    x4tk_1=xtk_1(4);
    x5tk_1=xtk_1(5);
    
    x1tk_2=xtk_2(1);
    x2tk_2=xtk_2(2);
    x3tk_2=xtk_2(3);
    x4tk_2=xtk_2(4);
    x5tk_2=xtk_2(5);
    
    x1tk_3=xtk_3(1);
    x2tk_3=xtk_3(2);
    x3tk_3=xtk_3(3);
    x4tk_3=xtk_3(4);
    x5tk_3=xtk_3(5);
    
    x1tk_4=xtk_4(1);
    x2tk_4=xtk_4(2);
    x3tk_4=xtk_4(3);
    x4tk_4=xtk_4(4);
    x5tk_4=xtk_4(5);
    
    x1tk_5=xtk_5(1);
    x2tk_5=xtk_5(2);
    x3tk_5=xtk_5(3);
    x4tk_5=xtk_5(4);
    x5tk_5=xtk_5(5);
    
    y1=aij(1,1)*(x(1)-x(1))+aij(1,2)*(x(1)-x(2))+aij(1,3)*(x(1)-x(3))+aij(1,4)*(x(1)-x(4))+aij(1,5)*(x(1)-x(5));
    y2=aij(2,1)*(x(2)-x(1))+aij(2,2)*(x(2)-x(2))+aij(2,3)*(x(2)-x(3))+aij(2,4)*(x(2)-x(4))+aij(2,5)*(x(2)-x(5));
    y3=aij(3,1)*(x(3)-x(1))+aij(3,2)*(x(3)-x(2))+aij(3,3)*(x(3)-x(3))+aij(3,4)*(x(3)-x(4))+aij(3,5)*(x(3)-x(5));
    y4=aij(4,1)*(x(4)-x(1))+aij(4,2)*(x(4)-x(2))+aij(4,3)*(x(4)-x(3))+aij(4,4)*(x(4)-x(4))+aij(4,5)*(x(4)-x(5));
    y5=aij(5,1)*(x(5)-x(1))+aij(5,2)*(x(5)-x(2))+aij(5,3)*(x(5)-x(3))+aij(5,4)*(x(5)-x(4))+aij(5,5)*(x(5)-x(5));
    
    y1tk=aij(1,1)*(x1tk_1-x1tk_1)+aij(1,2)*(x1tk_1-x2tk_1)+aij(1,3)*(x1tk_1-x3tk_1)+aij(1,4)*(x1tk_1-x4tk_1)+aij(1,5)*(x1tk_1-x5tk_1);
    y2tk=aij(2,1)*(x2tk_2-x1tk_2)+aij(2,2)*(x2tk_2-x2tk_2)+aij(2,3)*(x2tk_2-x3tk_2)+aij(2,4)*(x2tk_2-x4tk_2)+aij(2,5)*(x2tk_2-x5tk_2);
    y3tk=aij(3,1)*(x3tk_3-x1tk_3)+aij(3,2)*(x3tk_3-x2tk_3)+aij(3,3)*(x3tk_3-x3tk_3)+aij(3,4)*(x3tk_3-x4tk_3)+aij(3,5)*(x3tk_3-x5tk_3);
    y4tk=aij(4,1)*(x4tk_4-x1tk_4)+aij(4,2)*(x4tk_4-x2tk_4)+aij(4,3)*(x4tk_4-x3tk_4)+aij(4,4)*(x4tk_4-x4tk_4)+aij(4,5)*(x4tk_4-x5tk_4);
    y5tk=aij(5,1)*(x5tk_5-x1tk_5)+aij(5,2)*(x5tk_5-x2tk_5)+aij(5,3)*(x5tk_5-x3tk_5)+aij(5,4)*(x5tk_5-x4tk_5)+aij(5,5)*(x5tk_5-x5tk_5);
    
    e1=c4*y1tk^alpha+c5*y1tk^beta+c6*y1tk-(c4*y1^alpha+c5*y1^beta+c6*y1);
    e2=c4*y2tk^alpha+c5*y2tk^beta+c6*y2tk-(c4*y2^alpha+c5*y2^beta+c6*y2);
    e3=c4*y3tk^alpha+c5*y3tk^beta+c6*y3tk-(c4*y3^alpha+c5*y3^beta+c6*y3);
    e4=c4*y4tk^alpha+c5*y4tk^beta+c6*y4tk-(c4*y4^alpha+c5*y4^beta+c6*y4);
    e5=c4*y5tk^alpha+c5*y5tk^beta+c6*y5tk-(c4*y5^alpha+c5*y5^beta+c6*y5);
         
    f1=abs(e1)-1/2*c6*abs(y1);
    f2=abs(e2)-1/2*c6*abs(y2);
    f3=abs(e3)-1/2*c6*abs(y3);
    f4=abs(e4)-1/2*c6*abs(y4);
    f5=abs(e5)-1/2*c6*abs(y5);
    
    E1=[E1 abs(e1)];
    E2=[E2 abs(e2)];
    E3=[E3 abs(e3)];
    E4=[E4 abs(e4)];
    E5=[E5 abs(e5)];
    
    Y1=[Y1 1/2*c6*abs(y1)];
    Y2=[Y2 1/2*c6*abs(y2)];
    Y3=[Y3 1/2*c6*abs(y3)];
    Y4=[Y4 1/2*c6*abs(y4)];
    Y5=[Y5 1/2*c6*abs(y5)];  
    
    u_1=real(-c4*y1tk^alpha-c5*y1tk^beta-c6*y1tk);
    u_2=real(-c4*y2tk^alpha-c5*y2tk^beta-c6*y2tk);
    u_3=real(-c4*y3tk^alpha-c5*y3tk^beta-c6*y3tk);
    u_4=real(-c4*y4tk^alpha-c5*y4tk^beta-c6*y4tk);
    u_5=real(-c4*y5tk^alpha-c5*y5tk^beta-c6*y5tk);
    u=[u_1 u_2 u_3 u_4 u_5];
    x=x+h*u;
    U=[U;u];

    if f1>=0%第1个智能体事件触发
        xtk_1=x;
    end
    if f2>=0%第2个智能体事件触发
        xtk_2=x;
    end    
    if f3>=0%第3个智能体事件触发
        xtk_3=x;
    end  
    if f4>=0%第4个智能体事件触发
        xtk_4=x;
    end 
    if f5>=0%第5个智能体事件触发
        xtk_5=x;
    end 

     A=A+1;

end

figure(1)
plot(Ts,X,'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i}'});
legend('$x_1$','$x_2$','$x_3$','$x_4$','$x_5$','interpreter','latex','linewidth',1.5,'fontsize',15);
grid on


figure(2)
plot(Ts,U,'LineWidth',1);
xlabel('time(s)');ylabel('control input');
legend('$u_1$','$u_2$','$u_3$','$u_4$','$u_5$','interpreter','latex','linewidth',1.5,'fontsize',15);
grid on

figure(3)
plot(Ts,E1,Ts,Y1,'LineWidth',1);
xlabel('time(s)');ylabel('||e1||');
legend('||e1||','0.6||y1||')
grid on

figure(4)
plot(Ts,E2,Ts,Y2,'LineWidth',1);
xlabel('time(s)');ylabel('||e2||');
legend('||e2||','0.6||y2||')
grid on

figure(5)
plot(Ts,E3,Ts,Y3,'LineWidth',1);
xlabel('time(s)');ylabel('||e3||');
legend('||e3||','0.6||y3||')
grid on

figure(6)
plot(Ts,E4,Ts,Y4,'LineWidth',1);
xlabel('time(s)');ylabel('||e4||');
legend('||e4||','0.6||y4||')
grid on

figure(7)
plot(Ts,E5,Ts,Y5,'LineWidth',1);
xlabel('time(s)');ylabel('||e5||');
legend('||e5||','0.6||y5||')
grid on

ut1=U;
n=size(ut1,1);
T_1=[];T_2=[];T_3=[];T_4=[];T_5=[];
for i=1:n-1
    if abs(ut1(i,1)-ut1(i+1,1))>0.001
        t1=i;
        T_1=[T_1;t1];
    end
end
for i=1:n-1
    if abs(ut1(i,2)-ut1(i+1,2))>0.001
        t1=i;
        T_2=[T_2;t1];
    end
end
for i=1:n-1
    if abs(ut1(i,3)-ut1(i+1,3))>0.001
        t1=i;
        T_3=[T_3;t1];
    end
end
for i=1:n-1
    if abs(ut1(i,4)-ut1(i+1,4))>0.001
        t1=i;
        T_4=[T_4;t1];
    end
end
for i=1:n-1
    if abs(ut1(i,5)-ut1(i+1,5))>0.001
        t1=i;
        T_5=[T_5;t1];
    end
end

h=0.001;
T1=h*T_1;
T2=h*T_2;
T3=h*T_3;
T4=h*T_4;
T5=h*T_5;
B1=ones(size(T_1,1),1);
B2=2*ones(size(T_2,1),1);
B3=3*ones(size(T_3,1),1);
B4=4*ones(size(T_4,1),1);
B5=5*ones(size(T_5,1),1);
grid on
figure(8)
plot(T1,B1,'+r',T2,B2,'*b',T3,B3,'oy',T4,B4,'squarem',T5,B5,'diamondk');
grid on

figure(9)
plot(Ts,W,'LineWidth',1);
xlabel('time(s)');ylabel('The Lyapunov function');
legend('$W$','interpreter','latex','linewidth',1.5,'fontsize',15);
grid on



               
    
    
    
    
    
    
