f = @(x) -0.1*x.^4 - 0.15*x.^3 - 0.5*x.^2 - 0.25*x + 1.2;
fD = @(x) -0.4*x.^3 - 0.45*x.^2 - 1.0*x - 0.25;

xi = 0.5;

h = 1;

n = 13;

h_valores = 10 .^ linspace(0, -12, n);

dFFinitaCentrada = zeros(size(h_valores));
erroVerdadeiro = zeros(size(h_valores));

for i = 1:length(h_valores)
    h = h_valores(i);
    dFFinitaCentrada(i) = (f(xi + h) - f(xi - h)) / (2*h);
    erroVerdadeiro(i) = abs(fD(xi) - dFFinitaCentrada(i));
end

disp('  Tamanho do Passo  |  Diferença Finita  |  Erro Verdadeiro  ');
disp('----------------------------------------------------');
for i = 1:length(h_valores)
    fprintf('%e | %e | %e\n', h_valores(i), dFFinitaCentrada(i), erroVerdadeiro(i));
end

figure;
loglog(h_valores, erroVerdadeiro, '-ok', 'MarkerSize', 6, 'LineWidth', 1.5);
xlabel('Tamanho do Passo (h)', 'FontSize', 12);
ylabel('Erro Verdadeiro', 'FontSize', 12);
title('Gráfico do Erro Verdadeiro versus Tamanho do Passo', 'FontSize', 14);
grid on;
set(gca, 'Color', 'w');
set(gcf, 'Color', 'w');

ax = gca;
ax.XAxis.Exponent = 0;
ax.YAxis.Exponent = 0;

