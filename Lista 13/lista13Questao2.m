% Dados da Tabela para Regressão Linear Múltipla
x1 = [0; 2; 2.5; 1; 4; 7];
x2 = [0; 1; 2; 3; 6; 2];
y = [5; 10; 9; 0; 3; 27];

% Função para Regressão Linear Múltipla
function [coeffs, R2] = regressao_linear_multipla(X, y)
    % Exibindo os dados de entrada
    disp('--- Etapa 1: Dados de entrada ---');
    disp('Matriz de Variáveis Independentes (X):');
    disp(X);
    disp('Vetor de Variáveis Dependentes (y):');
    disp(y);

    % Construção da Matriz de Somatórios (X'X) e do Vetor de Produtos (X'y)
    disp('--- Etapa 2: Construção das matrizes X''X e X''y ---');
    A = X' * X;
    b = X' * y;
    disp('Matriz X''X:');
    disp(A);
    disp('Vetor X''y:');
    disp(b);

    % Resolução do Sistema Linear por Eliminação de Gauss
    disp('--- Etapa 3: Resolução do sistema linear (Eliminação de Gauss) ---');
    n = size(X, 2); % Número de variáveis independentes (incluindo termo constante)
    coeffs = zeros(n, 1); % Inicialização do vetor de coeficientes

    % Passo 1: Transformar a matriz em forma triangular superior
    for k = 1:n
        disp(['Iteração ', num2str(k), ':']);
        disp('Matriz A antes da transformação:');
        disp(A);
        disp('Vetor b antes da transformação:');
        disp(b);

        for i = k+1:n
            factor = A(i, k) / A(k, k);
            disp(['Fator para a linha ', num2str(i), ': ', num2str(factor)]);
            A(i, :) = A(i, :) - factor * A(k, :);
            b(i) = b(i) - factor * b(k);
        end

        disp('Matriz A após a transformação:');
        disp(A);
        disp('Vetor b após a transformação:');
        disp(b);
    end

    % Passo 2: Resolução por substituição regressiva
    disp('--- Etapa 4: Resolução por substituição regressiva ---');
    coeffs(n) = b(n) / A(n, n);
    disp(['Coeficiente ', num2str(n), ': ', num2str(coeffs(n))]);
    for i = n-1:-1:1
        coeffs(i) = (b(i) - sum(A(i, i+1:end) .* coeffs(i+1:end)')) / A(i, i);
        disp(['Coeficiente ', num2str(i), ': ', num2str(coeffs(i))]);
    end

    disp('Coeficientes finais:');
    disp(coeffs);

    % Cálculo do Coeficiente de Determinação (R²)
    disp('--- Etapa 5: Cálculo do Coeficiente de Determinação (R²) ---');
    y_fit = X * coeffs; % Valores ajustados
    SS_res = sum((y - y_fit).^2); % Soma dos quadrados dos resíduos
    SS_tot = sum((y - mean(y)).^2); % Soma total dos quadrados
    R2 = 1 - (SS_res / SS_tot);
    disp('Valores ajustados (y_fit):');
    disp(y_fit);
    disp(['Soma dos Quadrados dos Resíduos (SS_res): ', num2str(SS_res)]);
    disp(['Soma Total dos Quadrados (SS_tot): ', num2str(SS_tot)]);
    disp(['Coeficiente de Determinação (R²): ', num2str(R2)]);
end

% Matriz de Variáveis Independentes com Termo Constante
disp('--- Preparando os dados para a regressão ---');
X = [ones(length(y), 1), x1, x2];

% Obtenção dos Coeficientes e R²
disp('--- Iniciando a Regressão Linear Múltipla ---');
[coeffs, R2] = regressao_linear_multipla(X, y);

disp('--- Resultados Finais ---');
disp('Coeficientes da Regressão Linear Múltipla:');
disp(coeffs);
disp(['Coeficiente de Determinação (R²): ', num2str(R2)]);

% Gráfico (apenas para visualização)
disp('--- Gerando gráfico de visualização ---');
[X1, X2] = meshgrid(linspace(min(x1), max(x1), 10), linspace(min(x2), max(x2), 10));
Y_fit = coeffs(1) + coeffs(2) * X1 + coeffs(3) * X2;

figure;
scatter3(x1, x2, y, 'bo', 'DisplayName', 'Pontos Originais');
hold on;
mesh(X1, X2, Y_fit, 'EdgeColor', 'r', 'DisplayName', 'Ajuste');
xlabel('x1');
ylabel('x2');
zlabel('y');
title('Regressão Linear Múltipla');
legend('show');
grid on;

