function lista5Questao4IteracaoLinear()

  r = 1;
  Vs = 0.837758;
  %Vesfera = 4/3*pi*r^(3) = 4,18879
  %Pw*Vs*G = Ps*Vesfera*G
  %1000*Vs = 200*4,18879
  %Vs = 0.837758

  f = @(h) ((pi*h.^(2))/3)*(3*r-h)-Vs;

  g = @(h)sqrt(3*Vs/((3*r*pi-pi*h)));

  Es = 5^(-4);
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

lista5Questao4IteracaoLinear();

