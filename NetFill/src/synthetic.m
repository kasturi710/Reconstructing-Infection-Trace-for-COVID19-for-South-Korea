%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Real graph synthetic data
% initialize parameters
beta = 0.1;
nseeds = 1;
max_steps = 25;



% Load edgelist
E = data;
G = sparse([E(:,1); E(:,2)], [E(:,2) E(:,1)], 1);
G(G > 1) = 1;
%assert(G == G');

% Find seeds
seed = find(sum(G) == max(sum(G)), 1);

% Simulate SI
N = length(G); % number of nodes
%S_1 = randperm(N, seed_num); % Initialize random seeds. These seeds are unique and seed_num in number.
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

D = sum(isInfected);
D(D > 1) = 1;
display(['Nodes = ' num2str(N) ' infected = 'num2str(sum(D))]);