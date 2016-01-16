%%  This program will calculate Binary SVM extension and plots accuracy vs cost on testing data.
% Importing data and converting sparse matrices to full matrix.
filepath = input('Please give full path for the file HeartDataSet.mat (without quotes) :','s');
addpath(filepath);
%'F:\CSE 569\Project\Option2files\data\HeartDataSet.mat'
data = importdata(filepath); 
B = data.Xtrain;
TrainX = full(B);
TrainY = data.Ytrain;
C = data.Xtest;
TestX = full(C);
TestY = data.Ytest;
TestY(TestY == -1)=0;
Total_testsamples = size(TestY,1);
% Below matrix stores cost in first column and corresponding correclty
% classfied samples in second column and % of samples correctly classified
% in third column
answer = zeros(100,3);
%% Finding optimal solution using quadratic programming  
y =0;
[N,M] = size(TrainX);
A = zeros([2*N,N+M+1]);
g = zeros([2*N 1]);
C=1;
for i=1:N
    A(i,:) = -1*[TrainY(i).*TrainX(i,:) TrainY(i) zeros([1 i-1]) 1 zeros([1 N-i])];
    g(i,1) = -1;
end
for i=1:N
    A(N+i,:) = -1*[zeros([1 M+1]) zeros([1 i-1]) 1 zeros([1 N-i])];
    g(N+i,1) = 0;
end
%disp(TrainY);
for j = 1: 50
%C = 2^j;
C=j;
c =transpose([zeros(M+1,1) ; C*ones(N,1)]);
Q = [eye(M) zeros([M N+1]);zeros([N+1 M]) zeros([N+1 N+1])];
[z,fval,exitflag,output,lambda] = quadprog(Q,c,A,g); 
%% Classification 
w = z(1:M,1);
b = z(M+1,1);
E = z(M+2:M+N+1,1);
Testclassification =((TestX*w)+b); % w^t * x + b
TestY_labels  = Testclassification > 0;
Results = (TestY == TestY_labels);
Correctly_classified_samples = sum(Results);
if(Correctly_classified_samples>y)
    y = Correctly_classified_samples;
    Cmax = C;
end
disp('Correctly classiifed samples out of 70 :');
disp(Correctly_classified_samples);
%% Storing the results in the answer matrix and incrementing the cost
answer(j+1,[1 2 3])= [C Correctly_classified_samples ((Correctly_classified_samples/Total_testsamples)*100)];
plot(answer(2:50,1),answer(2:50,3));
xlim([1 50]);
xlabel('Cost');
ylabel('Accuracy in %')
title('Step 0 Accuracy results vs cost graph')
end