function F = frontier_set(G, infected)

F = [];
for i=1:length(infected)
		r = G(infected(i), :);
        F = [F, setdiff(find(r), infected)];
end
F = unique(F);
