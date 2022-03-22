close all; clear all;
global uu  A B agent;
A=[0 1 0;
   0 0 1;
   0 0 0];

B=[0;0;1];
K=-[1.0000 2.4142 2.4142];
a=[0 1 0 1
   1 0 0 0;
   0 0 0 1;
   1 0 1 0];
agent=size(a,2);uu=zeros(agent,1);
x1=[8 6 8].';
x2=[-4 1 1].';
x3=[4 6 4].';
x4=[7 -1 -2].';
x=[x1.' x2.' x3.' x4.'].';
xhat=x;
X1=[];uc=[];x1hat=[];
EE1=[];EE2=[];EE3=[];EE4=[];F1=[];
s=0.01;
% c=[0 1 0 1
%    1 0 0 0;
%    0 0 0 1;
%    1 0 1 0];
c=[1 1 1 1
   1 1 1 1;
   1 1 1 1;
   1 1 1 1];
k=0.2;delta=1;mu=2;v=0.5;rho=0;
Gama=[1.0000 2.4142 2.4142;
      2.4142 5.8284 5.8284;
      2.4142 5.8284 5.8284];
tk=zeros(4,1);
f=zeros(4,1);
e=cat(3,[0;0;0],[0;0;0],[0;0;0],[0;0;0]);
num1=0;num2=0;num3=0;num4=0;
Ts=0:s:20;
for t=0:s:20
    X1=[X1,x];
    x1hat=[x1hat,xhat];
    
xt_1=x(1:3);
xt_2=x(4:6);
xt_3=x(7:9);
xt_4=x(10:12);

xtk1=expm(A*(t-tk(1)))*xhat(1:3);
xtk2=expm(A*(t-tk(2)))*xhat(4:6);
xtk3=expm(A*(t-tk(3)))*xhat(7:9);
xtk4=expm(A*(t-tk(4)))*xhat(10:12);

e(:,:,1)=xtk1-xt_1;
e(:,:,2)=xtk2-xt_2;
e(:,:,3)=xtk3-xt_3;
e(:,:,4)=xtk4-xt_4;

e1=xtk1-xt_1;
e2=xtk2-xt_2;
e3=xtk3-xt_3;
e4=xtk4-xt_4;

  u=cat(3,[0;0;0],[0;0;0],[0;0;0],[0;0;0]);%三维3*1*3
    for i=1:agent
        for j=1:agent
            u(:,:,i)=u(:,:,i)+c(i,j)*a(i,j)*(expm(A*(t-tk(i)))*[xhat(3*i-2);xhat(3*i-1);xhat(3*i)]-expm(A*(t-tk(j)))*[xhat(3*j-2);xhat(3*j-1);xhat(3*j)]);
        end
    end
    
    for i=1:agent
        uu(i)=1*K*u(:,:,i);%u控制输入
        uc=[uc uu];
    end

[~,X_1]=ode45('x111',[t-s,t],x);%微分得X_1值
x=X_1(end,:)';%生成行向量，转置成列向量

f=zeros(4,1);

for i=1:agent
    for j=1:agent
        f(i)=f(i)+(1+delta*c(i,j))*a(i,j)*e(:,:,i).'*Gama*e(:,:,i)-...
            1/4*a(i,j)*(expm(A*(t-tk(i)))*[xhat(3*i-2);xhat(3*i-1);xhat(3*i)]-expm(A*(t-tk(j)))*[xhat(3*j-2);xhat(3*j-1);xhat(3*j)]).'*Gama*(expm(A*(t-tk(i)))*[xhat(3*i-2);xhat(3*i-1);xhat(3*i)]-expm(A*(t-tk(j)))*[xhat(3*j-2);xhat(3*j-1);xhat(3*j)])-mu*exp(-v*t);
    end
end


