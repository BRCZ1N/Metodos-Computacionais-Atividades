function lista6Questao1GaussEliminacaoP()

  % Sistema:
  % 1*x1 + 6*x2 + 2*x3 + 4*x4 = 8
  % 3*x1 + 19*x2 + 4*x3 + 15*x4 = 25
  % 1*x1 + 4*x2 + 8*x3 - 12*x4 = 18
  % 5*x1 + 33*x2 + 9*x3 + 3*x4 = 72

  %Matriz  de coeficientes
  A = [ 1 , 6  , 2 , 4;
        3 , 19 , 4 , 15;
        1 , 4  , 8 , -12;
        5 , 33 , 9 , 3];

  %Matriz de valores independentes
  b = [8;25;18;72];

  Ab = [ A b ];
  x = [];

  n = size(A, 1);
  nb = n+1;

  if(det(A) != 0)

    Ab = gaussEliminacao(Ab, n, nb);

    x = gaussSubstituicao(Ab,n,nb);

    disp(x);

  endif

endfunction

function[Ab] = gaussEliminacao(Ab,n,nb)

  for k = 1: n-1

    Ab = gaussPivotagem(Ab,n,k);

    for i = k + 1 : n

       fator  = Ab(i,k) / Ab(k,k);
       Ab(i,k:nb) = Ab(i,k:nb) - fator * Ab(k,k:nb);z

    endfor

  endfor

endfunction

function debug(Ab,n)

 for i = 1:(n)

   for j = 1:(n)

      fprintf('%d,', Ab(i,j));

   endfor

  endfor

endfunction

function [Ab] = gaussPivotagem(Ab,n,k)

  [maior,i] = max(Ab(k:n,k));
  ipr = i + k - 1;
  if ipr != k
      Ab([k,ipr],:) = Ab([ipr,k],:);
  endif

endfunction

function [x] = gaussSubstituicao(Ab,n,nb)

  x = zeros(n, 1);
  x(n) = Ab(n,nb)/Ab(n,n);
  for i = n-1:-1:1
    x(i) = (Ab(i,nb)-Ab(i,i+1:n)*x(i+1:n))/Ab(i,i);
  endfor

endfunction


% Chama a função principal
lista6Questao1GaussEliminacaoP();

