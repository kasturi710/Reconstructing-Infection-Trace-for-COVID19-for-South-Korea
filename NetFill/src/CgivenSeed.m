function [C_next singletons ]  = CgivenSeed(C, G, I, SS, D, missing, XX, filename, p, beta, singletons, bulk)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

global MDL_MAX;
global mdl_plot;
mdl_plot = [];
% Takecare of disconnctd components
ntimestamps = length(I(:, 1));
nnodes = length(I(1, :));
infectedSample = find(D(1,:));
infectedCurrent = setdiff(union(find(D(1,:)), find(C(1,:))), singletons );
infectedCorrected = find(C(1,:));


infectedSubgraph = G(infectedCurrent, infectedCurrent);

[M N] = graphconncomp(sparse(infectedSubgraph));
% disp("Infected Samples is")
% disp(infectedSample)
% disp("Infected Current is")
% disp(infectedCurrent)
% disp("Infected Corrected is")
% disp(infectedCorrected)
% Divide S and XX
C_curr = zeros(M, nnodes);
sample_curr = zeros(M, nnodes);
S = zeros(M, nnodes);
X = zeros(M, nnodes);
maxcomp = -1;
value = 0;
for i = 1:M
    if length(find(N == i)) > value
        maxcomp = i;
        value = length(find(N == i));
    end
    subInfCorr = infectedCurrent(find(N == i));
    for node = subInfCorr
        if find(infectedSample == node)
            sample_curr(i, node) = 1;
        end
        if find(find(C) == node)
            C_curr(i, node) = 1;
        end
        if SS(1, node) == 1
            S(i, node) = 1;
        end
    end
    
end
% disp("C_curr")
% disp(C_curr)
% disp("Sample_Curr")
% disp(sample_curr)
% disp("S curr")
% disp(S)
C_next = [];
%changing here added C_nexter=[]
C_nexter=[];
if M > 1
    for i = 1:M
        X = XX(find(XX > 0));

        Y = [];
        for kkk = 1:length(X)
            x = X(kkk);
            if (sample_curr(i,x) == 1) || (C_curr(i,x) == 1)
                Y = [Y x];
            end
        end
        if sample_curr(i,:) == 0
            %changing here added find
            C_next = union(C_next, find(C_curr(i,:)));
            continue
        end
        C_nextnew = modifiedumaxscore(Y, D, sample_curr(i,:), S(i,:), C_curr(i,:), G, p);
       % mdl0 = MDL();
       %changing here, adding S(i,:) to sample_curr(i,:)  like done for one
       %component

       mdl0 = MDL([], G, sample_curr(i,:)+ S(i,:), S(i,:), p, beta);
       mdl0;
%        if i == 1
%           mdl_plot = [mdl0];
%        end
       %display('hello')
       %i
       flag = 0;
        for k = 1:(length(C_nextnew)/ bulk)
            C_dummy = zeros(1,nnodes);
            C_dummy(1, C_nextnew(1:k*bulk)) = 1;
            %changing here, adding S(i,:) to sample_curr(i,:) like done for
            %one component
            [mdl1 tpath singletons] = MDL(C_dummy, G, sample_curr(i,:)+ S(i,:), S(i,:), p, beta);
            %display([num2str(mdl1)]);
%             if i == 1
%                 mdl_plot = [mdl_plot mdl1];
%             end
%             if k == 80
%                 %display('H');
%                 %return;
%             end
%            display(num2str(mdl1));
            if mdl1 < MDL_MAX - 1
                if mdl1 < mdl0
                    
                    mdl1;
                    flag = 1;
                    C_nexter = find(C_dummy);
                    mdl0 = mdl1;
                else
                    mdl0 = mdl1;
                    break;
                end
            else
                %display([num2str(k) '    ' num2str(mdl1)]);
                mdl0 = mdl1;
                if flag == 1
                    break;
                end
                continue;
            end
            
       end
%         expected = floor(((1-p)/p)*sum(sample_curr(i,:)));
%         C_nexter = C_nextnew(1:expected);


        C_next = union(C_next, C_nexter);
       % C_next = union(C_next, C_nextnew);
    end
