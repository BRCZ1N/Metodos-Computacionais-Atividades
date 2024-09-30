function lista5Questao4FalsaPosicao()

  r = 1;
  Vs = 0.837758;
  %Vesfera = 4/3*pi*r^(3) = 4,18879
  %Pw*Vs*G = Ps*Vesfera*G
  %1000*Vs = 200*4,18879
  %Vs = 0.837758

  f = @(h) ((pi*h.^(2))/3)*(3*r-h)-Vs;

  a = 0;
  b = 1;
  E = 5e-5;
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
      fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Erro aproximado = %f\n', ...
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

lista5Questao4FalsaPosicao();

