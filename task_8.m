load("task_6_results.mat", "w","w_0" ); 
load("classifier_dataset.mat", "testdataset", "testlabels", "traindataset", "trainlabels")

P = 0.18;

%adapt all x values in the dataset
attacked_testdataset = get_x_snake(testdataset,P,w,testlabels);

%assess performance using attacked test dataset with the classifier from task 6
cl_attacked_test = classifier(attacked_testdataset,w,w_0); 
cl_err_attacked_data = fD(cl_attacked_test, testlabels);
fprintf('Classifier error rate for the attacked test data set: %.3f\n', cl_err_attacked_data);

function x_snake_ = get_x_snake(x,P,w,y)
w_matrix = repmat(w', size(y,1), 1);
x_snake_ = x - P*sign(y.*w_matrix);
end