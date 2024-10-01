function lista5Questao1IteracaoLinear()

    P = 35000;
    A = 8500;
    n = 7;

    % Definindo a função
    f = @(i) (P * ((i * (1 + i).^n) / ((1 + i).^n - 1)) - A);

    % Definindo a função de iteração
    g = @(i) i - f(i) / (P * (1 + i)^n / (((1 + i)^n - 1)^2)); % Estimativa de derivada

    Es = 5e-5; % Tolerância
    Ea = Inf;  % Erro absoluto inicial
    it = 0;    % Contador de iterações
    n = 20;    % Número máximo de iterações
    xr = 0.1;  % Aproximação inicial

    while (it < n)
        xrPrevio = xr; % Armazena o valor anterior de xr
        xr = g(xrPrevio); % Cálculo da nova aproximação
        it = it + 1; % Incrementa o contador de iterações

        % Cálculo do erro
        if (xrPrevio != 0)
            Ea = calcularErroEstimativa(xr, xrPrevio);
        end

        fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
                it, xr, f(xr), Ea);

        % Verificação da convergência
        if (Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it, xr);
            return; % Encerra a função se a raiz for encontrada
        end
    endwhile

    fprintf("Método falhou em %d iterações\n", it);
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf || resultadoAtual == 0
        Ea = Inf; % Se o valor anterior for zero
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Erro percentual
    end
endfunction

% Chama a função principal
lista5Questao1IteracaoLinear();

