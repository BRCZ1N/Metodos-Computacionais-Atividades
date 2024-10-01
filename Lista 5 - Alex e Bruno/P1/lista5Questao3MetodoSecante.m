function lista5Questao3MetodoSecante()

  % Definindo constantes
  e = 8.9e-12;
  F = 1.25;
  q = 2e-5;
  Q = 2e-5;
  raio = 0.85;

  % Definindo a função
  f = @(x) (1/(4*pi*e)) * (q*Q*x ./ (x.^2 + raio^2).^(3/2)) - F;

  % Define a tolerância para o erro absoluto e o erro inicial
  Es = 5^(-4); % Tolerância em porcentagem
  Ea = Inf; % Erro absoluto inicial (grande valor para iniciar o loop)

  it = 0; % Inicializa o contador de iterações
  N = 20; % Define o número máximo de iterações
  n = 0;
  x = 0.5;
  xPrevio = 0;
  xProx = 0;

  for n = 0:(N-1)

    xProx = (xPrevio*f(x) - x*f(xPrevio))/ (f(x) - f(xPrevio));

    fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', ...
              n, x, f(x), Ea);

    Ea = calcularErroEstimativa(xProx,x);

    if(Ea < Es)

      fprintf("Iterações %d: Raiz encontrada: %f\n", ...
              n+1, x);
      break;

    end

    xPrevio = x;
    x = xProx;

  endfor

    % Se o número máximo de iterações for atingido sem encontrar a raiz
    if it > n
      fprintf("Método falhou em %d iterações\n", it); % Exibe mensagem de falha
    end

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
lista4Questao1MetodoSecante();

