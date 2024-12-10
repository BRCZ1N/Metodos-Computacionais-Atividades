% Dados da Tabela para Regressão Polinomial
x = [0; 1; 2; 3; 4; 5];
y = [0; 20; 60; 68; 77; 100];

% Função para Regressão Polinomial
function [coeffs, R2] = regressao_polinomial(x, y, grau)
    n = length(x);

    % Matriz de Vandermonde
    X = zeros(n, grau+1);
    for i = 1:n
        for j = 0:grau
            X(i, j+1) = x(i)^j;
        end
    end
    disp('Matriz de Vandermonde (X):');
    disp(X);

    % Construção da Matriz de Somatórios (X'X) e do Vetor de Produtos (X'y)
    A = X' * X;
    b = X' * y;
    disp('Matriz (X''X):');
    disp(A);
    disp('Vetor (X''y):');
    disp(b);

    % Resolução do Sistema Linear por Eliminação de Gauss
    coeffs = zeros(grau+1, 1);
    for k = 1:grau+1
        for i = k+1:grau+1
            factor = A(i, k) / A(k, k);
            A(i, :) -= factor * A(k, :);
            b(i) -= factor * b(k);
        end
    end
    coeffs(grau+1) = b(grau+1) / A(grau+1, grau+1);
    for i = grau:-1:1
        coeffs(i) = (b(i) - sum(A(i, i+1:end) .* coeffs(i+1:end)')) / A(i, i);
    end

    disp('Coeficientes obtidos:');
    disp(coeffs);

    % Cálculo do R²
    y_fit = X * coeffs;
    SS_res = sum((y - y_fit).^2); % Soma dos resíduos ao quadrado
    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    R2 = 1 - (SS_res / SS_tot);
    disp(['Coeficiente de Determinação (R²): ', num2str(R2)]);
end

% Teste para Graus de 1 a 5
graus = 1:5;
cores = ['r', 'g', 'b', 'm', 'c'];
figure;
hold on;
plot(x, y, 'ko', 'MarkerSize', 8, 'DisplayName', 'Pontos Originais');
for g = graus
    [coeffs, R2] = regressao_polinomial(x, y, g);
    disp(["Grau: ", num2str(g), " Coeficientes: ", num2str(coeffs')]);
    disp(["Coeficiente de Determinação (R²): ", num2str(R2)]);

    % Plot do Ajuste
    x_fit = linspace(min(x), max(x), 100);
    y_fit = zeros(size(x_fit));
    for i = 0:g
        y_fit += coeffs(i+1) * x_fit.^i;
    end
    plot(x_fit, y_fit, 'Color', cores(g), 'LineWidth', 2, 'DisplayName', ["Ajuste Grau ", num2str(g)]);
end
xlabel('x');
ylabel('y');
title('Regressão Polinomial para Graus 1 a 5');
legend('show');
grid on;

