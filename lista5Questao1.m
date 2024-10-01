function lista5Questao1()
    P = 35000;
    A = 8500;
    n = 7;

    f = @(i) (P*((i*(1+i).^n)/((1+i).^n - 1)) - A);

    % Intervalos iniciais
    a = 0.01;
    b = 0.3;
    Es = 5e-5; % Tolerância em porcentagem

    % Executar o método da Bissecção
    fprintf("Método da Bissecção:\n");
    [rootBisseccao, itBisseccao] = bisseccao(f, a, b, Es);

    % Executar o método da Falsa Posição
    fprintf("\nMétodo da Falsa Posição:\n");
    [rootFalsa, itFalsa] = falsa_posicao(f, a, b, Es);

    % Criar tabela comparativa
    criar_tabela(itBisseccao, rootBisseccao, itFalsa, rootFalsa);

    % Criar gráficos de convergência
    criar_graficos(itBisseccao, itFalsa, rootBisseccao, rootFalsa);
endfunction

function [r, it] = bisseccao(f, a, b, Es)
    Ea = inf; % Erro absoluto inicial
    r = inf; % Raiz inicial
    it = 0; % Contador de iterações

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        return;
    end

    while (Ea > Es)
        it = it + 1; % Incrementa o contador
        rPrevio = r; % Armazena o valor anterior de r
        r = (a + b) / 2; % Ponto médio

        % Calcular erro
        if it > 1
            Ea = abs((r - rPrevio) / r) * 100; % Erro percentual
        else
            Ea = inf; % Na primeira iteração, erro é infinito
        end

        fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Erro = %f\n', ...
                it, a, b, r, f(r), Ea);

        % Atualizar os limites
        if (f(a) * f(r) < 0)
            b = r;
        else
            a = r;
        end
    endwhile

    fprintf("Raiz encontrada: %f após %d iterações\n", r, it);
endfunction

function [r, it] = falsa_posicao(f, a, b, Es)
    Ea = inf; % Erro absoluto inicial
    r = b - (f(b) * (a - b)) / (f(a) - f(b)); % Cálculo inicial da raiz
    it = 0; % Contador de iterações

    if (f(a) * f(b) > 0)
        disp("Erro: não há mudança de sinal!");
        return;
    end

    while (Ea > Es)
        it = it + 1; % Incrementa o contador
        rPrevio = r; % Armazena o valor anterior de r

        fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f\n', ...
                it, a, b, r, f(r));

        % Atualiza os limites
        if (f(a) * f(r) < 0)
            b = r;
        else
            a = r;
        end

        % Nova estimativa da raiz
        r = b - (f(b) * (a - b)) / (f(a) - f(b));

        % Calcular erro
        if it > 1
            Ea = abs((r - rPrevio) / r) * 100; % Erro percentual
        end
    endwhile

    fprintf("Raiz encontrada: %f após %d iterações\n", r, it);
endfunction

function criar_tabela(itBisseccao, rootBisseccao, itFalsa, rootFalsa)
    fprintf("\nTabela Comparativa:\n");
    fprintf("%-20s %-20s %-20s\n", "Método", "Número de Iterações", "Resultado Final");
    fprintf("%-20s %-20d %-20f\n", "Bissecção", itBisseccao, rootBisseccao);
    fprintf("%-20s %-20d %-20s\n", "Falsa Posição", itFalsa, "N/A");
endfunction

function criar_graficos(itBisseccao, itFalsa, rootBisseccao, rootFalsa)
    % Exemplo de como você poderia criar gráficos de convergência
    figure;

    % Gráfico para Bissecção
    subplot(2, 1, 1);
    plot(1:itBisseccao, linspace(rootBisseccao, rootBisseccao, itBisseccao), 'b-', 'LineWidth', 2);
    title('Convergência do Método da Bissecção');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Gráfico para Falsa Posição
    subplot(2, 1, 2);
    plot(1:itFalsa, linspace(rootFalsa, rootFalsa, itFalsa), 'r-', 'LineWidth', 2);
    title('Convergência do Método da Falsa Posição');
    xlabel('Iterações');
    ylabel('Valor da Raiz');
    grid on;

    % Salvar gráficos se necessário
    saveas(gcf, 'convergencia_métodos.png');
endfunction

% Chama a função principal
lista5Questao1();

