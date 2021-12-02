function [MDLSCORE, tpathnew, singletons] = MDL(Culp, Graph, Infection, Seeds,p, beta)
% R is composed of ripples R_0, R_1.....
% S is a set of buckets. S_i = seeds only at time i
% C = buckets of corrections. C_i = nodes infected but not in D
% I_i nodes we think were infected at time stamp i.

global MDL_MAX;
tpath = [];
tpathnew = [];
singletons = [];
infectedSample = find(Infection);
if sum(Culp) == 0
    infectedCurrent = find(Infection);
else
    infectedCurrent = union(find(Infection), find(Culp));
end

nnodes = length(Graph(1,:));
[M N] = graphconncomp(sparse(Graph(infectedCurrent, infectedCurrent)));

Current = find(Culp);
C = zeros(M, nnodes);
S = zeros(M, nnodes);
I = zeros(M, nnodes);
% S should be a part of infected current

if isempty(find(Seeds))
    disp("Seeds is empty LMAO")
end
for s = find(Seeds)
    if isempty(find(infectedCurrent == s))
        s;
    end

    assert(~isempty(find(infectedCurrent == s)));
end
% Divide the infectedCurrent graph into M mdl computations
for i = 1:M
    subInfCurr = infectedCurrent(find(N == i));
    for node = subInfCurr
        if find(infectedCurrent == node)
            I(i, node) = 1; 
        end
        if Seeds(1, node) == 1
            S(i, node) = 1;
        end
        if find(Current == node)
            C(i, node) = 1;
        end
    end
end
%   disp("Check I formed in MDL")
%   disp(I)
%   disp("Check S in MDL")
%   disp(S)
extra = 0;
notTocheck = [];
% Check for seed in every connected component
for i = 1:M
    %assert(sum(S(i,:)) > 0)
    if sum(S(i,:)) == 0
        if sum(I(i,:)) == 1
            extra = extra + 1;
            notTocheck = [ notTocheck i];
            singletons = [singletons find(I(i,:))];
        else
            MDLSCORE = MDL_MAX;
            return;
        end
    end
end
MDLSCORE = 0;
MDL_r = 0;
MDL_c = 0;
if M > 1
    for i = 1:M
%         if length(find(N == i)) < 4
%             continue;
%         end
        if ~isempty(find(notTocheck == i))
            continue;
        end
        V = ones(1, length(Graph(1,:)));
        mdl_s = MDL_S(I(i,:), S(i,:), V);
        mdl_c = MDL_C(C(i,:), I(i,:), (1 - p)/p);
        [mdl_r, tpath] = MDL_R(C(i,:), Graph, I(i,:), S(i,:),beta);
        tpathnew = [tpathnew tpath];
        MDL_r = MDL_r + mdl_r;
        MDL_c = MDL_c + mdl_c;
        mdl = mdl_s + mdl_c + mdl_r;
        MDLSCORE = MDLSCORE + mdl;
    end
else
    

    

    V = ones(1, length(Graph(1,:)));
    mdl_s = MDL_S(I, S, V);
    mdl_c = MDL_C(C, I, (1 - p)/p);
    [mdl_r, tpath] = MDL_R(C, Graph, I, S,beta);
    tpathnew = [tpathnew tpath];
    mdl = mdl_s + mdl_c + mdl_r;
    MDL_r = MDL_r + mdl_r;
    MDL_c = MDL_c + mdl_c;
    MDLSCORE = mdl;
end
if extra > 0
    MDLSCORE = MDLSCORE + L_N(extra);
end
MDLSCORE_r = MDL_r;
MDL_r;
MDL_c;
end

