function lista2Questao6()

    valorVerdadeiro = exp(0.5);
    x = 0.5;
    Es = 0.05;
    resultado = 0;
    n = 0;

    resultado = calcularSerie(Es, x, n, resultado, valorVerdadeiro);
    disp('Resultado final:');
    disp(resultado);

endfunction

function resultado = calcularSerie(Es, x, n, resultado, valorVerdadeiro)

    resultadoPrev = resultado;
    resultado = resultado + (x^(n)) / factorial(n);
    Et = calcularErroVerdadeiro(valorVerdadeiro, resultado);
    Ea = calcularErroEstimativa(resultado, resultadoPrev);

    fprintf('Termo: %d | Soma: %.6f | Erro Verdadeiro: %.6f%% | Erro Estimativa: %.6f%%\n', ...
            n+1, resultado, Et, Ea);

    if (Ea <= Es)
        return;
    else
        resultado = calcularSerie(Es, x, n + 1, resultado, valorVerdadeiro);
    end
endfunction

function Et = calcularErroVerdadeiro(valorVerdadeiro, resultadoAtual)

    Et = (abs((valorVerdadeiro - resultadoAtual) / valorVerdadeiro)) * 100;

endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)

    if resultadoPrev == 0
        Ea = Inf;
    else
        Ea = (abs((resultadoAtual - resultadoPrev) / resultadoAtual)) * 100;
    end
endfunction

lista2Questao6();

