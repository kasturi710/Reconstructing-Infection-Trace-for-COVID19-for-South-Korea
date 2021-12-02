%DEMO of NetFill and Top-l-dni for grid-disc (3600 node grid disconnected see figure in paper)

% Load all the data
load('../sample-data/grid-disc-korea-118.mat');

% Set all the variables
G = grid; %# Graph

beta = 0.1; %# infection probability
p = 0.9; %# Probability of sampling
bulk = 10; %# To make mdl smoother
missing = find(D - SD); %# True missing

% disp('The value of D is')
% disp(D)
% disp('The value of SD is')
% disp(SD)
% x=input('wait')
% disp(missing)
% x=input('wait')
% Run NetFill
[ S_netfill, C_netfill, R, I, singletonset] = complete( SD, beta, G, missing, p, bulk);

% Visualize the result
% S = seeds
% R = ripple
% SD = sampled data
% D = complete data
% 
disp("I is")
disp(I)
missingFound = find(C_netfill); %# missing nodes by NetFill
disp("missing nodes is")
disp(missingFound)
seeds = find(S_netfill);
infected = find(SD);
file = 'grid-node-mapping.txt';

visualize_grid(60, infected, seeds, file, missing, missingFound, '../output/grid-disconnected-NetFill')
% Running for Top-l-dni
S = zeros(1, length(G));
expected = sum(C_netfill);
C_topl = Topldni(G, SD, S, beta, expected );
singletons = [];
[SS XX] = seedGivenC( C_topl, G, SD, beta, SD, p, singletons);

S_topl = zeros(1, length(G));
S_topl(XX) = 1;

missingFound = find(C_topl); %# missing nodes by Top-l-dni
seeds = find(S_topl);
infected = find(SD);
file = 'grid-node-mapping.txt';

visualize_grid(60, infected, seeds, file, missing, missingFound, '../output/grid-disconnected-Top-l-dni');
exit;
