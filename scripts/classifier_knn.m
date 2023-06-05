close all;
clear;

load('train_test.mat');

cart = fitcknn(train.features, train.labels, 'NumNeighbors',15);

predict_train = predict(cart, train.features);
performance_train = confmat(predict_train, train.labels);

predict_test = predict(cart, test.features);
performance_test = confmat(predict_test, test.labels);

figure();
show_confmat(performance_train.cm_raw, performance_train.labels);

figure();
show_confmat(performance_test.cm_raw, performance_test.labels);

save('model_knn.mat', "cart");