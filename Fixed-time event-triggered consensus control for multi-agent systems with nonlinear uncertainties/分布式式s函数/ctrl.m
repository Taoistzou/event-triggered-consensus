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
sizes.NumInputs      = 5+5+5+5+5;
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

x1hat_1=u(1);
x2hat_1=u(2);
x3hat_1=u(3);
x4hat_1=u(4);
x5hat_1=u(5);

x1hat_2=u(1+5);
x2hat_2=u(2+5);
x3hat_2=u(3+5);
x4hat_2=u(4+5);
x5hat_2=u(5+5);

x1hat_3=u(1+5+5);
x2hat_3=u(2+5+5);
x3hat_3=u(3+5+5);
x4hat_3=u(4+5+5);
x5hat_3=u(5+5+5);

x1hat_4=u(1+5+5+5);
x2hat_4=u(2+5+5+5);
x3hat_4=u(3+5+5+5);
x4hat_4=u(4+5+5+5);
x5hat_4=u(5+5+5+5);

x1hat_5=u(1+5+5+5+5);
x2hat_5=u(2+5+5+5+5);
x3hat_5=u(3+5+5+5+5);
x4hat_5=u(4+5+5+5+5);
x5hat_5=u(5+5+5+5+5);

c1=0.5;c2=0.5;c3=1.2;alpha=3/5;beta=7/5;
y1hat=aij(1,1)*(x1hat_1-x1hat_1)+aij(1,2)*(x1hat_1-x2hat_1)+aij(1,3)*(x1hat_1-x3hat_1)+aij(1,4)*(x1hat_1-x4hat_1)+aij(1,5)*(x1hat_1-x5hat_1);
y2hat=aij(2,1)*(x2hat_2-x1hat_2)+aij(2,2)*(x2hat_2-x2hat_2)+aij(2,3)*(x2hat_2-x3hat_2)+aij(2,4)*(x2hat_2-x4hat_2)+aij(2,5)*(x2hat_2-x5hat_2);
y3hat=aij(3,1)*(x3hat_3-x1hat_3)+aij(3,2)*(x3hat_3-x2hat_3)+aij(3,3)*(x3hat_3-x3hat_3)+aij(3,4)*(x3hat_3-x4hat_3)+aij(3,5)*(x3hat_3-x5hat_3);
y4hat=aij(4,1)*(x4hat_4-x1hat_4)+aij(4,2)*(x4hat_4-x2hat_4)+aij(4,3)*(x4hat_4-x3hat_4)+aij(4,4)*(x4hat_4-x4hat_4)+aij(4,5)*(x4hat_4-x5hat_4);
y5hat=aij(5,1)*(x5hat_5-x1hat_5)+aij(5,2)*(x5hat_5-x2hat_5)+aij(5,3)*(x5hat_5-x3hat_5)+aij(5,4)*(x5hat_5-x4hat_5)+aij(5,5)*(x5hat_5-x5hat_5);

u_1=real(-c1*y1hat^alpha-c2*y1hat^beta-c3*y1hat);
u_2=real(-c1*y2hat^alpha-c2*y2hat^beta-c3*y2hat);
u_3=real(-c1*y3hat^alpha-c2*y3hat^beta-c3*y3hat);
u_4=real(-c1*y4hat^alpha-c2*y4hat^beta-c3*y4hat);
u_5=real(-c1*y5hat^alpha-c2*y5hat^beta-c3*y5hat);

sys(1)=u_1;
sys(2)=u_2;
sys(3)=u_3;
sys(4)=u_4;
sys(5)=u_5;





