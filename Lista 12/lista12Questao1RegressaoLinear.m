function lista12Questao1RegressaoLinear()
    % Definição dos dados
    xi = [1 2 3 4 5 6 7 8 9 10]';
    yi = [1.3 3.5 4.2 5.0 7.0 8.8 10.1 12.5 13.0 15.6]';

    % Execução do método de regressão linear
    [a1, a2, desvio_padrao_total, erro_padrao_estimativa, r2, residuos, y_adjusted] = regressao_linear(xi, yi);

    % Exibir detalhes no terminal
    disp('=== RESULTADOS DO AJUSTE LINEAR ===');
    fprintf('Coeficiente de inclinação (a1): %.4f\n', a1);
    fprintf('Coeficiente de interseção (a2): %.4f\n', a2);
    fprintf('Desvio padrão total: %.4f\n', desvio_padrao_total);
    fprintf('Erro padrão da estimativa: %.4f\n', erro_padrao_estimativa);
    fprintf('Coeficiente de determinação (r^2): %.4f\n\n', r2);

    % Mostrar somatórios
    disp('--- Somatórios ---');
    fprintf('Soma de x (Sx): %.2f\n', sum(xi));
    fprintf('Soma de y (Sy): %.2f\n', sum(yi));
    fprintf('Soma de x^2 (Sx2): %.2f\n', sum(xi .^ 2));
    fprintf('Soma de x*y (Sxy): %.2f\n\n', sum(xi .* yi));

    % Mostrar resíduos e comparação
    disp('--- Comparação dos Dados ---');
    fprintf('%-10s %-10s %-15s %-10s\n', 'x', 'y_real', 'y_ajustado', 'residuo');
    for i = 1:length(xi)
        fprintf('%-10.2f %-10.2f %-15.2f %-10.2f\n', xi(i), yi(i), y_adjusted(i), residuos(i));
    end

    % Plotar o ajuste
    plot_regressao(xi, yi, a1, a2, r2, erro_padrao_estimativa);
endfunction

function [a1, a2, desvio_padrao_total, erro_padrao_estimativa, r2, residuos, y_adjusted] = regressao_linear(x, y)
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

    % Resíduos
    residuos = y - y_adjusted;
endfunction

function plot_regressao(x, y, a1, a2, r2, erro_padrao_estimativa)
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

    % Adicionar informações ao gráfico
    text(mean(x), mean(y), sprintf('R^2 = %.4f\nErro padrão = %.4f', r2, erro_padrao_estimativa), ...
        'FontSize', 12, 'Color', 'red', 'HorizontalAlignment', 'center');
endfunction

lista12Questao1RegressaoLinear();

