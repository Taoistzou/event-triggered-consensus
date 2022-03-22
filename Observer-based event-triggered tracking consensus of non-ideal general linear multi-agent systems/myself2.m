A=[2 -2;3 -2];
B=[0;1];
C=[1 0];
D=0;
L=[2 -1 -1 0;-1 3 -1 -1;-1 -1 2 0; 0 -1 0 1];
M=[3 -1 -1 0;-1 4 -1 -1;-1 -1 2 0; 0 -1 0 1];
h=0.02;
T=10;
gama=0.95;
alfa=10;
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
G2=double(int(expm((A-G*C)*x),x,0,h))
PB=P1*B*B'*P1;
thita=norm(kron(M,PB));
ka=gama*0.5*tao*(1-1/alfa);
thita1=thita-0.5*(1-alfa);
ez=1.5*ka/thita1;
a=1;a1=1;a2=1;a3=1;a4=1;
A1=[];A2=[];A3=[];A4=[];
t=0:h:T;
x0=[4;-4];x1=[1;-1];x2=[3;-3];x3=[5;-5];x4=[7;-7];
z0=[];z1=[];z2=[];z3=[];z4=[];
z1o=[];z2o=[];z3o=[];z4o=[];
E1=[];E2=[];E3=[];E4=[];EZ=[];W1=[];
x1o=[0;0];x2o=[0;0];x3o=[0;0];x4o=[0;0];
DETA1=[];DETA2=[];DETA3=[];DETA4=[];
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
    e1=expm((a-a1)*h)*x1o-z1o(:,a1);
    e2=expm((a-a2)*h)*x2o-z2o(:,a2);
    e3=expm((a-a3)*h)*x3o-z3o(:,a3);
    e4=expm((a-a4)*h)*x4o-z4o(:,a4);
    %e1=x1o-z1o(:,a1);
    %e2=x2o-z2o(:,a2);
    %e3=x3o-z3o(:,a3);
    %e4=x4o-z4o(:,a4);
    e1f=norm(e1);
    e2f=norm(e2);
    e3f=norm(e3);
    e4f=norm(e4);
    E1=[E1;e1f];
    E2=[E2;e2f];
    E3=[E3;e3f];
    E4=[E4;e4f];
    deta1=z1o(:,a1)-z0(:,a);
    deta2=z2o(:,a2)-z0(:,a);
    deta3=z3o(:,a3)-z0(:,a);
    deta4=z4o(:,a4)-z0(:,a);
    deta1f=norm(deta1);
    deta2f=norm(deta2);
    deta3f=norm(deta3);
    deta4f=norm(deta4);
    DETA1=[DETA1 ez*deta1f];
    DETA2=[DETA2 ez*deta2f];
    DETA3=[DETA3 ez*deta3f]; 
    DETA4=[DETA4 ez*deta4f];
    for n=0:4
      if n==0
         u0=0;
         x0=F1*x0+G1*u0;
      end
      if n==1
        % u1=0;
         u1=K*(3*z1o(:,a1)-z2o(:,a2)-z3o(:,a3)-z0(:,a));  
      end
      if n==2
        % u2=0;     
         u2=K*(4*z2o(:,a2)-z1o(:,a1)-z3o(:,a3)-z4o(:,a4)-z0(:,a));
      end
      if n==3
        % u3=0;
       u3=K*(2*z3o(:,a3)-z1o(:,a1)-z2o(:,a2)); 
      end
      if n==4
        % u4=0; 
        u4=K*(z4o(:,a4)-z2o(:,a2));  
      end
    end
    if e1f<(ez^0.5)*deta1f
        x1o=F2*x1o+G2*B*u1+G2*G*C*x1;
        x1=F1*x1+G1*u1;
    else
        a1=a;
        A1=[A1 a];
    end
    if e2f<(ez^0.5)*deta2f
        x2o=F2*x2o+G2*B*u2+G2*G*C*x2;
        x2=F1*x2+G1*u2;
    else
        a2=a;
        A2=[A2 a];
    end
    if e3f<(ez^0.5)*deta3f
         x3o=F2*x3o+G2*B*u3+G2*G*C*x3;
         x3=F1*x3+G1*u3;
    else
        a3=a;
        A3=[A3 a];
    end
    if e4f<(ez^0.5)*deta4f 
       x4o=F2*x4o+G2*B*u4+G2*G*C*x4;
       x4=F1*x4+G1*u4;
    else
        a4=a;
        A4=[A4 a];
    end
    a=a+1;
