function lista4Questao1MetodoSecante()

  f = @(x) x.^2 - 3*x + exp^(x) - 2;

  % Define a tolerância para o erro absoluto e o erro inicial
  Es = 10^(-4); % Tolerância em porcentagem
  Ea = Inf; % Erro absoluto inicial (grande valor para iniciar o loop)

  it = 0; % Inicializa o contador de iterações
  N = 20; % Define o número máximo de iterações
  n = 0;
  x = 0;
  xPrevio = 0;
  xProx = 0;

  for (int n = 0; n < N ; n++)

    xProx = xPrevio*f(x) - x*f(xPrevio)/ f(x) - f(xPrevio);

    fprintf('Iteração %d: xr = %f, f(x) = %f, Ea = %f', ...
              it, x, f(x), Ea);

    if(calcularErroEstimativa(xProx,x) < Es)

      fprintf("Iterações %d: Raiz encontrada: %f\n", ...
              it+1, x);
      break;

    end

    xPrevio = x;
    x = xProx;

  endwhile

    % Se o número máximo de iterações for atingido sem encontrar a raiz
    if it > n
      fprintf("Método falhou em %d iterações\n", it); % Exibe mensagem de falha
    end

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

