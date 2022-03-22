function xdot=x00(t,x)
global A B uu;
xdot=kron(eye(6),A)*x+kron(eye(6),B)*uu;