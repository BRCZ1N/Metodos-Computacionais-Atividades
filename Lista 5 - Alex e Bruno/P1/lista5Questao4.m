function lista5Questao4()
    % Definindo constantes
    r = 1;
    Vs = 0.837758;

    % Definindo a função
    f = @(h) ((pi * h.^2) / 3) * (3 * r - h) - Vs;

    % Define a tolerância para o erro absoluto
    Es = 5e-5; % Tolerância em porcentagem

    % Executar o método da Falsa Posição
    fprintf("Método da Falsa Posição:\n");
    [rootFalsaPosicao, itFalsaPosicao] = metodoFalsaPosicao(f, Es);

    % Executar o método de Iteração Linear
    fprintf("\nMétodo de Iteração Linear:\n");
    [rootIteracaoLinear, itIteracaoLinear] = metodoIteracaoLinear(f, Vs, r, Es);

    % Criar tabela comparativa
    criar_tabela(itFalsaPosicao, rootFalsaPosicao, itIteracaoLinear, rootIteracaoLinear);
endfunction

function [r, it] = metodoFalsaPosicao(f, E)
    a = 0;
    b = 1;
    Ea = inf;
    rPrevio = inf;
    it = 1;
    n = 20;

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        r = NaN; % Indica falha
        return;
    else
        r = b - (f(b) * (a - b)) / (f(a) - f(b));  % Cálculo inicial da raiz
        fa = f(a);
        fb = f(b);

        while (it <= n)
            fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Erro aproximado = %f\n', ...
                    it, a, b, r, f(r), Ea);
            if (it >= n || Ea <= E)
                fprintf("Raiz encontrada: %f\n", r);
                return;
            end

            if (f(a) * f(r) < 0)
                b = r;
                fb = f(r);
            else
                a = r;
                fa = f(r);
            end

            it = it + 1;

            rPrevio = r;
            r = b - (fb * (a - b)) / (fa - fb);
            Ea = calcularErroEstimativa(it, r, rPrevio);
        endwhile

        if it > n
            fprintf("Método falhou em %d iterações\n", it);
        end
    end
endfunction

function [r, it] = metodoIteracaoLinear(f, Vs, r, Es)
    g = @(h) sqrt(3 * Vs / (3 * r * pi - pi * h)); % Função de iteração
    Ea = Inf;
    it = 0;
    n = 20;
    xr = 0;

    while (it < n)
        xrPrevio = xr;
        xr = g(xrPrevio);
        it = it + 1;

        if (xr != 0 && xrPrevio != 0)
            Ea = calcularErroEstimativa(it, xr, xrPrevio);
        end

        fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
                it, xr, f(xr), Ea);

        if (Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it, xr);
            return;
        end
    endwhile

    fprintf("Método falhou em %d iterações\n", it);
    r = NaN; % Indica falha
endfunction

function Ea = calcularErroEstimativa(it, resultadoAtual, resultadoPrev)
    if it == 1 || resultadoPrev == Inf || resultadoAtual == 0
        Ea = Inf;
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100;
    end
endfunction

function criar_tabela(itFalsaPosicao, rootFalsaPosicao, itIteracaoLinear, rootIteracaoLinear)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Falsa Posição", itFalsaPosicao, rootFalsaPosicao);
    fprintf("%-20s %-20d %-20f\n", "Iteração Linear", itIteracaoLinear, rootIteracaoLinear);
endfunction

% Chama a função principal
lista5Questao4();

