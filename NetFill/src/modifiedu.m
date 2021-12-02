function [C_next u] = modifiedu(X, D, SD, S, C_curr, G, p)

S(1, X) = 0;
SD(1, X) = 0;
C_curr(1, X) = 0;
infectedSample = find(SD);
infectedCurrent = union(find(SD), find(C_curr));
infectedReal = find(D);
notInfected = setdiff(1:length(G), infectedSample);
missingNodes = setdiff(infectedReal, infectedSample);

% Calculate Laplacian submatrix of sampled data and current C
L = diag(sum(G)) - G;
LA = L(infectedCurrent, infectedCurrent);

% Eigenvector corresponding to smallest eigenvalue
if length(LA) == 1
    display('A')
end
[u l] = eigs(LA, 1, 'SM');
l = abs(l);
u = abs(u);

% Remove C_curr from u
for c = find(C_curr)
    u(find(infectedCurrent == c)) = 0;
end
% u_ind = find(u);
% u_mod = u(find(u));

u_mod = [];
for kk = 1:length(u)
    node = infectedCurrent(kk);
    if ~isempty(find(infectedSample == node))
        u_mod = [u_mod; u(kk)];
    end
end
% calculate top nodes
Z = G(notInfected, infectedSample);
[m1 n1] = size(u_mod);
[m2 n2] = size(Z);
if n2 ~= m1
    display('Error')
end
Score = Z*u_mod;
[sortedScore sortedIndex] = sort(Score, 'descend');
n1 = ceil(p*sum(SD));
C_next = notInfected(sortedIndex);
seeds = find(S);

%visualize_grid(60, infectedSample, seeds, 'grid-node-mapping', missingNodes, find(C_curr), 'frontier_C_curr_two_seed_u_1_96'); 
%visualize_grid(60, infectedSample, seeds, 'grid-node-mapping', missingNodes, C_next, 'frontier_C_next_two_seed_u_2_96'); 












% X = [1523];
% X = [1285 1523];
% X = [1285 1304 1523];
% X = [1285 1304 1523 1760];

end
