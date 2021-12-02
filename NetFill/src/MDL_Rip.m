function [cost, path, F_size, code_length] = MDL_Rip(G, infected, seeds, beta)

N = length(G);
NI = length(infected);
NS = length(seeds);

% not null seeds
assert(length(seeds) > 0);

% not null infected
assert(length(infected) > 0);

% seeds should be in infected set
assert(length(setdiff(seeds, infected)) == 0);
% beta is a prob
assert(beta >= 0 );
assert(beta <= 1);
% first find the frontier set
F = frontier_set(G, seeds);

% not null frontier set
assert(length(F) > 0);

AD = sum(G(F, seeds), 2); % Attack degree of every node
asum = sum(AD);

factor = 1;

cost_path = 0.0;

path = seeds;
l = NS;
F_size = zeros(NI-l, 1);
code_length = zeros(NI-l, 1);
k = 0;
max_g_deg = max(sum(G, 2));
tries = zeros(max_g_deg, 1);
flag = 0;

while l < NI
	k = k + 1;
    k;
    l - NI;
	if k > 1000
			k
			pause
	end
	if mod(k,100) == 0
        l - NI;
    end
	max_ad = max(AD);
    %display(['k = ' num2str(k) ' AD max = ' num2str(max_ad) ' number of infected ' num2str(l)])
	patients = [];
	for j = 1:max_ad
			ind_ad = find(AD == j);
			if length(ind_ad) == 0
					continue;
            end
            if k == 2 && j == 1
                %display('Hello')
            end
			a_beta = 1-(1-beta)^j;

			[nodes_inf_ad iF iI] = intersect(F(ind_ad), infected);
			%tries(j) = floor(tries(j) + length(ind_ad)/(factor*beta));
            tries(j) = floor(tries(j) + length(ind_ad)/beta);
			v = (tries(j) + 1) * a_beta;

			b_mode = floor(v);
		
			if b_mode == 0
		%			continue;
			   %display 'here'
			   %pause
               b_mode = 1;
			end
			if b_mode > length(iF) 
					% there aren't enough eventually infected nodes
					% just send max
					%pro = binopdf(length(iF), tries(j), a_beta); 
					pro = L_P(length(ind_ad),length(iF), a_beta); 
                    md = length(iF);
                    fd = length(ind_ad);
					%cost_path = cost_path + pro + log2nchoosek(length(ind_ad), length(iF));
                    if md/fd == 0 
                        cost_path = cost_path + pro - (fd - md)*log2(1 - md/fd); 
                    elseif md/fd == 1
                            cost_path = cost_path + pro - md*log2(md/fd); 
                    else
                        cost_path = cost_path + pro - md*log2(md/fd) - (fd - md)*log2(1 - md/fd); 
                    end
                    
                   
                    
					if length(nodes_inf_ad) > 0
					    patients = [patients nodes_inf_ad];
                    end
            
                    if ~isfinite(cost_path)
                        assert(isfinite(cost_path));
                    end
                    %display(['1.With attack degree ' num2str(j) ' f = ' num2str(length(iF)) ' choose = ' num2str(length(nodes_inf_ad))]);
			else
					% send the mode
					pro = L_P(length(ind_ad), b_mode, a_beta); 
                    md = b_mode;
                    fd = length(ind_ad);
					%cost_path = cost_path + pro + log2nchoosek(length(ind_ad), b_mode);
                    if md/fd == 0 
                        cost_path = cost_path + pro - (fd - md)*log2(1 - md/fd); 
                    elseif md/fd == 1
                            cost_path = cost_path + pro - md*log2(md/fd); 
                    else
                        cost_path = cost_path + pro - md*log2(md/fd) - (fd - md)*log2(1 - md/fd); 
                    end
					% randomly choose b_mode patients from nodes_inf_ad
                    if cost_path == Inf
                        display('O');
                    end
					temp_ind = randsample(length(nodes_inf_ad), b_mode);
					temp = nodes_inf_ad(temp_ind);
					patients = [patients temp];
                    if ~isfinite(cost_path)
                        display('H');
                    end
                    assert(isfinite(cost_path));
                    %display(['2.With attack degree ' num2str(j) ' f = ' num2str(length(iF)) ' choose = ' num2str(length(temp))]);
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
    if ~isempty(find(path == 175)) && flag == 0
        k;
        flag = 1;
    end
%	pause
end
cost =  cost_path;

end