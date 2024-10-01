function lista5Questao3FalsaPosicao()

  e = 8.9e-12;
  F = 1.25;
  q = 2e-5;
  Q = 2e-5;
  raio = 0.85;

  f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);

  a = 0;
  b = 0.5;
  E = 5e-4;
  Ea = inf;
  rPrevio = inf;

  if (f(a) * f(b) > 0)
    disp("Erro: não há mudança de sinal!");
  else
    it = 1;
    n = 20;
    r = b - (f(b) * (a - b)) / (f(a) - f(b));  % Cálculo inicial da raiz
    fa = f(a);
    fb = f(b);

    while (it <= n)
      fprintf('Iteração %d: a = %f, b = %f, xr = %f, f(xr) = %f, Ea = %f\n', ...
              it, a, b, r, f(r), Ea);
      if (it >= n || Ea <= E)
        fprintf("Raiz encontrada: %f\n", r);
        break;
      end

      if (f(a) * f(r) < 0)
        b = r;
        fb = f(r);
      else
        a = r;
        fa = f(r);
      end

      it = it + 1;

      rPrevio = r;
      r = b - (fb * (a - b)) / (fa - fb);
      Ea = calcularErroEstimativa(it, r, rPrevio);
    endwhile

    if it > n
      fprintf("Método falhou em %d iterações\n", it);
    end
  end
endfunction

function Ea = calcularErroEstimativa(it, resultadoAtual, resultadoPrev)
  if it == 1
    Ea = inf;
  else
    Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100;
  end
endfunction

function Et = calcularErroVerdadeiro(valorVerdadeiro, resultadoAtual)

    Et = (abs((valorVerdadeiro - resultadoAtual) / valorVerdadeiro)) * 100;

endfunction

lista5Questao3FalsaPosicao();

