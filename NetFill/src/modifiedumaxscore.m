function C_next = modifiedumaxscore(Y, D, SD, S, C_curr, G, p)

nu = length(Y);
C_next = [];
ninfected = length(union(find(SD + S), find(C_curr)));
u = zeros(nu, ninfected);
if ~isempty(setdiff(find(SD), union(find(S), find(C_curr))))
    [C_next1 u(1,:)] = modifiedu([], D, SD + S, S, C_curr, G, p);
else
%    display('What??')
    u(1,:) = zeros(1, length(ninfected));
    C_next = union(C_next, C_curr);
end

if nu >= 1
    Y;
end
for i = 1:nu - 1
    if ~isempty(setdiff(find(SD), union(find(S), find(C_curr))))
        [C_next2 b] = modifiedu(Y(1:i), D, SD + S, S, C_curr, G, p);
        infectedCurrent = union(find(SD + S), find(C_curr));
        s = [];
        unew = b;
        for j = 1:i
            s(j) = find(infectedCurrent == Y(j)); 
            unew = [ unew(1:s(j) - 1); 0; unew(s(j):end) ];
        end
        u(i + 1,:) = (unew');
    else
%        display('Whhat2??')
        u(i + 1,:) = zeros(1, length(ninfected));
        C_next = union(C_next, C_curr,'stable');
    end
    
end
%u_avg = (u(1,:) - u(2,:)).*(u(1,:) - u(2,:));


infectedSample = find(SD);
infectedCurrent = union(find(SD + S), find(C_curr));
infectedReal = find(D);
notInfected = setdiff([1:length(G)], infectedSample);
missingNodes = setdiff(infectedReal, infectedSample);
k = 1;
u_new = [];
for i = 1: ninfected
    if find(infectedSample == infectedCurrent(i))
        u_new(k,:) = u(:, i)';
        k = k + 1;
    end
end

%u_ind = find(u_avg);
%u_mod = u(find(u_avg));
% calculate top nodes
Z = G(notInfected, infectedSample);
Score = max(Z*(u_new), [], 2);




[sortedScore sortedIndex] = sort(Score, 'descend');
%n1 = ceil((1 - p)*sum(SD)/p);
n1 = 74;
C_next = notInfected(sortedIndex);
%display('READ THIS')
% for i = 1:length(C_next)
%     %SD(1, C_next(i)) = 1;
%     C = zeros(1, length(SD));
%     C(C_next(1:i)) = 1;
%     [MDLSCORE, tpath] = MDL(C, G, SD, S,p, 0.1);
%     display(num2str(MDLSCORE))
% end
%display('TILL HERE')
%C_nextnew = union(C_next1(1:floor(n1)), C_next2(1:floor(n2)));
seeds = find(S);

%visualize_grid(60, infectedSample, seeds, 'grid-node-mapping', missingNodes, find(C_curr), 'frontier_C_curr_two_seed_u_1_96'); 
%visualize_grid(60, infectedSample, seeds, 'grid-node-mapping', missingNodes, C_next, 'test'); 



end