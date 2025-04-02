clc; clear all; close all;

%% AME 552 HW3 problem 3d

% Define the transfer function G(s) = 4 / (s(s+1)(s+2))
num = 4;               % Numerator coefficients
den = conv([1 0], conv([1 1], [1 2]));  % Denominator coefficients

% Create transfer function
G = tf(num, den);

% Plot Nyquist diagram
figure;
nyquist(G);
ylim([-7,7])
grid on;
title('Nyquist Plot of G(s) = 4 / (s(s+1)(s+2))');

%% 
clc;
clear;
close all;

k = linspace(0.1,0.9999,1000);
a = k.*0.424;
A = linspace(0.1,9999,1000);


N = 4./(pi.*A).*sqrt(1-(a./A).^2);

%%

clc;
clear;
close all;

% 参数设置
a = 0.5 * (4 / (3 * pi)); % 非线性项的阈值
tspan = [0 20]; % 时间范围
y0 = [5; 0; 0]; % 初始条件 [y(0), dy/dt(0), d^2y/dt^2(0)]
w = sqrt(2); % 角频率
t_limit_cycle = linspace(0, 20, 1000); % 时间点

% 计算极限环
% 大极限环
A1 = (4 * sqrt(2)) / (3 * pi) * sqrt(1 + sqrt(1 - 0.5^2)); % 大极限环的振幅
y_limit_cycle1 = A1 * sin(w * t_limit_cycle); % 大极限环的 y 值
dy_limit_cycle1 = A1 * w * cos(w * t_limit_cycle); % 大极限环的 dy/dt 值
d2y_limit_cycle1 = -A1 * w^2 * sin(w * t_limit_cycle); % 大极限环的 d^2y/dt^2 值

% 小极限环
A2 = (4 * sqrt(2)) / (3 * pi) * sqrt(1 - sqrt(1 - 0.5^2)); % 小极限环的振幅
y_limit_cycle2 = A2 * sin(w * t_limit_cycle); % 小极限环的 y 值
dy_limit_cycle2 = A2 * w * cos(w * t_limit_cycle); % 小极限环的 dy/dt 值
d2y_limit_cycle2 = -A2 * w^2 * sin(w * t_limit_cycle); % 小极限环的 d^2y/dt^2 值

% 解微分方程
[t, y] = ode45(@(t, y) odefun(t, y, a), tspan, y0);

% 绘图
figure;
hold on;

% 绘制大极限环
plot3(y_limit_cycle1, dy_limit_cycle1, d2y_limit_cycle1, 'r--', 'LineWidth', 2);

% 绘制小极限环
plot3(y_limit_cycle2, dy_limit_cycle2, d2y_limit_cycle2, 'g--', 'LineWidth', 2);

% 绘制相图
plot3(y(:,1), y(:,2), y(:,3), 'b', 'LineWidth', 1.5);

% 图形设置
xlabel('y');
ylabel('dy/dt');
zlabel('d^2y/dt^2');
title('3D Phase Portrait with Limit Cycles');
legend('Large Limit Cycle', 'Small Limit Cycle', 'Phase Portrait');
grid on;
hold off;


%% 定义方程
eqn = @(A, k) (2*k/pi) * (asin(1./A) + (1./A) .* sqrt(1 - (1./A).^2)) - 1/5;

% 定义k的范围
k_values = linspace(0.2, 10, 100); % k从0.1到10，取100个点
A_values = zeros(size(k_values)); % 预分配A的值

% 对于每个k值，求解A
options = optimoptions('fsolve', 'Display', 'off'); % 关闭fsolve的显示
for i = 1:length(k_values)
    k = k_values(i);
    % 使用fsolve求解A，初始猜测值为1.5
    A_values(i) = fsolve(@(A) eqn(A, k), 1.5, options);
end

% 绘制A随k的变化图像
figure;
plot(k_values, A_values, 'b-', 'LineWidth', 2);
xlabel('k');
ylabel('A');
title('A随k的变化');
grid on;


%% 定义微分方程
function dydt = odefun(t, y, a)
    u = -y(1);
    if u < -a
        v = -1;
    elseif u > a
        v = 1;
    else
        v = 0;
    end
    
    dydt = zeros(3,1);
    dydt(1) = y(2); % dx1/dt = x2
    dydt(2) = y(3); % dx2/dt = x3
    dydt(3) = -3*y(3) - 2*y(2) + 4*v; % dx3/dt = -3x3 - 2x2 + 4v
end

