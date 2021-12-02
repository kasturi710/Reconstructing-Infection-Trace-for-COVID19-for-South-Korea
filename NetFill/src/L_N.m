function score = L_N( num )
%UNTITLED2 Summary of this function goes here
% This function is correct
% returns the MDL universal code for integers for num

l = log2(num);
score = l;
while(log2(l)>0)
    l = log2(l);
    score = score + l;
end

end

