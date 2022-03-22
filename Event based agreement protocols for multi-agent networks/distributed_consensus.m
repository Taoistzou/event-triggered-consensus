clear 
close All
clc
x=[-1.8074 12.4584 -0.6378 -6.1134 11.0932];
xtk_1=x;
xtk_2=x;
xtk_3=x;
xtk_4=x;
xtk_5=x;
X=[];U=[];
Xtk_1=[];Xtk_2=[];Xtk_3=[];Xtk_4=[];Xtk_5=[];W=[];
E1=[];E2=[];E3=[];E4=[];E5=[];
Y1=[];Y2=[];Y3=[];Y4=[];Y5=[];
F1=[];F2=[];F3=[];F4=[];F5=[];
T_1=[];T_2=[];T_3=[];T_4=[];T_5=[];
t=5;
h=0.001;
A=1;
Ts=0:h:t;
alpha=1;mu=3/4;mu_1=4/3;alpha_1=0;
% gama1=0.1;gama2=0.12;gama3=0.106;gama4=0.09;gama5=0.098;
gama1=0.06;gama2=0.06;gama3=0.06;gama4=0.06;gama5=0.06;
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
    
    e1=x1tk_1-x(1);
    e2=x2tk_2-x(2);
    e3=x3tk_3-x(3);
    e4=x4tk_4-x(4);
    e5=x5tk_5-x(5);
    
    y1=aij(1,1)*(x(1)-x(1))+aij(1,2)*(x(1)-x(2))+aij(1,3)*(x(1)-x(3))+aij(1,4)*(x(1)-x(4))+aij(1,5)*(x(1)-x(5));
    y2=aij(2,1)*(x(2)-x(1))+aij(2,2)*(x(2)-x(2))+aij(2,3)*(x(2)-x(3))+aij(2,4)*(x(2)-x(4))+aij(2,5)*(x(2)-x(5));
    y3=aij(3,1)*(x(3)-x(1))+aij(3,2)*(x(3)-x(2))+aij(3,3)*(x(3)-x(3))+aij(3,4)*(x(3)-x(4))+aij(3,5)*(x(3)-x(5));
    y4=aij(4,1)*(x(4)-x(1))+aij(4,2)*(x(4)-x(2))+aij(4,3)*(x(4)-x(3))+aij(4,4)*(x(4)-x(4))+aij(4,5)*(x(4)-x(5));
    y5=aij(5,1)*(x(5)-x(1))+aij(5,2)*(x(5)-x(2))+aij(5,3)*(x(5)-x(3))+aij(5,4)*(x(5)-x(4))+aij(5,5)*(x(5)-x(5));
    
    E1=[E1 abs(e1^2)];
    E2=[E2 abs(e2^2)];
    E3=[E3 abs(e3^2)];
    E4=[E4 abs(e4^2)];
    E5=[E5 abs(e5^2)];
     
    Y1=[Y1 gama1*abs(y1^2)];
    Y2=[Y2 gama2*abs(y2^2)];
    Y3=[Y3 gama3*abs(y3^2)];
    Y4=[Y4 gama4*abs(y4^2)];
    Y5=[Y5 gama5*abs(y5^2)]; 
    
    f1=abs(e1^2)-gama1*abs(y1^2);
    f2=abs(e2^2)-gama2*abs(y2^2);
    f3=abs(e3^2)-gama3*abs(y3^2);
    f4=abs(e4^2)-gama4*abs(y4^2);
    f5=abs(e5^2)-gama5*abs(y5^2);
    
    F1=[F1 f1];
    F2=[F2 f2];
    F3=[F3 f3];
    F4=[F4 f4];
    F5=[F5 f5];
    
    u_1=(-alpha*sig(aij(1,1)*(x1tk_1-x1tk_1)+aij(1,2)*(x1tk_1-x2tk_1)+aij(1,3)*(x1tk_1-x3tk_1)+aij(1,4)*(x1tk_1-x4tk_1)+aij(1,5)*(x1tk_1-x5tk_1),mu))+...
        (-alpha_1*sig(aij(1,1)*(x1tk_1-x1tk_1)+aij(1,2)*(x1tk_1-x2tk_1)+aij(1,3)*(x1tk_1-x3tk_1)+aij(1,4)*(x1tk_1-x4tk_1)+aij(1,5)*(x1tk_1-x5tk_1),mu_1));
    u_2=(-alpha*sig(aij(2,1)*(x2tk_2-x1tk_2)+aij(2,2)*(x2tk_2-x2tk_2)+aij(2,3)*(x2tk_2-x3tk_2)+aij(2,4)*(x2tk_2-x4tk_2)+aij(2,5)*(x2tk_2-x5tk_2),mu))+...
        (-alpha_1*sig(aij(2,1)*(x2tk_2-x1tk_2)+aij(2,2)*(x2tk_2-x2tk_2)+aij(2,3)*(x2tk_2-x3tk_2)+aij(2,4)*(x2tk_2-x4tk_2)+aij(2,5)*(x2tk_2-x5tk_2),mu_1));
    u_3=(-alpha*sig(aij(3,1)*(x3tk_3-x1tk_3)+aij(3,2)*(x3tk_3-x2tk_3)+aij(3,3)*(x3tk_3-x3tk_3)+aij(3,4)*(x3tk_3-x4tk_3)+aij(3,5)*(x3tk_3-x5tk_3),mu))+...
        (-alpha_1*sig(aij(3,1)*(x3tk_3-x1tk_3)+aij(3,2)*(x3tk_3-x2tk_3)+aij(3,3)*(x3tk_3-x3tk_3)+aij(3,4)*(x3tk_3-x4tk_3)+aij(3,5)*(x3tk_3-x5tk_3),mu_1));
    u_4=(-alpha*sig(aij(4,1)*(x4tk_4-x1tk_4)+aij(4,2)*(x4tk_4-x2tk_4)+aij(4,3)*(x4tk_4-x3tk_4)+aij(4,4)*(x4tk_4-x4tk_4)+aij(4,5)*(x4tk_4-x5tk_4),mu))+...
        (-alpha_1*sig(aij(4,1)*(x4tk_4-x1tk_4)+aij(4,2)*(x4tk_4-x2tk_4)+aij(4,3)*(x4tk_4-x3tk_4)+aij(4,4)*(x4tk_4-x4tk_4)+aij(4,5)*(x4tk_4-x5tk_4),mu_1));
    u_5=(-alpha*sig(aij(5,1)*(x5tk_5-x1tk_5)+aij(5,2)*(x5tk_5-x2tk_5)+aij(5,3)*(x5tk_5-x3tk_5)+aij(5,4)*(x5tk_5-x4tk_5)+aij(5,5)*(x5tk_5-x5tk_5),mu))+...
        (-alpha_1*sig(aij(5,1)*(x5tk_5-x1tk_5)+aij(5,2)*(x5tk_5-x2tk_5)+aij(5,3)*(x5tk_5-x3tk_5)+aij(5,4)*(x5tk_5-x4tk_5)+aij(5,5)*(x5tk_5-x5tk_5),mu));
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

