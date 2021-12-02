function [cost, path, F_size, code_length] = MDL_Rip(G, infected, seeds, beta)

N = length(G);
NI = length(infected);
NS = length(seeds);

% first find the frontier set
F = frontier_set(G, seeds);
AD = sum(G(F, seeds), 2); % Attack degree of every node
asum = sum(AD);

factor = 1;

cost_path = 0.0;

path = seeds';
l = NS;
F_size = zeros(NI-l, 1);
code_length = zeros(NI-l, 1);
k = 0;
max_g_deg = max(sum(G, 2));
tries = zeros(max_g_deg, 1);

while l < NI
	k = k + 1;
	if k > 100
			display 'here'
			pause
	end
	
	max_ad = max(AD);

	patients = [];
	for j = 1:max_ad
			ind_ad = find(AD == j);
			if length(ind_ad) == 0
					continue;
			end
			a_beta = 1-(1-beta)^j;

			[nodes_inf_ad iF iI] = intersect(F(ind_ad), infected);

			tries(j) = floor(tries(j) + length(ind_ad)/(factor*beta));

			v = (tries(j) + 1) * a_beta;

			b_mode = floor(v);
		
			if b_mode == 0
		%			continue;
			display 'here'
			pause
			end
			if b_mode > length(iF) 
					% there aren't enough eventually infected nodes
					% just send max
					%pro = binopdf(length(iF), tries(j), a_beta); 
					pro = binopdf(length(iF), length(ind_ad), a_beta); 
					cost_path = cost_path - log2(pro) + log2nchoosek(length(ind_ad), length(iF));
					if length(nodes_inf_ad) > 0
							patients = [patients nodes_inf_ad];
					end
			else
					% send the mode
					pro = binopdf(b_mode, length(ind_ad), a_beta); 
					cost_path = cost_path - log2(pro) + log2nchosek(length(ind_ad), b_mode);
					% randomly choose b_mode patients from nodes_inf_ad
					temp_ind = randsample(length(nodes_inf_ad), b_mode);
					temp = nodes_inf_ad(temp_ind);
					patients = [patients temp];
			end
	
	end


	path = [path patients];
	l = l + length(patients);
	r = frontier_set(G, patients);
	F = [F, r];
	F = unique(F);
	F = setdiff(F, path);
	AD = sum(G(F, path), 2);
%	asum = sum(AD);

	% reset tries
	tries = zeros(max_g_deg, 1);
%	pause
end
cost = mdl_l_n_code(k) + cost_seeds + cost_path;

end