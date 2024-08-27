% Definindo os valores positivos exatamente representáveis
representaveis = [0.3125, 0.375, 0.4375, 0.5, 0.5625, 0.625, 0.6875, 0.75, ...
                   0.875, 1.0, 1.125, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, ...
                   2.75, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 7.5];

% Criando a figura
figure;

% Plotando os pontos representáveis na reta com cor vermelha
plot(representaveis, zeros(size(representaveis)), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
hold on;

% Ajustando os limites dos eixos
xlim([0 8]);
ylim([-0.1 0.1]);

% Adicionando grid e labels
grid on;
xlabel('Valores Positivos Exatamente Representáveis');
ylabel('Posição na Reta');
title('Representação dos Números Positivos Exatamente Representáveis com a zona de overflow e underflow (rosa)');

% Adicionando uma linha horizontal verde
line([0 8], [0 0], 'Color', 'g', 'LineWidth', 1);

% Região de Underflow (valores menores que 0.5) em rosa
fill([0, 0.5, 0.5, 0], [-0.1, -0.1, 0.1, 0.1], 'm', 'FaceAlpha', 0.2, 'EdgeColor', 'none');

% Região de Overflow (valores maiores que 7.5) em azul
fill([7.5, 8, 8, 7.5], [-0.1, -0.1, 0.1, 0.1], 'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none');

% Exibindo a figura
hold off;

