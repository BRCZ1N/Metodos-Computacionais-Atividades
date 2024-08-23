function lista1Questao2()

  v = [0,2,10,-4];
  i = 1;
  eps = 1e-4;
  i = 1;

  while (i ~= length(v))

    [result,erro] = calcula(v(i),eps);
    fprintf('Resultado para %d: %.10f\n', v(i), result);
    fprintf('Erro: %.10f\n', erro);
    i = i+1;

  endwhile

endfunction

function [aproxR,erroAproxR] = calcula(a,eps)

  if(a == 0)

      aproxR = 0;
      erroAproxR = 0;
      return

  endif

  if(a < 0)

    a = -a;
    imaginario = true;

  else

    imaginario = false;

  endif

  x = a/2;

  while (true)

    xProximo = calcularAproximacao(x,a);
    erroAproxR = calcularErroAproximacao(xProximo,x);

    if(erroAproxR <= eps)

      break

    endif

    x = xProximo;

  endwhile

  if(imaginario)

    aproxR = x *1i;

  else

    aproxR = x;

  endif

endfunction

function x = calcularAproximacao(x,a)

  x = (x + a/x)/2

endfunction

function erro = calcularErroAproximacao(xProximo,x)

  erro = abs((xProximo-x)/xProximo)

endfunction


lista1Questao2();
