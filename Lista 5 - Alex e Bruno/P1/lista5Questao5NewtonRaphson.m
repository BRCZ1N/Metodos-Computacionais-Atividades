function lista5Questao5NewtonRaphson()
    % Definindo constantes
    g = 9.81;
    u = 1800;
    mi = 160000;
    q = 2600;
    v = 750;
    raio = 0.85;

    % Definindo a função e sua derivada
    f = @(t) u*log(mi/(mi-q*t)) - g*t - v;
    df = @(t) (u * q / (mi - q*t)) - g; % Derivada da função

    % Define a tolerância para o erro absoluto e o erro inicial
    Es = 1; % Tolerância em porcentagem
    Ea = Inf; % Erro absoluto inicial (grande valor para iniciar o loop)

    it = 0; % Inicializa o contador de iterações
    N = 20; % Define o número máximo de iterações
    x = 50; % Valor inicial para t

    for n = 0:(N-1)
        % Cálculo do próximo valor usando Newton-Raphson
        xProx = x - f(x) / df(x);

        fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', ...
                n, x, f(x), Ea);

        Ea = calcularErroEstimativa(xProx, x);

        if(Ea < Es)
            fprintf("Iterações %d: Raiz encontrada: %f\n", ...
                    n+1, xProx);
            return; % Encerra a função se a raiz for encontrada
        end

        % Atualiza x para a próxima iteração
        x = xProx;
    endfor

    fprintf("Método falhou em %d iterações\n", N); % Exibe mensagem de falha
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
lista5Questao5NewtonRaphson();

