%% This will calculate SVM using error-correcting-coding and plots accuracy vs cost on testing data.
% The coding matrix used is having 4 rows for ('bus','saab','van','opel')
% 7 columns and each column provides values of ylabels for that classifier.
% Classifier lable is +1 or -1 for each of 4 categories in above matrix
% Inputs : The dataset vehicle train and vehicle test with 18 features and
% 4 categories.
% Outputs : The number of correctly classsified samples for the test data 
% ranging over the cost function
%% Initializing variables
% Storing the weight and bias vectors of discriminant functions for four classes
total_weight = zeros(18,7);
total_bias = zeros(1,7);
%Optimum classifier is the number of samples one which gives maximum correct validations on
%test data and its corresponding cost is "Cmax"
Optimiumclassifier =0;
Cost = 1;
%Coding matrix:  For the convenience we changed the second row of coding
%matrix to 'opel' and third row to 'saab' 
C = ones(4,7);
C(1,[2 3 4]) = [-1 -1 -1];           % bus
C(2,[1 2 4 5 7]) = [-1 -1 -1 -1 -1]; % opel
C(3,[1 3 4 6 7]) = [-1 -1 -1 -1 -1]; % saab
C(4,[1 2 3 5 6]) = [-1 -1 -1 -1 -1]; % van
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
filepath = input('Please give the path for the folder of testing data set (without quotes) :','s');
[TestData,Testlabels] = Dataimport(filepath);
Total_testsamples = size(Testlabels,1);
%% Finding discrminant functions for each of 4 categories using "error-correcting-coding"
% and iterating over Cost(C) in powers of 2
for j = 1:100
%Cost = 2^j;    
Cost = j;    
for i = 1:7
%Changing the labels of required category to 1 and all others to -1
Trainlabels_new = Changelabels(Trainlabels,C(:,i),'error coding');
%disp(Trainlabels_new);
%Finding optimal solution using quadratic programming 
[weight,bias,slackvariables] = SVM(TrainData,Trainlabels_new,Cost);
total_weight(:,i)= weight;
total_bias(:,i)= bias;
end

%% Prediction on test data
Correctly_classified_samples = predict(TestData,Testlabels,total_weight,total_bias,'error coding',C);
if(Correctly_classified_samples>Optimiumclassifier)
    Optimiumclassifier = Correctly_classified_samples;
    Cmax = Cost;
end
disp('Correctly classiifed samples out of 188 :');
disp(Correctly_classified_samples);
%% Storing the results in the answer matrix and incrementing the cost
answer(j+1,[1 2 3])= [Cost Correctly_classified_samples ((Correctly_classified_samples/Total_testsamples)*100)];
plot(answer(2:50,1),answer(2:50,3));
xlim([1 50]);
xlabel('Cost');
ylabel('Accuracy in %')
title('Step 3 Accuracy results vs cost graph')
end
 




