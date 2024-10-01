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
    Es = 5e-5; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial
    r = inf; % Valor inicial de r como infinito

    % Verifica se há mudança de sinal no intervalo [a, b]
    if (funcao(Pu_max, Ps_max, P0, ku, ks, a) * funcao(Pu_max, Ps_max, P0, ku, ks, b) > 0)
        disp("Erro: não há mudança de sinal!");
    else
        it = 1; % Inicializa o contador de iterações
        n = 30; % Define o número máximo de iterações

        % Loop do método da bissecção
        while (it <= n)
            rPrevio = r; % Armazena o valor anterior de r
            r = (a + b) / 2; % Calcula o ponto médio do intervalo

            % Exibe os valores da iteração atual
            if it > 1
                Ea = calcularErroEstimativa(r, rPrevio); % Calcula o erro absoluto a partir da segunda iteração
            else
                Ea = Inf; % Na primeira iteração, o erro é infinito
            end

            fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Aproximado = %f\n', ...
                    it, a, b, r, funcao(Pu_max, Ps_max, P0, ku, ks, r), Ea);

            % Verifica se o erro é menor ou igual à tolerância ou se atingiu o máximo de iterações
            if (Ea <= Es)
                fprintf("Raiz encontrada: %f\n", r); % Exibe a raiz encontrada
                break; % Sai do loop
            end

            it = it + 1; % Incrementa o contador de iterações

            % Atualiza o intervalo [a, b] com base no valor de f(r)
            if (funcao(Pu_max, Ps_max, P0, ku, ks, a) * funcao(Pu_max, Ps_max, P0, ku, ks, r) < 0)
                b = r; % Se houver mudança de sinal, atualiza o limite superior
            else
                a = r; % Caso contrário, atualiza o limite inferior
            end
        endwhile

        % Se o número máximo de iterações for atingido sem encontrar a raiz
        if it > n
            fprintf("Método falhou em %d iterações\n", it);
        end
    end
endfunction

function f = funcao(Pu_max, Ps_max, P0, ku, ks, t)
    Pu = Pu_max * exp(-ku * t); % Cálculo da população urbana
    Ps = Ps_max * (P0 / (Ps_max + ((Ps_max / P0) - 1) * exp(-ks * t))); % Cálculo da população suburbana
    f = Ps - 1.2 * Pu; % Retorna a diferença entre a população suburbana e 20% da urbana
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
lista5Questao2();