end
A1T=[];A2T=[];A3T=[];A4T=[];A5T=[];A6T=[];
y1=ones(size(A1,2),1);
y2=2*ones(size(A2,2),1);
y3=3*ones(size(A3,2),1);
y4=4*ones(size(A4,2),1);
A1h=h*A1;
A2h=h*A2;
A3h=h*A3;
A4h=h*A4;
AT1=h*A1(1,1:(size(A1,2)-1));
AT2=h*A2(1,1:(size(A2,2)-1));
AT3=h*A3(1,1:(size(A3,2)-1));
AT4=h*A4(1,1:(size(A4,2)-1));
A1T=[0 AT1];
A2T=[0 AT2];
A3T=[0 AT3];
A4T=[0 AT4];
Tk1=[];
k1=size(A1,2);
Tk1=[Tk1 h*A1(1,1)];
for p=2:k1
    Tk=h*(A1(1,p)-A1(1,p-1));
    Tk1=[Tk1 Tk];
end
Tk2=[];
k2=size(A2,2);
Tk2=[Tk2 h*A2(1,1)];
for p=2:k2
    Tk=h*(A2(1,p)-A2(1,p-1));
    Tk2=[Tk2 Tk];
end
Tk3=[];
k3=size(A3,2);
Tk3=[Tk3 h*A3(1,1)];
for p=2:k3
    Tk=h*(A3(1,p)-A3(1,p-1));
    Tk3=[Tk3 Tk];
end
Tk4=[];
k4=size(A4,2);
Tk4=[Tk4 h*A4(1,1)];
for p=2:k4
    Tk=h*(A4(1,p)-A4(1,p-1));
    Tk4=[Tk4 Tk];
end
ATK1=mean(Tk1);
ATK2=mean(Tk2);
ATK3=mean(Tk3);
ATK4=mean(Tk4);
ATK=[];
ATK=[ATK ATK1];
ATK=[ATK ATK2];
ATK=[ATK ATK3];
ATK=[ATK ATK4];
aTK=mean(ATK);
figure(1)
plot(z0(1,:),z0(2,:),'r',z1(1,:),z1(2,:),'b',z2(1,:),z2(2,:),'b',z3(1,:),z3(2,:),'b',z4(1,:),z4(2,:),'b')
figure(2)
plot(t,z1(1,:),'r',t,z1o(1,:));
figure(3)
subplot(2,1,1)
plot(t,z0(1,:),'r',t,z1(1,:),'g',t,z2(1,:),'g',t,z3(1,:),'g',t,z4(1,:),'g')
subplot(2,1,2)
plot(t,z0(2,:),'r',t,z1(2,:),'g',t,z2(2,:),'g',t,z3(2,:),'g',t,z4(2,:),'g')
figure(4)
plot(t,DETA1,'r',t,E1)
figure(5);
plot(A1h,y1,'*r',A2h,y2,'*b',A3h,y3,'*y',A4h,y4,'*m');
figure(6);
subplot(4,1,1);
h1=stem(A1T,Tk1,'k','fill');
set(h1(:),'MarkerSize',2)
xlabel('time(s)')
subplot(4,1,2);
h2=stem(A2T,Tk2,'k','fill');
set(h2(:),'MarkerSize',2)
xlabel('time(s)')
subplot(4,1,3);
h3=stem(A3T,Tk3,'k','fill');
set(h3(:),'MarkerSize',2)
xlabel('time(s)')
%axis([0 15 0 0.5]);
subplot(4,1,4);
h4=stem(A4T,Tk4,'k','fill');
set(h4(:),'MarkerSize',2)
xlabel('time(s)')
%axis([0 15 0 0.6]);
xlabel('time(s)');