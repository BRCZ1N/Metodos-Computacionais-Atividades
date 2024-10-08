function lista5Questao1()
    P = 35000; % Valor de P
    A = 8500;  % Valor de A
    n = 7;     % Número de períodos

    f = @(i) (P * ((i * (1 + i).^n) / ((1 + i).^n - 1)) - A);

    % Definir limites e tolerância
    a = 0.01; % Limite inferior
    b = 0.3;  % Limite superior
    Es = 5e-5; % Tolerância

    % Executar o método da bissecção
    fprintf("Método da Bissecção:\n");
    [rootBisseccao, itBisseccao, valoresBisseccao] = metodoBisseccao(f, a, b, Es);

    % Verifica se o método da bissecção retornou valores válidos
    if isempty(rootBisseccao)
        disp("Erro no método da bissecção.");
        return;
    end

    % Executar o método de iteração linear
    fprintf("\nMétodo de Iteração Linear:\n");
    [rootIteracaoLinear, itIteracaoLinear, valoresIteracaoLinear] = metodoIteracaoLinear(f, P, A, n, Es);

    % Verifica se o método de iteração linear retornou valores válidos
    if isempty(rootIteracaoLinear)
        disp("Erro no método de iteração linear.");
        return;
    end

    % Criar tabela comparativa
    criar_tabela(itBisseccao, rootBisseccao, itIteracaoLinear, rootIteracaoLinear);

    % Criar gráficos de convergência
    criar_graficos(itBisseccao, valoresBisseccao, itIteracaoLinear, valoresIteracaoLinear);
endfunction

function [r, it, valores] = metodoBisseccao(f, a, b, Es)
    Ea = Inf; % Erro absoluto inicial
    r = NaN;  % Inicializa como NaN para evitar erros
    it = 0;   % Contador de iterações
    n = 30;   % Número máximo de iterações
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

        % Verificação da convergência
        if (Ea <= Es)
            fprintf("Raiz encontrada: %f\n", r);
            it = it + 1;  % Incrementa apenas se a raiz for encontrada
            return;  % Retorna a raiz encontrada
        end

        it = it + 1; % Incrementa o contador de iterações

        if (f(a) * f(r) < 0)
            b = r; % Atualiza o limite superior
        else
            a = r; % Atualiza o limite inferior
        end
    endwhile

    % Se o loop terminar sem encontrar uma raiz, retorna NaN
    r = NaN;
endfunction

function [r, it, valores] = metodoIteracaoLinear(f, P, A, n, Es)
    Ea = Inf;  % Erro absoluto inicial
    it = 0;    % Contador de iterações
    nIter = 20; % Número máximo de iterações
    xr = 0.1;  % Aproximação inicial
    valores = []; % Armazena os valores de xr

    g = @(i) i - f(i) / (P * (1 + i)^n / (((1 + i)^n - 1)^2)); % Estimativa de derivada

    while (it < nIter)
        xrPrevio = xr; % Armazena o valor anterior de xr
        xr = g(xrPrevio); % Cálculo da nova aproximação
        it = it + 1; % Incrementa o contador de iterações

        % Cálculo do erro
        if (xrPrevio != 0)
            Ea = calcularErroEstimativa(xr, xrPrevio);
        end

        valores = [valores; xr]; % Armazena o valor atual

        fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
                it, xr, f(xr), Ea);

        % Verificação da convergência
        if (Ea < Es)
            fprintf("Raiz encontrada: %f\n", xr);
            r = xr; % Atribui r como a raiz encontrada
            return; % Encerra a função se a raiz for encontrada
        end
    endwhile

    % Se o loop terminar sem encontrar uma raiz, retorna NaN
    r = NaN;
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
    end
endfunction

function criar_tabela(itBisseccao, rootBisseccao, itIteracaoLinear, rootIteracaoLinear)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Bissecção", itBisseccao, rootBisseccao);
    fprintf("%-20s %-20d %-20f\n", "Iteração Linear", itIteracaoLinear, rootIteracaoLinear);
endfunction

function criar_graficos(itBisseccao, valoresBisseccao, itIteracaoLinear, valoresIteracaoLinear)
    figure;

    % Gráfico para Bissecção
    subplot(2, 1, 1);
    plot(1:length(valoresBisseccao), valoresBisseccao, 'b-');
    title('Convergência do Método da Bissecção');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Gráfico para Iteração Linear
    subplot(2, 1, 2);
    plot(1:length(valoresIteracaoLinear), valoresIteracaoLinear, 'r-');
    title('Convergência do Método de Iteração Linear');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Salvar gráficos
    saveas(gcf, 'convergencia_metodos_bisseccao_iteracao_linear.png');
endfunction

% Chama a função principal
lista5Questao1();

