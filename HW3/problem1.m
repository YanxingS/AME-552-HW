clc; clear all; close all;

%% AME 552 problem 1 hw 3 

syms A W

eqn1(A,W) = 4*W - pi*A*W^3+6*pi*A*W;
eqn2(A,W) = - 5*pi*A*W^2+24;

sol = solve(eqn1,eqn2,[A,W]);