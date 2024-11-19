function lista12Questao2AjustePotencia()
    % Definição dos dados
    xi = [10 20 30 40 50 60 70 80]';
    yi = [25 70 380 550 610 1220 830 1450]';

    % Execução do método de ajuste de potência
    [alpha, beta, desvio_padrao_total, erro_padrao_estimativa, r2, log_y_adjusted, detalhes] = ajuste_potencia(xi, yi);

    % Exibir detalhes no terminal
    disp('=== RESULTADOS DO AJUSTE DE POTÊNCIA ===');
    fprintf('Coeficiente de escala (alpha): %.4f\n', alpha);
    fprintf('Coeficiente de potência (beta): %.4f\n', beta);
    fprintf('Desvio padrão total (log): %.4f\n', desvio_padrao_total);
    fprintf('Erro padrão da estimativa (log): %.4f\n', erro_padrao_estimativa);
    fprintf('Coeficiente de determinação (r^2): %.4f\n\n', r2);

    % Mostrar valores intermediários
    disp('--- Detalhes dos Somatórios e Intermediários ---');
    disp(detalhes);

    % Mostrar resíduos e comparação
    disp('--- Comparação dos Dados (log-transformados) ---');
    fprintf('%-10s %-15s %-15s %-10s\n', 'x', 'log(y_real)', 'log(y_ajustado)', 'residuo');
    log_y = log(yi);
    residuos = log_y - log_y_adjusted;
    for i = 1:length(xi)
        fprintf('%-10.2f %-15.4f %-15.4f %-10.4f\n', xi(i), log_y(i), log_y_adjusted(i), residuos(i));
    end

    % Plotar o ajuste
    plot_ajuste_potencia(xi, yi, alpha, beta);
endfunction

function [alpha, beta, desvio_padrao_total, erro_padrao_estimativa, r2, log_y_adjusted, detalhes] = ajuste_potencia(x, y)
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
    log_y_adjusted = beta * log_x + log_alpha;
    Se2_log = sum((log_y - log_y_adjusted).^2); % Resíduo em relação ao ajuste

    desvio_padrao_total = sqrt(Sy2_log / (n - 1));
    erro_padrao_estimativa = sqrt(Se2_log / (n - 2));
    r2 = (Sy2_log - Se2_log) / Sy2_log;

    % Coletar detalhes intermediários
    detalhes = struct('Sx_log', Sx_log, 'Sy_log', Sy_log, 'Sx2_log', Sx2_log, ...
                      'Sxy_log', Sxy_log, 'Sy2_log', Sy2_log, 'Se2_log', Se2_log);

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

    % Adicionar informações ao gráfico
    text(mean(x), mean(y), sprintf('y = %.2f x^{%.2f}', alpha, beta), ...
        'FontSize', 12, 'Color', 'red', 'HorizontalAlignment', 'center');
endfunction

% Chamar a função principal
lista12Questao2AjustePotencia();

