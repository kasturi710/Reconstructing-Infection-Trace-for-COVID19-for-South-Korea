function [SS XX] = seedGivenC( C, G, I, beta, D, p, singletons)
%Performs the seedGivenC algorithm in the paper
%   We assume C is complete and without errors
% C_i = set of nodes we think are infected at time stamp i
% G is the graph adjacency matrix
% I_i is the set of nodes we think are infected at time stamp i.

% Returns seed bucket set S.
% Modifies I because a node could be bumped from I_10 to I_2 (say)

% S = zeros(1, length(G(1,:)));
% S(1, [1400 1420]) = 1;

% graph may be disconnected
ntimestamps = length(I(:, 1));
nnodes = length(I(1, :));
infectedSample = find(I(1,:));
infectedSample = setdiff(infectedSample, singletons);
infectedCurrent = union(find(I(1,:)), find(C(1,:)));
infectedCurrent = setdiff(infectedCurrent, singletons);
infectedCorrected = find(C(1,:));
infectedCorrected = setdiff(infectedCorrected, singletons);

infectedSubgraph = G(infectedCurrent, infectedCurrent);

[M N] = graphconncomp(sparse(infectedSubgraph));


C_curr = zeros(M, nnodes);
sample_curr = zeros(M, nnodes);
maxcomp = -1;
value = 0;

%iterating over all the connected components
for i = 1:M
    subInfCorr = infectedCurrent(find(N == i));
    if length(find(N == 1)) > value
        maxcomp = i;

        value = length(find(N == 1));
    end
    for node = subInfCorr
        if find(infectedSample == node)
            sample_curr(i, node) = 1;
        else
            C_curr(i, node) = 1;
        end
    end
    
end
% disp("sample curr is")
% disp(sample_curr)
% disp("C curr is")
% disp(C_curr)
% wait=input("enter")

S = zeros(M, nnodes);
X = -1*ones(M, nnodes);


for i = 1:M
    infected = union(find(C_curr(i,:)), find(sample_curr(i, :)));
    nodesToReach = union(find(C_curr(i,:)), find(sample_curr(i, :))); % To  help with timestamps
%     disp("infected and nodes to reach is")
%     disp(infected)
%     disp(nodesToReach)
    mdl0 = Inf;
    if i == maxcomp
        maxcomp;
    end
%     disp("Calculating the seeds for component "+i)
    for j = 1:10000
        if ~isempty(union(infected, nodesToReach))
            seed = Netsleuth(infected, nodesToReach, G, beta);

            X(i,j) = seed;  
            S(i, seed) = 1;
            mdl1 = MDL(C_curr(i,:), G, sample_curr(i,:), S(i,:), p,beta);
            if mdl1 < mdl0
                mdl0 = mdl1;
                nodesToReach = setdiff(nodesToReach, seed);
                infected = setdiff(infected, seed);

                
            else
                X(i,j) = -1;
                S(i, seed) = 0;
                break;
            end
        else
            break;
        end
        
    end
    
    
end
if M > 1
    SS = sum(S);
    XX = [];
    for i = 1:M
        BB = X(i,:);
        XX = [XX BB(find(BB > 0))];
    end
else
    SS = S;
    XX = X(find(X > 0));
end
% disp("SSn is ")
% disp(SS)
% disp("XX: i . e Seed  is ")
% disp(XX)
end


% for time = 1:ntimestamps
%     nodesToReach = union(find(I(time, :)), find(C(time, :)));
%     infected = [];
%     for i = 1:time
%         infected = union(union(infected, find(I(i, :))), find(C(i, :)));
%     end
%     X = [];
%     mdl0 = Inf;
%     for i = 1:10000
%         s = Netsleuth(infected, nodesToReach, G , beta);
%         X = [X s];
%         %modify S and I for s
%         for k = time: ntimestamps
%             if I(k,s) == 0
%                 I(k,s) = 1;
%             else
%                 break;
%             end
%         end
%         S(time, s) = 1;
%         mdl1 = MDL(C, G, I, S, p,beta);
%         nodesToReach = setdiff(nodesToReach, s);
%         infected = setdiff(infected, s);
%         if mdl1 < mdl0
%             mdl0 = mdl1;
%         else
%             break;
%         end
%     end
% 
%  end
% 
