function [node can] = findBestNode( seeds, toinfect,X, G, beta, missing)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
G = beta * G;
infected = union(seeds, toinfect);
% full laplacian
L = diag(sum(G)) - G;
% take submatrix
LA = L(infected, infected);
A = G(infected, infected);

% find smallest eig 
[u, l] = eigs(LA, 1, 'SM');
u = abs(u);
l = abs(l);

% find optimal z^T
value = 0;
max_u = -1;
V = ones(1, length(G(1,:)));
notInfected = setdiff(find(V), infected);

coordinates = zeros(3600, 2);
k = 1;
for j = 1:60
    for i = 1:60
        coordinates(k,:) = [j i];
        k = k + 1;
    end
end

for n = notInfected
    z = G(n, infected);
    if z*u > value && length(find(X == n)) == 0 
        value = z*u;
        max_u = n;
    end
end
Z = G(notInfected, infected);
can = Z*u;
if max_u <= 0
%    display('l')
    node  = max_u;
    return
end
%display(['Node ' num2str(max_u) ' coordintes ' num2str(coordinates(max_u,2)) ' ' num2str(coordinates(max_u,1))]);

node = max_u;
% for n = notInfected
%     d_n_i = sum(G(n, infected));
%     if d_n_i > value && length(find(X == n)) == 0
%         max_u = n;
%         value = d_n_i;
%     end
% end
% node = max_u;
end

