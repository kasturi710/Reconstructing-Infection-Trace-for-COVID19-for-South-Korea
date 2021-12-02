function visualize_cnext(n, infected, S_curr1,S_curr2, file,missing, C_curr1, C_curr2, filename) 

% For the figure in the paper, do:
% T = load('OUTPUT/grid-.si-seeds-final-state.0.1.2.out');
% infected = find(T(T(1)+2:end));
% visualize_grid(60, infected, [1757, 1783], [1756, 1785], 'OUTPUT/grid-node-mapping')


X = [1:n];
Y = [1:n];

h = figure;
hold all;
axis off;

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
real_missing = nodeMap(missing);
Y_MISS = zeros(size(real_missing));
X_MISS = zeros(size(real_missing));
for i=1:length(real_missing)
		Y_MISS(i) = floor((real_missing(i)-1)/n);
		X_MISS(i) = real_missing(i) - Y_MISS(i)*n - 1;
end
% for i=0:n-1
% 		for j=0:n-1
%                 for k=1:length(real_inf)
%                     for t=1:length(real_missing)
%                         if ((i == X_INF(k) && j == Y_INF(k)) || (i == X_MISS(t) && j == Y_MISS(t)))
%                             flag = 0;
%                             break;
%                         end
%                     end
%                 end
%                 if (flag == 0)
%                     flag = 1;
%                     continue;
%                 end                    
% 				%plot(i, j, '.','Color',grey);
% 		end
% end

for i=1:length(real_inf)
		%y = floor((real_inf(i)-1)/n);
		%x = real_inf(i) - y*n - 1;
		%plot(x, y, '+', 'Color',grey);
        plot(X_INF(i), Y_INF(i), 'b.');
end

for i=1:length(S_curr1) 
		y = floor((S_curr1(i)-1)/n);
		x = S_curr1(i) - y*n - 1;
		%plot(x, y, 'or','MarkerFaceColor','r');
		plot(x, y, 'g+');
        pause;
end

for i=1:length(S_curr2) 
		y = floor((S_curr2(i)-1)/n);
		x = S_curr2(i) - y*n - 1;
		%plot(x, y, 'or','MarkerFaceColor','r');
		plot(x, y, 'r+');
        pause;
end

% for i=1:length(seed2)
% 		y = floor((seed2(i)-1)/n);
% 		x = seed2(i) - y*n - 1;
% 		%plot(x, y, 'sb','MarkerFaceColor','b');
% 		plot(x, y, 'g+');
% end
for i=1:length(real_missing)
		%y = floor((real_inf(i)-1)/n);
		%x = real_inf(i) - y*n - 1;
		%plot(x, y, '+', 'Color',grey);
        plot(X_MISS(i), Y_MISS(i), 'rs');
end
real_found = nodeMap(find(C_curr1));
Y_F = zeros(size(real_found));
X_F = zeros(size(real_found));

for i=1:length(real_found)
		Y_F(i) = floor((real_found(i)-1)/n);
		X_F(i) = real_found(i) - Y_F(i)*n - 1;
end


for i = 1:length(real_found)
    %plot(X_F(i), Y_F(i),'ko','MarkerFaceColor', 0.7*[1 1 1]);
    %pause;
end

real_found2 = nodeMap(C_curr2);
Y_F2 = zeros(size(real_found2));
X_F2 = zeros(size(real_found2));
% '--rs','LineWidth',2,...
%                        'MarkerEdgeColor','k',...
%                        'MarkerFaceColor','g',...
%                        'MarkerSize',10)
for i=1:length(real_found2)
		Y_F2(i) = floor((real_found2(i)-1)/n);
		X_F2(i) = real_found2(i) - Y_F2(i)*n - 1;
end
for i = 1:length(real_found2)
    plot(X_F2(i), Y_F2(i), 'kx','MarkerFaceColor',0.1*[1 1 1]);
    %pause;
end

end