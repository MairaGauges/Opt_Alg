function cl = classifier(x,w,w_0)
val = x*w + w_0*ones(size(x,1),1);
% start by setting all labels ro 1
cl = ones(size(val));  % Start with all entries set to 1
% label as -1 if below zero
cl(val < 0) = -1;
end