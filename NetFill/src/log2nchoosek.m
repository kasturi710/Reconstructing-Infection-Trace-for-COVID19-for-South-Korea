function answ = log2nchoosek(n,k)
% k <= n
assert(k <= n);

   answ = 0;
   if n == k || k == 0
       answ = 0;
       return;
   end
   for i = 0:k - 1
       answ = answ + log2(n - i) - log2(k - i);
   end
end