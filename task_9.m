load("classifier_dataset.mat", "testdataset", "testlabels", "traindataset", "trainlabels")
load("attacked_dataset.mat","attacked_testdataset")
n = size(traindataset,2);
n_data = size(traindataset,1);
rho = 0.1;
P = 0.18;    

cvx_begin 
    variable w(n,1); 
    variable w_0; 
    w_0_matrix = repmat(w_0,n_data,1);
    o = repmat(1,n_data,1);
    n_squared=  pow_pos(norm(w, 2), 2);
    %adapted equation to match equation nine - take l1 norm of w
    minimize ((1/n_data)*sum(pos(o-(trainlabels .* (traindataset*w +w_0_matrix)-P*norm(w,1)*ones(n_data,1))))+ rho*n_squared)
cvx_end

%printing optimal values for w and w_0
fprintf('Optimal value of w_0: %.2f\n', w_0);
fprintf('Optimal value of w: ');
fprintf('%d\n ', w); 


% %test results with testdata, vector of classifications 
cl_test = classifier(testdataset,w,w_0);

%classifier results for train dataset 
cl_train = classifier(traindataset,w,w_0);

%classifier results with the attacked dataset 
cl_attacked = classifier(attacked_testdataset,w,w_0);

%classifier error for train dataset, test dataset and for attacked dataset
cl_err_traindata = fD(cl_train, trainlabels);
cl_err_testdata = fD(cl_test, testlabels);
cl_err_attacked = fD(cl_attacked, testlabels);

fprintf('Classifier error rate for the training data: %.3f\n', cl_err_traindata);
fprintf('Classifier error rate for the test data: %.3f\n', cl_err_testdata);
fprintf('Classifier error rate for the attacked data: %.3f\n', cl_err_attacked);

