
function lista9Questao3SOR()

A = [-3, 12; 10, -2];
b = [9; 8];
x0 = [0; 0];
tol = 10;
max_iter = 100;

% Teste para valores de ω entre 1 e 1.9
for omega = 1:0.1:1.9
    try
        x_sor = sor_method(A, b, x0, tol, max_iter, omega);
        fprintf('Solução com ω = %.2f:\n', omega);
        disp(x_sor);
    catch
        fprintf('Falha na convergência para ω = %.2f\n', omega);
    end
end


endfunction

function x = sor_method(A, b, x0, tol, max_iter, omega)
    n = length(b);
    x = x0;

    for k = 1:max_iter
        x_old = x;

        for i = 1:n
            sum1 = A(i, 1:i-1) * x(1:i-1);
            sum2 = A(i, i+1:n) * x_old(i+1:n);
            x(i) = (1 - omega) * x_old(i) + (omega * (b(i) - sum1 - sum2) / A(i, i));
        end

        % Cálculo do erro relativo
        err = max(abs((x - x_old) ./ x)) * 100;
        if err < tol
            fprintf('Convergiu em %d iterações com ω = %.2f\n', k, omega);
            return;
        end
    end
    error('Não convergiu em %d iterações com ω = %.2f', max_iter, omega);
end

lista9Questao3SOR();

