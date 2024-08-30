function lista3Questao2()
  f = @(x) x.^3 - 9*x + 3;
  a = 0;
  b = 1;
  E = 5e-4;
  Ea = inf;
  rPrevio = inf;

  x = linspace(0.5, 1, 400);
  y = f(x);
  figure;
  plot(x, y, 'b', 'LineWidth', 2);
  hold on;
  plot(x, zeros(size(x)), 'k--');
  xlabel('x');
  ylabel('f(x)');
  title('Gráfico de f(x) = x.^3 - 9*x + 3');
  grid on;
  legend('f(x) = x.^3 - 9*x + 3');
  hold off;

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

      Ea = calcularErroEstimativa(it, r, rPrevio);

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

lista3Questao2();

