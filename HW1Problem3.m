clc; clear all; close all 

%% AME 552 hw 1 problem 3

A_eq1 = [3 0; 0 2];
A_eq2 = [-3 -6; 0 -1];
A_eq3 = [-1 0; -2 -2];
A_eq4 = [3 -2; -1 -1];

[V1,D1] = eig(A_eq1);
[V2,D2] = eig(A_eq2);
[V3,D3] = eig(A_eq3);
[V4,D4] = eig(A_eq4);

%% Non linear system equations

odefun = @(t,x)[x(1)*(3-x(1)-2*x(2));x(2)*(2-x(1)-x(2))];
plotpp(odefun,'xlim',[0 5],'ylim',[0 5])

ylabel('x(2)')
xlabel('x(1)')
title('phase portrait of nonlinear system problem 3')