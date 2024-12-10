function lista9Questao2GaussSeidel()
    % Definindo a matriz A e o vetor b
    A = [1, 0.5, -0.1;
         0.2, 1, -0.2;
        -0.1, -0.2, 1];
    b = [0.2; -2; 1];
    x0 = [0; 0; 0];
    tol = 0.05; % Tolerância (erro relativo percentual)
    max_iter = 100; % Número máximo de iterações

    % Verificando e exibindo o Critério de Sassenfeld
    fprintf('\n--- Verificação do Critério de Sassenfeld ---\n');
    satisfaz = verificar_criterio_sassenfeld(A);

    if satisfaz
        disp('Critério de Sassenfeld satisfeito. O método provavelmente converge.');
    else
        disp('Critério de Sassenfeld NÃO satisfeito. O método pode não convergir.');
    end

    % Chamando o método de Gauss-Seidel
    [x_gauss_seidel, iteracoes, tabela] = gauss_seidel(A, b, x0, tol, max_iter);

    % Mostrando os resultados
    fprintf('\nSolução pelo método de Gauss-Seidel:\n');
    disp(x_gauss_seidel);

    fprintf('\nTabela de Iterações:\n');
    fprintf('ITERAÇÃO\t x1\t\t x2\t\t x3\t\t ERRO REL. (%%)\n');
    for k = 1:iteracoes
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            tabela(k).iteracao, tabela(k).x(1), tabela(k).x(2), tabela(k).x(3), tabela(k).erro);
    end
end

function satisfaz = verificar_criterio_sassenfeld(A)
    n = size(A, 1);
    beta = zeros(n, 1);

    for i = 1:n
        soma_antes = sum(abs(A(i, 1:i-1)) .* beta(1:i-1)');
        soma_depois = sum(abs(A(i, i+1:end)));
        beta(i) = (soma_antes + soma_depois) / abs(A(i, i));
        fprintf('β%d = %.6f\n', i, beta(i));
    end

    satisfaz = all(beta < 1); % Critério satisfeito se todos os β_i < 1
end

function [x, iteracoes, tabela] = gauss_seidel(A, b, x0, tol, max_iter)
    n = length(b);
    x = x0;
    tabela = []; % Para armazenar as iterações
    iteracoes = 0;

    for k = 1:max_iter
        iteracoes = iteracoes + 1;
        x_old = x;

        % Atualização do vetor solução
        for i = 1:n
            sum1 = A(i, 1:i-1) * x(1:i-1);
            sum2 = A(i, i+1:n) * x_old(i+1:n);
            x(i) = (b(i) - sum1 - sum2) / A(i, i);
        end

        % Cálculo do erro relativo
        erro_relativo = max(abs((x - x_old) ./ x)) * 100;

        % Salvando informações da iteração atual
        tabela = [tabela; struct('iteracao', k, 'x', x', 'erro', erro_relativo)];

        % Verificando tolerância
        if erro_relativo < tol
            fprintf('\nConvergiu em %d iterações.\n', k);
            return;
        end
    end
    error('Não convergiu em %d iterações.\n', max_iter);
end

