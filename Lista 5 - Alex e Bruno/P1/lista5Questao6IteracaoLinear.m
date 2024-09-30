function lista5Questao3IteracaoLinear()

  Q = 20;
  g = 9.81;

  f = @(y)1 - ((Q.^(2)*(3+y)))/(g*(3*y+(y.^(2)/2)).^(3));

  g = @(y) ((g*(3*y+(y.^(2)/2)).^(3))/(Q.^(2)))-3;

  Es = 1;
  Ea = Inf;
  it = 0;
  n = 40;
  xr = 2;

  while (it < n)

    xrPrevio = xr;
    xr = g(xrPrevio);
    it = it + 1;

    if (xr != 0 && xrPrevio != 0)
      Ea = calcularErroEstimativa(xr, xrPrevio);
    end

    fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
              it, xr, f(xr), Ea);

    if (Ea < Es)
      fprintf("Iterações %d: Raiz encontrada: %f\n", it, xr);
      return;
    end

  endwhile

  fprintf("Método falhou em %d iterações\n", it);
endfunction

function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
  if resultadoPrev == Inf || resultadoAtual == 0
    Ea = Inf;
  else
    Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100;
  end
endfunction

% Chama a função principal
lista5Questao3IteracaoLinear();

