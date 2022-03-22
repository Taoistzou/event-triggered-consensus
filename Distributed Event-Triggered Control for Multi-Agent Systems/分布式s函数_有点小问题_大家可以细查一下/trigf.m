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
sizes.NumOutputs     = 5+5+10;
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

z=L*[x1 x2 x3 x4 x5]';
z_1=z(1);
z_2=z(2);
z_3=z(3);
z_4=z(4);
z_5=z(5);

alpha1=0.55;alpha2=0.55;alpha3=0.75;alpha4=0.75;alpha5=0.75;
gama=0.2;
N1=2;N2=3;N3=3;N4=2;N5=2;
y1=alpha1*gama*(1-gama*N1)/N1*z_1^2;
y2=alpha2*gama*(1-gama*N2)/N2*z_2^2;
y3=alpha3*gama*(1-gama*N3)/N3*z_3^2;
y4=alpha4*gama*(1-gama*N4)/N4*z_4^2;
y5=alpha5*gama*(1-gama*N5)/N5*z_5^2;

f1=e1^2-y1;
f2=e2^2-y2;
f3=e3^2-y3;
f4=e4^2-y4;
f5=e5^2-y5;

if f1>=0
    sys(1)=1;
else
    sys(1)=0;
end

if f2>=0
    sys(2)=1;
else
    sys(2)=0;
end

if f3>=0
    sys(3)=1;
else
    sys(3)=0;
end

if f4>=0
    sys(4)=1;
else
    sys(4)=0;
end

if f5>=0
    sys(5)=1;
else
    sys(5)=0;
end

sys(1+5)=x1;
sys(2+5)=x2;
sys(3+5)=x3;
sys(4+5)=x4;
sys(5+5)=x5;

sys(11)=e1.^2;
sys(12)=y1;

sys(13)=e2.^2;
sys(14)=y2;

sys(15)=e3.^2;
sys(16)=y3;

sys(17)=e4.^2;
sys(18)=y4;

sys(19)=e5.^2;
sys(20)=y5;


















