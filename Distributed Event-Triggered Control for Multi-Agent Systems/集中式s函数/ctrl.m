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
sizes.NumOutputs     = 4;
sizes.NumInputs      = 4;
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

x1hat=u(1);
x2hat=u(2);
x3hat=u(3);
x4hat=u(4);

control_input=-L*([x1hat;x2hat;x3hat;x4hat]);

u_1=control_input(1);  
u_2=control_input(2);
u_3=control_input(3);
u_4=control_input(4);
   
    
sys(1)=u_1;
sys(2)=u_2;
sys(3)=u_3;
sys(4)=u_4;





