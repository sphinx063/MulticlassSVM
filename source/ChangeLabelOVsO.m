function [Data12,NewLabels] = ChangeLabelOVsO(NewData,labels,category1,category2)
%% Changelabels This function changes the label of input category to 1 and
%others to -1 and removes the samples from the training dataset which
%doesn't belong to category 1 or 2
% Inputs: "labels" matrix consists of labels for different classes in
% integer format. "category1","category2"  is array of required labels(or any integer > 0) 
%of a class which is replaced with 1 and other labels to -1
%Newdata is the training data set
%Output: The vector of "NewLabels" is labels matrix after required modifications and "Data12" is training
%dataset after the samples whose labels are neither category 1 or 2 are
%removed
TempLabel1 = labels;
TempLabel2 = labels;
TempLabel1(TempLabel1 ~= category1) = 0;
TempLabel1(TempLabel1 == category1) = 1;
TempLabel2(TempLabel2 ~= category2) = 0;
TempLabel2(TempLabel2 == category2) = -1;
ModLabel = TempLabel1+TempLabel2;
Temp12 =  [NewData ModLabel];
Data12 = Temp12(Temp12(:, end) ~=0 , :);
[P,Q] = size(Data12);
Data12(:,Q) = [];
NewLabels = ModLabel(ModLabel ~= 0);
end

