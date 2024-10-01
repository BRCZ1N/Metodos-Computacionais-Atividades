function lista5Questao3()
    % Definindo constantes
    e = 8.9e-12;
    F = 1.25;
    q = 2e-5;
    Q = 2e-5;
    raio = 0.85;

    % Executar o método da Bissecção
    fprintf("Método da Bissecção:\n");
    [rootBisseccao, itBisseccao, valoresBisseccao] = metodoBisseccao(e, F, q, Q, raio);

    % Executar o método da Falsa Posição
    fprintf("\nMétodo da Falsa Posição:\n");
    [rootFalsaPosicao, itFalsaPosicao, valoresFalsaPosicao] = metodoFalsaPosicao(e, F, q, Q, raio);

    % Executar o método de Iteração Linear
    fprintf("\nMétodo de Iteração Linear:\n");
    [rootIteracaoLinear, itIteracaoLinear, valoresIteracaoLinear] = metodoIteracaoLinear(e, F, q, Q, raio);

    % Executar o método de Newton-Raphson
    fprintf("\nMétodo de Newton-Raphson:\n");
    [rootNewtonRaphson, itNewtonRaphson, valoresNewtonRaphson] = metodoNewtonRaphson(e, F, q, Q, raio);

    % Executar o método da Secante
    fprintf("\nMétodo da Secante:\n");
    [rootSecante, itSecante, valoresSecante] = metodoSecante(e, F, q, Q, raio);

    % Criar tabela comparativa
    criar_tabela(itBisseccao, rootBisseccao, itFalsaPosicao, rootFalsaPosicao, itIteracaoLinear, rootIteracaoLinear, itNewtonRaphson, rootNewtonRaphson, itSecante, rootSecante);

    % Criar gráficos de convergência
    criar_graficos(valoresBisseccao, valoresFalsaPosicao, valoresIteracaoLinear, valoresNewtonRaphson, valoresSecante);
endfunction

function [r, it, valores] = metodoBisseccao(e, F, q, Q, raio)
    f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);
    a = 0; b = 0.5; r = inf; Es = 5^(-4); Ea = 100; it = 1; n = 20;
    valores = [];  % Armazena os valores de r

    while (it <= n)
        rPrevio = r;
        r = (a + b) / 2;
        valores = [valores; r];  % Armazena o valor atual de r
        if it > 1
            Ea = calcularErroEstimativa(r, rPrevio);
        end
        fprintf('Iteração %d: a = %f, b = %f, xr = %f, f(xr) = %f, Ea = %f\n', it, a, b, r, f(r), Ea);
        if (Ea <= Es), break; end
        if (f(a) * f(r) < 0), b = r; else, a = r; end
        it = it + 1;
    end
endfunction

function [r, it, valores] = metodoFalsaPosicao(e, F, q, Q, raio)
    f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);
    a = 0; b = 0.5; Es = 5e-4; Ea = 100; it = 1; n = 20;
    valores = [];
    fa = f(a); fb = f(b);
    r = b - (fb * (a - b)) / (fa - fb);  % Inicializa r

    while (it <= n)
        valores = [valores; r];  % Armazena o valor atual de r
        fprintf('Iteração %d: a = %f, b = %f, xr = %f, f(xr) = %f, Ea = %f\n', it, a, b, r, f(r), Ea);
        if (Ea <= Es), break; end
        if (f(a) * f(r) < 0), b = r; fb = f(r); else, a = r; fa = f(r); end
        rPrevio = r;
        r = b - (fb * (a - b)) / (fa - fb);  % Atualiza r
        Ea = calcularErroEstimativa(r, rPrevio);
        it = it + 1;
    end
endfunction

