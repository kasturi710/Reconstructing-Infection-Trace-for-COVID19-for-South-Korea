function lp = L_P( A, B, prob )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% prob >=0 prob <= 1
assert(prob >= 0);
assert(prob <= 1);

% B <= A
assert(B <= A);

lp = 0;
if A == B || B == 0
    lp = 0;
else
    for i = 1:B
        lp = lp + log2(A - i + 1) - log2(i);
    end
end
lp = lp + B*log2(prob) + (A-B)*log2(1 - prob);
lp = -lp;

end

