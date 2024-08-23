function lista1Questao1()

    m_test = [2,0;
              2,1;
              0,3;
             -3,1;
             -2,0;
             -1,-2;
              0,0;
              0,-2;
              2,2];

    [i, j] = size(m_test);

    disp('   x       y       r       θ (graus)');
    disp('---------------------------------------');

    for m = 1:i

        x = m_test(m,1);
        y = m_test(m,2);

        r = calculaR(x, y);
        t = calculaT(x, y);

        printf(' %5.2f   %5.2f   %5.2f   %8.2f\n', x, y, r, t);

    endfor

endfunction

function r = calculaR(x, y)

  r = sqrt(x^2 + y^2);

endfunction

function t = calculaT(x, y)

    if x < 0

        if y > 0

            t = rad2deg(atan2(y,x)) + pi;

        elseif y < 0

            t = rad2deg(atan2(y,x)) - pi;

        else

            t = rad2deg(pi);
        end

    elseif x == 0

        if y > 0

            t = rad2deg(pi) / 2;

        elseif y < 0

            t = -rad2deg(pi) / 2;

        else

            t = 0;

        end

    else

        t = rad2deg(atan2(y,x));

    end

endfunction

lista1Questao1();

