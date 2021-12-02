function [cost, path] = MDL_Ri(G, infected, seeds)
%UNTITLED3 Summary of this function goes here
% G is the graph G(V, E)
% infected is the set of nodes that we want to infect by the ripple.
% seeds are the set of seeds in the graph.
% Works perfectly
N = length(G);
NI = length(infected);
NS = length(seeds);
seeds = seeds';
cost = 0;
%cost_seeds = mdl_l_n_code(NS);

%cost_seeds = cost_seeds + find_log_combination(N, NS);

% first find the frontier set
F = frontier_set(G, seeds);
AD = sum(G(F, seeds), 2);
asum = sum(AD);

%cost_path = mdl_l_n_code(NI);
cost_path = 0;
path = seeds';
l = NS;
zz = 0;
while l < NI
		%F 
		%infected
	[nodes_inf_frontier iF iI] = intersect(F, infected);
	[max_a temp] = max(AD(iF));
    % construct infected graph and get eig
%     LA = diag(sum(G(infected, infected))) - G(infected, infected) ;
%     lambda = eig(LA);
%     lambda(1:5)
    
    % iF there is no intersection?
	a_vec = find(AD(iF) == max_a);
%    try
        temp = a_vec(randsample(length(a_vec), 1));
%     catch exception
%         zz;
%         zz = zz + 1;
%         cost;
%     end
	patient = F(iF(temp));
	path = [path patient];
	l = l + 1;

	cost_path = cost_path - log2(max_a / asum);
    if cost_path > 0
        cost  = cost + cost_path;
    end

	% now fix the frontier set and AD
	r = G(patient, :);
	%[F(1:temp-1) F(temp+1:end)];
	F = [F, setdiff(find(r), path)];
	F = unique(F);
	F = setdiff(F, path);
	AD = sum(G(F, path), 2);
	asum = sum(AD);
end


end

