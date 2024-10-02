function lista4Questao1MetodoSecante()

  f = @(x) x.^2 - 3*x + exp(x) - 2;  % Define a função f(x)

  % Define a tolerância para o erro e o erro inicial
  Es = 10^(-4);  % Tolerância
  Ea = 100;      % Erro inicial

  it = 0;        % Inicializa o contador de iterações
  N = 20;        % Número máximo de iterações
  x = 0;         % Valor inicial de x
  xPrevio = -1;  % Valor anterior de x

  % Loop para o método da secante
  for n = 1:N
    xProx = (xPrevio*f(x) - x*f(xPrevio)) / (f(x) - f(xPrevio));

    % Incrementa o número de iterações
    it = it + 1;

    % Calcula o erro estimado antes de imprimir
    Ea = calcularErroEstimativa(xProx, x);

    % Exibe as informações da iteração
    fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
              it, xProx, f(xProx), Ea);

    % Verifica se o erro é menor que a tolerância
    if (Ea < Es)
      fprintf('Raiz encontrada em %d iterações: %f\n', it, xProx);
      return;  % Encerra a função se a raiz for encontrada
    end

    % Atualiza os valores de x e xPrevio para a próxima iteração
    xPrevio = x;
    x = xProx;
  endfor

  % Se o número máximo de iterações for atingido sem encontrar a raiz
  fprintf('Método falhou em %d iterações\n', it);

endfunction

% Função para calcular o erro
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
  % Evita divisão por zero
  if resultadoAtual == 0
    Ea = Inf;  % Erro infinito se resultadoAtual for zero
  else
    Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
  end
endfunction

% Chama a função principal
lista4Questao1MetodoSecante();

