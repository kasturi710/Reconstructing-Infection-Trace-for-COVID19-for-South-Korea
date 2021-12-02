function [ S, C, R, I, singletonset] = complete( SD, beta, G, missing, p, bulk)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% Graphs may be disconnected  
global MDL_MAX;
MDL_MAX = 9999999;
S = zeros(1, length(G));
R = [];

nnodes = length(G(1,:));
C = initializeC(SD, G); % Frontier sets
disp("C is")
disp(C)
singletons = [];
singletonset = [];
I = C + SD;

%display('C init done');
[SSn XX] = seedGivenC( C, G, SD, beta, SD, p, []);
% disp("SEEDS ARE")
% disp(SSn)
% disp("XX are")
% disp(XX)
assert(length(SSn(1,:)) == nnodes);
assert(length(SSn(:,1)) == 1)
newXX = XX;
S(XX) = 1;

%display('1 st seed given C done');
%display('start MDL_0')
mdl0 =  MDL(C, G, I, SSn, p, beta);
%display('end MDL_0')

% disp("C is")
% disp(C)
% x=input("enter")
% What if seed and C is not infected?
I(1, find(C)) = 0;
I(1, XX) = 1;
% disp("I is ")
% disp(I)
% wait=input("enter")
disp("Starting iterations now")
for i = 1:1000
    %missing = find(D - SD);
    filename = ['iteration' num2str(i)];
    %display('Starting iteration');
%     SSn(XX) = 0;
%     XX = [100 270];
%     SSn(XX) = 1;

    
    [Cn singletons] = CgivenSeed(C, G, I, SSn, SD, missing, XX, filename, p, beta, singletons, bulk);

    newCn = Cn;
%     disp("Cn is")
%     disp(Cn)

    
    newI = union(find(SD), newCn)

    I(1,newI) = 1;
    %display('C given C done');
    C_dummy = zeros(1,nnodes);
    C_dummy(1,Cn) = 1;
   
    
    [SSn XX] = seedGivenC( C_dummy, G, I, beta, SD, p, singletons);
%     disp("XX is")
%     disp(XX)
    I(XX) = 1;

    %i
    %display('start MDL_1')
    mdl1 =  MDL(C_dummy, G, I, SSn, p, beta);
    %display('end MDL_1')
    
    if mdl1 < mdl0
        mdl0 = mdl1;
        C = C_dummy;
        %I(1, find(C)) = 0 ;
        newXX = XX;
        singletonset = union(singletonset, singletons);
    else
        S = zeros(1, nnodes);
        S(1, setdiff(newXX, singletonset)) = 1;
        display(['done in iteration # ' num2str(i)]);
        %changing SD to I here , why are taking SD into account while
        %calculating MDL ?
%         [MDLSCORE, tpath, singletons] =  MDL(C, G, SD, SSn, p, beta);
%          R = unique(tpath);
        break;
        
    end
%     MDL_R(C, G, I, S)
    
%    display(['Iteration no ' num2str(i) ' for FULL ALGORITHM mdl1 = ' num2str(mdl1)]);
%     if mdl1 < mdl0
%         mdl0 = mdl1;
%     else

%         break;
%     end
%     
end

end
    %[C I Y] = CgivenSeed(G, I, S, beta, D, missing, p);
    %[ C I ] = SIM(G, I, S, beta );
%     MDL(initializeC(D, G), G, D, S, p, beta)
%     MDL([0 0 0 0], G, D, S, p)
