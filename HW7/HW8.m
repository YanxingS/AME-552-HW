clc; clear all; close all;

%% HW 8 problem 2 

syms x1 x2 x3 k1 k2 k3 z1 z2 z3


z = [z1;z2;z3];

[2-x3 -2 1-x1]*[-x1+x2-x3;-x1*x3-x2;-x1];

T = [x1; -x1+x2-x3; 2*x1-2*x2+x3 - x3*x1];

f = [-x1+x2-x3;-x1*x3-x2; -x1];
G = [0;1;1];

beta = 1/(jacobian(T(3),[x1 x2 x3])*G);

alpha = -beta*jacobian(T(3),[x1 x2 x3])*f;

v = -k1*z1 - k2*z2-k3*z3;

u = alpha+beta*v;

dTdx = jacobian(T,[x1 x2 x3]);

% compute input-state linearized system

dTdx*(f+G*u)

A = [0 1 0;0 0 1;0 0 0]; B = [0;0;1];
z_dot = A*T+B*inv(beta)*(u-alpha)
x_dot = [-x1+x2-x3;-x1*x3-x2+u;-x1+u]