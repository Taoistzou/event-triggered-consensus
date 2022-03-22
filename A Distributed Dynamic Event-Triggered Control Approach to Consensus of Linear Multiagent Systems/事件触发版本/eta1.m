function etadot=eta1(t,eta)
global  Z EE;
m=diag([2.8 1.2 1.2 2.4 2 1.6]*10^(-3));
etadot=-0.004.*eta+87.3971.*(m*Z-EE);
