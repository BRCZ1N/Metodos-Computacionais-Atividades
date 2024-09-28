function lista5Questao3IteracaoLinear()

  e = 8.9e-12;
  F = 1.25;
  q = 2e-5;
  Q = 2e-5;
  raio = 0.85;

  f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);

  %f(x) = 0 e g(x) = x
  %(1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F = 0
  %(1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) = F
  %(4*pi*e)*F = (q*Q*x / (x.^2 + raio.^2).^(3/2))
  %(4*pi*e)*F*(x.^2 + raio.^2).^(3/2)= (q*Q*x)
  %((4*pi*e)*F*(x.^2 + raio.^2).^(3/2))/q*Q = x

  g = @(x)(4*pi*e*F*(x.^2 + raio.^2).^(3/2)/q*Q);


  % Define a tolerância para o erro absoluto e o erro inicial
  Es = 10^(-4); % Tolerância em porcentagem
  Ea = Inf; % Erro absoluto inicial (grande valor para iniciar o loop)

  it = 0; % Inicializa o contador de iterações
  n = 20; % Define o número máximo de iterações
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

% Função para calcular o erro absoluto
function Ea = calcularErroEstimativa(resultadoAtual, resultadoPrev)
  if resultadoPrev == Inf
    Ea = Inf; % Se o valor anterior for infinito, o erro é infinito
  else
    Ea = abs((resultadoAtual - resultadoPrev) / resultadoAtual) * 100; % Calcula o erro percentual
  end
endfunction

% Chama a função principal
lista5Questao3IteracaoLinear();

