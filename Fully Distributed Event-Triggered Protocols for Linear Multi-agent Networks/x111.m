function xdot=x111(t,x)
global A B uu;
xdot=kron(eye(4),A)*x+kron(eye(4),B)*uu;
end