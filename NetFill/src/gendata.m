% Script to generate simulated data sets
    % A = importdata('grid_60.edgelist');
     grid = full(sparse(A(:,1), A(:,2),1));
     beta = 0.1;
graph = G;
deltats = 50;
betas = 0.09;
max_stepss = 50;
seed_nums = 1;
ps = 0.90;
for p = ps
    for seed_num = seed_nums
        for max_steps = max_stepss
            for beta = betas
                for deltat = deltats
                    [SD, D] = SISampling(graph, deltat, beta, max_steps, seed_num, p);
                    display('Sampling done once');
 %                   filename1 = ['grid_D_' num2str(deltat) '_' num2str(int8(beta*100)) '_' num2str(max_steps) '_' num2str(seed_num) '_' num2str(p) '.matrix' ];
 %                   filename2 = ['grid_Sd_' num2str(deltat) '_' num2str(int8(beta*100)) '_' num2str(max_steps) '_' num2str(seed_num) '_' num2str(p) '.matrix' ];
 %                   dlmwrite(filename1,D);
 %                   dlmwrite(filename2,SD);
                end
            end
        end
    end
end
visualize_grid(60, find(SD), [1755 1785], 'grid-node-mapping', find(D - SD), [], 'Grid_two_seed_SI')