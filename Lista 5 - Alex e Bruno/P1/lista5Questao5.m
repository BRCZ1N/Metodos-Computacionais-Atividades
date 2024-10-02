function lista5Questao5()
    % Definindo constantes
    g = 9.81;
    u = 1800;
    mi = 160000;
    q = 2600;
    v = 750;

    % Executar o método da Bissecção
    fprintf("Método da Bissecção:\n");
    [rootBisseccao, itBisseccao, valoresBisseccao] = metodoBisseccao(u, mi, q, g, v);

    % Executar o método de Newton-Raphson
    fprintf("\nMétodo de Newton-Raphson:\n");
    [rootNewtonRaphson, itNewtonRaphson, valoresNewtonRaphson] = metodoNewtonRaphson(u, mi, q, g, v);

    % Criar tabela comparativa
    criar_tabela(itBisseccao, rootBisseccao, itNewtonRaphson+1, rootNewtonRaphson);

    % Criar gráficos de convergência
    criar_graficos(itBisseccao, valoresBisseccao, itNewtonRaphson+1, valoresNewtonRaphson);
endfunction

function [r, it, valores] = metodoBisseccao(u, mi, q, g, v)
    f = @(t) u * log(mi / (mi - q * t)) - g * t - v;

    a = 10;
    b = 50;

    % Define a tolerância para o erro absoluto
    Es = 1; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial
    r = inf; % Valor inicial de r como infinito
    valores = []; % Armazena os valores de r

    % Verifica se há mudança de sinal no intervalo [a, b]
    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        r = NaN; % Indica falha
        return;
    else
        it = 1; % Inicializa o contador de iterações
        n = 20; % Define o número máximo de iterações

        % Loop do método da Bissecção
        while (it <= n)
            rPrevio = r; % Armazena o valor anterior de r
            r = (a + b) / 2; % Calcula o ponto médio
            valores = [valores; r]; % Armazena o valor atual

            % Exibe os valores da iteração atual
            if it > 1
                Ea = calcularErroEstimativa(r, rPrevio); % Calcula o erro absoluto
            else
                Ea = Inf; % Na primeira iteração, o erro é infinito
            end

            fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Aproximado = %f\n', ...
                    it, a, b, r, f(r), Ea);

            % Verifica se o erro é menor ou igual à tolerância
            if (Ea <= Es)
                fprintf("Raiz encontrada: %f\n", r);
                return; % Sai do loop
            end

            it = it + 1; % Incrementa o contador de iterações

            % Atualiza o intervalo [a, b] com base no valor de f(r)
            if (f(a) * f(r) < 0)
                b = r; % Se houver mudança de sinal, atualiza o limite superior
            else
                a = r; % Caso contrário, atualiza o limite inferior
            end
        endwhile

        % Se o número máximo de iterações for atingido sem encontrar a raiz
        if it > n
            fprintf("Método falhou em %d iterações\n", it);
            r = NaN; % Indica falha
        end
    end
endfunction

function [r, it, valores] = metodoNewtonRaphson(u, mi, q, g, v)
    f = @(t) u * log(mi / (mi - q * t)) - g * t - v;
    df = @(t) (u * q / (mi - q * t)) - g; % Derivada da função

    x = 0; % Valor inicial para t
    it = 0; % Inicializa o contador de iterações
    N = 20; % Define o número máximo de iterações
    Ea = Inf; % Erro absoluto inicial
    valores = []; % Armazena os valores de r

    while (it < N)
        xProx = x - f(x) / df(x); % Cálculo do próximo valor
        valores = [valores; xProx]; % Armazena o novo valor de r

        fprintf('Iteração %d: xr = %f, f(x) = %f\n', it + 1, x, f(x));

        Ea = calcularErroEstimativa(xProx, x);

        if (Ea < 1) % Define a tolerância de 1%
            fprintf("Iterações %d: Raiz encontrada: %f\n", it + 1, xProx);
            r = xProx; % A raiz encontrada
            return; % Sai do loop
        end

        x = xProx; % Atualiza x para a próxima iteração
        it = it + 1; % Incrementa o contador de iterações
    endwhile

    % Se o número máximo de iterações for atingido sem encontrar a raiz
    fprintf("Método falhou em %d iterações\n", it+1);
    r = NaN; % Indica falha
endfunction

% Função para calcular o erro absoluto
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
    end
endfunction

function criar_tabela(itBisseccao, rootBisseccao, itNewtonRaphson, rootNewtonRaphson)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Bissecção", itBisseccao, rootBisseccao);
    fprintf("%-20s %-20d %-20f\n", "Newton-Raphson", itNewtonRaphson, rootNewtonRaphson);
endfunction

function criar_graficos(itBisseccao, valoresBisseccao, itNewtonRaphson, valoresNewtonRaphson)
    figure;

    % Gráfico para Bissecção
    subplot(2, 1, 1);
    plot(1:length(valoresBisseccao), valoresBisseccao, 'b-');
    title('Convergência do Método da Bissecção');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Gráfico para Newton-Raphson
    subplot(2, 1, 2);
    plot(1:length(valoresNewtonRaphson), valoresNewtonRaphson, 'r-');
    title('Convergência do Método de Newton-Raphson');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Salvar gráficos
    saveas(gcf, 'convergencia_metodos_bisseccao_newton_raphson.png');
endfunction

% Chama a função principal
lista5Questao5();

