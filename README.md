```octave
% Atribuição de Variáveis e Operações Básicas
a = 5;
b = 10;
c = a + b;
d = b - a;
e = a * b;
f = b / a;
g = b^2;

% Vetores e Matrizes
v = [1, 2, 3, 4]; % Vetor linha
v_col = [1; 2; 3; 4]; % Vetor coluna
A = [1, 2, 3; 4, 5, 6; 7, 8, 9]; % Matriz 3x3

A_transpose = A'; % Transposta de uma matriz
A_inv = inv(A); % Inversa de uma matriz
det_A = det(A); % Determinante de uma matriz

% Controle de Fluxo: Condicionais e Laços
if a > b
  disp('a é maior que b');
elseif a == b
  disp('a é igual a b');
else
  disp('a é menor que b');
endif

for i = 1:5
  disp(i); % Exibe números de 1 a 5
endfor

n = 1;
while n <= 5
  disp(n);
  n = n + 1;
endwhile

% Funções
function y = quadrado(x)
  y = x^2;
endfunction

resultado = quadrado(4); % Chama a função 'quadrado' com argumento 4

% Resolução de Sistemas Lineares
A = [3, 2; 1, 4];
b = [7; 10];
x = A \ b; % Resolve o sistema Ax = b

% Interpolação
x = [1, 2, 3, 4];
y = [2, 4, 6, 8];
xi = 2.5;
yi_linear = interp1(x, y, xi); % Interpolação linear
p = polyfit(x, y, 1); % Ajuste polinomial de grau 1 (linear)
yi_poly = polyval(p, xi); % Avaliação do polinômio no ponto xi

% Diferenciação e Integração Numérica
f = @(x) x^3 + 2*x + 1;
x_values = 0:0.1:10;
df = diff(f(x_values)) ./ diff(x_values); % Diferenciação numérica

Q = quad(@(x) x^3 + 2*x + 1, 0, 10); % Integração numérica de 0 a 10

% Métodos Iterativos

% Método de Newton-Raphson
f = @(x) x^2 - 2;
df = @(x) 2*x;
x0 = 1;
tol = 1e-6;
x = x0;
while abs(f(x)) > tol
  x = x - f(x) / df(x);
endwhile

% Método da Bisseção
f = @(x) x^2 - 2;
a = 0;
b = 2;
tol = 1e-6;
while (b - a) / 2 > tol
  c = (a + b) / 2;
  if f(c) == 0
    break;
  elseif f(a) * f(c) < 0
    b = c;
  else
    a = c;
  endif
endwhile

% Resolução de Equações Diferenciais

% Método de Euler
f = @(t, y) -2*y + t;
h = 0.1; % Passo
t = 0:h:10;
y = zeros(size(t));
y(1) = 1; % Condição inicial
for i = 1:length(t)-1
  y(i+1) = y(i) + h*f(t(i), y(i));
endfor
plot(t, y);

% Método de Runge-Kutta de 4ª Ordem
f = @(t, y) -2*y + t;
h = 0.1;
t = 0:h:10;
y = zeros(size(t));
y(1) = 1;
for i = 1:length(t)-1
  k1 = h * f(t(i), y(i));
  k2 = h * f(t(i) + h/2, y(i) + k1/2);
  k3 = h * f(t(i) + h/2, y(i) + k2/2);
  k4 = h * f(t(i) + h, y(i) + k3);
  y(i+1) = y(i) + (k1 + 2*k2 + 2*k3 + k4) / 6;
endfor
plot(t, y);

% Análise de Dados

% Ajuste de Curvas
x = [1, 2, 3, 4, 5];
y = [2, 3, 5, 7, 11];
p = polyfit(x, y, 2); % Ajuste polinomial de grau 2
yfit = polyval(p, x);
plot(x, y, 'o', x, yfit, '-');

% Regressão Linear
X = [ones(length(x), 1) x(:)];
theta = (X' * X) \ (X' * y(:)); % Solução de mínimos quadrados
yfit = X * theta;
plot(x, y, 'o', x, yfit, '-');
