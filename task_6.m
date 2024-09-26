load("classifier_dataset.mat", "testdataset", "testlabels", "traindataset", "trainlabels")

%bla bla
n = 784; %vector size for each image
rho = 0.1; % try different values

cvx_begin 
    variable w(n,1); 
    variable w_0; 
    w_0_matrix = repmat(w_0,400,1);
    o = repmat(1,400,1);

    minimize sum(pos(o-(trainlabels .* (traindataset*w +w_0_matrix)))) + rho*norm(w)
 

cvx_end


fprintf('Optimal value of w_0: %.2f\n', w_0);

fprintf('Optimal value of w: \n');
disp(w)


%test results with testdata

cl = arrayfun(@classifier, testdataset)



function cl = classifier(x)
val = x*w + w_0
if val < 0 
    cl = -1
else 
    cl = 1
end 
end


%function (1)
function norm_ = norm(w)
norm_ = sqrt(w'*w);
end

%function (2)
function err = fD(x)

if x < 0
    a = 1;
else
    a = 0;
end
end



function show_im ( x )
image ( rescale ( reshape (x ,28 ,28) ,0 ,255) ) ;
axis square equal ;
colormap ( gray )
end

%show_im()