% 
% E1=(1+delta*c(1,1))*a(1,1)*e1.'*Gama*e1+(1+delta*c(1,2))*a(1,2)*e1.'*Gama*e1+(1+delta*c(1,3))*a(1,3)*e1.'*Gama*e1+(1+delta*c(1,4))*a(1,4)*e1.'*Gama*e1+...
%       -1/4*(a(1,1)*(xtk1-xtk1).'*Gama*(xtk1-xtk1)+a(1,2)*(xtk1-xtk2).'*Gama*(xtk1-xtk2)+a(1,3)*(xtk1-xtk3).'*Gama*(xtk1-xtk3)+a(1,4)*(xtk1-xtk4).'*Gama*(xtk1-xtk4));
% EE1=[EE1 E1];
% f(1)=E1-mu*exp(-v*t);
% F1=[F1 mu*exp(-v*t)];
% 
% E2=(1+delta*c(2,1))*a(2,1)*e2.'*Gama*e2+(1+delta*c(2,2))*a(2,2)*e2.'*Gama*e2+(1+delta*c(2,3))*a(2,3)*e2.'*Gama*e2+(1+delta*c(2,4))*a(2,4)*e2.'*Gama*e2+...
%       -1/4*(a(2,1)*(xtk2-xtk1).'*Gama*(xtk2-xtk1)+a(2,2)*(xtk2-xtk2).'*Gama*(xtk2-xtk2)+a(2,3)*(xtk2-xtk3).'*Gama*(xtk2-xtk3)+a(2,4)*(xtk2-xtk4).'*Gama*(xtk2-xtk4));
% EE2=[EE2 E2];
% f(2)=E2-mu*exp(-v*t);
% 
% E3=(1+delta*c(3,1))*a(3,1)*e3.'*Gama*e3+(1+delta*c(3,2))*a(3,2)*e3.'*Gama*e3+(1+delta*c(3,3))*a(3,3)*e3.'*Gama*e3+(1+delta*c(3,4))*a(3,4)*e3.'*Gama*e3+...
%       -1/4*(a(3,1)*(xtk3-xtk1).'*Gama*(xtk3-xtk1)+a(3,2)*(xtk3-xtk2).'*Gama*(xtk3-xtk2)+a(3,3)*(xtk3-xtk3).'*Gama*(xtk3-xtk3)+a(3,4)*(xtk3-xtk4).'*Gama*(xtk3-xtk4));
% EE3=[EE3 E3];
% f(3)=E3-mu*exp(-v*t);
% 
% E4=(1+delta*c(4,1))*a(4,1)*e4.'*Gama*e4+(1+delta*c(4,2))*a(4,2)*e4.'*Gama*e4+(1+delta*c(4,3))*a(4,3)*e4.'*Gama*e4+(1+delta*c(4,4))*a(4,4)*e4.'*Gama*e4+...
%       -1/4*(a(4,1)*(xtk4-xtk1).'*Gama*(xtk4-xtk1)+a(4,2)*(xtk4-xtk2).'*Gama*(xtk4-xtk2)+a(4,3)*(xtk1-xtk3).'*Gama*(xtk4-xtk3)+a(4,4)*(xtk4-xtk4).'*Gama*(xtk4-xtk4));
% EE4=[EE4 E4];
% f(4)=E4-mu*exp(-v*t);

if f(1)>=0
     xhat(1:3)=x(1:3);
     tk(1)=t;
     num1=num1+1;
end

if f(2)>=0
     xhat(4:6)=x(4:6);
     tk(2)=t;
     num2=num2+1;
end

if f(3)>=0
     xhat(7:9)=x(7:9);
     tk(3)=t;
     num3=num3+1;
end

if f(4)>=0
     xhat(10:12)=x(10:12);
     tk(4)=t;
     num4=num4+1;
end

