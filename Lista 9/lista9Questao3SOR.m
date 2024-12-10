function lista9Questao2SOR()
    % Definindo a matriz A e o vetor b
    A = [10, -2;
         -3, 12];
    b = [8; 9];
    x0 = [0; 0];
    tol = 10; % Tolerância (erro relativo percentual)
    max_iter = 100; % Número máximo de iterações
    omega = 1.25;   % Fator de relaxamento (ω = 1.25)

    % Verificando e exibindo o Critério de Sassenfeld
    fprintf('\n--- Verificação do Critério de Sassenfeld ---\n');
    satisfaz = verificar_criterio_sassenfeld(A);

    if satisfaz
        disp('Critério de Sassenfeld satisfeito. O método provavelmente converge.');
    else
        disp('Critério de Sassenfeld NÃO satisfeito. O método pode não convergir.');
    end

    % Chamando o método SOR
    [x_sor, iteracoes, tabela] = sor_method(A, b, x0, tol, max_iter, omega);

    % Mostrando os resultados
    fprintf('\nSolução pelo método de SOR:\n');
    disp(x_sor);

    fprintf('\nTabela de Iterações:\n');
    fprintf('ITERAÇÃO\t x1\t\t x2\t\t ERRO REL. (%%)\n');
    for k = 1:iteracoes
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\n', ...
            tabela(k).iteracao, tabela(k).x(1), tabela(k).x(2), tabela(k).erro);
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

function [x, iteracoes, tabela] = sor_method(A, b, x0, tol, max_iter, omega)
    n = length(b);
    x = x0;
    tabela = []; % Para armazenar as iterações
    iteracoes = 0;

    for k = 1:max_iter
        iteracoes = iteracoes + 1;
        x_old = x;

        % Atualização do vetor solução com o fator de relaxamento ω (SOR)
        for i = 1:n
            sum1 = A(i, 1:i-1) * x(1:i-1);
            sum2 = A(i, i+1:n) * x_old(i+1:n);
            x(i) = (1 - omega) * x_old(i) + omega * (b(i) - sum1 - sum2) / A(i, i);
        end

        % Cálculo do erro relativo em relação a toda a solução
        erro_relativo = max(abs((x - x_old) ./ (x + eps))) * 100;  % "eps" para evitar divisão por zero

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

