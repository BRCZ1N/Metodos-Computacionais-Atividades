function lista4Questao1MetodoSecante()

  f = @(x) x.^2 - 3*x + exp(x) - 2;  % Define a função f(x)

  % Define a tolerância para o erro e o erro inicial
  Es = 10^(-4);  % Tolerância
  Ea = 100;      % Erro  inicial

  it = 0;        % Inicializa o contador de iterações
  N = 20;        % Número máximo de iterações
  x = 0;         % Valor inicial de x
  xPrevio = -1;  % Valor anterior de x

  % Loop para o método da secante
  for n = 0:(N-1)
    xProx = (xPrevio*f(x) - x*f(xPrevio)) / (f(x) - f(xPrevio));

    % Incrementa o número de iterações
    it = it + 1;

    % Exibe as informações da iteração
    fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
              it, xProx, f(xProx), Ea);

    % Calcula o erro estimado
    Ea = calcularErroEstimativa(xProx, x);

    % Verifica se o erro é menor que a tolerância
    if (Ea < Es)
      fprintf('Iteração %d: Raiz encontrada: %f\n', it, xProx);
      break;
    end

    % Atualiza os valores de x e xPrevio para a próxima iteração
    xPrevio = x;
    x = xProx;
  endfor

  % Se o número máximo de iterações for atingido sem encontrar a raiz
  if (n == N-1)
    fprintf('Método falhou em %d iterações\n', it);
  end

endfunction

% Função para calcular o erro
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
  Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
endfunction

% Chama a função principal
lista4Questao1MetodoSecante();

