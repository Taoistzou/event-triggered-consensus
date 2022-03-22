A=[0 1;-9.8 0];
B=[0;-1];
C=[1 0];
D=0;
L=[2 -1 -1 0;-1 3 -1 -1;-1 -1 2 0; 0 -1 0 1];
M=[3 -1 -1 0;-1 4 -1 -1;-1 -1 2 0; 0 -1 0 1];
h=0.01;
T=20;
gama=0.95;
F1=expm(A*h);
syms x
G1=double(int(expm(A*x),x,0,h))*B;
lamdaM=min(eig(M));
tao=1/lamdaM
BB=2*B*B';
CC=2*C'*C;
setlmis([]);
P=lmivar(1,[2,1]);
lmiterm([1 1 1 P],A,1,'S');
lmiterm([-1 1 1 0],BB);
lmiterm([-2 1 1 P],1,1);
lmisys=getlmis;
[tmin,xfeas]=feasp(lmisys);
P=dec2mat(lmisys,xfeas,P);
P1=inv(P);
setlmis([]);
P2=lmivar(1,[2,1]);
lmiterm([1 1 1 P2],1,A,'S');
lmiterm([-1 1 1 0],CC);
lmiterm([-2 1 1 P2],1,1);
lmisys=getlmis;
[tmin,xfeas]=feasp(lmisys);
P2=dec2mat(lmisys,xfeas,P2);
K=-tao*B'*P1;
G=inv(P2)*C';
I=eye(4);
BK=B*K;
H=kron(I,A)+kron(M,BK);
lamdaH=min(eig(H));
F2=expm((A-G*C)*h);
syms x
G2=double(int(expm((A-G*C)*x),x,0,h));
a=1;a1=1;a2=1;a3=1;a4=1;
A1=[];A2=[];A3=[];A4=[];
t=0:h:T;
x0=[10;10];x1=[-3;3];x2=[-4;1];x3=[0;2];x4=[4;8];
z0=[];z1=[];z2=[];z3=[];z4=[];
z1o=[];z2o=[];z3o=[];z4o=[];
E1=[];E2=[];E3=[];E4=[];EZ=[];W1=[];
EE1=[];EE2=[];EE3=[];EE4=[];
DETA1=[];DETA2=[];DETA3=[];DETA4=[];
x1o=[0;0];x2o=[0;0];x3o=[0;0];x4o=[0;0];
for i=0:h:T
    z0=[z0 x0];
    z1=[z1 x1];
    z2=[z2 x2];
    z3=[z3 x3];
    z4=[z4 x4];
    z1o=[z1o x1o];
    z2o=[z2o x2o];
    z3o=[z3o x3o];
    z4o=[z4o x4o];
    e1=x1o-z1o(:,a1);
    e2=x2o-z2o(:,a2);
    e3=x3o-z3o(:,a3);
    e4=x4o-z4o(:,a4);
    e1f=norm(e1);
    e2f=norm(e2);
    e3f=norm(e3);
    e4f=norm(e4);
    E1=[E1;e1f];
    E2=[E2;e2f];
    E3=[E3;e3f];
    E4=[E4;e4f];
    deta1=x1o-x0;
    deta2=x2o-x0;
    deta3=x3o-x0;
    deta4=x4o-x0;
    ee1=x1-x0;
    ee2=x2-x0;
    ee3=x3-x0;
    ee4=x4-x0;
    EE1=[EE1 ee1];
    EE2=[EE2 ee2];
    EE3=[EE3 ee3];
    EE4=[EE4 ee4];
    deta1f=norm(deta1);
    deta2f=norm(deta2);
    deta3f=norm(deta3);
    deta4f=norm(deta4);
    DETA1=[DETA1 deta1f];
    DETA2=[DETA2 deta2f];
    DETA3=[DETA3 deta3f];
    DETA4=[DETA4 deta4f];
    for n=0:4
      if n==0
         u0=0;
         x0=F1*x0+G1*u0;
      end
      if n==1
        % u1=0;
         u1=K*(3*z1o(:,a)-z2o(:,a)-z3o(:,a)-z0(:,a));
         x1=F1*x1+G1*u1;
         x1o=F2*x1o+G2*B*u1+G2*G*C*x1;
      end
      if n==2
        % u2=0;
         u2=K*(4*z2o(:,a)-z1o(:,a)-z3o(:,a)-z4o(:,a)-z0(:,a));
         x2=F1*x2+G1*u2;
         x2o=F2*x2o+G2*B*u2+G2*G*C*x2;
      end
      if n==3
        % u3=0;
         u3=K*(2*z3o(:,a)-z1o(:,a)-z2o(:,a));
         x3=F1*x3+G1*u3;
         x3o=F2*x3o+G2*B*u3+G2*G*C*x3;
      end
      if n==4
        % u4=0;
        u4=K*(z4o(:,a)-z2o(:,a));
         x4=F1*x4+G1*u4;
         x4o=F2*x4o+G2*B*u4+G2*G*C*x4;
      end
    end
    a=a+1;
end
%figure(1)
%plot(z0(1,:),z0(2,:),'r',z1(1,:),z1(2,:),'b',z2(1,:),z2(2,:),'b',z3(1,:),z3(2,:),'b',z4(1,:),z4(2,:),'b')
%legend('agent1','agent2','agent3','agent4','agent5','agent6');
figure(2)
subplot(2,1,1)
plot(t,z1(1,:),'r',t,z1o(1,:),'LineWidth',1.5);
xlabel('time(s)');
ylabel('real-time state and estimated state');
legend('real-time state x1_1','estimated state x1o_1');
subplot(2,1,2)
plot(t,z1(2,:),'r',t,z1o(2,:),'LineWidth',1.5);
xlabel('time(s)');
ylabel('real-time state and estimated state');
legend('real-time state x1_2','estimated state x1o_2');
figure(3)
subplot(2,1,1)
plot(t,z1(1,:),'g',t,z2(1,:),'b',t,z3(1,:),'c',t,z4(1,:),'m',t,z0(1,:),'r','LineWidth',1.5)
xlabel('time(s)');
ylabel('state xi_1');
h1=legend('x1_1','x2_1','x3_1','x4_1','x0_1');
set(h1,'Fontsize',7)
subplot(2,1,2)
plot(t,z1(2,:),'g',t,z2(2,:),'b',t,z3(2,:),'c',t,z4(2,:),'m',t,z0(2,:),'r','LineWidth',1.5)
xlabel('time(s)');
ylabel('state xi_2');
h2=legend('x1_2','x2_2','x3_2','x4_2','x0_2');
set(h2,'Fontsize',7)
%figure(4)
%plot(t,DETA1,t,DETA3,t,DETA3,t,DETA4)
figure(5);
subplot(2,1,1)
plot(t,EE1(1,:),t,EE2(1,:),t,EE3(1,:),t,EE4(1,:),'LineWidth',1.5);
xlabel('time(s)');
ylabel('tracking error 1 ');
h3=legend('e1_1','e2_1','e3_1','e4_1');
set(h3,'Fontsize',7)
subplot(2,1,2)
plot(t,EE1(2,:),t,EE2(2,:),t,EE3(2,:),t,EE4(2,:),'LineWidth',1.5);
xlabel('time(s)');
ylabel('tracking error 2 ');
h4=legend('e1_2','e2_2','e3_2','e4_2');
set(h4,'Fontsize',7)
