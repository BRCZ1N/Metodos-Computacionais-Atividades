% Configurações iniciais
h = 0.25;         % Passo
x = 0:h:1;        % Intervalo de x
y0 = 1;           % Condição inicial

% Função f(x, y)
f = @(x, y) (1 + 4*x) * sqrt(y);

% ==========================
% Método de Euler
% ==========================
printf("\n========================\n");
printf("Método de Euler\n");
printf("========================\n");
y_euler = zeros(1, length(x));
y_euler(1) = y0;
printf("x = %.2f, y = %.6f (inicial)\n", x(1), y_euler(1));
for i = 1:length(x)-1
    slope = f(x(i), y_euler(i));
    y_euler(i+1) = y_euler(i) + h * slope;
    printf("x = %.2f, slope = %.6f, y = %.6f\n", x(i+1), slope, y_euler(i+1));
end

% ==========================
% Método de Heun
% ==========================
printf("\n========================\n");
printf("Método de Heun\n");
printf("========================\n");
y_heun = zeros(1, length(x));
y_heun(1) = y0;
printf("x = %.2f, y = %.6f (inicial)\n", x(1), y_heun(1));
for i = 1:length(x)-1
    predictor = y_heun(i) + h * f(x(i), y_heun(i));
    corrector = (f(x(i), y_heun(i)) + f(x(i+1), predictor)) / 2;
    y_heun(i+1) = y_heun(i) + h * corrector;
    printf("x = %.2f, predictor = %.6f, corrector = %.6f, y = %.6f\n", x(i+1), predictor, corrector, y_heun(i+1));
end

% ==========================
% Método do Ponto Médio
% ==========================
printf("\n========================\n");
printf("Método do Ponto Médio\n");
printf("========================\n");
y_midpoint = zeros(1, length(x));
y_midpoint(1) = y0;
printf("x = %.2f, y = %.6f (inicial)\n", x(1), y_midpoint(1));
for i = 1:length(x)-1
    midpoint = y_midpoint(i) + (h/2) * f(x(i), y_midpoint(i));
    y_midpoint(i+1) = y_midpoint(i) + h * f(x(i) + h/2, midpoint);
    printf("x = %.2f, midpoint = %.6f, y = %.6f\n", x(i+1), midpoint, y_midpoint(i+1));
end

% ==========================
% Método de Ralston (RK 2ª Ordem)
% ==========================
printf("\n========================\n");
printf("Método de Ralston (RK 2ª Ordem)\n");
printf("========================\n");
y_ralston = zeros(1, length(x));
y_ralston(1) = y0;
printf("x = %.2f, y = %.6f (inicial)\n", x(1), y_ralston(1));
for i = 1:length(x)-1
    k1 = f(x(i), y_ralston(i));
    k2 = f(x(i) + (3/4)*h, y_ralston(i) + (3/4)*h * k1);
    y_ralston(i+1) = y_ralston(i) + h * ((1/3)*k1 + (2/3)*k2);
    printf("x = %.2f, k1 = %.6f, k2 = %.6f, y = %.6f\n", x(i+1), k1, k2, y_ralston(i+1));
end

% ==========================
% Método RK de 3ª Ordem
% ==========================
printf("\n========================\n");
printf("Método RK de 3ª Ordem\n");
printf("========================\n");
y_rk3 = zeros(1, length(x));
y_rk3(1) = y0;
printf("x = %.2f, y = %.6f (inicial)\n", x(1), y_rk3(1));
for i = 1:length(x)-1
    k1 = h * f(x(i), y_rk3(i));
    k2 = h * f(x(i) + h/2, y_rk3(i) + k1/2);
    k3 = h * f(x(i) + h, y_rk3(i) - k1 + 2*k2);
    y_rk3(i+1) = y_rk3(i) + (1/6)*(k1 + 4*k2 + k3);
    printf("x = %.2f, k1 = %.6f, k2 = %.6f, k3 = %.6f, y = %.6f\n", x(i+1), k1, k2, k3, y_rk3(i+1));
end

% ==========================
% Método RK de 4ª Ordem
% ==========================
printf("\n========================\n");
printf("Método RK de 4ª Ordem\n");
printf("========================\n");
y_rk4 = zeros(1, length(x));
y_rk4(1) = y0;
printf("x = %.2f, y = %.6f (inicial)\n", x(1), y_rk4(1));
for i = 1:length(x)-1
    k1 = h * f(x(i), y_rk4(i));
    k2 = h * f(x(i) + h/2, y_rk4(i) + k1/2);
    k3 = h * f(x(i) + h/2, y_rk4(i) + k2/2);
    k4 = h * f(x(i) + h, y_rk4(i) + k3);
    y_rk4(i+1) = y_rk4(i) + (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    printf("x = %.2f, k1 = %.6f, k2 = %.6f, k3 = %.6f, k4 = %.6f, y = %.6f\n", x(i+1), k1, k2, k3, k4, y_rk4(i+1));
end

% ==========================
% Gráficos
% ==========================
figure;
plot(x, y_euler, 'b-o', 'LineWidth', 1.2); hold on;
plot(x, y_heun, 'r-s', 'LineWidth', 1.2);
plot(x, y_midpoint, 'g-^', 'LineWidth', 1.2);
plot(x, y_ralston, 'm-d', 'LineWidth', 1.2);
plot(x, y_rk3, 'c-p', 'LineWidth', 1.2);
plot(x, y_rk4, 'y-*', 'LineWidth', 1.2);
legend('Euler', 'Heun', 'Midpoint', 'Ralston', 'RK3', 'RK4');
xlabel('x'); ylabel('y');
title('Comparative Solutions of ODE');
grid on;

