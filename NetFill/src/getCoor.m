function [x, y] = getCoor(a)
coordinates = zeros(3600, 2);
k = 1;
for j = 1:60
    for i = 1:60
        coordinates(k,:) = [j i];
        k = k + 1;
    end
end
y  = coordinates(a,1);
x = coordinates(a,2);
end