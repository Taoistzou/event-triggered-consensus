clear All
close All
clc
x=[-3 -2 0 2 -3];%初始值
L=[2 -1 -1 0 0;
   -1 3 -1 0 -1;
   -1 -1 3 -1 0;
   0 0 -1 2 -1;
   0 -1 0 -1 2];
xhat=x;
A=1;
x1=[];
x1hat=[];
T1=[];
ef1=[];ef2=[];ef3=[];ef4=[];ef5=[];
Y1=[];Y2=[];Y3=[];Y4=[];Y5=[];
T_1=[];T_2=[];T_3=[];T_4=[];T_5=[];
U=[];
E=[];
T=[];
t=10;
h=0.001;
Ts=0:h:t;
alpha1=0.55;alpha2=0.55;alpha3=0.75;alpha4=0.75;alpha5=0.75;
gama=0.2;
for G=0:h:t
    f=0;
    z_1=0;z=[];
    u_1=0;u=[];
    u_e=0;e=[];
    T=[];
    x1=[x1;x];
    x1hat=[x1hat;xhat];
    for N=1:5
        if N==1
            u_e=x1hat(A,1)-x1(A,1);
            e=[e u_e];
        end
        if N==2
            u_e=x1hat(A,2)-x1(A,2);
            e=[e u_e];
        end
        if N==3
            u_e=x1hat(A,3)-x1(A,3);
            e=[e u_e];
        end        
         if N==4
            u_e=x1hat(A,4)-x1(A,4);
            e=[e u_e];
        end          
          if N==5
            u_e=x1hat(A,5)-x1(A,5);
            e=[e u_e];
          end  
    end
    E=[E;e];
        z=L*([x1(A,1);x1(A,2);x1(A,3);x1(A,4);x1(A,5)]);
        y1=alpha1*gama*(1-gama*2)/2*z(1).^2;
        Y1=[Y1 y1];
        ef_1=e(1).^2-y1;
        ef1=[ef1,ef_1];
        y2=alpha2*gama*(1-gama*3)/3*z(2).^2;
        Y2=[Y2 y2];
        ef_2=e(2).^2-y2;
        ef2=[ef2,ef_2];
        y3=alpha3*gama*(1-gama*3)/3*z(3).^2;
        Y3=[Y3 y3];
        ef_3=e(3).^2-y3;
        ef3=[ef3,ef_3];
        y4=alpha4*gama*(1-gama*2)/2*z(4).^2;
        Y4=[Y4 y4];
        ef_4=e(4).^2-y4;
        ef4=[ef4,ef_4];
        y5=alpha5*gama*(1-gama*2)/2*z(5).^2;
        Y5=[Y5 y5];
        ef_5=e(5).^2-y5;
        ef5=[ef5,ef_5];

               u1=-L*([x1hat(A,1);x1hat(A,2);x1hat(A,3);x1hat(A,4);x1hat(A,5)]);
               u=u1.';
               x(1,1)=x(1,1)+h*u(1,1);%更新状态值
               x(1,2)=x(1,2)+h*u(1,2);%更新状态值
               x(1,3)=x(1,3)+h*u(1,3);%更新状态值
               x(1,4)=x(1,4)+h*u(1,4);%更新状态值
               x(1,5)=x(1,5)+h*u(1,5);%更新状态值
               U=[U;u];
    
    if ef_1>=0%第1个智能体事件触发
        xhat(1,1)=x(1,1);
        t1=A;
        T_1=[T_1;t1];
    else
        xhat(1,1)=xhat(1,1);
    end
    if ef_2>=0%第2个智能体事件触发
        xhat(1,2)=x(1,2);
        t1=A;
        T_2=[T_2;t1];
    else
        xhat(1,2)=xhat(1,2);
    end    
    if ef_3>=0%第3个智能体事件触发
        xhat(1,3)=x(1,3);
        t1=A;
        T_3=[T_3;t1];
    else
        xhat(1,3)=xhat(1,3);
    end  
    if ef_4>=0%第4个智能体事件触发
        xhat(1,4)=x(1,4);
        t1=A;
        T_4=[T_4;t1];
    else
        xhat(1,4)=xhat(1,4);
    end 
    if ef_5>=0%第4个智能体事件触发
     xhat(1,5)=x(1,5);
        t1=A;
        T_5=[T_5;t1];
    else
     xhat(1,5)=xhat(1,5);
    end 

     A=A+1;
        
end
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


figure(1)
plot(Ts,x1,'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i}'});
legend('Agent1','Agent2','Agent3','Agent4','Agent5')
grid on

figure(2)
plot(Ts,abs(E(:,1)).^2,Ts,Y1,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{1}|');
legend('|e_{1}|')
grid on

figure(3)
plot(Ts,abs(E(:,2)).^2,Ts,Y2,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{2}|');
legend('|e_{2}|')
grid on

figure(4)
plot(Ts,abs(E(:,3)).^2,Ts,Y3,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{3}|');
legend('|e_{3}|')
grid on

figure(5)
plot(Ts,abs(E(:,4)).^2,Ts,Y4,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{4}|');
legend('|e_{4}|')
grid on

figure(6)
plot(Ts,abs(E(:,5)).^2,Ts,Y5,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{5}|');
legend('|e_{5}|')
grid on

figure(7)
plot(Ts,U,'LineWidth',1);
xlabel('time(s)');ylabel('control input');
legend('Agent1','Agent2','Agent3','Agent4','Agent5')
grid on

figure(8)
plot(T1,B1,'+r',T2,B2,'*b',T3,B3,'oy',T4,B4,'squarem',T5,B5,'diamondk');
grid on


% %上标用 ^，下标用 _
% % 调用方式为: ^{任意字符}, _{任意字符}, 注意{}的使用!
% title({'position changes of agents';'the initial states z_{2}(0)=(20,40,-30,10,-30,-20)^{T}'},'FontSize',10);% title换行，两行的内容用分号隔开，再用大括号括起来。
% set(gca,'FontSize',10);
% legend('agent1','agent2','agent3','agent4','agent5','agent6')
% % set(gca,'XLim',[0 20],'YLim',[-40 40])  %控制坐标轴尺度长度
% % set(gca,'YLim',[-40 40])
% grid on







