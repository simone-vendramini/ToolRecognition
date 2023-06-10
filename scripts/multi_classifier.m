close all;
clear;

%% Segmentazione ed estrazione features
data = feature_extraction();
features_knn = data.features_ANOVA;
labels = data.labels;
images = data.images;

features_tree = data.features_MRMR;

%% Partizionamento
train_test_split = partitioner(features_knn, labels, images);
train_knn = train_test_split.train;
test_knn = train_test_split.test;

train_test_split = partitioner(features_tree, labels, images);
train_tree = train_test_split.train;
test_tree = train_test_split.test;
%% Creazione del modello
% KNN (15, mahalanobis)
knnMahalanobis = fitcknn(train_knn.features, train_knn.labels, 'NumNeighbors',15, 'Distance','mahalanobis');
acc_knn = model_evaluation(knnMahalanobis, train_knn, test_knn);

% Tree ("MaxNumSplits", 20)
cart = fitctree(train_tree.features, train_tree.labels, "MaxNumSplits", 20);
view(cart, "Mode","graph");
acc_tree = model_evaluation(cart, train_tree, test_tree);

save("multi_classifier.mat", "knnMahalanobis", "cart");

function out = model_evaluation(classifier, train, test)
    predict_train = predict(classifier, train.features);
    performance_train = confmat(train.labels, predict_train);
    
    predict_test = predict(classifier, test.features);
    performance_test = confmat(test.labels, predict_test);
    
    figure();
    show_confmat(performance_train.cm_raw, performance_train.labels), title("Train");
    
    figure();
    show_confmat(performance_test.cm_raw, performance_test.labels), title("Test");
    
    out = [performance_train.accuracy performance_test.accuracy];
end
