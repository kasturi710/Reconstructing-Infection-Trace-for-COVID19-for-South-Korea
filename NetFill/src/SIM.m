function C = SIM(G, I, S, beta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
noOfInfected = sum(I);

reached = sum(S);
graph = G;
N = length(graph);
time = 1;
isInfected = [];
isInfected(1,:) = S;
while length(setdiff(find(I), find(isInfected(time,:)))) > 0.05*sum(I)
    time = time + 1
    % simple SI iteration \reminder{Check definition of D and p}
    isInfected(time, :) = isInfected(time - 1, :); % copy infection states from previous time stamps
    for node = 1:N % For every node in graph
        if isInfected(time,node) == 1 % If node is infected 
            for neighbour = 1:N % Consider adjacency matrix row node
                if graph(node, neighbour) == 1 % node and neighbour are neighbours
                    if isInfected(time, neighbour) == 0 % If neighbour is not previously infected
                        if rand() <= beta % If coin toss with prob = beta has a success
                            isInfected(time,neighbour) = 1;
                            reached = reached + 1;
                            % display(['Node ' num2str(neighbour) ' got infected at time stamp ' num2str(time)])
                        end
                    end
                end
            end
        end
    end   
end

C = zeros(1,length(graph(1,:)));
candidates = setdiff(find(isInfected(time,:)),find(I(1,:)));
C(1,candidates) = 1;
end

