function [sys,x0,str,ts] = trigf(t,x,u,flag)
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
sizes.NumOutputs     = 5+5+5;
sizes.NumInputs      = 5+5+5+5+5+5;
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
L=diag(sum(aij,2))-aij;

x1=u(1);
x2=u(2);
x3=u(3);
x4=u(4);
x5=u(5);

x1_hat=u(1+5);
x2_hat=u(2+5+5);
x3_hat=u(3+5+5+5);
x4_hat=u(4+5+5+5+5);
x5_hat=u(5+5+5+5+5+5);

e1=x1_hat-x1;
e2=x2_hat-x2;
e3=x3_hat-x3;
e4=x4_hat-x4;
e5=x5_hat-x5;

y=L*[x1 x2 x3 x4 x5]';

y1=y(1);
y2=y(2);
y3=y(3);
y4=y(4);
y5=y(5);
 
% gama1=0.138;gama2=0.12;gama3=0.106;gama4=0.09;gama5=0.098;
gama1=0.138;gama2=0.138;gama3=0.138;gama4=0.138;gama5=0.138;

f1=abs(e1)-gama1*abs(y1);
f2=abs(e2)-gama2*abs(y2);
f3=abs(e3)-gama3*abs(y3);
f4=abs(e4)-gama4*abs(y4);
f5=abs(e5)-gama5*abs(y5);

sys(1)=f1;
sys(2)=f2;
sys(3)=f3;
sys(4)=f4;
sys(5)=f5;

sys(6)=abs(e1);
sys(7)=gama1*abs(y1);

sys(8)=abs(e2);
sys(9)=gama2*abs(y2);

sys(10)=abs(e3);
sys(11)=gama3*abs(y3);

sys(17-5)=abs(e4);
sys(18-5)=gama4*abs(y4);

sys(19-5)=abs(e5);
sys(20-5)=gama5*abs(y5);


















