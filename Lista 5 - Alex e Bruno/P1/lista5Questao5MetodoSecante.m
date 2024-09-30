function lista5Questao5MetodoSecante()

  % Definindo constantes
  g = 9.81;
  u = 1800;
  mi = 160000;
  q = 2600;
  v = 750;
  raio = 0.85;

  % Definindo a função
  f = @(t) u*log(mi/(mi-q*t))-g*t-v;

  % Define a tolerância para o erro absoluto e o erro inicial
  Es = 1; % Tolerância em porcentagem
  Ea = Inf; % Erro absoluto inicial (grande valor para iniciar o loop)

  it = 0; % Inicializa o contador de iterações
  N = 20; % Define o número máximo de iterações
  n = 0;
  x = 50;
  xPrevio = 10;
  xProx = 0;

  for n = 0:(N-1)

    xProx = (xPrevio*f(x) - x*f(xPrevio))/ (f(x) - f(xPrevio));

    fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f\n', ...
              n, x, f(x), Ea);

    Ea = calcularErroEstimativa(xProx,x);

    if(Ea < Es)

      fprintf("Iterações %d: Raiz encontrada: %f\n", ...
              it+1, x);
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
lista5Questao5MetodoSecante();

