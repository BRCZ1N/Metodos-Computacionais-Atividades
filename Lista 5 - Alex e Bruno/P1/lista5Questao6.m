function lista5Questao6()
    % Definindo constantes
    Q = 20;
    g = 9.81;

    % Executar o método da Falsa Posição
    fprintf("Método da Falsa Posição:\n");
    [rootFalsaPosicao, itFalsaPosicao, valoresFalsaPosicao] = metodoFalsaPosicao(Q, g);

    % Executar o método da Secante
    fprintf("\nMétodo da Secante:\n");
    [rootSecante, itSecante, valoresSecante] = metodoSecante(Q, g);

    % Criar tabela comparativa
    criar_tabela(itFalsaPosicao, rootFalsaPosicao, itSecante, rootSecante);

    % Criar gráficos de convergência
    criar_graficos(itFalsaPosicao, valoresFalsaPosicao, itSecante, valoresSecante);
endfunction

function [r, it, valores] = metodoFalsaPosicao(Q, g)
    f = @(y) 1 - ((Q^2 * (3 + y)) / (g * (3 * y + (y^2 / 2))^3));

    a = 1;
    b = 2;

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

        % Loop do método da Falsa Posição
        while (it <= n)
            rPrevio = r; % Armazena o valor anterior de r
            r = b - (f(b) * (a - b)) / (f(a) - f(b)); % Calcula nova raiz
            valores = [valores; r]; % Armazena o valor atual

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

function [r, it, valores] = metodoSecante(Q, g)
    f = @(y) 1 - ((Q^2 * (3 + y)) / (g * (3 * y + (y^2 / 2))^3));

    % Define a tolerância para o erro absoluto
    Es = 1; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial
    valores = []; % Armazena os valores de r

    it = 0; % Inicializa o contador de iterações
    N = 20; % Define o número máximo de iterações
    x = 2; % Estimativa inicial
    xPrevio = 1; % Segunda estimativa inicial

    while (it < N)
        xProx = (xPrevio * f(x) - x * f(xPrevio)) / (f(x) - f(xPrevio)); % Cálculo do próximo valor
        valores = [valores; xProx]; % Armazena o novo valor de r

        fprintf('Iteração %d: xr = %f, f(x) = %f\n', ...
                it + 1, x, f(x));

        Ea = calcularErroEstimativa(xProx, x);

        if (Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it + 1, xProx);
            r = xProx; % A raiz encontrada
            return; % Sai do loop
        end

        xPrevio = x; % Atualiza o valor anterior
        x = xProx; % Atualiza o valor atual
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

function criar_tabela(itFalsaPosicao, rootFalsaPosicao, itSecante, rootSecante)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Falsa Posição", itFalsaPosicao, rootFalsaPosicao);
    fprintf("%-20s %-20d %-20f\n", "Secante", itSecante, rootSecante);
endfunction

function criar_graficos(itFalsaPosicao, valoresFalsaPosicao, itSecante, valoresSecante)
    figure;

    % Gráfico para Falsa Posição
    subplot(2, 1, 1);
    plot(1:length(valoresFalsaPosicao), valoresFalsaPosicao, 'b-');
    title('Convergência do Método da Falsa Posição');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Gráfico para Secante
    subplot(2, 1, 2);
    plot(1:length(valoresSecante), valoresSecante, 'r-');
    title('Convergência do Método da Secante');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Salvar gráficos
    saveas(gcf, 'convergencia_metodos_falsa_posicao_secante.png');
endfunction

% Chama a função principal
lista5Questao6();

