
function lista5Questao2Bisseccao()
  % Parâmetros fornecidos
  P_umax = 80000;  % P_u,max
  ku = 0.05;       % k_u
  P_umin = 110000; % P_u,min
  Psmax = 320000;  % P_s,max
  P0 = 10000;      % P_0
  ks = 0.09;       % k_s

  % Intervalo inicial de tempo (estimado)
  t0 = 0;          % ano 0
  t1 = 50;         % ano 50

  % Tolerância e número máximo de iterações
  tol = 5^(-4);
  max_iter = 100;

  % Executar o método da bisseção
  [t_final, n_iter] = bissecao(P_umax, ku, P_umin, Psmax, P0, ks, t0, t1, tol, max_iter);
  fprintf('Tempo final após %d iterações: t = %.5f anos\n', n_iter, t_final);
endfunction

% Funções auxiliares
function Pu = P_u(t, P_umax, ku, P_umin)
    Pu = P_umax * exp(-ku * t) + P_umin;
endfunction

function Ps = P_s(t, Psmax, P0, ks)
    Ps = Psmax / (1 + (Psmax / P0 - 1) * exp(-ks * t));
endfunction

% Definindo a função f(t) = P_s(t) - 1.2 * P_u(t)
function val = f(t, P_umax, ku, P_umin, Psmax, P0, ks)
    val = P_s(t, Psmax, P0, ks) - 1.2 * P_u(t, P_umax, ku, P_umin);
endfunction

% Função para o método da bisseção
function [tm, iter] = bissecao(P_umax, ku, P_umin, Psmax, P0, ks, t0, t1, tol, max_iter)
    iter = 0;
    while (t1 - t0 > tol && iter < max_iter)
        tm = (t0 + t1) / 2;
        if f(t0, P_umax, ku, P_umin, Psmax, P0, ks) * f(tm, P_umax, ku, P_umin, Psmax, P0, ks) < 0
            t1 = tm;
        else
            t0 = tm;
        endif
        iter += 1;
        fprintf('Iteração %d: t0 = %.5f, t1 = %.5f, tm = %.5f\n', iter, t0, t1, tm);
    endwhile
    tm = (t0 + t1) / 2;
endfunction

