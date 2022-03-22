close all;

figure(1);
plot(t,y1,'linewidth',1.5);
legend('x1','x2','x3','x4','linewidth',1.5);
xlabel('time(s)');ylabel('Position of agents');

figure(2)
plot(t,ut1,'linewidth',1.5)

figure(3)
plot(t,y(:,1),t,y(:,2))
% plot(t(1:end-10,1),y(11:end,1),t(1:end-10,1),y(1:end-10,2))

n=size(ut1,1);
T_1=[];T_2=[];T_3=[];T_4=[];
for i=1:n-1
    if ut1(i,1)~=ut1(i+1,1)
        t1=i;
        T_1=[T_1;t1];
    end
end
for i=1:n-1
    if ut1(i,2)~=ut1(i+1,2)
        t1=i;
        T_2=[T_2;t1];
    end
end
for i=1:n-1
    if ut1(i,3)~=ut1(i+1,3)
        t1=i;
        T_3=[T_3;t1];
    end
end
for i=1:n-1
    if ut1(i,4)~=ut1(i+1,4)
        t1=i;
        T_4=[T_4;t1];
    end
end
h=0.001;
T1=h*T_1;T2=h*T_2;T3=h*T_3;T4=h*T_4;
B1=ones(size(T_1,1),1);
B2=2*ones(size(T_2,1),1);
B3=3*ones(size(T_3,1),1);
B4=4*ones(size(T_4,1),1);
grid on
figure(4)
plot(T1,B1,'+r',T2,B2,'*b',T3,B3,'oy',T4,B4,'squarem');
grid on





