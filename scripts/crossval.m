close all;
clear;

load("data.mat");

% Example: 10-fold cross-validation
cv = cvpartition(length(images), 'KFold', 5);

train.avgTreeMat = {}; train.avgEcocMat = {}; train.avgKnnMat = {};

test.avgTreeMat = {}; test.avgEcocMat = {}; test.avgKnnMat = {};

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
    
    % avg model
    tmpMat = confmat(predict_train, train.labels);
    tmpMat.cm(isnan(tmpMat.cm)) = 0;
    tmpMat.cm_raw(isnan(tmpMat.cm_raw)) = 0;

    if (size(tmpMat.cm) ~= [13 13])
        tmpMat.cm(13,13) = 0;
    end
    if (size(tmpMat.cm_raw) ~= [13 13])
        tmpMat.cm_raw(13,13) = 0;
    end

    if isempty(train.avgTreeMat)
        train.avgTreeMat = tmpMat;
    else
        train.avgTreeMat.cm = train.avgTreeMat.cm + tmpMat.cm;
        train.avgTreeMat.cm_raw = train.avgTreeMat.cm_raw + tmpMat.cm_raw;
        train.avgTreeMat.accuracy = train.avgTreeMat.accuracy + tmpMat.accuracy;
    end

    % test
    predict_test = predict(model, test.features);

    % avg model
    tmpMat = confmat(predict_test, test.labels);
    tmpMat.cm(isnan(tmpMat.cm)) = 0;
    tmpMat.cm_raw(isnan(tmpMat.cm_raw)) = 0;

    if (size(tmpMat.cm) ~= [13 13])
        tmpMat.cm(13,13) = 0;
    end
    if (size(tmpMat.cm_raw) ~= [13 13])
        tmpMat.cm_raw(13,13) = 0;
    end

    if isempty(test.avgTreeMat)
        test.avgTreeMat = tmpMat;
    else
        test.avgTreeMat.cm = test.avgTreeMat.cm + tmpMat.cm;
        test.avgTreeMat.cm_raw = test.avgTreeMat.cm_raw + tmpMat.cm_raw;
        test.avgTreeMat.accuracy = test.avgTreeMat.accuracy + tmpMat.accuracy;
    end
    
    %% ECOC
    model = fitcecoc(train.features, train.labels);

    % train
    predict_train = predict(model, train.features);
    
    % avg model
    tmpMat = confmat(predict_train, train.labels);
    tmpMat.cm(isnan(tmpMat.cm)) = 0;
    tmpMat.cm_raw(isnan(tmpMat.cm_raw)) = 0;

    if (size(tmpMat.cm) ~= [13 13])
        tmpMat.cm(13,13) = 0;
    end
    if (size(tmpMat.cm_raw) ~= [13 13])
        tmpMat.cm_raw(13,13) = 0;
    end

    if isempty(train.avgEcocMat)
        train.avgEcocMat = tmpMat;
    else
        train.avgEcocMat.cm = train.avgEcocMat.cm + tmpMat.cm;
        train.avgEcocMat.cm_raw = train.avgEcocMat.cm_raw + tmpMat.cm_raw;
        train.avgEcocMat.accuracy = train.avgEcocMat.accuracy + tmpMat.accuracy;
    end

    % test
    predict_test = predict(model, test.features);

    % avg model
    tmpMat = confmat(predict_test, test.labels);
    tmpMat.cm(isnan(tmpMat.cm)) = 0;
    tmpMat.cm_raw(isnan(tmpMat.cm_raw)) = 0;

    if (size(tmpMat.cm) ~= [13 13])
        tmpMat.cm(13,13) = 0;
    end
    if (size(tmpMat.cm_raw) ~= [13 13])
        tmpMat.cm_raw(13,13) = 0;
    end

    if isempty(test.avgEcocMat)
        test.avgEcocMat = tmpMat;
    else
        test.avgEcocMat.cm = test.avgEcocMat.cm + tmpMat.cm;
        test.avgEcocMat.cm_raw = test.avgEcocMat.cm_raw + tmpMat.cm_raw;
        test.avgEcocMat.accuracy = test.avgEcocMat.accuracy + tmpMat.accuracy;
    end

    %% KNN
    model = fitcknn(train.features, train.labels);

    % train
    predict_train = predict(model, train.features);
    
    % avg model
    tmpMat = confmat(predict_train, train.labels);
    tmpMat.cm(isnan(tmpMat.cm)) = 0;
    tmpMat.cm_raw(isnan(tmpMat.cm_raw)) = 0;

    if (size(tmpMat.cm) ~= [13 13])
        tmpMat.cm(13,13) = 0;
    end
    if (size(tmpMat.cm_raw) ~= [13 13])
        tmpMat.cm_raw(13,13) = 0;
    end

    if isempty(train.avgKnnMat)
        train.avgKnnMat = tmpMat;
    else
        train.avgKnnMat.cm = train.avgKnnMat.cm + tmpMat.cm;
        train.avgKnnMat.cm_raw = train.avgKnnMat.cm_raw + tmpMat.cm_raw;
        train.avgKnnMat.accuracy = train.avgKnnMat.accuracy+ tmpMat.accuracy;
    end

    % test
    predict_test = predict(model, test.features);

    % avg model
    tmpMat = confmat(predict_test, test.labels);
    tmpMat.cm(isnan(tmpMat.cm)) = 0;
    tmpMat.cm_raw(isnan(tmpMat.cm_raw)) = 0;

    if (size(tmpMat.cm) ~= [13 13])
        tmpMat.cm(13,13) = 0;
    end
    if (size(tmpMat.cm_raw) ~= [13 13])
        tmpMat.cm_raw(13,13) = 0;
    end

    if isempty(test.avgKnnMat)
        test.avgKnnMat = tmpMat;
    else
        test.avgKnnMat.cm = test.avgKnnMat.cm + tmpMat.cm;
        test.avgKnnMat.cm_raw = test.avgKnnMat.cm_raw + tmpMat.cm_raw;
        test.avgKnnMat.accuracy = test.avgKnnMat.accuracy + tmpMat.accuracy;
    end
