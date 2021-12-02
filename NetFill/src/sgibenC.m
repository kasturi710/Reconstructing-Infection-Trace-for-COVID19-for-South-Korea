function sgibenC(C, G, I, beta, D, p, S)
    display('MDL for C given seed');
    ntimestamps = length(I(:, 1));
    nnodes = length(I(1, :));
    infectedSample = find(D(1,:));
    infectedCurrent = union(find(D(1,:)), find(C(1,:)));
    infectedCorrected = find(C(1,:));
    missing = setdiff(1:3600, find(D));
    C = zeros(1,3600);
    
    for time = 1:ntimestamps
        toInfect = find(I(time, :));
        seeds = [];
        for i = 1:time
            seeds = union(union(seeds, find(I(i, :))), find(C(i, :)));
        end
        mdl0 = Inf;
        X = [];
        Y = [];
        for i =1:38
            a = findBestNode(seeds, toInfect, X, G, beta, missing);
            % modify I and C
            if mod(i, 5) == 0
            %    display('ooo');
            end
            if a > 0
                for k = time: ntimestamps
                    if D(k,a) == 0
                        I(k,a) = 1;
                        C(k, a) = 1;
                    else
                        break;
                    end
                end
            %    display('H');

                mdl1 = MDL(C, G, I, S,p, beta);
                X = union(X, a);
                Y = [Y a];
                %{  } 
    %             
    %            display(['adding node no ' num2str(i) ' as ' num2str(a)]);
    %             if mdl1 < mdl0
    %                 X = union(X, a);
    %                 mdl0 = mdl1;
    %                 Y = [Y a];
                display([ num2str(length(Y)) ','  num2str(mdl1) ',' num2str(MDL_R(C,G,I,S, beta)) ',' num2str(L_N(length(find(C)))) ',' num2str(L_P(length(find(I(1,:))) ,sum(C(1,:)) ,0.9))]);
    %                 if length(Y) >= 40
    %                     break;
    %                 end
    %             else
    %                 for k = time: ntimestamps
    %                     if D(k,a) == 0
    %                         I(k,a) = 0;
    %                         C(k, a) = 0;
    %                     else
    %                         break;
    %                     end
    %                 end
    % %                 if length(X) == 0
    % %                     display('Err');
    % %                 end
    %                   if mod(i,100) == 0
    %                       display('good')
    %                   end
    %                 toInfect = union(toInfect, X);
    %                 X = [];
    %                 continue
    %             end

            X = union(X, a);
            if mod(i,5) == 0
                toInfect = union(toInfect, X);
                X = [];
            end
            end
        end
        fclose(fid);
        %visualize_grid(60, find(D(1,:)), find(S(1,:)), 'grid-node-mapping', missing, Y, file); 
        display('one r done')
    end
end