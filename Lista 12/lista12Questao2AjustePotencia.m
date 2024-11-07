function lista12Questao2AjustePotencia()
    % Definição dos dados
    xi = [10 20 30 40 50 60 70 80]';
    yi = [25 70 380 550 610 1220 830 1450]';

    % Execução do método de ajuste de potência
    [alpha, beta, desvio_padrao_total, erro_padrao_estimativa, r2] = ajuste_potencia(xi, yi);

    disp('Coeficiente de escala (alpha):'), disp(alpha);
    disp('Coeficiente de potência (beta):'), disp(beta);
    disp('Desvio padrão total:'), disp(desvio_padrao_total);
    disp('Erro padrão da estimativa:'), disp(erro_padrao_estimativa);
    disp('Coeficiente de determinação (r^2):'), disp(r2);

    % Plotar o ajuste
    plot_ajuste_potencia(xi, yi, alpha, beta);
endfunction

function [alpha, beta, desvio_padrao_total, erro_padrao_estimativa, r2] = ajuste_potencia(x, y)
    % Transformação logarítmica
    log_x = log(x);
    log_y = log(y);

    % Número de pontos
    n = length(log_x);

    % Somatórios para os logs
    Sx_log = sum(log_x);
    Sy_log = sum(log_y);
    Sx2_log = sum(log_x .^ 2);
    Sxy_log = sum(log_x .* log_y);

    % Coeficientes para a linha ajustada nos logs
    beta = (n * Sxy_log - Sx_log * Sy_log) / (n * Sx2_log - Sx_log^2);
    log_alpha = mean(log_y) - beta * mean(log_x);
    alpha = exp(log_alpha);

    % Estatísticas
    Sy2_log = sum((log_y - mean(log_y)).^2); % Resíduo em relação à média
    y_adjusted_log = beta * log_x + log_alpha;
    Se2_log = sum((log_y - y_adjusted_log).^2); % Resíduo em relação ao ajuste

    desvio_padrao_total = sqrt(Sy2_log / (n - 1));
    erro_padrao_estimativa = sqrt(Se2_log / (n - 2));
    r2 = (Sy2_log - Se2_log) / Sy2_log;
endfunction

function plot_ajuste_potencia(x, y, alpha, beta)
    % Plotar os pontos e a curva de ajuste
    y_adjusted = alpha * x .^ beta;
    figure;
    plot(x, y, 'bo', 'MarkerSize', 8); % Pontos reais
    hold on;
    plot(x, y_adjusted, 'r-', 'LineWidth', 2); % Curva de ajuste
    xlabel('x');
    ylabel('y');
    title('Ajuste de Potência por Mínimos Quadrados');
    legend('Dados', 'Ajuste de Potência');
    grid on;
endfunction

lista9Questao2AjustePotencia();

