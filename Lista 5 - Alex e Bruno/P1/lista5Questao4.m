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
    [rootFalsaPosicao, itFalsaPosicao, valoresFalsaPosicao] = metodoFalsaPosicao(f, Es);

    % Executar o método de Iteração Linear
    fprintf("\nMétodo de Iteração Linear:\n");
    [rootIteracaoLinear, itIteracaoLinear, valoresIteracaoLinear] = metodoIteracaoLinear(f, Vs, r, Es);

    % Criar tabela comparativa
    criar_tabela(itFalsaPosicao, rootFalsaPosicao, itIteracaoLinear, rootIteracaoLinear);

    % Criar gráficos de convergência
    criar_graficos(itFalsaPosicao, itIteracaoLinear, valoresFalsaPosicao, valoresIteracaoLinear);
endfunction

function [r, it, valores] = metodoFalsaPosicao(f, E)
    a = 0;
    b = 1;
    Ea = inf;
    rPrevio = inf;
    it = 1;
    n = 20;

    % Inicializando o vetor para armazenar os valores
    valores = [];

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

            % Armazenar o valor da raiz atual
            valores = [valores; r];

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
            Ea = calcularErroEstimativa(r, rPrevio);
        endwhile

        if it > n
            fprintf("Método falhou em %d iterações\n", it);
        end
    end
endfunction

function [r, it, valores] = metodoIteracaoLinear(f, Vs, r, Es)
    g = @(h) sqrt(3 * Vs / (3 * r * pi - pi * h)); % Função de iteração
    Ea = Inf;
    it = 0;
    n = 20;
    xr = 0;

    % Inicializando o vetor para armazenar os valores
    valores = [];

    while (it < n)
        xrPrevio = xr;
        xr = g(xrPrevio);
        it = it + 1;

        % Armazenar o valor da raiz atual
        valores = [valores; xr];

        if (xr != 0 && xrPrevio != 0)
            Ea = calcularErroEstimativa(xr, xrPrevio);
        end

        fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
                it, xr, f(xr), Ea);

        if (Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it, xr);
            r = xr; % Certificando-se de que o resultado final seja o correto
            return;
        end
    endwhile

    fprintf("Método falhou em %d iterações\n", it);
    r = NaN; % Indica falha
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf || resultadoAtual == 0
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

function criar_graficos(itFalsaPosicao, itIteracaoLinear, valoresFalsaPosicao, valoresIteracaoLinear)
    % Exemplo de como você poderia criar gráficos de convergência
    figure;

    % Gráfico para Falsa Posição
    subplot(2, 1, 1);
    plot(1:itFalsaPosicao, valoresFalsaPosicao, 'b-');
    title('Convergência do Método da Falsa Posição');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Gráfico para Iteração Linear
    subplot(2, 1, 2);
    plot(1:itIteracaoLinear, valoresIteracaoLinear, 'r-');
    title('Convergência do Método de Iteração Linear');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Salvar gráficos se necessário
    saveas(gcf, 'convergencia_metodos_falsa_posicao_iteracao_linear.png');
endfunction

% Chama a função principal
lista5Questao4();

