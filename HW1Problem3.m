clc; clear all; close all 

%% AME 552 hw 1 problem 3

A_eq1 = [-3 0; 0 -2];
A_eq2 = [3 6; 0 1];
A_eq3 = [1 0; 2 2];
A_eq4 = [-3 2; 1 1];

[V,D] = eig(A_eq4)