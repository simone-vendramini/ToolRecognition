function out = cross_validation()
    load("train_test.mat");
    tree = fitctree(train.features, train.labels, "MaxNumSplits", 20);

    % 2b. Definizione del modello KNN
    knn = fitcknn(train.features, train.labels, "NumNeighbors", 15, "Distance", "mahalanobis");
    
    % 3a. Creazione del modello di cross-validation per l'albero decisionale
    cv_tree = crossval(tree, 'KFold', 5); % Utilizza 5 fold
    
    % 3b. Creazione del modello di cross-validation per KNN
    cv_knn = crossval(knn, 'KFold', 5); % Utilizza 5 fold
    
    % 4a. Valutazione del modello di albero decisionale
    out.loss_tree = kfoldLoss(cv_tree);
    
    % 4b. Valutazione del modello KNN
    out.loss_knn = kfoldLoss(cv_knn);

end