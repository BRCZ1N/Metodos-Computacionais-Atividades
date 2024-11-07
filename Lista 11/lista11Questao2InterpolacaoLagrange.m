function lista11Questao2InterpolacaoLagrange()
    % Definição dos pontos
    x = [0, 0.5, 1.0];
    fx = [1.3, 2.5, 0.9];

    % Avaliação em x = 0.8
    x_val = 0.8;
    P2 = lagrange_interpolador(x, fx, x_val);

    % Exibe o valor aproximado para f(0.8)
    fprintf('Valor aproximado de f(0.8) pelo método de Lagrange: %.4f\n', P2);

    % Plotar o polinômio interpolador
    plot_lagrange_interpolador(x, fx);
endfunction

function P = lagrange_interpolador(x, fx, x_val)
    % Calcula o polinômio interpolador de Lagrange para um valor específico x_val
    n = length(x);
    P = 0;
    for i = 1:n
        L = fx(i);
        for j = 1:n
            if j ~= i
                L = L * (x_val - x(j)) / (x(i) - x(j));
            end
        end
        P = P + L;
    end
endfunction

function plot_lagrange_interpolador(x, fx)
    % Plota o polinômio interpolador em um intervalo contínuo
    x_plot = linspace(min(x), max(x), 100);
    y_plot = zeros(size(x_plot));

    % Calcula o polinômio interpolador para cada ponto em x_plot
    for k = 1:length(x_plot)
        y_plot(k) = lagrange_interpolador(x, fx, x_plot(k));
    end

    % Exibe o gráfico
    figure;
    plot(x_plot, y_plot, 'r-', 'LineWidth', 2); % Polinômio interpolador
    hold on;
    plot(x, fx, 'bo', 'MarkerSize', 8); % Pontos dados
    xlabel('x');
    ylabel('f(x)');
    title('Interpolação de Lagrange - Polinômio Interpolador');
    legend('Polinômio Interpolador', 'Pontos Dados');
    grid on;
    hold off;
endfunction

% Chama a função principal
lista11Questao2InterpolacaoLagrange();

