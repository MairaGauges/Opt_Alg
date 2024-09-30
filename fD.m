function err = fD(C_x,y)
val = y .* C_x;
c = ones(size(val));
c(val >= 0) = 0;
err = 100*(sum(c) / size(C_x,1));
end