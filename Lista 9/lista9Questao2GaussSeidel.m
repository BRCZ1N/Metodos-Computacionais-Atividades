function lista9Questao2GaussSeidel()

A = [1, 0.5, -0.1; 0.2, 1, -0.2; -0.1, -0.2, 1];
b = [0.2; -2; 1];
x0 = [0; 0; 0];
tol = 0.05;
max_iter = 100;

x_gauss_seidel = gauss_seidel(A, b, x0, tol, max_iter);
disp('Solução pelo método de Gauss-Seidel:');
disp(x_gauss_seidel);

endfunction

function x = gauss_seidel(A, b, x0, tol, max_iter)
    n = length(b);
    x = x0;

    for k = 1:max_iter
        x_old = x;

        for i = 1:n
            sum1 = A(i, 1:i-1) * x(1:i-1);
            sum2 = A(i, i+1:n) * x_old(i+1:n);
            x(i) = (b(i) - sum1 - sum2) / A(i, i);
        end

        % Cálculo do erro relativo
        err = max(abs((x - x_old) ./ x)) * 100;
        if err < tol
            fprintf('Convergiu em %d iterações\n', k);
            return;
        end
    end
    error('Não convergiu em %d iterações', max_iter);
end

lista9Questao2GaussSeidel();

