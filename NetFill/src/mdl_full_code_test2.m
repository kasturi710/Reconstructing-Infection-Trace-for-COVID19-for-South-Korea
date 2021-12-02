function [cost, path, F_size, code_length] = mdl_full_code_test2(G, infected, seeds, beta)

N = length(G);
NI = length(infected);
NS = length(seeds);

cost_seeds = mdl_l_n_code(NS);

cost_seeds = cost_seeds + find_log_combination(N, NS);

% first find the frontier set
F = frontier_set(G, seeds);
AD = sum(G(F, seeds), 2);
asum = sum(AD);

%[u factor] = eigs(G, 1, 'LM');
%factor = (abs(factor))/N;
factor = 1;

%cost_path = mdl_l_n_code(NI);
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
			%{
			display 'length of ind_ad is'
			size(length(ind_ad))
			size(infected)
			size(F)
			F(ind_ad)
			ind_ad
			%}

			[nodes_inf_ad iF iI] = intersect(F(ind_ad), infected);

			%{
			display 'size of nodes_inf_ad is'
			size(nodes_inf_ad)
			nodes_inf_ad
			pause
			%}
			% set the number of tries
			tries(j) = floor(tries(j) + length(ind_ad)/(factor*beta));

			%tries(j)
			% mode of the binomial
			%v = (length(ind_ad) + 1) * a_beta;
			%v = (length(ind_ad)) * a_beta;
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
					cost_path = cost_path - log2(pro) + find_log_combination(length(ind_ad), length(iF));
					if length(nodes_inf_ad) > 0
							patients = [patients nodes_inf_ad];
					end
			else
					% send the mode
					pro = binopdf(b_mode, length(ind_ad), a_beta); 
					cost_path = cost_path - log2(pro) + find_log_combination(length(ind_ad), b_mode);
					% randomly choose b_mode patients from nodes_inf_ad
					temp_ind = randsample(length(nodes_inf_ad), b_mode);
					temp = nodes_inf_ad(temp_ind);
					patients = [patients temp];
			end
	%{		
	if isinf(cost_path) || size(path,1) ~= 1
			% no new node got infected
			b_mode
			tries(j)
			pro
			length(iF)
			length(ind_ad)
			%patients
			path
			
			pause
			continue;
			end
	%}		
	end
	%[max_a temp] = max(AD(iF));
	%a_vec = find(AD(iF) == max_a);
	%temp = a_vec(randsample(length(a_vec), 1));
	%patient = F(iF(temp));
	%path = [path patient];
	%l = l + 1;

%	cost_path = cost_path - log2(max_a / asum);
	%F_size(k) = length(a_vec);
%	code_length(k) = -log2(max_a/asum);
	%AP = AD/asum;
	%cost_path = cost_path - ( log2(max_a/asum) + sum(log2( 1 - AP )) - log2(1 - (max_a/asum)) ); 
%	cost_path = cost_path - log2(1 / length(a_vec));

	% now fix the frontier set and AD
	%r = G(patients, :);
	%[F(1:temp-1) F(temp+1:end)];

%	if length(patients) == 0
%	if size(path, 2) ~= 1
%			path
%			patients
%			length(path) - NI
%			pause
%continue;
%	end

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
%{
figure;
plot(F_size);
print('-djpeg', 'simialr_nodes_number.jpg');
close;
figure;
plot(code_length);
print('-djpeg', 'prob_per_step.jpg');
close;
%}
