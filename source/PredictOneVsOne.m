function Correctly_classified_samples = PredictOneVsOne(TestData,Testlabels,total_weight,total_bias)
%Predict This function predicts the category of each test sample and
%returns total number of samples which are classified correctly
% This is specific to One vs One extension.
%Inputs: "TestData" is matrix of test samples with row indicating features and columns
%indicating the sample number,"total_weight" & "total_bias" are the parameters of the
%the discriminant function for each category of samples.
%Lets say column 1 of weight matrix is weight vector of discriminant
%function for 'bus'
%Outputs: The Number of correctly classified samples.
%% Modifying the bias matrix for computing y = w^t*x+b for all samples and 
%discriminant functions in one go
[Rows,Cols]= size(TestData);
bias_modified = zeros(Rows,6);
for i = 1:6
bias_modified(:,i)=total_bias(1,i);
end
%computing y = w^t*x+b
Testclassification =((TestData*total_weight)+bias_modified); % w^t * x + b
TestY_labels = zeros(Rows,1);
SignMatrix = sign(Testclassification);
for i=1:size(Testclassification,1)
  FullResultMatrix = zeros(4,4);
  FullResultMatrix(1,[2 3 4]) = [SignMatrix(i,1) SignMatrix(i,2) SignMatrix(i,3)];
  FullResultMatrix(2,[1 3 4]) = [-SignMatrix(i,1) SignMatrix(i,4) SignMatrix(i,5)];
  FullResultMatrix(3,[1 2 4]) = [-SignMatrix(i,2) -SignMatrix(i,4) SignMatrix(i,6)];
  FullResultMatrix(4,[1 2 3]) = [-SignMatrix(i,3) -SignMatrix(i,5) -SignMatrix(i,6)];
  SumMatrix = sum(transpose(FullResultMatrix));
  [SumMax,labels]  = max(SumMatrix,[],2);
  TestY_labels(i,1) = labels;
end
%save('predict.mat','Testclassification');
%disp(size(TestY_labels));
%disp(TestY_labels);
Results = (Testlabels == TestY_labels);
Correctly_classified_samples = sum(Results);
end