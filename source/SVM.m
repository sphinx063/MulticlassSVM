function [ weight,bias,slackvariables ] = SVM(Train_data,Train_labels,Cost)
%SVM This function calculates the SVM classifier using Matlab Quadprog. 
%Inputs: Training data,its labels and cost that controls relative influence
%between two different labels(1,-1).
%Outputs: Weight vector, bias and slackvariables
%The detailed mathematical description can be found at:
% <http://www.mathworks.com>
[N,M] = size(Train_data);
A = zeros([2*N,N+M+1]);
g = zeros([2*N 1]);
for i=1:N
    A(i,:) = -1*[Train_labels(i).*Train_data(i,:) Train_labels(i) zeros([1 i-1]) 1 zeros([1 N-i])];
    g(i,1) = -1;
end
for i=1:N
    A(N+i,:) = -1*[zeros([1 M+1]) zeros([1 i-1]) 1 zeros([1 N-i])];
    g(N+i,1) = 0;
end
c =transpose([zeros(M+1,1) ; Cost*ones(N,1)]);
Q = [eye(M) zeros([M N+1]);zeros([N+1 M]) zeros([N+1 N+1])];
[z,fval,exitflag,output,lambda] = quadprog(Q,c,A,g); 
weight = z(1:M,1);
bias = z(M+1,1);
slackvariables = z(M+2:M+N+1,1);
end


