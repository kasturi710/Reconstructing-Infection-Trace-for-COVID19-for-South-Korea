% name1 = meme8_100_edgelist_2;
% name2 = meme8_100_inf_2;
edgelist = name1;
infectedNodes = name2;
clear name1;
clear name2;
m = max(edgelist(:,1));
n = max(edgelist(:,2));
G = sparse(zeros(max(m,n), max(m,n)));
p = 0.7;
for i = 1:length(edgelist)
    G(edgelist(i,1), edgelist(i,2)) = 1;
    G(edgelist(i,2), edgelist(i,1)) = 1;
end

%G(edgelist(:,1), edgelist(:,2)) = 1;
[M N] = graphconncomp(G);
value = 0;
max_comp = -1;
for i = 1:M
    if length(find(N == i)) > value
        value = length(find(N == i));
        max_comp = i;
    end
end
infected_GCC = [];
for i = 1:length(infectedNodes)
    if N(infectedNodes(i)) == max_comp
        infected_GCC = [infected_GCC infectedNodes(i)];
    end
end

infectedSubgraph = sparse(G(infected_GCC, infected_GCC));
prunedInfected = infected_GCC;
% for i = 1:length(infected_GCC)
%     d_n_i = sum(G(infected_GCC(i), infected_GCC));
%     if d_n_i > 0
%         prunedInfected = [prunedInfected infected_GCC(i)];
%     end
% end
D = zeros(1, length(G(1,:)));
%infected_GCC = unique(infected_GCC);

[Z V] = graphconncomp(G(prunedInfected, prunedInfected));

prunedInfectedGiant = prunedInfected(find(V == 1));
pruned2InfectedGiant = [];
for i = 1:length(prunedInfectedGiant)
    d_n_i = sum(G(prunedInfectedGiant(i), prunedInfectedGiant));
    if d_n_i > 2
        pruned2InfectedGiant = [pruned2InfectedGiant prunedInfectedGiant(i)];
    end
end


D(1, pruned2InfectedGiant) = 1;
SD = D;
prb = rand(1, length(G(1,:)));
for i = 1:length(prb)
if prb(1,i) > p
SD(1, i) = 0;
end
end

%[ S, C, R, I] = complete( SD, 0.1, G, find(D - SD), p);