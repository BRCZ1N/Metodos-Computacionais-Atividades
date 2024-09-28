function lista5Questao3Bisseccao()

  e = 8.9e-12;
  F = 1.25;
  q = 2e-5;
  Q = 2e-5;
  raio = 0.85;

  f = @(x)((1/(4*pi*e)) * (q*Q*x / (x.^2 + raio.^2).^(3/2)) - F);

  a = 0;
  b = 1;

  % Define a tolerância para o erro absoluto e o erro inicial
  Es = 5e-4; % Tolerância em porcentagem
  Ea = Inf; % Erro absoluto inicial (grande valor para iniciar o loop)
  r = inf; % Valor inicial de r (raiz) como infinito

  % Cria um vetor x de 400 pontos entre 0.5 e 1
  x = linspace(0.5, 1, 400);
  % Calcula y para cada ponto em x usando a função f
  y = f(x);

  % Cria um gráfico da função
  figure;
  plot(x, y, 'b', 'LineWidth', 2); % Plota f(x) em azul com linha espessa
  hold on;
  plot(x, zeros(size(x)), 'k--'); % Plota a linha do eixo x (f(x) = 0) em linha pontilhada preta
  xlabel('x');
  ylabel('f(x)');
  title('Gráfico de f(x) = sin(x) - x^2'); % Adiciona um título ao gráfico
  grid on; % Ativa a grade do gráfico
  legend('f(x) = sin(x) - x^2'); % Adiciona uma legenda ao gráfico
  hold off;

  % Verifica se há mudança de sinal no intervalo [a, b]
  if (f(a) * f(b) > 0)
    disp("Erro: não há mudança de sinal!"); % Se não houver mudança de sinal, exibe uma mensagem de erro
  else
    it = 1; % Inicializa o contador de iterações
    n = 20; % Define o número máximo de iterações

    % Loop do método da bissecção
    while (it <= n)
      rPrevio = r; % Armazena o valor anterior de r
      r = (a + b) / 2; % Calcula o ponto médio do intervalo

      % Exibe os valores da iteração atual
      if it > 1
        Ea = calcularErroEstimativa(r, rPrevio); % Calcula o erro absoluto a partir da segunda iteração
      else
        Ea = Inf; % Na primeira iteração, o erro é infinito
      end

      fprintf('Iteração %d: a = %f, b = %f, r = %f, f(r) = %f, Aproximado = %f\n', ...
              it, a, b, r, f(r), Ea);

      % Verifica se o erro é menor ou igual à tolerância ou se atingiu o máximo de iterações
      if (Ea <= Es)
        fprintf("Raiz encontrada: %f\n", r); % Exibe a raiz encontrada
        break; % Sai do loop
      end

      it = it + 1; % Incrementa o contador de iterações

      % Atualiza o intervalo [a, b] com base no valor de f(r)
      if (f(a) * f(r) < 0)
        b = r; % Se houver mudança de sinal, atualiza o limite superior
      else
        a = r; % Caso contrário, atualiza o limite inferior
      end
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
lista5Questao3Bisseccao();

