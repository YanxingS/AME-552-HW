clc; clear all; close all;

%% HW 6 problem 1 

% design a MRAC controller for a given model system and a given plant
% system with unknown parameter a

%% assigning constants 

a = 1; % a_p, a number that we don't know, this is initial guess
b_p = 1; 
a_m = 2;
b_m = 1;

a_r = b_m/b_p;
a_y = (a-a_m)/b_p;

step = 0.1; % time step size

gamma_r = 0.75;
gamma_y = 0.75;

syms y(t) y_m(t) r(t) u(t) 

model_ode_cond = y_m(0) == 0;
plant_ode_cond = y(0) == 0;

u(t) = 0;

time = 0.1:step:15;

model_response = [];
plant_response = [];
e_overtime = [];
a_y_hat_overtime = [];

a_r_hat = 0;
a_y_hat = 0;

for i = 1:length(time)

r(t) = sin(time(i));
% r(t) = 1;

%compute plant and model response
model_ode = diff(y_m,t) == -a_m*y_m + r;  
plant_ode = diff(y,t) == -a*y+b_p*u; 

model_ode_sol(t) = dsolve(model_ode,model_ode_cond);
plant_ode_sol(t) = dsolve(plant_ode,plant_ode_cond);

% %change next initial condition
% model_ode_cond = y_m(0) == model_ode_sol(time(i));
% plant_ode_cond = y(0) == plant_ode_sol(time(i));

%store response
model_response(i) = model_ode_sol(time(i)); 
plant_response(i) = plant_ode_sol(time(i));

e = plant_response(i) - model_response(i);
e_overtime(i) = e;

a_r_hat_dot = -gamma_r*e*r(t);
a_y_hat_dot = -gamma_r*e*plant_response(i);

a_r_hat = a_r_hat + a_r_hat_dot*step;
a_y_hat = a_y_hat + a_y_hat_dot*step;

% store a_y approximation

a_y_hat_overtime(i) = a_y_hat;

u = a_r_hat*r(t)+a_y_hat*plant_response(i);

a = a_y_hat*b_p+a_m;

end

%% plotting 
close all

subplot(2,1,1)

plot(time,model_response(1,:),"LineWidth",2);
hold on
plot(time,plant_response(1,:),"LineWidth",2);
plot(time,1,"LineWidth",2,"LineStyle","--");
title('model response vs plant response over time for gamma_y = 0.75')

grid on
legend('model response','plant response')

subplot(2,1,2)

plot(time,a_y_hat_overtime(1,:),"LineWidth",2);
title('a approximation overtime')
grid on