function lista12Questao1RegressaoLinear()
    % Definição dos dados
    xi = [1 2 3 4 5 6 7 8 9 10]';
    yi = [1.3 3.5 4.2 5.0 7.0 8.8 10.1 12.5 13.0 15.6]';

    % Execução do método de regressão linear
    [a1, a2, desvio_padrao_total, erro_padrao_estimativa, r2] = regressao_linear(xi, yi);

    disp('Coeficiente de inclinação (a1):'), disp(a1);
    disp('Coeficiente de interseção (a2):'), disp(a2);
    disp('Desvio padrão total:'), disp(desvio_padrao_total);
    disp('Erro padrão da estimativa:'), disp(erro_padrao_estimativa);
    disp('Coeficiente de determinação (r^2):'), disp(r2);

    % Plotar o ajuste
    plot_regressao(xi, yi, a1, a2);
endfunction

function [a1, a2, desvio_padrao_total, erro_padrao_estimativa, r2] = regressao_linear(x, y)
    % Número de pontos
    n = length(x);

    % Somatórios
    Sx = sum(x);
    Sy = sum(y);
    Sx2 = sum(x .^ 2);
    Sxy = sum(x .* y);

    % Cálculo dos coeficientes de ajuste
    a1 = (n * Sxy - Sx * Sy) / (n * Sx2 - Sx^2);
    a2 = mean(y) - a1 * mean(x);

    % Estatísticas
    Sy2 = sum((y - mean(y)).^2);  % Resíduo em relação à média
    y_adjusted = a1 * x + a2;     % Ajuste linear
    Se2 = sum((y - y_adjusted).^2); % Resíduo em relação ao ajuste

    desvio_padrao_total = sqrt(Sy2 / (n - 1));
    erro_padrao_estimativa = sqrt(Se2 / (n - 2));
    r2 = (Sy2 - Se2) / Sy2;
endfunction

function plot_regressao(x, y, a1, a2)
    % Plotar os pontos e a linha de ajuste
    y_adjusted = a1 * x + a2;
    figure;
    plot(x, y, 'bo', 'MarkerSize', 8); % Pontos reais
    hold on;
    plot(x, y_adjusted, 'r-', 'LineWidth', 2); % Linha de ajuste
    xlabel('x');
    ylabel('y');
    title('Ajuste Linear por Mínimos Quadrados');
    legend('Dados', 'Ajuste Linear');
    grid on;
endfunction

lista9Questao1RegressaoLinear();

