load("classifier_dataset.mat", "testdataset", "testlabels", "traindataset", "trainlabels")

n = size(traindataset,2);
n_data = size(traindataset,1);
rho = 0.1;

cvx_begin 
    variable w(n,1); 
    variable w_0; 
    w_0_matrix = repmat(w_0,n_data,1);
    o = repmat(1,n_data,1);
    n_squared=  pow_pos(norm(w, 2), 2);
    minimize ((1/n_data)*sum(pos(o-(trainlabels .* (traindataset*w +w_0_matrix))))+ rho*n_squared)
cvx_end

%printing optimal values for w and w_0
fprintf('Optimal value of w_0: %.2f\n', w_0);
%fprintf('Optimal value of w: ');
%fprintf('%d\n ', w); 

%save w and w_0 variables to access them outside of the file
save('task_6_results.mat', 'w', 'w_0')


% %test results with testdata, vector of classifications 
cl_test = classifier(testdataset,w,w_0);

%classifier results for train dataset 
cl_train = classifier(traindataset,w,w_0);

check = cl_test .* testlabels;

%classifier error for train dataset and test dataset
cl_err_traindata = fD(cl_train, trainlabels);
cl_err_testdata = fD(cl_test, testlabels);

fprintf('Classifier error rate for the training data: %.3f\n', cl_err_traindata);
fprintf('Classifier error rate for the test data: %.3f\n', cl_err_testdata);


function show_im ( x )
image ( rescale ( reshape (x ,28 ,28) ,0 ,255) ) ;
axis square equal ;
colormap ( gray )
end

