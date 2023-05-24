close all;
clear;

load("data.mat");

% Example: 10-fold cross-validation
cv = cvpartition(length(images), 'KFold', 10);

train.avgAccTree = 0; train.avgAccEcoc = 0; train.avgAccKnn = 0;
train.bestAccTree = 0; train.bestAccEcoc = 0; train.bestAccKnn = 0;

test.avgAccTree = 0; test.avgAccEcoc = 0; test.avgAccKnn = 0;
test.bestAccTree = 0; test.bestAccEcoc = 0; test.bestAccKnn = 0;

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

    %% TREE
    model = fitctree(train.features, train.labels);

    % train
    predict_train = predict(model, train.features);
    tot = 0;

    for i=1 : numel(train.labels)
        if isequal(predict_train(i), train.labels(i))
            tot = tot + 1;
        end
    end
    
    acc = tot / numel(train.labels);
    train.avgAccTree = train.avgAccTree + acc;
    
    if acc > train.bestAccTree
        train.bestAccTree = acc;
        train.bestTreeModel = predict_train;
    end

    % test
    predict_test = predict(model, test.features);
    tot = 0;

    for i=1 : numel(test.labels)
        if isequal(predict_test(i), test.labels(i))
            tot = tot + 1;
        end
    end
    
    acc = tot / numel(test.labels);
    test.avgAccTree = test.avgAccTree + acc;
    
    if acc > test.bestAccTree
        test.bestAccTree = acc;
        test.bestTreeModel = predict_test;
    end
    
    %% ECOC
    model = fitcecoc(train.features, train.labels);

    % train
    predict_train = predict(model, train.features);
    tot = 0;

    for i=1 : numel(train.labels)
        if isequal(predict_train(i), train.labels(i))
            tot = tot + 1;
        end
    end

    acc = tot / numel(train.labels);
    train.avgAccEcoc = train.avgAccEcoc + acc;

    if acc > train.bestAccEcoc
        train.bestAccEcoc = acc;
        train.bestEcocModel = predict_train;
    end

    % test
    predict_test = predict(model, test.features);
    tot = 0;

    for i=1 : numel(test.labels)
        if isequal(predict_test(i), test.labels(i))
            tot = tot + 1;
        end
    end

    acc = tot / numel(test.labels);
    test.avgAccEcoc = test.avgAccEcoc + acc;

    if acc > test.bestAccEcoc
        test.bestAccEcoc = acc;
        test.bestEcocModel = predict_test;
    end

    %% KNN
    model = fitcknn(train.features, train.labels);

    % train
    predict_train = predict(model, train.features);
    tot = 0;

    for i=1 : numel(train.labels)
        if isequal(predict_train(i), train.labels(i))
            tot = tot + 1;
        end
    end

    acc = tot / numel(train.labels);
    train.avgAccKnn = train.avgAccKnn + acc;

    if acc > train.bestAccKnn
        train.bestAccKnn = acc;
        train.bestKnnModel = predict_train;
    end

    % test
    predict_test = predict(model, test.features);
    tot = 0;

    for i=1 : numel(test.labels)
        if isequal(predict_test(i), test.labels(i))
            tot = tot + 1;
        end
    end

    acc = tot / numel(test.labels);
    test.avgAccKnn = test.avgAccKnn + acc;

    if acc > test.bestAccKnn
        test.bestAccKnn = acc;
        test.bestKnnModel = predict_test;
    end
end

train.avgAccTree = train.avgAccTree / cv.NumTestSets;
train.avgAccEcoc = train.avgAccEcoc / cv.NumTestSets;
train.avgAccKnn = train.avgAccKnn / cv.NumTestSets;

train

test.avgAccTree = test.avgAccTree / cv.NumTestSets;
test.avgAccEcoc = test.avgAccEcoc / cv.NumTestSets;
test.avgAccKnn = test.avgAccKnn / cv.NumTestSets;

test

performance_trainEcc = confmat(train.bestEcocModel, train.labels);
performance_trainKnn = confmat(train.bestKnnModel, train.labels);
performance_trainTree = confmat(train.bestTreeModel, train.labels);

performance_testEcc = confmat(test.bestEcocModel, test.labels);
performance_testKnn = confmat(test.bestKnnModel, test.labels);
performance_testTree = confmat(test.bestTreeModel, test.labels);

subplot(2,3,1), show_confmat(performance_trainEcc.cm_raw, performance_trainEcc.labels), title("train ecc");
subplot(2,3,2), show_confmat(performance_trainKnn.cm_raw, performance_trainKnn.labels), title("train knn");
subplot(2,3,3), show_confmat(performance_trainTree.cm_raw, performance_trainTree.labels), title("train tree");

subplot(2,3,4), show_confmat(performance_testEcc.cm_raw, performance_testEcc.labels), title("test ecc");
subplot(2,3,5), show_confmat(performance_testKnn.cm_raw, performance_testKnn.labels), title("test knn");
subplot(2,3,6), show_confmat(performance_testTree.cm_raw, performance_testTree.labels), title("test tree");

