function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

cVals = [0.01 0.03 0.1 0.3 1 3 10];
sigmaVals = [0.01 0.03 0.1 0.3 1 3 10];

results = [];

for i = 1:length(cVals)

    for j = 1:length(sigmaVals)
	
        #determine model based on C(i) using svmTrain.m
	model = svmTrain(X, y, cVals(i), @(x1, x2) gaussianKernel(x1, x2, sigmaVals(j)));	
	
        #determine prediction using model as input to svmPredict.m
	prediction = svmPredict(model, Xval);

        #calculate error using the method suggested in the assignment notes: 
	errors = mean(double(prediction ~= yval));

	results(i,j) = errors;
    end

end

#Find minimum error from results
[i,j] = find(results == min(results(:)) );

C = cVals(i);
sigma = sigmaVals(j);


% =========================================================================

end
