
%gendata
% for one snapshot
[M N] = graphconncomp(sparse(grid(find(SD(1,:)), find(SD(1,:)))));
max = 0;
comp = 0;
for i = 1:M
    if length(find(N == i)) > max
        max = length(find(N == i));
        comp = i;
    end
end
SDnew = zeros(1,length(SD(1,:)));
x = find(SD(1,:));

SDnew(1, x(find(N == comp))) = 1;
display('The number of infected nodes in the snapshot are')
sum(SDnew)
missingNodes = find((D(1,:) - SD(1,:)));
display('No of missing Nodes');
length(missingNodes)
ps = 0.95;
SD = SDnew;
kkk = length(SD(:,1));
sizeofgraph = sqrt(length(grid(:,1)));
[ S, C, R, I , Y] = complete( SD(1,:), beta, grid, missingNodes, 1 - ps);
% coordinates = zeros(3600, 2);
% k = 1;
% for j = 1:sizeofgraph
%     for i = 1:sizeofgraph
%         coordinates(k,:) = [j i];
%         k = k + 1;
%     end
% end
% %display('The culprits found were :')
%coordinates(find(S), :)
%display('The missing nodes were')
%coordinates(find(C), :)
display(['The # of nodes missed were ' num2str(length(setdiff(missingNodes, find(C))))]);
visualize_grid(60, find(SD(1,:)), find(S(1,:)), 'grid-node-mapping', missingNodes, Y);
