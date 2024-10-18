function lista8Questao1GaussJordanP()

  % Exibe o sistema de equações
  disp('Sistema de Equações:');
  disp('-0.04*x1 + 0.04*x2 + 0.12*x3 = 3');
  disp('0.56*x1 - 1.56*x2 + 0.32*x3 = 1');
  disp('-0.24*x1 + 1.24*x2 - 0.28*x3 = 0');
  disp(' ');


  % Matriz de coeficientes do sistema
  A = [ -0.04,0.04,0.12 ;
        0.56,-1.56,0.32;
        -0.24,1.24,-0.28;];

  % Matriz de termos independentes
  b = [3; 1; 0];

  n = size(A, 1);  % Obtém o número de equações

  I = eye(n);

  % Criação da matriz aumentada [A | b]
  Ab = [A I b];

  if (det(A) != 0)  % Verifica se a matriz é não singular
    Ab = gaussEliminacao(Ab, n);  % Executa a eliminação de Gauss
    % Exibe a matriz aumentada após a eliminação
    disp('Matriz aumentada após eliminação de Gauss Jordan com Pivoteamento:');
    debug(Ab);
    x = gaussSubstituicao(Ab, n);  % Resolve o sistema por substituição
    disp('Soluções:');
    debugRaizes(x,n);  % Exibe as soluções das variáveis
  else
    disp('A matriz é singular, não há solução única.');  % Mensagem de erro
  end
endfunction

function Ab = gaussEliminacao(Ab, n)
  % Realiza a eliminação de Gauss-Jordan
  for k = 1:n  % Para cada coluna
    Ab = gaussPivotagem(Ab, n, k);  % Aplica pivotagem

    % Normaliza a linha do pivô para garantir que o pivô seja 1
    Ab(k, :) = Ab(k, :) / Ab(k, k);  % Divide a linha toda pelo valor do pivô

    for i = 1:n  % Para todas as outras linhas
      if i != k
        fator = Ab(i, k) / Ab(k, k);  % Calcula o fator de eliminação
        Ab(i, :) = Ab(i, :) - fator * Ab(k, :);  % Atualiza a linha

        % Exibe a matriz após a atualização
        disp('Matriz estendida após a atualização:');
        debug(Ab);
      end
    end
  end
endfunction


function debug(Ab)
  % Exibe a matriz aumentada em formato de matriz estendida
  [n_rows, n_cols] = size(Ab);
  for i = 1:n_rows
    for j = 1:n_cols-1  % Para as colunas da matriz A
      fprintf('%.2f\t', Ab(i, j));  % Formatação para duas casas decimais
    end
    fprintf('| %.2f\n', Ab(i, j+1));  % Exibe o valor do termo independente
  end
endfunction

function Ab = gaussPivotagem(Ab, n, k)
  % Aplica a pivotagem para melhorar a estabilidade numérica
  [maior, i] = max(abs(Ab(k:n, k)));  % Encontra o índice do maior elemento
  ipr = i + k - 1;  % Ajusta o índice
  if ipr ~= k
      disp(['Troca de linha: ', num2str(k), ' com ', num2str(ipr)]);  % Mostra a troca de linha
      Ab([k, ipr], :) = Ab([ipr, k], :);  % Troca as linhas
  end
  % Normaliza a linha pivô
endfunction


function x = gaussSubstituicao(Ab, n)
  % Resolve o sistema usando substituição regressiva
  x = zeros(n, 1);  % Inicializa o vetor de soluções
  x(n) = Ab(n, 2*n+1) / Ab(n, n);  % Calcula a última variável
  for i = n-1:-1:1  % Retrocede para calcular as outras variáveis
    x(i) = (Ab(i, 2*n+1) - Ab(i, i+1:n) * x(i+1:n)) / Ab(i, i);
  end
endfunction

function debugRaizes(x,n)
  % Exibe as raízes encontradas
  for i = 1:n
    fprintf('x%d = %.2f\n', i, x(i));  % Exibe cada raiz com o índice
  end
endfunction

% Chama a função principal
lista8Questao1GaussJordanP();

