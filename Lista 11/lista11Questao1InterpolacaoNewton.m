function lista11Questao1InterpolacaoNewton()
    % Definição dos pontos
    x = [0, 0.5, 1.0];
    fx = [1.0, 2.12, 3.55];

    % Avaliação em x = 0.7
    x_val = 0.7;

    % Cálculo do polinômio interpolador usando diferenças divididas
    P2 = newton_interpolacao(x, fx, x_val);

    fprintf('Valor aproximado de f(0.7) pelo método de Newton: %.4f\n', P2);

    % Plotar o polinômio interpolador
    plot_newton(x, fx);
endfunction

function P2 = newton_interpolacao(x, fx, x_val)
    n = length(x);
    coef = fx;

    % Construção da tabela de diferenças divididas
    for j = 2:n
        for i = n:-1:j
            coef(i) = (coef(i) - coef(i-1)) / (x(i) - x(i-j+1));
        end
    end

    % Avaliação de P2(x) usando os coeficientes de Newton
    P2 = coef(n);
    for k = n-1:-1:1
        P2 = P2 * (x_val - x(k)) + coef(k);
    end
endfunction

function plot_newton(x, fx)
    % Definir intervalo de plotagem
    x_plot = linspace(min(x), max(x), 100);
    y_plot = arrayfun(@(x_val) newton_interpolacao(x, fx, x_val), x_plot);

    % Plotar o gráfico
    figure;
    plot(x, fx, 'bo', 'MarkerSize', 8); % Pontos dados
    hold on;
    plot(x_plot, y_plot, 'r-', 'LineWidth', 2); % Polinômio interpolador
    xlabel('x');
    ylabel('f(x)');
    title('Interpolação de Newton - Polinômio de Grau 2');
    legend('Pontos Dados', 'Polinômio Interpolador');
    grid on;
endfunction

lista11Questao1InterpolacaoNewton();

