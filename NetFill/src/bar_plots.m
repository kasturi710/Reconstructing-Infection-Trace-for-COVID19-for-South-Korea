function bar_plots(G, SD, C_our, C_fron, C_sim, C_topk, S_our, S_fron, S_sim, S_topk, D, beta, p)

% Our method
pre_bar_plot_our = [];
rec_bar_plot_our = [];
jac_bar_plot_our = [];
good = intersect(find(C_our), find(D - SD));
goodDeg = full(sum(G(good, find(SD)),2));
miss = find(D - SD);
rec = find(C_our);
missDeg = full(sum(G(miss, find(SD)),2));
recDeg = full(sum(G(rec, find(SD)),2));
for deg = 1:3
    correct = good(goodDeg == deg);
    missd = miss(missDeg == deg);
    recd = rec(recDeg == deg);
    rec_bar_plot_our = [rec_bar_plot_our length(correct)/length(missd)];
    jac_bar_plot_our = [jac_bar_plot_our length(correct)/length(union(missd, recd))];
    pre_bar_plot_our = [pre_bar_plot_our length(correct)/length(recd)];
end
correct = good(goodDeg > 3);
missd = miss(missDeg > 3);
recd = rec(recDeg > 3);
rec_bar_plot_our = [rec_bar_plot_our length(correct)/length(missd)];
pre_bar_plot_our = [pre_bar_plot_our length(correct)/length(recd)];
jac_bar_plot_our = [jac_bar_plot_our length(correct)/length(union(missd, recd))];

% Frontier
pre_bar_plot_fron = [];
rec_bar_plot_fron = [];
jac_bar_plot_fron = [];
good = intersect(find(C_fron), find(D - SD));
goodDeg = full(sum(G(good, find(SD)),2));
miss = find(D - SD);
rec = find(C_fron);
missDeg = full(sum(G(miss, find(SD)),2));
recDeg = full(sum(G(rec, find(SD)),2));
for deg = 1:3
    correct = good(goodDeg == deg);
    missd = miss(missDeg == deg);
    recd = rec(recDeg == deg);
    rec_bar_plot_fron = [rec_bar_plot_fron length(correct)/length(missd)];
    jac_bar_plot_fron = [jac_bar_plot_fron length(correct)/length(union(missd, recd))];
    pre_bar_plot_fron = [pre_bar_plot_fron length(correct)/length(recd)];
end
correct = good(goodDeg > 3);
missd = miss(missDeg > 3);
recd = rec(recDeg > 3);
rec_bar_plot_fron = [rec_bar_plot_fron length(correct)/length(missd)];
pre_bar_plot_fron = [pre_bar_plot_fron length(correct)/length(recd)];
jac_bar_plot_fron = [jac_bar_plot_fron length(correct)/length(union(missd, recd))];

% Simulation
pre_bar_plot_sim = [];
rec_bar_plot_sim = [];
jac_bar_plot_sim = [];
good = intersect(find(C_sim), find(D - SD));
goodDeg = full(sum(G(good, find(SD)),2));
miss = find(D - SD);
rec = find(C_sim);
missDeg = full(sum(G(miss, find(SD)),2));
recDeg = full(sum(G(rec, find(SD)),2));
for deg = 1:3
    correct = good(goodDeg == deg);
    missd = miss(missDeg == deg);
    recd = rec(recDeg == deg);
    rec_bar_plot_sim = [rec_bar_plot_sim length(correct)/length(missd)];
    jac_bar_plot_sim = [jac_bar_plot_sim length(correct)/length(union(missd, recd))];
    pre_bar_plot_sim = [pre_bar_plot_sim length(correct)/length(recd)];
end
correct = good(goodDeg > 3);
missd = miss(missDeg > 3);
recd = rec(recDeg > 3);
rec_bar_plot_sim = [rec_bar_plot_sim length(correct)/length(missd)];
pre_bar_plot_sim = [pre_bar_plot_sim length(correct)/length(recd)];
jac_bar_plot_sim = [jac_bar_plot_sim length(correct)/length(union(missd, recd))];


