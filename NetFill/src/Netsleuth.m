function seedids = Netsleuth( infectedi,nodesToReach,G , beta)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
G = beta * G;

infected = union(infectedi, nodesToReach);


% full laplacian
L = diag(sum(G)) - G;
seedids = 0;
% take submatrix
A = G(infected, infected);
if length(infected) <= 1
    seedids = infected;
    return;
end


% % find local maximum
% M1 = (u * ones(1, length(u)))';
% M2 = (beta*eye(size(A)) + A);
% UA = M2 .* M1; %(eye(size(A)) + A) .* (u * ones(1, length(u)))'
% [~, IND] = max(UA, [], 2);
% 
% DIFF = IND - [1:length(A)]';
% seedids = infected(DIFF == 0);
DI = diag(sum(A));
factor_i = 1; %/sum(sum(A));
DI = factor_i * DI;


TD =  sum(G);
TD = diag(TD(infected));

DNI = TD - DI;

%factor = 1/nnotinfec;
factor = 1;
DNI = factor * DNI;

%in = find(infected == 23)
%DNI(in, in) = 0;
%DI(in, in)

LA = DNI + DI - A;
size(LA);
% find smallest eig 
[u, l] = eigs(LA, 1, 'SM');
u = abs(u);
l = abs(l);
u_copy = u;
ind = zeros(length(u),1);
for i=1:length(u)
    [val, ind(i)] = max(u_copy);
%	eq_ind = find(u_copy == val);
%	infected(eq_ind)
    u_copy(ind(i)) = -99;
	DNI(ind(i), ind(i));
	DI(ind(i), ind(i));
end
 
for i = 1:length(ind)
    ids = infected(ind(i));
    if ~isempty(find(unique(nodesToReach) == ids))
        seedids = ids;
        break;
    end
end





end

