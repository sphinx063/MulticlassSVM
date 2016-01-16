function [fulldata,labels]  = Dataimport(filepath)
%Dataimport Import multiple data files into the matrix format.
% Inputs : This function takes the path of the directory where files are
% located. 
% file format : .dat
% Output: "fulldata" - Multiple data files are concatenated into single matrix.
%           "labels"   - labels of each sample in vector. 
% For convenience the the labels are replaced by integers as below:
% 'bus' - 1 'opel' - 2 'saab' - 3 'van' - '4'
% Example: first row of "fulldata" corresponds to a sample with features
% equal to no of columns in the matrix. 
% first data point in "labels" is the category of sample in first row of
% "fulldata"
%% Traversing to required directory and storing all the file names in it.
cd(filepath);
files = dir('*.dat');
i = 0;    
%% looping through all the files.
% "importfile" function takes a '.dat' file and returns matrix with labels
% modified. 
for k = 1:numel(files)
    dataimported = importfile(files(k).name);
    if i == 0 
        datamodified = dataimported;
        i = i+ 1;
    else
        datamodified = [datamodified;dataimported];
    end
end
%% Seperating labels and data.
[Rows,Cols]= size(datamodified);
labels = datamodified(:,Cols);
fulldata = datamodified(:,1:Cols-1);
end

