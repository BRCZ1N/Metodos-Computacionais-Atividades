function lista11Questao3Vandermonde()
    % Dados da Questão 1
    x1 = [0, 0.5, 1.0];
    fx1 = [1.0, 2.12, 3.55];

    % Dados da Questão 2
    x2 = [0, 0.5, 1.0];
    fx2 = [1.3, 2.5, 0.9];

    % Resolver com matriz de Vandermonde para cada conjunto de dados
    coef1 = vandermonde_interpolacao(x1, fx1);
    coef2 = vandermonde_interpolacao(x2, fx2);

    fprintf('Coeficientes do polinômio da Questão 1:\n');
    disp(coef1');

    fprintf('Coeficientes do polinômio da Questão 2:\n');
    disp(coef2');

    % Plotar os polinômios
    plot_vandermonde(x1, fx1, coef1, 'Interpolação com Vandermonde - Questão 1');
    plot_vandermonde(x2, fx2, coef2, 'Interpolação com Vandermonde - Questão 2');
endfunction

function coef = vandermonde_interpolacao(x, fx)
    % Construção da matriz de Vandermonde
    V = vander(x);

    % Resolver o sistema linear V * coef = fx
    coef = V \ fx';
endfunction

function plot_vandermonde(x, fx, coef, plot_title)
    % Definir intervalo de plotagem
    x_plot = linspace(min(x), max(x), 100);
    y_plot = polyval(coef, x_plot);

    % Plotar o gráfico
    figure;
    plot(x, fx, 'bo', 'MarkerSize', 8); % Pontos dados
    hold on;
    plot(x_plot, y_plot, 'r-', 'LineWidth', 2); % Polinômio interpolador
    xlabel('x');
    ylabel('f(x)');
    title(plot_title);
    legend('Pontos Dados', 'Polinômio Interpolador');
    grid on;
endfunction

lista11Questao3Vandermonde();