%图例换行操作
% h1=plot(Ts,U(:,1));hold on;
% h2=plot(Ts,U(:,2));hold on;
% h3=plot(Ts,U(:,3));hold on;
% h4=plot(Ts,U(:,4));hold on;
% h5=plot(Ts,U(:,5));hold on;
% lgd1=legend([h1,h2],'$u_1$','$u_2$','orientation','horizontal','location','north');
% % set(lgd1,'FontName','宋体','FontSize',14);
% set(lgd1,'interpreter','latex','linewidth',1.5,'fontsize',15);
% %不想要有框框区分，在每个图例下面加行代码就行啦，如下
% legend boxoff;
% ah=axes('position',get(gca,'position'),'visible','off');
% lgd2=legend(ah,[h3,h4,h5],'$u_3$','$u_4$','$u_5$','orientation','horizontal','location','north');
% set(lgd2,'interpreter','latex','linewidth',1.5,'fontsize',15);
% %不想要有框框区分，在每个图例下面加行代码就行啦，如下
% legend boxoff;

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
    if (ut1(i,1)~= ut1(i+1,1))
        t1=i;
        T_1=[T_1;t1];
    end
end
for i=1:n-1
    if (ut1(i,2)~=ut1(i+1,2))
        t1=i;
        T_2=[T_2;t1];
    end
end
for i=1:n-1
    if (ut1(i,3)~=ut1(i+1,3))
        t1=i;
        T_3=[T_3;t1];
    end
end
for i=1:n-1
    if (ut1(i,4)~=ut1(i+1,4))
        t1=i;
        T_4=[T_4;t1];
    end
end
for i=1:n-1
    if (ut1(i,5)~=ut1(i+1,5))
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
xlabel('time(s)');ylabel('w');
legend('$W$','interpreter','latex','linewidth',1.5,'fontsize',15);
grid on

figure(10)
plot(Ts,F1,'LineWidth',1);
xlabel('time(s)');ylabel('w');
legend('$W$','interpreter','latex','linewidth',1.5,'fontsize',15);
grid on

    
    
    
    
