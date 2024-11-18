function lista11Questao3Vandermonde()
    % Dados da Questão 1
    x1 = [0, 0.5, 1.0];
    fx1 = [1.0, 2.12, 3.55];

    % Dados da Questão 2
    x2 = [0, 0.5, 1.0];
    fx2 = [1.3, 2.5, 0.9];

    % Resolver com matriz de Vandermonde para cada conjunto de dados
    fprintf('--- Questão 1 ---\n');
    coef1 = vandermonde_interpolacao(x1, fx1, true); % Mostrar detalhes
    fprintf('\n--- Questão 2 ---\n');
    coef2 = vandermonde_interpolacao(x2, fx2, true); % Mostrar detalhes

    % Mostrar coeficientes encontrados
    fprintf('\nCoeficientes do polinômio da Questão 1 (ordem decrescente):\n');
    disp(coef1');
    fprintf('Coeficientes do polinômio da Questão 2 (ordem decrescente):\n');
    disp(coef2');

    % Calcular valores em pontos adicionais para cada questão
    ponto1 = 0.7; % Ponto para Questão 1
    ponto2 = 0.8; % Ponto para Questão 2
    fprintf('\n--- Cálculo do polinômio em pontos adicionais ---\n');
    valor1 = calcular_polinomio(coef1, ponto1, true); % Mostrar detalhes
    valor2 = calcular_polinomio(coef2, ponto2, true); % Mostrar detalhes
    fprintf('\nf(0.7) para Questão 1: %.4f\n', valor1);
    fprintf('f(0.8) para Questão 2: %.4f\n', valor2);

    % Plotar os polinômios com os pontos calculados
    plot_vandermonde(x1, fx1, coef1, 'Interpolação com Vandermonde - Questão 1', ponto1, valor1);
    plot_vandermonde(x2, fx2, coef2, 'Interpolação com Vandermonde - Questão 2', ponto2, valor2);
end

function coef = vandermonde_interpolacao(x, fx, mostrar_detalhes)
    % Construção manual da matriz de Vandermonde
    n = length(x);
    V = zeros(n, n);
    if mostrar_detalhes
        fprintf('\nConstruindo a matriz de Vandermonde passo a passo:\n');
    end
    for i = 1:n
        for j = 1:n
            V(i, j) = x(i)^(n-j); % Preenchendo a matriz manualmente
            if mostrar_detalhes
                fprintf('V(%d,%d) = %.4f\n', i, j, V(i, j));
            end
        end
    end
    if mostrar_detalhes
        fprintf('\nMatriz de Vandermonde V completa:\n');
        disp(V);
    end

    % Resolver o sistema linear
    fprintf('Sistema linear (equações):\n');
    for i = 1:n
        fprintf('%.4f * a1 + %.4f * a2 + %.4f * a3 = %.4f\n', V(i, 1), V(i, 2), V(i, 3), fx(i));
    end

    coef = linsolve(V, fx'); % Resolução do sistema linear
    if mostrar_detalhes
        fprintf('\nSolução do sistema (coeficientes do polinômio):\n');
        for i = 1:n
            fprintf('coef_%d = %.4f\n', i, coef(i));
        end
    end
end

function valor = calcular_polinomio(coef, x, mostrar_detalhes)
    % Calcula o valor do polinômio em x usando os coeficientes fornecidos
    n = length(coef);
    valor = 0;
    if mostrar_detalhes
        fprintf('\nCálculo detalhado do polinômio em x = %.2f:\n', x);
    end
    for i = 1:n
        termo = coef(i) * x^(n-i);
        valor = valor + termo;
        if mostrar_detalhes
            fprintf('Termo: coeficiente %.4f * x^%d = %.4f\n', coef(i), n-i, termo);
        end
    end
    if mostrar_detalhes
        fprintf('Valor final do polinômio: %.4f\n', valor);
    end
end

function plot_vandermonde(x, fx, coef, plot_title, ponto, valor)
    % Definir intervalo de plotagem
    x_plot = linspace(min(x) - 0.1, max(x) + 0.1, 100);
    y_plot = arrayfun(@(xi) calcular_polinomio(coef, xi, false), x_plot);

    % Gerar o gráfico
    figure;
    plot(x_plot, y_plot, '-b', 'LineWidth', 1.5); hold on;
    plot(x, fx, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Pontos dados
    plot(ponto, valor, 'gx', 'MarkerSize', 10, 'LineWidth', 2); % Ponto calculado
    title(plot_title);
    xlabel('x');
    ylabel('f(x)');
    legend({'Polinômio Interpolador', 'Pontos Dados', 'Ponto Calculado'}, 'Location', 'northwest');
    grid on;
end

