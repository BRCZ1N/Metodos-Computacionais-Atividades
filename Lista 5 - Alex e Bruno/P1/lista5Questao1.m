function lista5Questao1()
    P = 35000;
    A = 8500;
    n = 7;

    f = @(i) (P * ((i * (1 + i).^n) / ((1 + i).^n - 1)) - A);

    % Definir limites e tolerância
    a = 0.01;
    b = 0.3;
    Es = 5e-5;

    % Executar o método da bissecção
    fprintf("Método da Bissecção:\n");
    [rootBisseccao, itBisseccao, valoresBisseccao] = metodoBisseccao(f, a, b, Es);

    % Executar o método da falsa posição
    fprintf("\nMétodo da Falsa Posição:\n");
    [rootFalsaPosicao, itFalsaPosicao, valoresFalsaPosicao] = metodoFalsaPosicao(f, a, b, Es);

    % Criar tabela comparativa
    criar_tabela(itBisseccao, rootBisseccao, itFalsaPosicao, rootFalsaPosicao);

    % Criar gráficos de convergência
    criar_graficos(itBisseccao, valoresBisseccao, itFalsaPosicao, valoresFalsaPosicao);
endfunction

function [r, it, valores] = metodoBisseccao(f, a, b, Es)
    Ea = Inf; % Erro absoluto inicial
    r = inf; % Valor inicial de r
    it = 0; % Contador de iterações
    n = 30; % Número máximo de iterações
    valores = []; % Armazena os valores de r

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        return;
    end

    while (it < n)
        rPrevio = r;
        r = (a + b) / 2; % Cálculo do ponto médio
        valores = [valores; r]; % Armazena o valor atual

        if it > 0
            Ea = calcularErroEstimativa(r, rPrevio);
        end

        fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Aproximado = %f\n', ...
                it + 1, a, b, r, f(r), Ea);

        if (Ea <= Es)
            fprintf("Raiz encontrada: %f\n", r);
            break;
        end

        it = it + 1;

        if (f(a) * f(r) < 0)
            b = r; % Atualiza o limite superior
        else
            a = r; % Atualiza o limite inferior
        end
    endwhile

    if it >= n
        fprintf("Método falhou em %d iterações\n", it);
    end
endfunction

function [r, it, valores] = metodoFalsaPosicao(f, a, b, Es)
    Ea = Inf; % Erro absoluto inicial
    rPrevio = inf; % Valor inicial de r
    it = 0; % Contador de iterações
    n = 20; % Número máximo de iterações
    valores = []; % Armazena os valores de r

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        return;
    end

    r = b - (f(b) * (a - b)) / (f(a) - f(b));  % Cálculo inicial da raiz
    valores = [valores; r]; % Armazena o valor inicial

    while (it < n)
        fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Erro aproximado = %f\n', ...
                it + 1, a, b, r, f(r), Ea);

        if (it >= n || Ea <= Es)
            fprintf("Raiz encontrada: %f\n", r);
            break;
        end

        if (f(a) * f(r) < 0)
            b = r; % Atualiza o limite superior
        else
            a = r; % Atualiza o limite inferior
        end

        rPrevio = r;
        r = b - (f(b) * (a - b)) / (f(a) - f(b));
        valores = [valores; r]; % Armazena o novo valor de r
        Ea = calcularErroEstimativa(r, rPrevio);
        it = it + 1;
    endwhile

    if it >= n
        fprintf("Método falhou em %d iterações\n", it);
    end
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf;
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100;
    end
endfunction

function criar_tabela(itBisseccao, rootBisseccao, itFalsaPosicao, rootFalsaPosicao)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Bissecção", itBisseccao, rootBisseccao);
    fprintf("%-20s %-20d %-20f\n", "Falsa Posição", itFalsaPosicao, rootFalsaPosicao);
endfunction

function criar_graficos(itBisseccao, valoresBisseccao, itFalsaPosicao, valoresFalsaPosicao)
    figure;

    % Gráfico para Bissecção
    subplot(2, 1, 1);
    plot(1:length(valoresBisseccao), valoresBisseccao, 'b-', 'LineWidth', 2);
    title('Convergência do Método da Bissecção');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Gráfico para Falsa Posição
    subplot(2, 1, 2);
    plot(1:length(valoresFalsaPosicao), valoresFalsaPosicao, 'r-', 'LineWidth', 2);
    title('Convergência do Método da Falsa Posição');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Salvar gráficos
    saveas(gcf, 'convergencia_metodos_bisseccao_falsa_posicao.png');
endfunction

% Chama a função principal
lista5Questao1();

