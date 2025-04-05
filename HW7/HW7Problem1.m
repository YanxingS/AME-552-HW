clc; clear all; close all;

%% HW 7 problem 1 

% draw Nyquist plot for Circle criterion

s = tf('s');

G1 = 1/((s+2)*(s+3));
G2 = 1/(s^2+s+1);
G3 = (s-1)/(s^2+0.1*s+0.9);
% G4 = (s+1)/(((s+2)^2)*(s-1));
G4 = (s+1)/(s^3+3*s^2+5*s+1);

% problem 2 system
G5 = (2*s)/(s^2+s+1);

% figure

% nyquist(G1);
% nyquist(G2);  
% nyquist(G3);
% nyquist(G4);
% nyquist(G5);

omega = logspace(-2,2,500);

Gjw = freqresp(G4,omega);
Gjw = squeeze(Gjw);

ReGjw = real(Gjw);
ImGjw = imag(Gjw);
wImGjw = omega.*ImGjw';

figure

plot(ReGjw,wImGjw,'b','LineWidth',2);
xlabel('Re(G(j\omega)');
ylabel('\omega Im(G(j\omega)');
title('modified Nyquist diagram for Popov criterion');

%% problem 4

% convert SS to TF

A = [-1 0; 1 -1];
B = [1;2];
C = [1 1];
D = 0;

[num den] = ss2tf(A,B,C,D);

sys4 = tf(num,den)

figure 
nyquist(sys4)