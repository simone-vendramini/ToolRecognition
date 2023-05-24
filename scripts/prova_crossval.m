close all;
clear;

load("data.mat");

% Example: 10-fold cross-validation
cv = cvpartition(length(images), 'KFold', 10);

for fold = 1:cv.NumTestSets
    % Get the indices of the training set for the current fold
    trainIndices = cv.training(fold);

    % Get the indices of the test set for the current fold
    testIndices = cv.test(fold);

    % Extract the training features and labels
    train.features = features(trainIndices, :);
    train.labels = labels(trainIndices);

    % Extract the test features and labels
    test.features = features(testIndices, :);
    test.labels = labels(testIndices);

    % Example: Train and evaluate a classifier (e.g., SVM)
    svmModel = fitcsvm(train.features, train.labels);
    y_pred = predict(svmModel, test.features);
    accuracy = sum(y_pred == test.labels) / numel(test.labels)
end

% Load dataset from a CSV file
% data = csvread('dataset.csv');

% Split the data into training and test sets
% cv = cvpartition(size(data, 1), 'HoldOut', 0.2);  % 80% for training, 20% for testing

% Indices of the training set
% trainIndices = training(cv);

% Indices of the test set
% testIndices = test(cv);

% Split the data into training and test sets
% X_train = data(trainIndices, 1:end-1);  % Input features for training
% y_train = data(trainIndices, end);      % Target labels for training

% X_test = data(testIndices, 1:end-1);    % Input features for testing
% y_test = data(testIndices, end);        % Target labels for testing

