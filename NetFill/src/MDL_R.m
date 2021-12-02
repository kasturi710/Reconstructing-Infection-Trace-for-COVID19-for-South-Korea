function [tcost, tpath] = MDL_R(C, G, I ,S , beta)
%UNTITLED2 Summary of this function goes here
%   G is the graph in adjacency matrix
% I_i is the set of nodes we believe to be infected at time stamp i
% S_i is the seed nodes at time step i;
% What is ripple???? R is a ordering of the infected nodes in the order
% that we believe they were infected
% Works correctly

global MDL_MAX;
% the seed should not be empty
assert(~isempty(find(S(1,:))));

% seeds should be in infectedCurrent
seeds = find(S);
infectedCurrent = union(find(C), find(I));
for s = seeds
    assert(length(find(infectedCurrent == s)) > 0);
end
% c's sould be in I
assert(length(setdiff(find(C), find(I))) == 0);
% beta is a prob
assert(beta >=0 );
assert(beta <= 1);
cost_avg = 0;
% for i = 1:100
%     [cost, path, F_size, code_length] = MDL_Rip(G, union(find(I(1,:)), find(C(1,:))) , find(S(1,:)), beta);
%     
%     cost_avg = cost_avg + cost;
%     
% end
% cost = cost_avg/100;
% cost should be >= 0
[cost, path, F_size, code_length] = MDL_Rip(G, union(find(I(1,:)), find(C(1,:))) , find(S(1,:)), beta);
assert(cost >= 0);

% mdl_r = 0;
% path = [];
% Currently we are not executing the next loop
ntimestamps = length(S(:,1));
tpath = [];
tpath = [tpath path];
tcost = cost;
for time = 2:ntimestamps
    infected = [];
    for i = 1:time - 1
        infected = union(union(infected, find(S(i, :))), find(I(i, :)));
    end
    infected = union(infected, find(S(time, :)));
     [cost, path] = MDL_Ri(G, find(I(time, :)), infected);
     mdl_r = mdl_r + cost;
     tpath = [tpath path];
end

[b,m1,n1] = unique(tpath,'first');
[c1,d1] =sort(m1);
b = b(d1);
tpath = b;
end

