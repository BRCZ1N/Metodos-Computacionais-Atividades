function lista11Questao1InterpolacaoNewton()
    % Definição dos pontos
    x = [0, 0.5, 1.0];
    fx = [1.0, 2.12, 3.55];

    fprintf("Passo 1: Definição dos pontos\n");
    fprintf("x:\t\t%.2f\t%.2f\t%.2f\n", x(1), x(2), x(3));
    fprintf("f(x):\t\t%.2f\t%.2f\t%.2f\n\n", fx(1), fx(2), fx(3));

    % Avaliação em x = 0.7
    x_val = 0.7;
    fprintf("Passo 2: Avaliação em x_val = %.2f\n\n", x_val);

    % Cálculo do polinômio interpolador usando diferenças divididas
    P2 = newton_interpolacao(x, fx, x_val, true); % Mostrar passos

    fprintf("\nResultado Final\n");
    fprintf('Valor aproximado de f(%.2f) pelo método de Newton: %.4f\n\n', x_val, P2);
endfunction

function P2 = newton_interpolacao(x, fx, x_val, show_steps)
    n = length(x);
    coef = fx; % Coeficientes de Newton

    if show_steps
        fprintf("Passo 3: Construção da tabela de diferenças divididas\n");
        fprintf("Ordem\tCoeficientes\t\tCalculo\n");
    end

    % Construção da tabela de diferenças divididas
    for j = 2:n
        for i = n:-1:j
            formula = sprintf("(%.4f - %.4f) / (%.2f - %.2f)", coef(i), coef(i-1), x(i), x(i-j+1));
            coef(i) = (coef(i) - coef(i-1)) / (x(i) - x(i-j+1));
            if show_steps
                fprintf("%d\t%.4f\t\t%s\n", j - 1, coef(i), formula);
            end
        end
    end

    if show_steps
        fprintf("\nPasso 4: Avaliação do polinômio de Newton em x_val = %.2f\n", x_val);
        fprintf("k\tP2 Intermediário\tTermo Adicionado\n");
    end

    % Avaliação de P2(x) usando os coeficientes de Newton
    P2 = coef(n); % Último coeficiente inicializado
    if show_steps, fprintf("%d\t%.4f\t%.4f\n", n, P2, P2); end

    for k = n-1:-1:1
        termo = P2 * (x_val - x(k));
        P2 = termo + coef(k);
        if show_steps
            fprintf("%d\t%.4f\t%.4f * (%.2f - %.2f) + %.4f\n", ...
                    k, P2, termo, x_val, x(k), coef(k));
        end
    end
endfunction

% Executar o programa
lista11Questao1InterpolacaoNewton();

