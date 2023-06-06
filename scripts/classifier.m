function out = classifier(type)

    load('train_test.mat');
    if type == "knn"
        cart = fitcknn(train.features, train.labels, 'NumNeighbors',15, 'Distance','mahalanobis');
    else
        cart = fitctree(train.features, train.labels);
        view(cart, "Mode","graph");
    end
    
    predict_train = predict(cart, train.features);
    performance_train = confmat(predict_train, train.labels);
    
    predict_test = predict(cart, test.features);
    performance_test = confmat(predict_test, test.labels);
    
    figure();
    show_confmat(performance_train.cm_raw, performance_train.labels);
    
    figure();
    show_confmat(performance_test.cm_raw, performance_test.labels);
    
    out = [performance_train.accuracy performance_test.accuracy];
    
    save('model.mat', "cart");

end