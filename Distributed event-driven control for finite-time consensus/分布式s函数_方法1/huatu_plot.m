close all;

figure(1);
plot(t,y);
legend('$x_1$','$x_2$','$x_3$','$x_4$','$x_5$','interpreter','latex','linewidth',1.5,'fontsize',15);
xlabel('time(s)');ylabel('Position of agents');

figure(2)
plot(t,ut1,'linewidth',1.5)
xlabel('time(s)');ylabel('control input of agents');
legend('$u_1$','$u_2$','$u_3$','$u_4$','$u_5$','interpreter','latex','linewidth',1.5,'fontsize',15);

figure(3)
plot(t,y2)
xlabel('time(s)');ylabel('||e1||');

figure(4)
plot(t,y3)

figure(5)
plot(t,y4)

figure(6)
plot(t,y5)

figure(7)
plot(t,y6)

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

% T11=T1-[0;T1(1:end-1)];
% figure 
% stem(T1,T11)
%  title('Agent 1');
% xlabel('time(s)');
% ylabel('trigger interval','FontSize',12);
% 
% T12=T2-[0;T2(1:end-1)];
% figure 
% stem(T2,T12)
%   title('Agent 2');
% xlabel('time(s)');
% ylabel('trigger interval','FontSize',12);
% 
% T13=T3-[0;T3(1:end-1)];
% figure
% stem(T3,T13)
%   title('Agent 3');
% xlabel('time(s)');
% ylabel('trigger interval','FontSize',12);
% 
% T14=T4-[0;T4(1:end-1)];
% figure
% stem(T4,T14)
%   title('Agent 4');
% xlabel('time(s)');
% ylabel('trigger interval','FontSize',12);
% 
% 
