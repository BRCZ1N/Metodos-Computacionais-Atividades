function lista5Questao2()
    % Definindo constantes
    Pu_max = 80000; % População máxima urbana
    ku = 0.05; % Taxa de declínio da população urbana
    Ps_max = 320000; % População máxima suburbana
    P0 = 10000; % População inicial suburbana
    ks = 0.09; % Taxa de crescimento suburbano

    % Definindo o limite superior e inferior para a busca
    a = 0; % Tempo inicial
    b = 50; % Tempo final (em anos)

    % Define a tolerância para o erro absoluto
    Es = 5e-4; % Tolerância em porcentagem

    % Executar o método da bissecção
    fprintf("Método da Bissecção:\n");
    [rootBisseccao, itBisseccao, valoresBisseccao] = metodoBisseccao(Pu_max, Ps_max, P0, ku, ks, a, b, Es);

    % Verifica se o método da bissecção retornou valores válidos
    if isempty(rootBisseccao) || isempty(itBisseccao)
        disp("Erro no método da bissecção.");
        return;
    end

    % Executar o método da secante
    fprintf("\nMétodo da Secante:\n");
    [rootSecante, itSecante, valoresSecante] = metodoSecante(Pu_max, Ps_max, P0, ku, ks, Es);

    % Verifica se o método da secante retornou valores válidos
    if isempty(rootSecante) || isempty(itSecante)
        disp("Erro no método da secante.");
        return;
    end

    % Criar tabela comparativa
    criar_tabela(itBisseccao+1, rootBisseccao, itSecante+1, rootSecante);

    % Criar gráficos de convergência
    criar_graficos(itBisseccao+1, valoresBisseccao, itSecante+1, valoresSecante);
endfunction

function [r, it, valores] = metodoBisseccao(Pu_max, Ps_max, P0, ku, ks, a, b, Es)
    Ea = Inf; % Erro absoluto inicial
    r = [];  % Inicializa como vazio para evitar erros
    it = 0;   % Contador de iterações
    n = 30;   % Número máximo de iterações
    valores = []; % Armazena os valores de r

    if (funcao(Pu_max, Ps_max, P0, ku, ks, a) * funcao(Pu_max, Ps_max, P0, ku, ks, b) > 0)
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
                it + 1, a, b, r, funcao(Pu_max, Ps_max, P0, ku, ks, r), Ea);

        if (Ea <= Es)
            fprintf("Raiz encontrada: %f\n", r);
            break;
        end

        it = it + 1;

        if (funcao(Pu_max, Ps_max, P0, ku, ks, a) * funcao(Pu_max, Ps_max, P0, ku, ks, r) < 0)
            b = r; % Atualiza o limite superior
        else
            a = r; % Atualiza o limite inferior
        end
    endwhile

    if it >= n
        fprintf("Método falhou em %d iterações\n", it);
    end

    if isempty(r)
        r = NaN; % Atribuir NaN para indicar que não foi encontrada raiz
    end
endfunction

function [r, it, valores] = metodoSecante(Pu_max, Ps_max, P0, ku, ks, Es)
    Ea = Inf;  % Erro absoluto inicial
    it = 0;    % Contador de iterações
    N = 20; % Número máximo de iterações
    xPrevio = 10; % Valor inicial de t
    x = 10.1; % Um valor ligeiramente diferente para x
    valores = []; % Armazena os valores de xr

    f = @(t) funcao(Pu_max, Ps_max, P0, ku, ks, t);

    while (it < N)
        xProx = (xPrevio * f(x) - x * f(xPrevio)) / (f(x) - f(xPrevio)); % Cálculo do próximo valor
        valores = [valores; xProx]; % Armazena o valor atual

        % Mensagem de depuração para ver os valores
        fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', it+1, xProx, f(xProx), Ea);

        Ea = calcularErroEstimativa(xProx, x); % Cálculo do erro absoluto

        if (Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", it + 1, xProx);
            r = xProx; % Atribui r como a raiz encontrada
            return; % Encerra a função se a raiz for encontrada
        end

        % Atualiza os valores para a próxima iteração
        xPrevio = x;
        x = xProx;
        it = it + 1; % Incrementa o contador de iterações
    endwhile

    fprintf("Método falhou em %d iterações\n", it+1);

    if it >= N
        r = NaN; % Atribuir NaN para indicar que não foi encontrada raiz
    end
endfunction

function f = funcao(Pu_max, Ps_max, P0, ku, ks, t)
    Pu = Pu_max * exp(-ku * t); % Cálculo da população urbana
    Ps = Ps_max * (P0 / (Ps_max + ((Ps_max / P0) - 1) * exp(-ks * t))); % Cálculo da população suburbana
    f = Ps - 1.2 * Pu; % Retorna a diferença entre a população suburbana e 20% da urbana
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
    end
endfunction

function criar_tabela(itBisseccao, rootBisseccao, itSecante, rootSecante)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20.6f\n", "Bissecção", itBisseccao, rootBisseccao);
    fprintf("%-20s %-20d %-20.6f\n", "Secante", itSecante, rootSecante);
endfunction

function criar_graficos(itBisseccao, valoresBisseccao, itSecante, valoresSecante)
    figure;

    % Gráfico para Bissecção
    subplot(2, 1, 1);
    plot(1:length(valoresBisseccao), valoresBisseccao, 'b-');
    title('Convergência do Método da Bissecção');
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
    saveas(gcf, 'convergencia_metodos_bisseccao_secante.png');
endfunction

% Chama a função principal
lista5Questao2();

