function C = initializeC(D, G)
% returns the frontier set of every D in C
%  D is the set of buckets cummulative
% D is the adjacency matrix
% This code works correctly.
% C_i is a bucket of frontier sets of D_i at every time stamp i
ntimestamps = length(D(:, 1));

nnodes = length(G(:, 1));

C = zeros(ntimestamps, nnodes);
for time = 1:ntimestamps
    X = frontier_set(G, find(D(time, :)));
    C(time, X) = 1;
    for c = X
        for k = time:ntimestamps
            if D(k, c) == 0
                C(k, c) = 1;
            else
                break
            end
        end
    end
end
% nnodes = length(G);
% infectedSample = find(D);
% notInfected = setdiff([1:length(G)], infectedSample );
% B = G(notInfected, infectedSample);
% infectedDegrees = sum(B,2); % infected degrees of notInfected
% 
% [sortedInfectedDegrees sortedIndex] = sort(infectedDegrees, 'descend');
% 
% C = zeros(1, nnodes);
% C(1, notInfected(sortedIndex(1:96))) = 1;
end

%     for i = 1:10
%     [ S, C, R, I] = complete( SD, i/10, G, find(D - SD), 0.8);
%     aa = length(setdiff(find(C), find(D - SD)));
%     bb = sum(C);
%     dd = ['beta = ' num2str(i/10) ' |C| = ' num2str(bb) ' incorrect ' num2str(aa)];
%     display(dd);
%     end