% Topkdni
pre_bar_plot_topk = [];
rec_bar_plot_topk = [];
jac_bar_plot_topk = [];
good = intersect(find(C_topk), find(D - SD));
goodDeg = full(sum(G(good, find(SD)),2));
miss = find(D - SD);
rec = find(C_topk);
missDeg = full(sum(G(miss, find(SD)),2));
recDeg = full(sum(G(rec, find(SD)),2));
for deg = 1:3
    correct = good(goodDeg == deg);
    missd = miss(missDeg == deg);
    recd = rec(recDeg == deg);
    rec_bar_plot_topk = [rec_bar_plot_topk length(correct)/length(missd)];
    jac_bar_plot_topk = [jac_bar_plot_topk length(correct)/length(union(missd, recd))];
    pre_bar_plot_topk = [pre_bar_plot_topk length(correct)/length(recd)];
end
correct = good(goodDeg > 3);
missd = miss(missDeg > 3);
recd = rec(recDeg > 3);
rec_bar_plot_topk = [rec_bar_plot_topk length(correct)/length(missd)];
pre_bar_plot_topk = [pre_bar_plot_topk length(correct)/length(recd)];
jac_bar_plot_topk = [jac_bar_plot_topk length(correct)/length(union(missd, recd))];

% F measure
f_bar_plot_our = 2*rec_bar_plot_our.*pre_bar_plot_our./(rec_bar_plot_our + pre_bar_plot_our);
f_bar_plot_fron = 2*rec_bar_plot_fron.*pre_bar_plot_fron./(rec_bar_plot_fron + pre_bar_plot_fron);
f_bar_plot_sim = 2*rec_bar_plot_sim.*pre_bar_plot_sim./(rec_bar_plot_sim + pre_bar_plot_sim);
f_bar_plot_topk = 2*rec_bar_plot_topk.*pre_bar_plot_topk./(rec_bar_plot_topk + pre_bar_plot_topk);

% Plot bars
bar( [1:4], f_bar_plot_our, 0.2, 'r');
hold on;
bar( [1.2:1:4.2], f_bar_plot_fron,0.2, 'g');
bar( [1.4:1:4.4], f_bar_plot_sim,0.2, 'y');
bar( [1.6:1:4.6], f_bar_plot_topk,0.2, 'b');
hold off;

figure;
bar( [1:4], jac_bar_plot_our, 0.2, 'r');
hold on;
bar( [1.2:1:4.2], jac_bar_plot_fron,0.2, 'g');
bar( [1.4:1:4.4], jac_bar_plot_sim,0.2, 'y');
bar( [1.6:1:4.6], jac_bar_plot_topk,0.2, 'b');
hold off;

figure;
bar( [1:4], rec_bar_plot_our, 0.2, 'r');
hold on;
bar( [1.2:1:4.2], rec_bar_plot_fron,0.2, 'g');
bar( [1.4:1:4.4], rec_bar_plot_sim,0.2, 'y');
bar( [1.6:1:4.6], rec_bar_plot_topk,0.2, 'b');
hold off;

figure;
bar( [1:4], pre_bar_plot_our, 0.2, 'r');
hold on;
bar( [1.2:1:4.2], pre_bar_plot_fron,0.2, 'g');
bar( [1.4:1:4.4], pre_bar_plot_sim,0.2, 'y');
bar( [1.6:1:4.6], pre_bar_plot_topk,0.2, 'b');
hold off;

% Q_MDL
mdl_fron = MDL(C_fron, G, SD, S_fron,p, beta);
mdl_topk = MDL(C_topk, G, SD, S_topk,p, beta);
mdl_sim = MDL(C_sim, G, SD, S_sim,p, beta);
[SS XX] = seedGivenC( zeros(1, length(G)), G, D, beta, D, p, []);
S = zeros(1, length(G));
S(XX) = 1;
mdl_red = MDL(D - SD, G, SD,S ,p, beta);
mdl_our = MDL(C_our, G, SD, S_our,p, beta);

q_mdl_fron = mdl_fron/mdl_red;
q_mdl_our = mdl_our/mdl_red;
q_mdl_sim = mdl_sim/mdl_red;
q_mdl_topk = mdl_topk/mdl_red;

figure;
bar( 1,q_mdl_fron, 'g');
hold on;
bar( 2,q_mdl_sim, 'y');
bar( 3,q_mdl_our, 'r');
bar( 4,q_mdl_topk, 'b');
hold off;

end