function [r, it, valores] = metodoIteracaoLinear(e, F, q, Q, raio)
    f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);
    g = @(x)(4*pi*e*F*(x.^2 + raio.^2).^(3/2) / (q * Q));  % Função iterativa
    Es = 5^(-4); Ea = 100; it = 0; n = 20; xr = 0; valores = [];

    while (it < n)
        xrPrevio = xr;
        xr = g(xrPrevio);
        valores = [valores; xr];  % Armazena o valor atual de xr
        it = it + 1;
        if (xr != 0), Ea = calcularErroEstimativa(xr, xrPrevio); end
        fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', it, xr, f(xr), Ea);
        if (Ea < Es), break; end
    end
    r = xr;  % Retorna o valor final de xr como r
endfunction

function [r, it, valores] = metodoNewtonRaphson(e, F, q, Q, raio)
    f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);
    df = @(x)(1 / (4 * pi * e)) * ...
     ((q * Q * (x^2 + raio^2)^(3/2)) - ...
      (3 * q * Q * x^2 * (x^2 + raio^2)^(1/2))) / ...
     (x^2 + raio^2)^3;

    Es = 5^(-4); Ea = 100; it = 0; N = 20; x = 0;
    valores = [];

    while (it < N)
        xProx = x - f(x) / df(x);
        valores = [valores; x];  % Armazena o valor atual de x
        Ea = calcularErroEstimativa(xProx, x);
        fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', it+1, x, f(x), Ea);
        if (Ea < Es), break; end
        x = xProx;
        it = it + 1;
    end
    r = x;
endfunction

function [r, it, valores] = metodoSecante(e, F, q, Q, raio)
    f = @(x) (1/(4*pi*e)) * (q*Q*x ./ (x.^2 + raio^2).^(3/2)) - F;
    Es = 5^(-4); Ea = 100; it = 0; N = 20; x = 0.5; xPrevio = 0;
    valores = [];

    while (it < N)
        xProx = (xPrevio*f(x) - x*f(xPrevio))/ (f(x) - f(xPrevio));
        valores = [valores; x];  % Armazena o valor atual de x
        fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', it+1, x, f(x), Ea);
        Ea = calcularErroEstimativa(xProx, x);
        if (Ea < Es), break; end
        xPrevio = x;
        x = xProx;
        it = it + 1;
    end
    r = x;
endfunction

function criar_tabela(itBisseccao, rootBisseccao, itFalsaPosicao, rootFalsaPosicao, itIteracaoLinear, rootIteracaoLinear, itNewtonRaphson, rootNewtonRaphson, itSecante, rootSecante)
    % Função para criar a tabela comparativa
    fprintf("\nTabela Comparativa:\n");
    fprintf('Método\t\tRaiz\t\tIterações\n');
    fprintf('Bissecção\t%f\t%d\n', rootBisseccao, itBisseccao);
    fprintf('Falsa Posição\t%f\t%d\n', rootFalsaPosicao, itFalsaPosicao);
    fprintf('Iteração Linear\t%f\t%d\n', rootIteracaoLinear, itIteracaoLinear);
    fprintf('Newton-Raphson\t%f\t%d\n', rootNewtonRaphson, itNewtonRaphson);
    fprintf('Secante\t\t%f\t%d\n', rootSecante, itSecante);
endfunction

function criar_graficos(valoresBisseccao, valoresFalsaPosicao, valoresIteracaoLinear, valoresNewtonRaphson, valoresSecante)
    % Função para criar gráficos de convergência
    figure;
    plot(valoresBisseccao, '-o'); hold on;
    plot(valoresFalsaPosicao, '-x');
    plot(valoresIteracaoLinear, '-s');
    plot(valoresNewtonRaphson, '-d');
    plot(valoresSecante, '-p');
    legend('Bissecção', 'Falsa Posição', 'Iteração Linear', 'Newton-Raphson', 'Secante');
    xlabel('Iterações');
    ylabel('Valor de xr');
    title('Convergência dos Métodos');
    grid on;
    saveas(gcf, 'graficos_convergencia_lista5Questao3.png');  % Salva o gráfico gerado
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
    if resultadoPrev == Inf
        Ea = Inf;
    else
        Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100;
    end
endfunction

