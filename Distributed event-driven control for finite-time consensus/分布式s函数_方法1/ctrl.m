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

x1tk_1=u(1);%agent1触发时，agent1最新状态值
x2tk_1=u(2);
x3tk_1=u(3);
x4tk_1=u(4);
x5tk_1=u(5);

x1tk_2=u(1+5);
x2tk_2=u(2+5);
x3tk_2=u(3+5);
x4tk_2=u(4+5);
x5tk_2=u(5+5);

x1tk_3=u(1+5+5);
x2tk_3=u(2+5+5);
x3tk_3=u(3+5+5);
x4tk_3=u(4+5+5);
x5tk_3=u(5+5+5);

x1tk_4=u(1+5+5+5);
x2tk_4=u(2+5+5+5);
x3tk_4=u(3+5+5+5);
x4tk_4=u(4+5+5+5);
x5tk_4=u(5+5+5+5);

x1tk_5=u(1+5+5+5+5);
x2tk_5=u(2+5+5+5+5);
x3tk_5=u(3+5+5+5+5);
x4tk_5=u(4+5+5+5+5);
x5tk_5=u(5+5+5+5+5);

alpha=1;mu=3/4;

u_1=real(-alpha*sig(aij(1,1)*(x1tk_1-x1tk_1)+aij(1,2)*(x1tk_1-x2tk_1)+aij(1,3)*(x1tk_1-x3tk_1)+aij(1,4)*(x1tk_1-x4tk_1)+aij(1,5)*(x1tk_1-x5tk_1),mu));
u_2=real(-alpha*sig(aij(2,1)*(x2tk_2-x1tk_2)+aij(2,2)*(x2tk_2-x2tk_2)+aij(2,3)*(x2tk_2-x3tk_2)+aij(2,4)*(x2tk_2-x4tk_2)+aij(2,5)*(x2tk_2-x5tk_2),mu));
u_3=real(-alpha*sig(aij(3,1)*(x3tk_3-x1tk_3)+aij(3,2)*(x3tk_3-x2tk_3)+aij(3,3)*(x3tk_3-x3tk_3)+aij(3,4)*(x3tk_3-x4tk_3)+aij(3,5)*(x3tk_3-x5tk_3),mu));
u_4=real(-alpha*sig(aij(4,1)*(x4tk_4-x1tk_4)+aij(4,2)*(x4tk_4-x2tk_4)+aij(4,3)*(x4tk_4-x3tk_4)+aij(4,4)*(x4tk_4-x4tk_4)+aij(4,5)*(x4tk_4-x5tk_4),mu));
u_5=real(-alpha*sig(aij(5,1)*(x5tk_5-x1tk_5)+aij(5,2)*(x5tk_5-x2tk_5)+aij(5,3)*(x5tk_5-x3tk_5)+aij(5,4)*(x5tk_5-x4tk_5)+aij(5,5)*(x5tk_5-x5tk_5),mu));
  
sys(1)=u_1;
sys(2)=u_2;
sys(3)=u_3;
sys(4)=u_4;
sys(5)=u_5;





