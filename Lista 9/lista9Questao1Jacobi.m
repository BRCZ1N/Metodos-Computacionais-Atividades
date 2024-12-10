function lista9Questao1Jacobi()
    % Definição dos parâmetros
    A = [5, 1, 1; 3, 4, 1; 3, 3, 6];
    b = [5; 6; 0];
    x0 = [0; 0; 0];
    tol = 0.05; % Tolerância em porcentagem
    max_iter = 100;

    % Teste de convergência: Critério de diagonal dominante
    if ~isDiagonalDominant(A)
        error('A matriz não satisfaz o critério de diagonal dominante. O método pode não convergir.');
    end

    % Execução do método de Jacobi
    [x, k, Erx] = jacobiMethod(A, b, x0, tol, max_iter);

    % Exibir os resultados finais
    disp('Solução final pelo método de Jacobi:');
    disp(x);
    fprintf('Convergiu em %d iterações com erro máximo relativo de %.2f%%\n', k, max(Erx));
end

function [x, k, Erx] = jacobiMethod(A, b, x0, tol, max_iter)
    % Método de Jacobi
    n = length(b); % Número de equações no sistema
    x = x0; % Inicialização do vetor solução
    k = 1; % Inicialização do contador de iterações
    Erx = inf * ones(n, 1); % Erro relativo inicial

    % Construção das matrizes C e d baseadas em A e b
    C = zeros(n, n); % Inicializando a matriz C (elementos fora da diagonal)
    d = zeros(n, 1); % Inicializando o vetor d (diagonais com b[i]/A[i,i])
    for i = 1:n
        for j = 1:n
            if i == j
                C(i,j) = 0;
                d(i,1) = b(i,1) / A(i, i);
            else
                C(i, j) = -A(i, j) / A(i, i);
            end
        end
    end

    % Criar uma tabela para armazenar os resultados de cada iteração
    iteration_results = zeros(max_iter, n+2); % Tabela com as iterações

    % Iteração do método de Jacobi
    while k <= max_iter
        x_new = C * x + d; % Atualiza a solução

        % Calcula o erro relativo para cada componente
        for i = 1:n
            if abs(x_new(i)) > eps  % Verifica se o valor não é muito pequeno
                Erx(i) = abs((x_new(i) - x(i)) / x_new(i)) * 100; % Erro relativo
            else
                Erx(i) = 0; % Evitar divisão por zero, atribuindo erro zero
            end
        end

        % Armazena os resultados da iteração
        iteration_results(k, :) = [k, x_new', max(Erx)];

        % Atualiza a solução para a próxima iteração
        x = x_new;

        % Se o erro máximo for menor que a tolerância, para a iteração
        if max(Erx) < tol
            fprintf('Critério de convergência atingido após %d iterações\n', k);
            break; % Convergiu, sai do loop
        end

        % Incrementa o contador de iterações
        k = k + 1;
    end

    % Verificar se o método não convergiu após o número máximo de iterações
    if k > max_iter
        error('O método não convergiu em %d iterações', max_iter);
    end

    % Exibir os resultados das iterações em formato de tabela
    disp('   Iteração |    x1    |   x2    |   x3    | Erro Relativo (%)');
    disp(iteration_results(1:k, :));
end

function is_dd = isDiagonalDominant(A)
    % Verificar se a matriz A satisfaz o critério de diagonal dominante
    [n, m] = size(A); % Obtém as dimensões da matriz
    if n ~= m
        error('A matriz deve ser quadrada.');
    end

    is_dd = true; % Inicialmente assume que a matriz é diagonal dominante
    for i = 1:n
        % Elemento da diagonal principal
        diag_element = abs(A(i, i));
        % Soma dos elementos fora da diagonal
        off_diag_sum = sum(abs(A(i, :))) - diag_element;

        % Verifica se a soma dos elementos fora da diagonal é menor que o elemento diagonal
        if diag_element < off_diag_sum
            is_dd = false; % A matriz não é diagonal dominante
            break; % Sai do loop se não for diagonal dominante
        end
    end
end

% Executar o código principal
lista9Questao1Jacobi();

