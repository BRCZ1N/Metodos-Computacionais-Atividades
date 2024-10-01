function lista5Questao2MetodoSecante()
    % Definindo constantes
    Pu_max = 80000; % População máxima urbana
    ku = 0.05; % Taxa de declínio da população urbana
    Ps_max = 320000; % População máxima suburbana
    P0 = 10000; % População inicial suburbana
    ks = 0.09; % Taxa de crescimento suburbano

    % Definindo a função
    f = @(t) Ps_max * (P0 / (Ps_max + ((Ps_max / P0) - 1) * exp(-ks * t))) - 1.2 * Pu_max * exp(-ku * t);

    % Define a tolerância para o erro absoluto e o erro inicial
    Es = 5e-4; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial

    it = 0; % Inicializa o contador de iterações
    N = 20; % Define o número máximo de iterações
    n = 0; % Contador para iterações do método de secante
    xPrevio = 10; % Valor inicial de t
    x = 10.1; % Um valor ligeiramente diferente para x

    for n = 0:(N-1)
        % Cálculo do próximo valor usando o método da secante
        xProx = (xPrevio * f(x) - x * f(xPrevio)) / (f(x) - f(xPrevio));

        % Mensagem de depuração para ver os valores
        fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', ...
                n, x, f(x), Ea);

        % Calcula o erro absoluto
        Ea = calcularErroEstimativa(xProx, x);

        if (Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", ...
                    n + 1, xProx);
            break;
        end

        % Atualiza os valores para a próxima iteração
        xPrevio = x;
        x = xProx;
        it = it + 1; % Incrementa o contador de iterações
    endfor

    % Se o número máximo de iterações for atingido sem encontrar a raiz
    if it >= N
        fprintf("Método falhou em %d iterações\n", it); % Exibe mensagem de falha
    end

endfunction

% Função para calcular o erro absoluto
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
    end
endfunction

% Chama a função principal
lista5Questao2MetodoSecante();

