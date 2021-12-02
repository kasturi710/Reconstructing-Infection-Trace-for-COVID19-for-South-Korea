function visualize_grid(n, infected, seed1, file, missing, missingFound, filename) 

% For the figure in the paper, do:
% T = load('OUTPUT/grid-.si-seeds-final-state.0.1.2.out');
% infected = find(T(T(1)+2:end));
% visualize_grid(60, infected, [1757, 1783], [1756, 1785], 'OUTPUT/grid-node-mapping')


X = [1:n];
Y = [1:n];

h = figure;
hold all;
axis off;
good = intersect(missing, missingFound);
notFound = setdiff(missing, missingFound);
fp = setdiff(missingFound, missing);
grey = [0.4 0.4 0.4];

cnodeMap = load(file);
nodeMap = zeros(size(cnodeMap, 1), 1);
nodeMap(cnodeMap(:, 2)+1) = cnodeMap(:, 1);
real_inf = nodeMap(infected);
Y_INF = zeros(size(real_inf));
X_INF = zeros(size(real_inf));

for i=1:length(real_inf)
		Y_INF(i) = floor((real_inf(i)-1)/n);
		X_INF(i) = real_inf(i) - Y_INF(i)*n - 1;
end

flag = 1;
% For infected and missing nodes
good = nodeMap(good);
Y_GOOD = zeros(size(good));
X_GOOD = zeros(size(good));
for i=1:length(good)
		Y_GOOD(i) = floor((good(i)-1)/n);
		X_GOOD(i) = good(i) - Y_GOOD(i)*n - 1;
end
for i=0:n-1
		for j=0:n-1
                for k=1:length(real_inf)
                    for t=1:length(good)
                        if ((i == X_INF(k) && j == Y_INF(k)) || (i == X_GOOD(t) && j == Y_GOOD(t)))
                            flag = 0;
                            break;
                        end
                    end
                end
                if (flag == 0)
                    flag = 1;
                    continue;
                end                    
				plot(i, j, '.','Color',grey);
		end
end

for i=1:length(real_inf)
		%y = floor((real_inf(i)-1)/n);
		%x = real_inf(i) - y*n - 1;
		%plot(x, y, '+', 'Color',grey);
        plot(X_INF(i), Y_INF(i), 'o', 'Color', grey);
end

for i=1:length(seed1) 
		y = floor((seed1(i)-1)/n);
		x = seed1(i) - y*n - 1;
		%plot(x, y, 'or','MarkerFaceColor','r');
		plot(x, y, 'g+');
end

% for i=1:length(seed2)
% 		y = floor((seed2(i)-1)/n);
% 		x = seed2(i) - y*n - 1;
% 		%plot(x, y, 'sb','MarkerFaceColor','b');
% 		plot(x, y, 'g+');
% end
for i=1:length(good)
		%y = floor((real_inf(i)-1)/n);
		%x = real_inf(i) - y*n - 1;
		%plot(x, y, '+', 'Color',grey);
        plot(X_GOOD(i), Y_GOOD(i), 'ro');
end
notFound = nodeMap(notFound);
Y_NF = zeros(size(notFound));
X_NF = zeros(size(notFound));
for i=1:length(notFound)
		Y_NF(i) = floor((notFound(i)-1)/n);
		X_NF(i) = notFound(i) - Y_NF(i)*n - 1;
end
for i = 1:length(notFound)
    plot(X_NF(i), Y_NF(i), 'yo');
    %pause;
end

fp = nodeMap(fp);
Y_FP = zeros(size(fp));
X_FP = zeros(size(fp));
for i=1:length(fp)
		Y_FP(i) = floor((fp(i)-1)/n);
		X_FP(i) = fp(i) - Y_FP(i)*n - 1;
end
for i = 1:length(fp)
    plot(X_FP(i), Y_FP(i), 'co');
    %pause;
end
title(filename);
legend('green "+": seeds', 'cyan: false-positives', 'red: correct', 'yellow: false-negatives');
%print(h, '-djpeg', 'infected-grid.jpg');
print(h, 'infected-grid.fig');
print(h, '-dpdf', [filename '.pdf']);
print(h, '-depsc2', [filename '.eps']);
