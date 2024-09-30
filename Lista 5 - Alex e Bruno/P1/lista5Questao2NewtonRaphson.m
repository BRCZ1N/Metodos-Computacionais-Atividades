  function lista5Questao2NewtonRaphson()
  % Parâmetros fornecidos
  P_umax = 80000;  % P_u,max
  ku = 0.05;       % k_u
  P_umin = 110000; % P_u,min
  Psmax = 320000;  % P_s,max
  P0 = 10000;      % P_0
  ks = 0.09;       % k_s

  % Ponto inicial de tempo estimado
  t = 0;           % Ponto inicial (chute)
  tol = 5^(-4);      % Tolerância
  max_iter = 100;  % Número máximo de iterações

  % Método de Newton-Raphson
  iter = 0;
  while (iter < max_iter)
      % Calcula P_u(t) e P_s(t)
      Pu = P_umax * exp(-ku * t) + P_umin;                     % P_u(t)
      Ps = Psmax / (1 + (Psmax / P0 - 1) * exp(-ks * t));     % P_s(t)

      % Calcula f(t) = P_s(t) - 1.2 * P_u(t)
      f_t = Ps - 1.2 * Pu;

      % Calcula as derivadas
      dPu = -P_umax * ku * exp(-ku * t);                       % dP_u(t)/dt
      dPs = -Psmax * ks * exp(-ks * t) / (1 + (Psmax / P0 - 1) * exp(-ks * t))^2;  % dP_s(t)/dt

      % Derivada de f(t)
      df_t = dPs - 1.2 * dPu;

      % Atualiza t usando a fórmula do método de Newton-Raphson
      t_new = t - f_t / df_t;

      % Verifica se a mudança em t está dentro da tolerância
      if abs(t_new - t)/t_new < tol
          break;  % Sai do loop se a condição de parada for atingida
      end

      % Atualiza t e iteração
      t = t_new;
      iter += 1;
      fprintf('Iteração %d: t = %.5f\n', iter, t);
  endwhile

  % Resultado final
  fprintf('Tempo final após %d iterações: t = %.5f anos\n', iter, t);
  endfunction
