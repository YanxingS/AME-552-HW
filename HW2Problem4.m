clc; clear all; close all

%% HW 2 problem 4

A = 1;
B = 1;
Kb = 1;
wc = 1;
J = 1;

kp = 1;
ki = 1;

%% case i 
plotpp(@(t,x) [x(2);(-A - Kb*x(2) + Kb*wc)/J]);

%% case ii 

plotpp(@(t,x) [x(2); (-A/B*(x(2)*kp+ki*x(1))-Kb*x(2)+Kb*wc)/J]);

A = [0 1;-A*ki/(B*J) -A*kp/B-Kb];

eig(A);

%% case iii

plotpp(@(t,x) [x(2);(A - Kb*x(2) + Kb*wc)/J]);