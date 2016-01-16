%% This program will calculate One vs One extension and plots accuracy vs cost on testing data. 
%% Initializing variables
% Storing the weight and bias vectors of discriminant functions for four classes
total_weight = zeros(18,6);
total_bias = zeros(1,6);
%Optimum classifier is the number of samples one which gives maximum correct validations on
%test data and its corresponding cost is "Cmax"
Optimiumclassifier =0;
Cost = 1;
% Below matrix stores cost in first column and corresponding correclty
% classfied samples in second column and % of samples correctly classified
% in third column
answer = zeros(100,3);
%% Loading data
disp('Please seperate training and testing datasets into different folders')
filepath = input('Please give the path for the folder of training data set (without quotes):','s');
addpath(filepath);
%'F:\CSE 569\Project\Option2files\data\vehicle_traindata'
%'F:\CSE 569\Project\Option2files\data\vehicle_testdata'
[TrainData,Trainlabels] = Dataimport(filepath);
filepath = input('Please give the path for the folder of testing data set (without quotes):','s');
[TestData,Testlabels] = Dataimport(filepath);
Total_testsamples = size(Testlabels,1);
%% Finding discrminant functions for each of 4 categories using "One vs All extension"
% and iterating over Cost(C) in powers of 2
for l = 1:100
%Cost = Cost*2;
Cost = l;    
    k=0;
for i = 1:3
    for j=i+1:4
        k = k+1;
        %Changing the labels of required category1 to 1,category2 to -1 and all others to 0
        [TrainData_new,Trainlabels_new] = ChangeLabelOVsO(TrainData,Trainlabels,i,j);
        %Finding optimal solution using quadratic programming 
        [weight,bias,slackvariables] = SVM(TrainData_new,Trainlabels_new,Cost);
        total_weight(:,k)= weight;
        total_bias(:,k)= bias;        
    end
end
%% Prediction on test data
Correctly_classified_samples = PredictOneVsOne(TestData,Testlabels,total_weight,total_bias);
if(Correctly_classified_samples>Optimiumclassifier)
    Optimiumclassifier = Correctly_classified_samples;
    Cmax = Cost;
end
disp('Correctly classiifed samples out of 188 :');
disp(Correctly_classified_samples);
%% Storing the results in the answer matrix and incrementing the cost
answer(l+1,[1 2 3])= [Cost Correctly_classified_samples ((Correctly_classified_samples/Total_testsamples)*100)];
plot(answer(2:50,1),answer(2:50,3));
xlim([1 50]);
xlabel('Cost');
ylabel('Accuracy in %')
title('Step 2 Accuracy results vs cost graph')
end