function lista9Questao1Jacobi()

 % Definição dos parâmetros
A = [5, 1, 1; 3, 4, 1; 3, 3, 6];
b = [5; 6; 0];
x0 = [0; 0; 0];
tol = 0.05;
max_iter = 100;

% Execução do método
x_jacobi = jacobi_method(A, b, x0, tol, max_iter);
disp('Solução pelo método de Jacobi:');
disp(x_jacobi);

endfunction

function x = jacobi_method(A, b, x0, tol, max_iter)
    n = length(b);
    x = x0;
    C = zeros(n, n);
    d = zeros(n, 1);

    % Construção da matriz C e vetor d
    for i = 1:n
        for j = 1:n
            if i == j
                C(i, j) = 0;
                d(i) = b(i) / A(i, i);
            else
                C(i, j) = -A(i, j) / A(i, i);
            end
        end
    end

    % Iteração do método de Jacobi
    for k = 1:max_iter
        x_new = C * x + d;
        % Cálculo do erro relativo
        err = max(abs((x_new - x) ./ x_new)) * 100;
        if err < tol
            fprintf('Convergiu em %d iterações\n', k);
            x = x_new;
            return;
        end
        x = x_new;
    end
    error('Não convergiu em %d iterações', max_iter);
end

lista9Questao1Jacobi();

