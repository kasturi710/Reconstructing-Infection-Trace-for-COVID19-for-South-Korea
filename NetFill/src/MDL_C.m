function mdl_c = MDL_C( C,I, p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% p >= 0 and p <= 1
assert(p >= 0);
assert(p <= 1);
% all c's must be in i
assert(length(setdiff(find(C), find(I))) == 0);
% mod c < = mod I
assert(sum(C) <= sum(I));

modc = sum(C(1,:));
y = length(find(I(1,:)));
mdl_c = L_P(y,  modc ,p ) ;%
%mdl_c = L_N(modc + 1);
mdl_c = mdl_c + log2nchoosek(y, modc);
ntimesteps = length(C(:, 1));


for time = 2:ntimesteps
    modc = sum(C(time, :));
    x = union(setdiff(find(I(time, :)), find(I(time - 1, :))), find(C(time - 1, :)));
    y = length(x);
    mdl_c = mdl_c + L_N(modc + 1);
    mdl_c = mdl_c + log2nchoosek(y, modc);
    
end

mdl_c;

end

