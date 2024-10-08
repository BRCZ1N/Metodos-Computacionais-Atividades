function lista4Questao1IteracaoLinear()

  f = @(x) x.^2 - 3*x + exp(x) - 2;
  %f(x) = 0 e g(x) = x
  %x^(2)-3x+exp(x)-2 = 0
  %x^(2)- 3x - 2 = 0
  %x^(2)+ exp(x)- 2 = 3x
  %(x^(2)+exp(x)-2)/3 = g(x)
  g = @(x)(x^(2)+exp(x)-2)/3;


  % Define a tolerância para o erro  e o erro inicial
  Es = 10^(-4); % Tolerância em porcentagem
  Ea = Inf; % Erro  inicial (grande valor para iniciar o loop)

  it = 0; % Inicializa o contador de iterações
  n = 10; % Define o número máximo de iterações
  xr = 0;

  while (it <= n)

    xrPrevio = xr;
    xr = g(xrPrevio);
    it = it + 1;
    if(xr != 0)
      Ea = calcularErroEstimativa(xr, xrPrevio);
    end

    fprintf('Iteração %d: xr = %f, f(xr) = %f, Ea = %f\n', ...
              it, xr, f(xr), Ea);

    if( Ea < Es || it >= n)

      fprintf("Iterações %d: Raiz encontrada: %f\n", ...
              it+1, xr);

      return;

    end

  endwhile

    % Se o número máximo de iterações for atingido sem encontrar a raiz
  if it > n
     fprintf("Método falhou em %d iterações\n", it); % Exibe mensagem de falha
  end


endfunction

% Função para calcular o erro
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
  if resultadoPrev == Inf
    Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
  else
    Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
  end
endfunction

% Chama a função principal
lista4Questao1IteracaoLinear();

