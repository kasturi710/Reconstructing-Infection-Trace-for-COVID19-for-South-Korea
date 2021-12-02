function [SD, D] = SISampling(graph, deltat, beta, max_steps, seed_num, p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D is a set of buckets D_i
% deltat is the time difference t_1 - t_0
% beta is the infection probability
% Graph is G(V, E) adjacency matrix undirected and unweighted
% max_steps is the number of iterations in the graph
% seed_num is the number of seeds \reminder{All seeds in S_0}
% p is the probability of sampling \reminder{What is p?}
% Note time counting starts at 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize variables
N = length(graph); % number of nodes
S_1 = randperm(N, seed_num); % Initialize random seeds. These seeds are unique and seed_num in number.
isInfected = -1*ones(max_steps, N); % Stores infection states at every time stamp
isInfected(1,:) = zeros(1,N);
isInfected(1,S_1) = 1;
% correct upto here

% Simulate the SI model
for time = 2:max_steps % iterate over simulation time
    % simple SI iteration \reminder{Check definition of D and p}
    isInfected(time, :) = isInfected(time - 1, :); % copy infection states from previous time stamps
    for node = 1:N % For every node in graph
        if isInfected(time,node) == 1 % If node is infected 
            for neighbour = 1:N % Consider adjacency matrix row node
                if graph(node, neighbour) == 1 % node and neighbour are neighbours
                    if isInfected(time, neighbour) == 0 % If neighbour is not previously infected
                        if rand() <= beta % If coin toss with prob = beta has a success
                            isInfected(time,neighbour) = 1;
                            % display(['Node ' num2str(neighbour) ' got infected at time stamp ' num2str(time)])
                        end
                    end
                end
            end
        end
    end
    
end

% Sample D. p% of the whole infection at deltat intervals
sampledInfected = zeros(floor(max_steps/deltat), N);
for time = 1:max_steps
    if mod(time, deltat) == 0 % sample at every deltat times
        infectedInd = find(isInfected(time, :));
        len = length(infectedInd);
        toDisInfect = rand(1,len);
        sample = infectedInd(toDisInfect <= p);
        infectedInd(1,sample) = 0;
        removeInfected = nonzeros(infectedInd);
        sampledInfected((time)/deltat, removeInfected) = 1;
        if time == max_steps
            display('s');
        end
    end
end
SD = zeros(size(sampledInfected));
length(sampledInfected)
SD(1,:) = sampledInfected(1,:);
for node = 1:N
    for time = 2:length(sampledInfected(:,1))
        if sum(SD(1:time - 1,node)) == 0
            SD(time, node) = sampledInfected(time, node);
        else
            SD(time, node) = 1;
        end
    end
end

deltatD = zeros(floor(max_steps/deltat), N);
for time = 1:max_steps
    if mod(time , deltat) == 0 % sample at every deltat times
        deltatD(((time)/deltat),:) = isInfected(time,:);
    end
end
D = zeros(size(deltatD));
D(1,:) = deltatD(1,:);
for node = 1:N
    for time = 2:length(deltatD(:,1))
        if sum(D(1:time - 1,node)) == 0
            D(time, node) = deltatD(time, node);
        else
            D(time, node) = 1;
        end
    end
end


% 
% % for time = 1:max_steps
% %     SD(time, unsampled) = 0;
% % end

end