function lista4Questao1NewtonRaphson()

  f = @(x) x.^2 - 3*x + exp(x) - 2;
  df = @(x) 2*x - 3 + exp(x);

  % Define a tolerância para o erro absoluto e o erro inicial
  Es = 10^(-4); % Tolerância em porcentagem
  Ea = inf; % Erro absoluto inicial (grande valor para iniciar o loop)
  n = 0;
  N = 20; % Define o número máximo de iterações
  x = 0;

  for n = 0:(N-1)

    xProx = x - f(x)/df(x);
    Ea = calcularErroEstimativa(xProx,x);

    fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
              n, x, f(x), Ea);

    if(Ea < Es)

      fprintf("Iterações %d: Raiz encontrada: %f\n", ...
              n+1, x);
      return;

    end

    x = xProx;

  endfor

  fprintf("Método falhou em %d iterações\n", n); % Exibe mensagem de falha


endfunction

% Função para calcular o erro absoluto
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
  if resultadoPrev == Inf
    Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
  else
    Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
  end
endfunction

% Chama a função principal
lista4Questao1NewtonRaphson();

