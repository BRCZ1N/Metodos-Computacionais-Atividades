function lista5Questao3()
    % Definindo constantes
    e = 8.9e-12;
    F = 1.25;
    q = 2e-5;
    Q = 2e-5;
    raio = 0.85;

    % Definindo a função
    f = @(x) (1/(4*pi*e)) * (q * Q * x / (x^2 + raio^2)^(3/2)) - F;

    % Define a tolerância para o erro absoluto
    Es = 5^(-4); % Tolerância em porcentagem

    % Executar o método da Secante
    fprintf("Método da Secante:\n");
    [rootSecante, itSecante] = metodoSecante(f, Es);

    % Executar o método de Newton-Raphson
    fprintf("\nMétodo de Newton-Raphson:\n");
    [rootNewton, itNewton] = metodoNewtonRaphson(f, e, q, Q, raio, Es);

    % Criar tabela comparativa
    criar_tabela(itSecante, rootSecante, itNewton, rootNewton);

    % Criar gráficos de convergência
    criar_graficos(itSecante, itNewton, rootSecante, rootNewton);
endfunction

function [r, it] = metodoSecante(f, Es)
    Ea = Inf; % Erro absoluto inicial
    xPrevio = 0.5; % Valor inicial
    x = 0.6; % Valor inicial
    it = 0; % Contador de iterações
    N = 20; % Número máximo de iterações

    for it = 0:(N-1)
        xProx = (xPrevio * f(x) - x * f(xPrevio)) / (f(x) - f(xPrevio)); % Cálculo do próximo x

        Ea = calcularErroEstimativa(xProx, x);
        fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', it, x, f(x), Ea);

        if(Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it + 1, xProx);
            r = xProx;
            return;
        end

        xPrevio = x;
        x = xProx;
    endfor

    fprintf("Método falhou em %d iterações\n", it);
    r = NaN; % Indica falha
endfunction

function [r, it] = metodoNewtonRaphson(f, e, q, Q, raio, Es)
    df = @(x) (1 / (4 * pi * e)) * ...
        ((q * Q * (x^2 + raio^2)^(3/2)) - ...
         (3 * q * Q * x^2 * (x^2 + raio^2)^(1/2))) / ...
        (x^2 + raio^2)^3;

    Ea = Inf; % Erro absoluto inicial
    x = 0.5; % Valor inicial
    it = 0; % Contador de iterações
    N = 20; % Número máximo de iterações

    for it = 0:(N-1)
        xProx = x - f(x) / df(x); % Cálculo do próximo x
        Ea = calcularErroEstimativa(xProx, x);

        fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', it, x, f(x), Ea);

        if(Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it + 1, xProx);
            r = xProx;
            return;
        end

        x = xProx;
    endfor

    fprintf("Método falhou em %d iterações\n", it);
    r = NaN; % Indica falha
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
    end
endfunction

function criar_tabela(itSecante, rootSecante, itNewton, rootNewton)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Secante", itSecante, rootSecante);
    fprintf("%-20s %-20d %-20f\n", "Newton-Raphson", itNewton, rootNewton);
endfunction

function criar_graficos(itSecante, itNewton, rootSecante, rootNewton)
    % Exemplo de como você poderia criar gráficos de convergência
    figure;

    % Gráfico para Secante
    subplot(2, 1, 1);
    plot(1:itSecante, linspace(rootSecante, rootSecante, itSecante), 'b-', 'LineWidth', 2);
    title('Convergência do Método da Secante');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Gráfico para Newton-Raphson
    subplot(2, 1, 2);
    plot(1:itNewton, linspace(rootNewton, rootNewton, itNewton), 'r-', 'LineWidth', 2);
    title('Convergência do Método de Newton-Raphson');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Salvar gráficos se necessário
    saveas(gcf, 'convergencia_métodos_secante_newton.png');
endfunction

% Chama a função principal
lista5Questao3();

