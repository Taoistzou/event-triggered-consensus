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



x1=u(1);
x2=u(2);
x3=u(3);
x4=u(4);
x5=u(5);

x1_hat_1=u(1+5);
x2_hat_1=u(2+5);
x3_hat_1=u(3+5);
x4_hat_1=u(4+5);
x5_hat_1=u(5+5);

x1_hat_2=u(1+5+5);
x2_hat_2=u(2+5+5);
x3_hat_2=u(3+5+5);
x4_hat_2=u(4+5+5);
x5_hat_2=u(5+5+5);

x1_hat_3=u(1+5+5+5);
x2_hat_3=u(2+5+5+5);
x3_hat_3=u(3+5+5+5);
x4_hat_3=u(4+5+5+5);
x5_hat_3=u(5+5+5+5);

x1_hat_4=u(1+5+5+5+5);
x2_hat_4=u(2+5+5+5+5);
x3_hat_4=u(3+5+5+5+5);
x4_hat_4=u(4+5+5+5+5);
x5_hat_4=u(5+5+5+5+5);

x1_hat_5=u(1+5+5+5+5+5);
x2_hat_5=u(2+5+5+5+5+5);
x3_hat_5=u(3+5+5+5+5+5);
x4_hat_5=u(4+5+5+5+5+5);
x5_hat_5=u(5+5+5+5+5+5);

y1=aij(1,1)*(x1-x1)+aij(1,2)*(x1-x2)+aij(1,3)*(x1-x3)+aij(1,4)*(x1-x4)+aij(1,5)*(x1-x5);
y2=aij(2,1)*(x2-x1)+aij(2,2)*(x2-x2)+aij(2,3)*(x2-x3)+aij(2,4)*(x2-x4)+aij(2,5)*(x2-x5);
y3=aij(3,1)*(x3-x1)+aij(3,2)*(x3-x2)+aij(3,3)*(x3-x3)+aij(3,4)*(x3-x4)+aij(3,5)*(x3-x5);
y4=aij(4,1)*(x4-x1)+aij(4,2)*(x4-x2)+aij(4,3)*(x4-x3)+aij(4,4)*(x4-x4)+aij(4,5)*(x4-x5);
y5=aij(5,1)*(x5-x1)+aij(5,2)*(x5-x2)+aij(5,3)*(x5-x3)+aij(5,4)*(x5-x4)+aij(5,5)*(x5-x5);

epsilon_1=aij(1,1)*(x1_hat_1-x1_hat_1)+aij(1,2)*(x1_hat_1-x2_hat_1)+aij(1,3)*(x1_hat_1-x3_hat_1)+aij(1,4)*(x1_hat_1-x4_hat_1)+aij(1,5)*(x1_hat_1-x5_hat_1);
epsilon_2=aij(2,1)*(x2_hat_2-x1_hat_2)+aij(2,2)*(x2_hat_2-x2_hat_2)+aij(2,3)*(x2_hat_2-x3_hat_2)+aij(2,4)*(x2_hat_2-x4_hat_2)+aij(2,5)*(x2_hat_2-x5_hat_2);
epsilon_3=aij(3,1)*(x3_hat_3-x1_hat_3)+aij(3,2)*(x3_hat_3-x2_hat_3)+aij(3,3)*(x3_hat_3-x3_hat_3)+aij(3,4)*(x3_hat_3-x4_hat_3)+aij(3,5)*(x3_hat_3-x5_hat_3);
epsilon_4=aij(4,1)*(x4_hat_4-x1_hat_4)+aij(4,2)*(x4_hat_4-x2_hat_4)+aij(4,3)*(x4_hat_4-x3_hat_4)+aij(4,4)*(x4_hat_4-x4_hat_4)+aij(4,5)*(x4_hat_4-x5_hat_4);
epsilon_5=aij(5,1)*(x5_hat_5-x1_hat_5)+aij(5,2)*(x5_hat_5-x2_hat_5)+aij(5,3)*(x5_hat_5-x3_hat_5)+aij(5,4)*(x5_hat_5-x4_hat_5)+aij(5,5)*(x5_hat_5-x5_hat_5);

c4=0.5;c5=0.5;c6=1.2;alpha=3/5;beta=7/5;
e1=c4*epsilon_1^alpha+c5*epsilon_1^beta+c6*epsilon_1-(c4*y1^alpha+c5*y1^beta+c6*y1);
e2=c4*epsilon_2^alpha+c5*epsilon_2^beta+c6*epsilon_2-(c4*y2^alpha+c5*y2^beta+c6*y2);
e3=c4*epsilon_3^alpha+c5*epsilon_3^beta+c6*epsilon_3-(c4*y3^alpha+c5*y3^beta+c6*y3);
e4=c4*epsilon_4^alpha+c5*epsilon_4^beta+c6*epsilon_4-(c4*y4^alpha+c5*y4^beta+c6*y4);
e5=c4*epsilon_5^alpha+c5*epsilon_5^beta+c6*epsilon_5-(c4*y5^alpha+c5*y5^beta+c6*y5);


f1=abs(e1)-1/2*c6*abs(y1);
f2=abs(e2)-1/2*c6*abs(y2);
f3=abs(e3)-1/2*c6*abs(y3);
f4=abs(e4)-1/2*c6*abs(y4);
f5=abs(e5)-1/2*c6*abs(y5);


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

sys(11)=abs(e1);
sys(12)=1/2*c6*abs(y1);

sys(13)=abs(e2);
sys(14)=1/2*c6*abs(y2);

sys(15)=abs(e3);
sys(16)=1/2*c6*abs(y3);

sys(17)=abs(e4);
sys(18)=1/2*c6*abs(y4);

sys(19)=abs(e5);
sys(20)=1/2*c6*abs(y5);


