% dotc11=k*a(1,1)*(-rho*c(1,1)+(xtk1-xtk1).'*Gama*(xtk1-xtk1));
% dotc12=k*a(1,2)*(-rho*c(1,2)+(xtk1-xtk2).'*Gama*(xtk1-xtk2));
% dotc13=k*a(1,3)*(-rho*c(1,3)+(xtk1-xtk3).'*Gama*(xtk1-xtk3));
% dotc14=k*a(1,4)*(-rho*c(1,4)+(xtk1-xtk4).'*Gama*(xtk1-xtk4));
% 
% dotc21=k*a(2,1)*(-rho*c(2,1)+(xtk2-xtk1).'*Gama*(xtk2-xtk1));
% dotc22=k*a(2,2)*(-rho*c(2,2)+(xtk2-xtk2).'*Gama*(xtk2-xtk2));
% dotc23=k*a(2,3)*(-rho*c(2,3)+(xtk2-xtk3).'*Gama*(xtk2-xtk3));
% dotc24=k*a(2,4)*(-rho*c(2,4)+(xtk2-xtk4).'*Gama*(xtk2-xtk4));
% 
% dotc31=k*a(3,1)*(-rho*c(3,1)+(xtk3-xtk1).'*Gama*(xtk3-xtk1));
% dotc32=k*a(3,2)*(-rho*c(3,2)+(xtk3-xtk2).'*Gama*(xtk3-xtk2));
% dotc33=k*a(3,3)*(-rho*c(3,3)+(xtk3-xtk3).'*Gama*(xtk3-xtk3));
% dotc34=k*a(3,4)*(-rho*c(3,4)+(xtk3-xtk4).'*Gama*(xtk3-xtk4));
% 
% dotc41=k*a(4,1)*(-rho*c(4,1)+(xtk4-xtk1).'*Gama*(xtk4-xtk1));
% dotc42=k*a(4,2)*(-rho*c(4,2)+(xtk4-xtk2).'*Gama*(xtk4-xtk2));
% dotc43=k*a(4,3)*(-rho*c(4,3)+(xtk4-xtk3).'*Gama*(xtk4-xtk3));
% dotc44=k*a(4,4)*(-rho*c(4,4)+(xtk4-xtk4).'*Gama*(xtk4-xtk4));
% 
% c(1,1)=c(1,1)+dotc11*s;
% c(1,2)=c(1,2)+dotc12*s;
% c(1,3)=c(1,3)+dotc13*s;
% c(1,4)=c(1,4)+dotc14*s;
% 
% c(2,1)=c(2,1)+dotc21*s;
% c(2,2)=c(2,2)+dotc22*s;
% c(2,3)=c(2,3)+dotc23*s;
% c(2,4)=c(2,4)+dotc24*s;
% 
% c(3,1)=c(3,1)+dotc31*s;
% c(3,2)=c(3,2)+dotc32*s;
% c(3,3)=c(3,3)+dotc33*s;
% c(3,4)=c(3,4)+dotc34*s;
% 
% c(4,1)=c(4,1)+dotc41*s;
% c(4,2)=c(4,2)+dotc42*s;
% c(4,3)=c(4,3)+dotc43*s;
% c(4,4)=c(4,4)+dotc44*s;
end
    


figure(1)%第一个分量的轨迹图
for i=1:4
plot(Ts,X1(3*i-2,:));
hold on
end
xlabel('time(s)');
ylabel('$x_{i1}(t)$','interpreter','latex','FontSize',12);
legend('i=1','i=2','i=3','i=4','i=0');


figure(2)%第二个分量的轨迹图
for i=1:4
plot(Ts,X1(3*i-1,:))
hold on
end
xlabel('time(s)');
ylabel('$x_{i1}(t)$','interpreter','latex','FontSize',12);
xp1=legend('i=1','i=2','i=3','i=4','i=0'); 


figure(3)%第三个分量的轨迹图
for i=1:4
plot(Ts,X1(3*i,:));
hold on
end
xlabel('time(s)');
% set(gca,'XTickLabel',(0:10:40));
ylabel('$x_{i1}(t)$','interpreter','latex','FontSize',12);
xp1=legend('i=1','i=2','i=3','i=4','i=0');

figure%控制输入轨迹图
for i=1:4
plot(Ts,uc(i,:),'LineWidth',1.2);
hold on
end
xlabel('time(s)');
xp1=legend('u1','u2','u3','u4');   

figure
plot(uc(1,:))
hold on
plot(uc(2,:))
hold on
plot(uc(3,:))
hold on








 
    



