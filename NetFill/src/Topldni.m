function  C = Topldni(G, I, S, beta, expected )

nnodes = length(G);
C = zeros(1, nnodes);
%expected = sum(I)*(1 - p)/p;

infected = union(find(I), find(S));
notInfected = setdiff(1:nnodes, infected);

dni = full(sum(G(notInfected, infected), 2));

[sorteddni ind] = sort(dni, 'descend');

Cn = notInfected(ind(1:floor(expected)));

C(Cn) = 1;


end
