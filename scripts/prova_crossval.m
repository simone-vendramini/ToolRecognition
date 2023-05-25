close all;
clear;

load("data.mat");

% Example: 10-fold cross-validation
cv = cvpartition(length(images), 'KFold', 10);
avgAccTree = 0;
avgAccEcoc = 0;
avgAccKnn = 0;
avgAccKmeans = 0;
avgAccRTree = 0;

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
    model = fitctree(train.features, train.labels);
    y_pred = predict(model, test.features);
    tot = 0;

    for i=1 : numel(test.labels)
        if isequal(y_pred(i), test.labels(i))
            tot = tot + 1;
        end
    end

    avgAccTree = avgAccTree + (tot / numel(test.labels));

    % ecoc
    model = fitcecoc(train.features, train.labels);
    y_pred = predict(model, test.features);
    tot = 0;

    for i=1 : numel(test.labels)
        if isequal(y_pred(i), test.labels(i))
            tot = tot + 1;
        end
    end

    avgAccEcoc = avgAccEcoc + (tot / numel(test.labels));

    % knn
    model = fitcknn(train.features, train.labels);
    y_pred = predict(model, test.features);
    tot = 0;

    for i=1 : numel(test.labels)
        if isequal(y_pred(i), test.labels(i))
            tot = tot + 1;
        end
    end

    avgAccKnn = avgAccKnn + (tot / numel(test.labels));
end

avgAccTree = avgAccTree / cv.NumTestSets
avgAccEcoc = avgAccEcoc / cv.NumTestSets
avgAccKnn = avgAccKnn / cv.NumTestSets
