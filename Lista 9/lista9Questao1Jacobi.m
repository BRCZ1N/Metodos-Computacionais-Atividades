function lista9Questao1Jacobi()

  % Exibe o sistema de equações
  disp('Sistema de Equações:');
  disp('5*x1 + 1*x2 + 1*x3 = 5');
  disp('3*x1 + 4*x2 + 1*x3 = 6');
  disp('3*x1 + 3*x2 + 6*x3 = 0');
  disp(' ');

  tol = 0.05;
  x0 = [0;0;0];

  % Matriz de coeficientes do sistema
  A = [ 5,1,1 ;
        3,4,1;
        3,3,6;];

  % Matriz de termos independentes
  b = [5; 6; 0];

  Ea = inf;
  k = 1;
  N = 50;

  n = size(A, 1);  % Obtém o número de equações

  C = zeros(n, 1);
  d = zeros(n, 1);
  x = x0;

  [x,k,Ea] = jacobiMethod(A, b, n, C, d, x, N, tol, Ea);

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

function [x,k,Ea] = jacobiMethod(A, b, n, C, d, x0, N, tol, Ea)

  for i = 1:n
    for j = 1:n
       if i == j
          C(i,j) = 0;
          d(i,1) = b(i,1)/A(i,i);
       else
          C(i,j) = -A(i,j)/A(i,i);
       end
     end
  end

  x = x0;
  k = 1;

  disp(norm(Ea) > tol);
  while(k < N && norm(Ea) > tol)

    xPrevio = x;
    x = C*xPrevio+d;

    for i = 1:n
      Ea = abs((x - xPrevio)/x) * 100;
    end

    if max(Ea) < tol
       disp(Ea);
       disp(N);
       disp(C);
       disp(d);
       disp(k);
       return;
    end
    k = k + 1
  end
  if k == N
    fprintf("Erro");
  end
endfunction


% Chama a função principal
lista9Questao1Jacobi();

