clear All
close All
clc
L=[1 -1 0 0;
   -1 3 -1 -1;
   0 -1 2 -1;
   0 -1 -1 2];
x=[4 -2 0 -2];%初始值
xtk=x;
A=1;
x1=[];
x1tk=[];
enorm1=[];
yy1=[];
f1=[];
U=[];
T_1=[];
t=10;
h=0.0006;
Ts=0:h:t;
sigma=0.65;
for p=0:h:t
    f=0;
    y_1=0;y=[];
    u_1=0;u_2=0;u=[];
    e_1=0;e=[];
    x1=[x1;x];
    x1tk=[x1tk;xtk];
    for N=1:4
        if N==1
            e_1=x1tk(A,1)-x1(A,1);
            e=[e e_1];
        end
        if N==2
            e_1=x1tk(A,2)-x1(A,2);
            e=[e e_1];
        end
        if N==3
            e_1=x1tk(A,3)-x1(A,3);
            e=[e e_1];
        end        
         if N==4
            e_1=x1tk(A,4)-x1(A,4);
            e=[e e_1];
        end          

    end
    enorm=norm(e);%测量误差2范数
    enorm1=[enorm1;enorm];%保存测量误差
    y=L*([x1(A,1);x1(A,2);x1(A,3);x1(A,4)]);
    yy=sigma*norm(y) /norm(L); 
    yy1=[yy1;yy];
    f=enorm-yy;      %trigger fuction
    f1=[f1;f];
    u1=-L*([x1tk(A,1);x1tk(A,2);x1tk(A,3);x1tk(A,4)]);
    u=u1.';
    x(1,1)=x(1,1)+h*u(1,1);%更新状态值
    x(1,2)=x(1,2)+h*u(1,2);%更新状态值
    x(1,3)=x(1,3)+h*u(1,3);%更新状态值
    x(1,4)=x(1,4)+h*u(1,4);%更新状态值
    U=[U;u];

    if f>=0%事件触发
        xtk=x;
        t1=A;
        T_1=[T_1;t1];
    else       %事件未触发
        xtk=xtk;
    end
     A=A+1;
        
end
T1=h*T_1;
B1=ones(size(T_1,1),1);
B2=2*ones(size(T_1,1),1);
B3=3*ones(size(T_1,1),1);
B4=4*ones(size(T_1,1),1);
figure(1)
plot(Ts,x1,'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i}'});
legend('Agent1','Agent2','Agent3','Agent4','Agent5')
grid on

figure(2)
plot(Ts,enorm1,Ts,yy1,'LineWidth',1);
xlabel('time(s)');ylabel('||e||');
legend('||e||','||e||max')
grid on
% 
figure(3)
plot(Ts,U,'LineWidth',1);
xlabel('time(s)');ylabel('control input');
legend('Agent1','Agent2','Agent3','Agent4')

grid on
figure(4)
plot(T1,B1,'+r',T1,B2,'*b',T1,B3,'oy',T1,B4,'squarem');
grid on



% %上标用 ^，下标用 _
% % 调用方式为: ^{任意字符}, _{任意字符}, 注意{}的使用!
% title({'position changes of agents';'the initial states z_{2}(0)=(20,40,-30,10,-30,-20)^{T}'},'FontSize',10);% title换行，两行的内容用分号隔开，再用大括号括起来。
% set(gca,'FontSize',10);
% legend('agent1','agent2','agent3','agent4','agent5','agent6')
% % set(gca,'XLim',[0 20],'YLim',[-40 40])  %控制坐标轴尺度长度
% % set(gca,'YLim',[-40 40])
% grid on







