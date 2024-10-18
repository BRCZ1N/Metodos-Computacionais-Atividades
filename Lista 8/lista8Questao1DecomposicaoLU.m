function lista8Questao1DecomposicaoLU()

  % Exibe o sistema de equações
  disp('Sistema de Equações:');
  disp('2*x1 + 1*x2 - 3*x3 = 2');
  disp('-1*x1 + 3*x2 + 2*x3 = 0');
  disp('3*x1 + 1*x2 - 3*x3 = 1');
  disp(' ');


  % Matriz de coeficientes do sistema
  A = [ 2,1,-3 ;
       -1,3,2;
        3,1,-3;];

  % Matriz de termos independentes
  b = [3; 1; 2];

  n = size(A, 1);  % Obtém o número de equações

  L = eye(n);
  U = eye(n);

  y = zeros(n, 1);
  x = zeros(n, 1);

  for j = 1:n-1;
    pivo = A(j,j);
    for i = j+1: n;
        fator = A(i,j)/pivo;
        A(i,:) = A(i,:) - fator*A(j,:);
        L(i,j) = fator;
    endfor
  endfor
  U = A;

  fprintf('Matriz L');
  fprintf('\n');
  debug(L);
  fprintf('\n');
  fprintf('Matriz U');
  fprintf('\n');
  debug(U);
  fprintf('\n');

  y = forwardSubstitution(L, b, n);
  fprintf('\nRaízes:\n');
  x = backwardSubstitution(U, y, n);

endfunction

function debug(A)
  % Exibe a matriz aumentada em formato de matriz estendida
  [n_rows, n_cols] = size(A);
  for i = 1:n_rows
    for j = 1:n_cols  % Para as colunas da matriz A
      fprintf('%.2f ', A(i, j));  % Formatação para duas casas decimais
    end
      fprintf('\n');
  end
endfunction

function y = forwardSubstitution(A, b, n)
  % Realiza a substituição reversa para encontrar as soluções
  y = zeros(n, 1);  % Inicializa o vetor de soluções
  y(1) = b(1) / A(1, 1);  % Solução para a última variável
  for i = 2:1:n
    soma = b(i);  % Inicia a soma com o valor correspondente em b
    for j = 1:i-1
      soma = soma - A(i, j) * y(j);  % Subtrai contribuições das variáveis já resolvidas
    endfor
    y(i) = soma / A(i, i);  % Calcula a solução para a 'variável i
    debugRaizes(y,n,'y');
    fprintf('\n');
  endfor
endfunction

function x = backwardSubstitution(A, b, n)
  % Realiza a substituição reversa para encontrar as soluções
  x = zeros(n, 1);  % Inicializa o vetor de soluções
  x(n) = b(n) / A(n, n);  % Solução para a última variável
  for i = n-1:-1:1
    soma = b(i);  % Inicia a soma com o valor correspondente em b
    for j = i+1:n
      soma = soma - A(i, j) * x(j);  % Subtrai contribuições das variáveis já resolvidas
    endfor
    x(i) = soma / A(i, i);  % Calcula a solução para a variável i
    debugRaizes(x,n,'x');
    fprintf('\n');
  endfor
endfunction


function debugRaizes(x,n,str)
  % Exibe as raízes encontradas
  for i = 1:n
    fprintf('%s%d = %.2f\n',str, i, x(i));  % Exibe cada raiz com o índice
  end
endfunction

% Chama a função principal
lista8Questao1DecomposicaoLU();

