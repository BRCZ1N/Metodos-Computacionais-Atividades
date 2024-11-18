function lista11Questao2InterpolacaoLagrange()
    % Definição dos pontos
    x = [0, 0.5, 1.0];
    fx = [1.3, 2.5, 0.9];

    % Avaliação em x = 0.8
    x_val = 0.8;

    fprintf('Cálculo do polinômio interpolador de Lagrange\n\n');

    % Exibição inicial
    fprintf('Passo 1: Definição dos pontos\n');
    fprintf('i    x_i      f(x_i)\n');
    for i = 1:length(x)
        fprintf('%d    %.2f     %.2f\n', i - 1, x(i), fx(i));
    end

    % Calcula o polinômio interpolador P2(x)
    [P2, poly_expression, Ls] = lagrange_interpolador(x, fx, x_val);

    % Exibe os polinômios de base L_i(x)
    fprintf('\nPasso 2: Polinômios de base L_i(x)\n');
    for i = 1:length(Ls)
        fprintf('L_%d(x) = %s\n', i - 1, Ls{i});
    end

    % Exibe o polinômio P2(x)
    fprintf('\nPasso 3: Polinômio interpolador P2(x)\n');
    fprintf('P2(x) = %s\n\n', poly_expression);

    % Exibe o valor aproximado para f(0.8)
    fprintf('Passo 4: Avaliação de P2(0.8)\n');
    fprintf('Valor de P2(%.2f) = %.4f\n\n', x_val, P2);

    % Plotar o gráfico dos polinômios
    plot_lagrange_interpolador(x, fx, x_val, P2, Ls);
end

function [P, poly_expression, Ls] = lagrange_interpolador(x, fx, x_val)
    % Calcula o polinômio interpolador de Lagrange para um valor específico x_val
    n = length(x);
    P = 0;
    poly_expression = ''; % Variável para armazenar a expressão do polinômio
    Ls = {}; % Lista para armazenar as expressões dos polinômios L_i(x)

    for i = 1:n
        % Inicializa o polinômio base L_i(x)
        L_val = 1; % Valor do polinômio base L_i(x)
        denom = 1; % Denominador acumulado
        L_formula = ''; % Fórmula do polinômio

        for j = 1:n
            if j ~= i
                % Atualiza o denominador
                denom = denom * (x(i) - x(j));

                % Calcula o produto (x - x_j)
                L_val = L_val * (x_val - x(j));

                % Atualiza a fórmula para exibição
                if isempty(L_formula)
                    L_formula = sprintf('(x - %.2f)', x(j));
                else
                    L_formula = strcat(L_formula, ' * ', sprintf('(x - %.2f)', x(j)));
                end
            end
        end

        % Divide o valor do polinômio pelo denominador
        L_val = L_val / denom;

        % Adiciona a expressão do polinômio L_i(x) à lista
        Ls{i} = sprintf('%.2f * (%s) / %.2f', fx(i), L_formula, denom);

        % Multiplica pelo valor de f(x_i) e adiciona à soma final
        contrib = fx(i) * L_val;
        P = P + contrib;

        % Para a expressão simbólica do polinômio
        if i == 1
            poly_expression = sprintf('%.2f * (%s) / %.2f', fx(i), L_formula, denom);
        else
            poly_expression = strcat(poly_expression, ' + ', sprintf('%.2f * (%s) / %.2f', fx(i), L_formula, denom));
        end
    end
end

function plot_lagrange_interpolador(x, fx, x_val, P2, Ls)
    % Plota os polinômios de base L_i(x) e o polinômio interpolador
    x_plot = linspace(min(x), max(x), 100);
    y_plot = zeros(size(x_plot));
    colors = ['r', 'g', 'b']; % Cores para os polinômios de base

    % Calcula e plota os polinômios de base L_i(x)
    figure;
    hold on;
    for i = 1:length(x)
        L_val_plot = 1;
        for j = 1:length(x)
            if j ~= i
                L_val_plot = L_val_plot .* (x_plot - x(j)) / (x(i) - x(j));
            end
        end
        plot(x_plot, L_val_plot, 'LineWidth', 1.5, 'DisplayName', sprintf('L_%d(x)', i - 1), 'Color', colors(i));
    end

    % Calcula o polinômio interpolador para cada ponto em x_plot
    for k = 1:length(x_plot)
        y_plot(k) = lagrange_interpolador(x, fx, x_plot(k)); % Não mostrar passos
    end

    % Adiciona o polinômio interpolador ao gráfico
    plot(x_plot, y_plot, 'k-', 'LineWidth', 2, 'DisplayName', 'P_2(x)');
    plot(x, fx, 'bo', 'MarkerSize', 8, 'DisplayName', 'Pontos Dados');

    % Adiciona o ponto de avaliação (x_val, P2)
    plot(x_val, P2, 'ms', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', sprintf('Avaliação f(%.2f)', x_val));

    xlabel('x');
    ylabel('f(x)');
    title('Interpolação de Lagrange - Polinômios de Base e Interpolador');
    legend('show');
    grid on;
    hold off;
end

