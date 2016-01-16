function Correctly_classified_samples = predict(TestData,Testlabels,total_weight,total_bias,errorcoding_argument,Coding_matrix)
%Predict This function predicts the category of each test sample and
%returns total number of samples which are classified correctly
%Inputs: "TestData" is matrix of test samples with row indicating features and columns
%indicating the sample number,"total_weight" & "total_bias" are the parameters of the
%the discriminant function for each category of samples.
%Lets say column 1 of weight matrix is weight vector of discriminant
%function for 'bus'
% error coding_ argument used when we use error correcting coding to
% determine the number of correctly classified samples.
%Coding matrix is used during error coding.
%Outputs: The Number of correctly classified samples.
%% Modifying the bias matrix for computing y = w^t*x+b for all samples and 
%discriminant functions in one go
[Rows,Cols]= size(TestData);
[Rows2,Cols2]= size(total_bias);
bias_modified = zeros(Rows,Cols2);
for i = 1:4
bias_modified(:,i)=total_bias(1,i);
end
%computing y = w^t*x+b
Testclassification =((TestData*total_weight)+bias_modified); % w^t * x + b
save('predict.mat','Testclassification');
%disp(size(Testclassification));
if (nargin ==6 && strcmp(errorcoding_argument,'error coding'))
Testclassification(Testclassification<0)= -1;
Testclassification(Testclassification >= 0)= 1;
distance_matrix = pdist2(Testclassification,Coding_matrix,'hamming');
%disp(distance_matrix);
[Maxvalues,TestY_labels]  = min(distance_matrix,[],2);
%disp(TestY_labels);
else
[Maxvalues,TestY_labels]  = max(Testclassification,[],2);
%save('predict.mat','Testclassification');
%disp(size(TestY_labels));
%disp(TestY_labels);
end
Results = (Testlabels == TestY_labels);
Correctly_classified_samples = sum(Results);
end

