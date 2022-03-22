clear All
close All
clc
x=[-3 -2 0 2 -3 4];%初始值
L=[3 0 0 -1 -1 -1;
   -1 1 0 0 0 0;
   -1 -1 2 0 0 0;
   -1 0 0 1 0 0 ;
   0 0 0 -1 1 0;
   0 0 0 0 -1 1];
xhat=x;
A=1;
x1=[];
x1hat=[];
T1=[];
ef1=[];ef2=[];ef3=[];ef4=[];ef5=[];ef6=[];
T_1=[];T_2=[];T_3=[];T_4=[];T_5=[];T_6=[];
U=[];
E=[];
alpha=0.9;
t=10;
h=0.01;
Ts=0:h:t;
line1=[];
gama=0.2;
c1 = 1.1;
for G=0:h:t
    f=0;
    z_1=0;z=[];
    u_1=0;u=[];
    u_e=0;e=[];
    T=[];
    x1=[x1;x];
    x1hat=[x1hat;xhat];
    for N=1:6
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
          if N==6
            u_e=x1hat(A,6)-x1(A,6);
            e=[e u_e];
          end        
    end
    E=[E;e];
        line_1=c1*exp(-alpha*G);
        ef_1=norm(e(1))-line_1;
        ef1=[ef1,ef_1];
        ef_2=norm(e(2))-line_1;
        ef2=[ef2,ef_2];
        ef_3=norm(e(3))-line_1;
        ef3=[ef3,ef_3];
        ef_4=norm(e(4))-line_1;
        ef4=[ef4,ef_4];
        ef_5=norm(e(5))-line_1;
        ef5=[ef5,ef_5];
        ef_6=norm(e(6))-line_1;
        ef6=[ef6,ef_6];
        line1=[line1 line_1];

               u1=-L*([x1hat(A,1);x1hat(A,2);x1hat(A,3);x1hat(A,4);x1hat(A,5);x1hat(A,6)]);
               u=u1.';
               x(1,1)=x(1,1)+h*u(1,1);%更新状态值
               x(1,2)=x(1,2)+h*u(1,2);%更新状态值
               x(1,3)=x(1,3)+h*u(1,3);%更新状态值
               x(1,4)=x(1,4)+h*u(1,4);%更新状态值
               x(1,5)=x(1,5)+h*u(1,5);%更新状态值
               x(1,6)=x(1,6)+h*u(1,6);%更新状态值
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
    if ef_5>=0%第5个智能体事件触发
     xhat(1,5)=x(1,5);
        t1=A;
        T_5=[T_5;t1];
    else
     xhat(1,5)=xhat(1,5);
    end 
    
    if ef_6>=0%第6个智能体事件触发
     xhat(1,6)=x(1,6);
        t1=A;
        T_6=[T_6;t1];
    else
     xhat(1,6)=xhat(1,6);
    end 

     A=A+1;
        
end
T1=h*T_1;
T2=h*T_2;
T3=h*T_3;
T4=h*T_4;
T5=h*T_5;
T6=h*T_6;
B1=ones(size(T_1,1),1);
B2=2*ones(size(T_2,1),1);
B3=3*ones(size(T_3,1),1);
B4=4*ones(size(T_4,1),1);
B5=5*ones(size(T_5,1),1);
B6=6*ones(size(T_6,1),1);

figure(1)
plot(Ts,x1,'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i}'});
legend('Agent1','Agent2','Agent3','Agent4','Agent5')
grid on

figure(2)
subplot(3, 2, 1);
plot(Ts,abs(E(:,1)),Ts,line1,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{1}|');
legend('|e_{1}|')
grid on

subplot(3, 2, 2);
plot(Ts,abs(E(:,2)),Ts,line1,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{2}|');
legend('|e_{2}|')
grid on

subplot(3, 2, 3);
plot(Ts,abs(E(:,3)),Ts,line1,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{3}|');
legend('|e_{3}|')
grid on

subplot(3, 2, 4);
plot(Ts,abs(E(:,4)),Ts,line1,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{4}|');
legend('|e_{4}|')
grid on

subplot(3, 2, 5);
plot(Ts,abs(E(:,5)),Ts,line1,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{5}|');
legend('|e_{5}|')
grid on

subplot(3, 2, 6);
plot(Ts,abs(E(:,6)),Ts,line1,'LineWidth',1);
xlabel('time(s)');ylabel('|e_{6}|');
legend('|e_{6}|')
grid on

figure(3)
plot(Ts,U,'LineWidth',1);
xlabel('time(s)');ylabel('control input');
legend('Agent1','Agent2','Agent3','Agent4','Agent5')
grid on

figure(4)
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







