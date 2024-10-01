function lista5Questao3NewtonRaphson()

  e = 8.9e-12;
  F = 1.25;
  q = 2e-5;
  Q = 2e-5;
  raio = 0.85;

  f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);
  df = @(x)(1 / (4 * pi * e)) * ...
     ((q * Q * (x^2 + raio^2)^(3/2)) - ...
      (3 * q * Q * x^2 * (x^2 + raio^2)^(1/2))) / ...
     (x^2 + raio^2)^3;

  % Define a tolerância para o erro absoluto e o erro inicial
  Es = 5^(-4); % Tolerância em porcentagem
  Ea = 100; % Erro absoluto inicial (grande valor para iniciar o loop)
  n = 0;
  N = 20; % Define o número máximo de iterações
  x = 0;

  for n = 0:(N-1)

    xProx = x - f(x)/df(x);
    Ea = calcularErroEstimativa(xProx,x);

    fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
              n+1, x, f(x), Ea);

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

function Et = calcularErroVerdadeiro(valorVerdadeiro, resultadoAtual)

    Et = (abs((valorVerdadeiro - resultadoAtual) / valorVerdadeiro)) * 100;

endfunction

% Chama a função principal
lista5Questao3NewtonRaphson();

