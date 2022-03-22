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
sizes.NumInputs      = 4+4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
L=[1 -1 0 0;
   -1 3 -1 -1;
   0 -1 2 -1;
   0 -1 -1 2];



x1=u(1);
x2=u(2);
x3=u(3);
x4=u(4);

x1hat=u(1+4);
x2hat=u(2+4);
x3hat=u(3+4);
x4hat=u(4+4);
    
e1=x1hat-x1;
e2=x2hat-x2;
e3=x3hat-x3;
e4=x4hat-x4;
e=[e1 e2 e3 e4];
sigma=0.95;
enorm=norm(e);%²âÁ¿Îó²î2·¶Êý
y=L*[x1;x2;x3;x4];
yy=sigma*norm(y) /norm(L); 
f=enorm-yy;      %trigger fuction

if f>=0
    sys(1)=1;
else
    sys(1)=0;
end

sys(2)=yy;
sys(3)=enorm;






