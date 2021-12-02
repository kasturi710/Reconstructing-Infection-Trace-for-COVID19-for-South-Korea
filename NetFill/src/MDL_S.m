function mdl_s = MDL_S(I, S, V)
% S buckets seed nodes
% I_i is the set of nodes we think is infected at time stamp i
% V is the total number of nodes in graph

% dimensions of S , I and V must match
assert(length(S) == length(I));
assert(length(I) == length(V));

% seed should be not null
if sum(S) <= 0
    S;
end
assert(sum(S) > 0);

% seed should be in infected set
seeds = find(S);
infected = find(I);

for s = seeds
    if length(find(infected == s)) <= 0
        s;
    end
    assert(length(find(infected == s)) > 0);
end


ntimesteps = length(S(:, 1));
mods = sum(S(1,:));
modv_minusi = length(V);

% mods < length v
assert(mods < modv_minusi);
mdl_s =  L_N(mods + 1) + log2nchoosek(modv_minusi, mods);
% add mdl score to time i = 1
for time = 2:ntimesteps
    mods = sum(S(time,:));
    modv_minusi = length(setdiff(find(V), find(I(time - 1, :))));
    mdl_s = mdl_s + L_N(mods + 1) + log2nchoosek(modv_minusi, mods);
end


end

