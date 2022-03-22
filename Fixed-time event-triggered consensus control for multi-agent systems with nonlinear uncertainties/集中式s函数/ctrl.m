function [sys,x0,str,ts] = ctrl(t,x,u,flag)
switch flag
case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 5;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
aij=[0 1 1 0 0;
     1 0 1 0 1;
     1 1 0 1 0;
     0 0 1 0 1;
     0 1 0 1 0];

x1hat=u(1);%智能体1第k次触发到第k+1次触发之间的状态值,是个常数不变值
x2hat=u(2);%智能体2第k次触发到第k+1次触发之间的状态值,是个常数不变值
x3hat=u(3);%智能体3第k次触发到第k+1次触发之间的状态值,是个常数不变值
x4hat=u(4);%智能体4第k次触发到第k+1次触发之间的状态值,是个常数不变值
x5hat=u(5);%智能体5第k次触发到第k+1次触发之间的状态值,是个常数不变值

c1=1;c2=0.25;c3=1.2;p=3/5;q=7/5;

u_1=real(-c1*(aij(1,1)*(x1hat-x1hat)+aij(1,2)*(x1hat-x2hat)+aij(1,3)*(x1hat-x3hat)+aij(1,4)*(x1hat-x4hat)+aij(1,5)*(x1hat-x5hat))^p-...
          c2*(aij(1,1)*(x1hat-x1hat)+aij(1,2)*(x1hat-x2hat)+aij(1,3)*(x1hat-x3hat)+aij(1,4)*(x1hat-x4hat)+aij(1,5)*(x1hat-x5hat))^q-...
          c3*(aij(1,1)*(x1hat-x1hat)+aij(1,2)*(x1hat-x2hat)+aij(1,3)*(x1hat-x3hat)+aij(1,4)*(x1hat-x4hat)+aij(1,5)*(x1hat-x5hat)));
u_2=real(-c1*(aij(2,1)*(x2hat-x1hat)+aij(2,2)*(x2hat-x2hat)+aij(2,3)*(x2hat-x3hat)+aij(2,4)*(x2hat-x4hat)+aij(2,5)*(x2hat-x5hat))^p-...
          c2*(aij(2,1)*(x2hat-x1hat)+aij(2,2)*(x2hat-x2hat)+aij(2,3)*(x2hat-x3hat)+aij(2,4)*(x2hat-x4hat)+aij(2,5)*(x2hat-x5hat))^q-...
          c3*(aij(2,1)*(x2hat-x1hat)+aij(2,2)*(x2hat-x2hat)+aij(2,3)*(x2hat-x3hat)+aij(2,4)*(x2hat-x4hat)+aij(2,5)*(x2hat-x5hat)));
u_3=real(-c1*(aij(3,1)*(x3hat-x1hat)+aij(3,2)*(x3hat-x2hat)+aij(3,3)*(x3hat-x3hat)+aij(3,4)*(x3hat-x4hat)+aij(3,5)*(x3hat-x5hat))^p-...
          c2*(aij(3,1)*(x3hat-x1hat)+aij(3,2)*(x3hat-x2hat)+aij(3,3)*(x3hat-x3hat)+aij(3,4)*(x3hat-x4hat)+aij(3,5)*(x3hat-x5hat))^q-...
          c3*(aij(3,1)*(x3hat-x1hat)+aij(3,2)*(x3hat-x2hat)+aij(3,3)*(x3hat-x3hat)+aij(3,4)*(x3hat-x4hat)+aij(3,5)*(x3hat-x5hat)));
u_4=real(-c1*(aij(4,1)*(x4hat-x1hat)+aij(4,2)*(x4hat-x2hat)+aij(4,3)*(x4hat-x3hat)+aij(4,4)*(x4hat-x4hat)+aij(4,5)*(x4hat-x5hat))^p-...
          c2*(aij(4,1)*(x4hat-x1hat)+aij(4,2)*(x4hat-x2hat)+aij(4,3)*(x4hat-x3hat)+aij(4,4)*(x4hat-x4hat)+aij(4,5)*(x4hat-x5hat))^q-...
          c3*(aij(4,1)*(x4hat-x1hat)+aij(4,2)*(x4hat-x2hat)+aij(4,3)*(x4hat-x3hat)+aij(4,4)*(x4hat-x4hat)+aij(4,5)*(x4hat-x5hat)));
u_5=real(-c1*(aij(5,1)*(x5hat-x1hat)+aij(5,2)*(x5hat-x2hat)+aij(5,3)*(x5hat-x3hat)+aij(5,4)*(x5hat-x4hat)+aij(5,5)*(x5hat-x5hat))^p-...
          c2*(aij(5,1)*(x5hat-x1hat)+aij(5,2)*(x5hat-x2hat)+aij(5,3)*(x5hat-x3hat)+aij(5,4)*(x5hat-x4hat)+aij(5,5)*(x5hat-x5hat))^q-...
          c3*(aij(5,1)*(x5hat-x1hat)+aij(5,2)*(x5hat-x2hat)+aij(5,3)*(x5hat-x3hat)+aij(5,4)*(x5hat-x4hat)+aij(5,5)*(x5hat-x5hat)));
  
sys(1)=u_1;
sys(2)=u_2;
sys(3)=u_3;
sys(4)=u_4;
sys(5)=u_5;