else
    X = XX(find(XX > 0));
    S(1, XX) = 1;
    C_nextnew = modifiedumaxscore(X, D, sample_curr(1,:), S(1,:), C_curr(1,:), G, p);
    [mdl0 ] = MDL([], G, sample_curr(1,:) + S(1,:), S(1,:), p, beta);
    mdl0;
   % mdl_plot = [mdl0];
    flag = 0;
    for k = 1:(length(C_nextnew)/bulk)
            C_dummy = zeros(1,nnodes);
%             if k == 80
%                 %display('O');
%                 %return;
%             end
            C_dummy(1, C_nextnew(1:k*bulk)) = 1;
            [mdl1 tpath singletons] = MDL(C_dummy, G, sample_curr(1,:) + S(1,:), S(1,:), p, beta);
%             if k == 2
%                 strtemp = ['mdl ' num2str(mdl1) ' mdl_r ' num2str(mdl1_r) ' id = ' num2str(C_nextnew(k))];
%                 display(strtemp);
%                 %temparr = [mdl1, mdl1_r, C_nextnew(k)];
%                 %break;
%                 return;
%             end
%            display([num2str(mdl1)]);
%            mdl_plot = [mdl_plot mdl1];
%             if k > 15
%                 display('H');
%                 break;
%             end
            if mdl1 < MDL_MAX
                if mdl1 < mdl0
                    mdl0 = mdl1;
                    flag = 1;
                    mdl1;
                    C_next = find(C_dummy);

                    C_next;
                else
                    mdl0 = mdl1;
                    break;
                end
            else
           %     display([num2str(k) '    ' num2str(mdl1)]);
                mdl0 = mdl1;
                if flag == 1
                    break;
                end
                continue;
            end
            
%            display([num2str(mdl1)]);   
            
   end
    %expected = floor(((1-p)/p)*sum(sample_curr(1,:)));
    C_next = C_next;
end
seeds = find(SS);
%visualize_grid(60, infectedSample, seeds, 'grid-node-mapping', missing, C_next, filename); 





%display('MDL for C given seed');
% for time = 1:ntimestamps
%     toInfect = find(I(time, :));
%     seeds = [];
%     for i = 1:time
%         seeds = union(union(seeds, find(I(i, :))), find(C(i, :)));
%     end
%     mdl0 = Inf;
%     X = [];
%     Y = [];
%     for i =1:96
%         a = findBestNode(seeds, toInfect, X, G, beta, missing);
%         % modify I and C
%         if mod(i, 5) == 0
%             display('ooo');
%         end
%         if a > 0
%             for k = time: ntimestamps
%                 if D(k,a) == 0
%                     I(k,a) = 1;
%                     C(k, a) = 1;
%                 else
%                     break;
%                 end
%             end
%             display('H');
%             
%             mdl1 = MDL(C, G, I, S,p, beta);
%             X = union(X, a);
%             Y = [Y a];
%             %{  } 
% %             
% %            display(['adding node no ' num2str(i) ' as ' num2str(a)]);
% %             if mdl1 < mdl0
% %                 X = union(X, a);
% %                 mdl0 = mdl1;
% %                 Y = [Y a];
% %                 display([ num2str(length(Y)) ','  num2str(mdl1) ',' num2str(MDL_R(C,G,I,S)) ',' num2str(L_N(length(find(C)))) ',' num2str(L_P(length(find(I(1,:))) ,sum(C(1,:)) ,0.9))]);
% %                 if length(Y) >= 40
% %                     break;
% %                 end
% %             else
% %                 for k = time: ntimestamps
% %                     if D(k,a) == 0
% %                         I(k,a) = 0;
% %                         C(k, a) = 0;
% %                     else
% %                         break;
% %                     end
% %                 end
% % %                 if length(X) == 0
% % %                     display('Err');
% % %                 end
% %                   if mod(i,100) == 0
% %                       display('good')
% %                   end
% %                 toInfect = union(toInfect, X);
% %                 X = [];
% %                 continue
% %             end
%         
%         X = union(X, a);
%         if mod(i,r) == 0
%             toInfect = union(toInfect, X);
%             X = [];
%         end
%         end
%     end
%     fclose(fid);
%     visualize_grid(60, find(D(1,:)), find(S(1,:)), 'grid-node-mapping', missing, Y, file); 
%     display('one r done')
% end

end