end

%% avg acc
train.avgEcocMat.accuracy = train.avgEcocMat.accuracy / cv.NumTestSets;
train.avgKnnMat.accuracy = train.avgKnnMat.accuracy / cv.NumTestSets;
train.avgTreeMat.accuracy = train.avgTreeMat.accuracy / cv.NumTestSets;

test.avgEcocMat.accuracy = test.avgEcocMat .accuracy/ cv.NumTestSets;
test.avgKnnMat.accuracy = test.avgKnnMat.accuracy / cv.NumTestSets;
test.avgTreeMat.accuracy = test.avgTreeMat.accuracy / cv.NumTestSets;

%% avg mat
train.avgEcocMat.cm = train.avgEcocMat.cm / cv.NumTestSets;
train.avgKnnMat.cm = train.avgKnnMat.cm / cv.NumTestSets;
train.avgTreeMat.cm = train.avgTreeMat.cm / cv.NumTestSets;

test.avgEcocMat.cm = test.avgEcocMat.cm / cv.NumTestSets;
test.avgKnnMat.cm = test.avgKnnMat.cm / cv.NumTestSets;
test.avgTreeMat.cm = test.avgTreeMat.cm / cv.NumTestSets;

train.avgEcocMat.cm_raw = floor(train.avgEcocMat.cm_raw / cv.NumTestSets);
train.avgKnnMat.cm_raw = floor(train.avgKnnMat.cm_raw / cv.NumTestSets);
train.avgTreeMat.cm_raw = floor(train.avgTreeMat.cm_raw/ cv.NumTestSets);

test.avgEcocMat.cm_raw = floor(test.avgEcocMat.cm_raw / cv.NumTestSets);
test.avgKnnMat.cm_raw = floor(test.avgKnnMat.cm_raw / cv.NumTestSets);
test.avgTreeMat.cm_raw = floor(test.avgTreeMat.cm_raw / cv.NumTestSets);

performance_trainEcoc = train.avgEcocMat;
performance_trainKnn = train.avgKnnMat;
performance_trainTree = train.avgTreeMat;

performance_testEcoc = test.avgEcocMat;
performance_testKnn = test.avgKnnMat;
performance_testTree = test.avgTreeMat;

%% show
subplot(2,3,1), show_confmat(performance_trainEcoc.cm_raw, performance_trainEcoc.labels), title("train ecc");
subplot(2,3,2), show_confmat(performance_trainKnn.cm_raw, performance_trainKnn.labels), title("train knn");
subplot(2,3,3), show_confmat(performance_trainTree.cm_raw, performance_trainTree.labels), title("train tree");

subplot(2,3,4), show_confmat(performance_testEcoc.cm_raw, performance_testEcoc.labels), title("test ecc");
subplot(2,3,5), show_confmat(performance_testKnn.cm_raw, performance_testKnn.labels), title("test knn");
subplot(2,3,6), show_confmat(performance_testTree.cm_raw, performance_testTree.labels), title("test tree");

