% Métodos Numéricos: Bissecção e Falsa Posição

function metodos_numericos()
    % Parâmetros do problema
    P = 35000;
    A = 8500;
    n = 7;
    f = @(i) (P * ((i * (1 + i).^n) / ((1 + i).^n - 1)) - A);

    % Intervalo inicial
    a = 0.01;
    b = 0.3;

    % Tolerância e variáveis para erro
    Es = 5e-5; % Tolerância em porcentagem
    Ea_bisseccao = Inf; % Erro absoluto inicial para bissecção
    Ea_falsa = Inf; % Erro absoluto inicial para falsa posição

    % Métodos numéricos
    [raiz_bisseccao, iteracoes_bisseccao] = bisseccao(f, a, b, Es, 30);
    [raiz_falsa, iteracoes_falsa] = falsa_posicao(f, a, b, Es, 20);

    % Tabela Comparativa
    criar_tabela(iteracoes_bisseccao, iteracoes_falsa);

    % Gráficos de Convergência
    criar_graficos(iteracoes_bisseccao, iteracoes_falsa);
end

% Função para o método da bissecção
function [r, iteracoes] = bisseccao(f, a, b, Es, n)
    it = 1; % Inicializa o contador de iterações
    r = inf; % Valor inicial da raiz
    iteracoes = []; % Para armazenar iterações

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
    else
        while (it <= n)
            rPrevio = r; % Armazena o valor anterior de r
            r = (a + b) / 2; % Calcula o ponto médio
            Ea = calcularErroEstimativa(r, rPrevio); % Calcula o erro

            % Armazena dados da iteração
            iteracoes = [iteracoes; it, a, b, r, f(r), Ea];

            fprintf('Bissecção - Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Aproximado = %f\n', ...
                    it, a, b, r, f(r), Ea);

            if (Ea <= Es)
                fprintf("Raiz encontrada pela bissecção: %f\n", r);
                break;
            end

            it = it + 1; % Incrementa o contador de iterações

            % Atualiza o intervalo [a, b]
            if (f(a) * f(r) < 0)
                b = r; % Atualiza o limite superior
            else
                a = r; % Atualiza o limite inferior
            end
        endwhile

        if it > n
            fprintf("Bissecção falhou em %d iterações\n", it);
        end
    end
end

% Função para o método da falsa posição
function [r, iteracoes] = falsa_posicao(f, a, b, Es, n)
    it = 1; % Inicializa o contador de iterações
    r = b - (f(b) * (a - b)) / (f(a) - f(b)); % Cálculo inicial da raiz
    fa = f(a);
    fb = f(b);
    iteracoes = []; % Para armazenar iterações

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
    else
        while (it <= n)
            Ea = calcularErroEstimativa(r, r); % Inicializa erro
            fprintf('Falsa Posição - Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Erro aproximado = %f\n', ...
                    it, a, b, r, f(r), Ea);

            if (it >= n || Ea <= Es)
                fprintf("Raiz encontrada pela falsa posição: %f\n", r);
                break;
            end

            if (f(a) * f(r) < 0)
                b = r; % Atualiza b
                fb = f(r);
            else
                a = r; % Atualiza a
                fa = f(r);
            end

            it = it + 1; % Incrementa o contador de iterações

            rPrevio = r; % Armazena o valor anterior de r
            r = b - (fb * (a - b)) / (fa - fb); % Calcula nova raiz
            Ea = calcularErroEstimativa(r, rPrevio);
            iteracoes = [iteracoes; it, a, b, r, f(r), Ea]; % Armazena dados da iteração
        endwhile

        if it > n
            fprintf("Falsa Posição falhou em %d iterações\n", it);
        end
    end
end

% Função para calcular o erro absoluto
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Erro percentual
    end
end

% Função para criar tabela comparativa
function criar_tabela(iteracoes_bisseccao, iteracoes_falsa)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Bissecção", size(iteracoes_bisseccao, 1), iteracoes_bisseccao(end, 4));
    fprintf("%-20s %-20d %-20f\n", "Falsa Posição", size(iteracoes_falsa, 1), iteracoes_falsa(end, 4));
end

% Função para criar gráficos de convergência
function criar_graficos(iteracoes_bisseccao, iteracoes_falsa)
    figure;

    % Gráfico para Bissecção
    subplot(1, 2, 1);
    plot(iteracoes_bisseccao(:, 1), iteracoes_bisseccao(:, 4), '-o');
    title('Convergência da Bissecção');
    xlabel('Iterações');
    ylabel('Valor Aproximado');
    grid on;

    % Gráfico para Falsa Posição
    subplot(1, 2, 2);
    plot(iteracoes_falsa(:, 1), iteracoes_falsa(:, 4), '-o', 'color', 'orange');
    title('Convergência da Falsa Posição');
    xlabel('Iterações');
    ylabel('Valor Aproximado');
    grid on;
end

% Chama a função principal
metodos_numericos();

