function lista5Questao6()
    % Definindo constantes
    Q = 20;
    g = 9.81;

    % Executar o método da Falsa Posição
    fprintf("Método da Falsa Posição:\n");
    [rootFalsaPosicao, itFalsaPosicao] = metodoFalsaPosicao(Q, g);

    % Executar o método da Secante
    fprintf("\nMétodo da Secante:\n");
    [rootSecante, itSecante] = metodoSecante(Q, g);

    % Criar tabela comparativa
    criar_tabela(itFalsaPosicao, rootFalsaPosicao, itSecante, rootSecante);
endfunction

function [r, it] = metodoFalsaPosicao(Q, g)
    f = @(y) 1 - ((Q^2 * (3 + y)) / (g * (3 * y + (y^2 / 2))^3));

    a = 1;
    b = 2;
    E = 1; % Tolerância
    Ea = inf; % Erro absoluto inicial
    rPrevio = inf; % Valor anterior da raiz

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        r = NaN; % Indica falha
        return;
    else
        it = 1; % Inicializa o contador de iterações
        r = b - (f(b) * (a - b)) / (f(a) - f(b)); % Cálculo inicial da raiz
        fa = f(a);
        fb = f(b);

        while (it <= 20)
            fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Erro aproximado = %f\n', ...
                    it, a, b, r, f(r), Ea);

            if (it >= 20 || Ea <= E)
                fprintf("Raiz encontrada: %f\n", r);
                return; % Sai do loop
            end

            if (f(a) * f(r) < 0)
                b = r; % Atualiza b
                fb = f(r);
            else
                a = r; % Atualiza a
                fa = f(r);
            end

            rPrevio = r; % Armazena o valor anterior de r
            r = b - (fb * (a - b)) / (fa - fb); % Calcula nova raiz
            Ea = calcularErroEstimativa(r, rPrevio); % Atualiza erro
            it = it + 1; % Incrementa contador de iterações
        endwhile

        if it > 20
            fprintf("Método falhou em %d iterações\n", it);
            r = NaN; % Indica falha
        end
    end
endfunction

function [r, it] = metodoSecante(Q, g)
    f = @(y) 1 - ((Q^2 * (3 + y)) / (g * (3 * y + (y^2 / 2))^3));

    % Define a tolerância para o erro absoluto e o erro inicial
    Es = 1; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial

    it = 0; % Inicializa o contador de iterações
    N = 20; % Define o número máximo de iterações
    x = 2; % Estimativa inicial
    xPrevio = 1; % Segunda estimativa inicial

    while (it < N)
        xProx = (xPrevio * f(x) - x * f(xPrevio)) / (f(x) - f(xPrevio)); % Cálculo do próximo valor

        fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', ...
                it + 1, x, f(x), Ea);

        Ea = calcularErroEstimativa(xProx, x); % Atualiza o erro

        if (Ea < Es)
            fprintf("Raiz encontrada: %f\n", xProx);
            r = xProx; % A raiz encontrada
            return; % Sai do loop
        end

        xPrevio = x; % Atualiza o valor anterior
        x = xProx; % Atualiza o valor atual
        it = it + 1; % Incrementa contador de iterações
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

function criar_tabela(itFalsaPosicao, rootFalsaPosicao, itSecante, rootSecante)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Falsa Posição", itFalsaPosicao, rootFalsaPosicao);
    fprintf("%-20s %-20d %-20f\n", "Secante", itSecante, rootSecante);
endfunction

% Chama a função principal
lista5Questao6();

