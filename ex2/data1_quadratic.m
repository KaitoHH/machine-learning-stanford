data = load('ex2data1.txt');
X = data(:, [1, 2]); y = data(:, 3);

[m, n] = size(X);
X = [ones(m,1), X, X(: ,1) .^ 2, X(: ,2) .^ 2, X(:, 1) .* X(:, 2)];
initial_theta = zeros(n + 4, 1);

options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

plotData(X(:,2:3), y);

hold on;
%% ============== Draw Contour ==============
u = linspace(30, 100, 100);
v = linspace(30, 100, 100);

z = zeros(length(u), length(v));
% Evaluate z = theta*x over the grid
for i = 1:length(u)
    for j = 1:length(v)
        z(i,j) = [1, u(i), v(j), u(i)^2, v(j)^2, u(i)*v(j)]*theta;
    end
end
z = z';
contour(u, v, z, [0, 0], 'LineWidth', 2)
%% ============== Draw Contour Finished ==============
xlabel('Exam 1 score')
ylabel('Exam 2 score')
hold off;
