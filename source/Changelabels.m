function Modified_labels = Changelabels(labels,category,errorcoding_argument)
%Changelabels This function changes the label of input category to 1 and
%others to -1
% Inputs: "labels" matrix consists of labels for different classes in
% integer format. "category" is array of required labels(or any integer > 0) 
%of a class which is replaced with 1 and other labels not in category array
%with -1.
%errorcoding argument is used to modify labels according to the error
%coding matrix. User needs to mention 'error coding' as input o.w this
%input is 'None'
%Output: The vector of labels after required modifications
%% checking for number of input arguments
if(nargin == 3)
if strcmp(errorcoding_argument,'error coding') 
actualcategory = find(category(:,1)== 1);
category = transpose(actualcategory);
%disp(category);
end
end
[rows,cols] = size(category);
for element = 1:cols
labels(labels == category(element)) = -1;
end
labels(labels ~= -1) = 1;
Modified_labels = -labels;

end
