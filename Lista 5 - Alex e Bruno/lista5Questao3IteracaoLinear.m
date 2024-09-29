function lista5Questao3IteracaoLinear()

  e = 8.9e-12;
  F = 1.25;
  q = 2e-5;
  Q = 2e-5;
  raio = 0.85;

  f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);

  g = @(x)(4*pi*e*F*(x.^2 + raio.^2).^(3/2) / (q * Q));

  Es = 10^(-4);
  Ea = Inf;
  it = 0;
  n = 20;
  xr = 0;

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

