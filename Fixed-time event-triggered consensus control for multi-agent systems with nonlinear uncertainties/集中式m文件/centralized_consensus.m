clear 
close All
clc
x=[-3 -2 0 2 4];%初始值
xhat=x;
x1=[];x1hat=[];f2_E=[];f2_Y=[];U=[];f2_3=[];T_1=[];
t=4;
h=0.001;
A=1;
Ts=0:h:t;
c1=1;c2=0.25;c3=1.2;
p=3/5;q=7/5;
aij=[0 1 1 0 0;
     1 0 1 0 1;
     1 1 0 1 0;
     0 0 1 0 1;
     0 1 0 1 0];
L=diag(sum(aij,2))-aij;
for P=0:h:t
    x1=[x1;x];
    x1hat=[x1hat;xhat];
    e=[]; u=[];
    
     yhat=L*xhat.';
     y1_hat=yhat(1);
     y2_hat=yhat(2);
     y3_hat=yhat(3);
     y4_hat=yhat(4);
     y5_hat=yhat(5);
     
     y=L*x.';
     y1=y(1);
     y2=y(2);
     y3=y(3);
     y4=y(4);
     y5=y(5);
     
     e1=real(c1*y1_hat^p+c2*y1_hat^q+c3*y1_hat-(c1*y1^p+c2*y1^q+c3*y1));
     e2=real(c1*y2_hat^p+c2*y2_hat^q+c3*y2_hat-(c1*y2^p+c2*y2^q+c3*y2));
     e3=real(c1*y3_hat^p+c2*y3_hat^q+c3*y3_hat-(c1*y3^p+c2*y3^q+c3*y3));
     e4=real(c1*y4_hat^p+c2*y4_hat^q+c3*y4_hat-(c1*y4^p+c2*y4^q+c3*y4));
     e5=real(c1*y5_hat^p+c2*y5_hat^q+c3*y5_hat-(c1*y5^p+c2*y5^q+c3*y5));
     e=[e1 e2 e3 e4 e5];
    for M=1:5
                if M==1
                    u_1=real(-c1*y1_hat^p-c2*y1_hat^q-c3*y1_hat);
                    u=[u u_1];
                end
                if M==2
                    u_2=real(-c1*y2_hat^p-c2*y2_hat^q-c3*y2_hat);
                    u=[u u_2];
                end
                if M==3
                    u_3=real(-c1*y3_hat^p-c2*y3_hat^q-c3*y3_hat);
                    u=[u u_3];
                end    
                if M==4
                    u_4=real(-c1*y4_hat^p-c2*y4_hat^q-c3*y4_hat);
                    u=[u u_4];
                end  
                if M==5
                    u_5=real(-c1*y5_hat^p-c2*y5_hat^q-c3*y5_hat);
                    u=[u u_5];
                end  
                
                
     end
                
%                x(1,1)=x(1,1)+h*u(1,1);%更新状态值
%                x(1,2)=x(1,2)+h*u(1,2);%更新状态值
%                x(1,3)=x(1,3)+h*u(1,3);%更新状态值
%                x(1,4)=x(1,4)+h*u(1,4);%更新状态值
%                x(1,5)=x(1,5)+h*u(1,5);%更新状态值
               x=x+h*u;
               U=[U;u];
    f2_e=norm(e);%测量误差2范数
    f2_E=[f2_E;f2_e];%保存测量误差
    f2_y=norm(y);%测量误差2范数
    f2_Y=[f2_Y;f2_y];
    f2_2=0.5*c3*norm(y);
    f2_3=[f2_3;f2_2];
    f=norm(e)-f2_2;%trigger fuction

    if f>=0%事件触发
        xhat=x;
        t1=A;
        T_1=[T_1;t1];
    else       %事件未触发
        xhat=xhat;
    end
     A=A+1;

end
T1=h*T_1;
B1=ones(size(T_1,1),1);
B2=2*ones(size(T_1,1),1);
B3=3*ones(size(T_1,1),1);
B4=4*ones(size(T_1,1),1);
B5=5*ones(size(T_1,1),1);

figure(1)
plot(Ts,x1,'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i}'});
legend('Agent1','Agent2','Agent3','Agent4','Agent5')
grid on

figure(2)
plot(Ts,x1hat,'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i}'});
legend('Agent1','Agent2','Agent3','Agent4','Agent5')
grid on

figure(3)
plot(Ts,U,'LineWidth',1);
xlabel('time(s)');ylabel('control input');
legend('Agent1','Agent2','Agent3','Agent4')
grid on

figure(4)
plot(Ts,f2_E,Ts,f2_3,'LineWidth',1);
xlabel('time(s)');ylabel('||e||');
legend('||e||','0.6||y||')
grid on

figure(5)
plot(T1,B1,'+r',T1,B2,'*b',T1,B3,'oy',T1,B4,'squarem',T1,B5,'-^');
grid on
               
    
    
    
    
    
    
