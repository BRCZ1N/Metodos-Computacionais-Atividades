function lista5Questao5()
    % Definindo constantes
    g = 9.81;
    u = 1800;
    mi = 160000;
    q = 2600;
    v = 750;

    % Executar o método da Bissecção
    fprintf("Método da Bissecção:\n");
    [rootBisseccao, itBisseccao] = metodoBissecao(u, mi, q, g, v);

    % Executar o método da Secante
    fprintf("\nMétodo da Secante:\n");
    [rootSecante, itSecante] = metodoSecante(u, mi, q, g, v);

    % Criar tabela comparativa
    criar_tabela(itBisseccao, rootBisseccao, itSecante, rootSecante);
endfunction

function [r, it] = metodoBissecao(u, mi, q, g, v)
    f = @(t) u * log(mi / (mi - q * t)) - g * t - v;

    a = 10;
    b = 50;

    % Define a tolerância para o erro absoluto
    Es = 1; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial
    r = inf; % Valor inicial de r como infinito

    % Verifica se há mudança de sinal no intervalo [a, b]
    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        r = NaN; % Indica falha
        return;
    else
        it = 1; % Inicializa o contador de iterações
        n = 20; % Define o número máximo de iterações

        % Loop do método da bissecção
        while (it <= n)
            rPrevio = r; % Armazena o valor anterior de r
            r = (a + b) / 2; % Calcula o ponto médio do intervalo

            % Exibe os valores da iteração atual
            if it > 1
                Ea = calcularErroEstimativa(r, rPrevio); % Calcula o erro absoluto
            else
                Ea = Inf; % Na primeira iteração, o erro é infinito
            end

            fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Aproximado = %f\n', ...
                    it, a, b, r, f(r), Ea);

            % Verifica se o erro é menor ou igual à tolerância ou se atingiu o máximo de iterações
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

function [r, it] = metodoSecante(u, mi, q, g, v)
    f = @(t) u * log(mi / (mi - q * t)) - g * t - v;

    % Define a tolerância para o erro absoluto
    Es = 1; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial

    it = 0; % Inicializa o contador de iterações
    N = 20; % Define o número máximo de iterações
    x = 50;
    xPrevio = 10;
    xProx = 0;

    while (it < N)
        xProx = (xPrevio * f(x) - x * f(xPrevio)) / (f(x) - f(xPrevio));

        fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', ...
                it, x, f(x), Ea);

        Ea = calcularErroEstimativa(xProx, x);

        if (Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it + 1, x);
            r = x; % A raiz encontrada
            return;
        end

        xPrevio = x;
        x = xProx;
        it = it + 1; % Incrementa o contador de iterações
    endwhile

    % Se o número máximo de iterações for atingido sem encontrar a raiz
    fprintf("Método falhou em %d iterações\n", it);
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

function criar_tabela(itBissecao, rootBisseccao, itSecante, rootSecante)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Bissecção", itBissecao, rootBisseccao);
    fprintf("%-20s %-20d %-20f\n", "Secante", itSecante, rootSecante);
endfunction

% Chama a função principal
lista5Questao5();

