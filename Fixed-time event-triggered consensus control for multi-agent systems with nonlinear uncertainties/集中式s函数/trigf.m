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
sizes.NumOutputs     = 3;
sizes.NumInputs      = 5+5;
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



x1=u(1);
x2=u(2);
x3=u(3);
x4=u(4);
x5=u(5);

x1_hat=u(1+5);
x2_hat=u(2+5);
x3_hat=u(3+5);
x4_hat=u(4+5);
x5_hat=u(5+5);
  
y1=aij(1,1)*(x1-x1)+aij(1,2)*(x1-x2)+aij(1,3)*(x1-x3)+aij(1,4)*(x1-x4)+aij(1,5)*(x1-x5);
y2=aij(2,1)*(x2-x1)+aij(2,2)*(x2-x2)+aij(2,3)*(x2-x3)+aij(2,4)*(x2-x4)+aij(2,5)*(x2-x5);
y3=aij(3,1)*(x3-x1)+aij(3,2)*(x3-x2)+aij(3,3)*(x3-x3)+aij(3,4)*(x3-x4)+aij(3,5)*(x3-x5);
y4=aij(4,1)*(x4-x1)+aij(4,2)*(x4-x2)+aij(4,3)*(x4-x3)+aij(4,4)*(x4-x4)+aij(4,5)*(x4-x5);
y5=aij(5,1)*(x5-x1)+aij(5,2)*(x5-x2)+aij(5,3)*(x5-x3)+aij(5,4)*(x5-x4)+aij(5,5)*(x5-x5);

y1_hat=aij(1,1)*(x1_hat-x1_hat)+aij(1,2)*(x1_hat-x2_hat)+aij(1,3)*(x1_hat-x3_hat)+aij(1,4)*(x1_hat-x4_hat)+aij(1,5)*(x1_hat-x5_hat);
y2_hat=aij(2,1)*(x2_hat-x1_hat)+aij(2,2)*(x2_hat-x2_hat)+aij(2,3)*(x2_hat-x3_hat)+aij(2,4)*(x2_hat-x4_hat)+aij(2,5)*(x2_hat-x5_hat);
y3_hat=aij(3,1)*(x3_hat-x1_hat)+aij(3,2)*(x3_hat-x2_hat)+aij(3,3)*(x3_hat-x3_hat)+aij(3,4)*(x3_hat-x4_hat)+aij(3,5)*(x3_hat-x5_hat);
y4_hat=aij(4,1)*(x4_hat-x1_hat)+aij(4,2)*(x4_hat-x2_hat)+aij(4,3)*(x4_hat-x3_hat)+aij(4,4)*(x4_hat-x4_hat)+aij(4,5)*(x4_hat-x5_hat);
y5_hat=aij(5,1)*(x5_hat-x1_hat)+aij(5,2)*(x5_hat-x2_hat)+aij(5,3)*(x5_hat-x3_hat)+aij(5,4)*(x5_hat-x4_hat)+aij(5,5)*(x5_hat-x5_hat);

y=[y1 y2 y3 y4 y5];

c1=1;c2=0.25;c3=1.2;p=3/5;q=7/5;
e1=c1*y1_hat^p+c2*y1_hat^q+c3*y1_hat-(c1*y1^p+c2*y1^q+c3*y1);
e2=c1*y2_hat^p+c2*y2_hat^q+c3*y2_hat-(c1*y2^p+c2*y2^q+c3*y2);
e3=c1*y3_hat^p+c2*y3_hat^q+c3*y3_hat-(c1*y3^p+c2*y3^q+c3*y3);
e4=c1*y4_hat^p+c2*y4_hat^q+c3*y4_hat-(c1*y4^p+c2*y4^q+c3*y4);
e5=c1*y5_hat^p+c2*y5_hat^q+c3*y5_hat-(c1*y5^p+c2*y5^q+c3*y5);
e=[e1 e2 e3 e4 e5];
f1=norm(e)-1/2*c3*norm(y);

if f1>=0
    sys(1)=1;
else
    sys(1)=0;
end

sys(2)=norm(e);
sys(3)=1/2*c3*norm(y);
















