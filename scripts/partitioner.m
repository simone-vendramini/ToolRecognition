function out = partitioner(features, labels, images)

    % load("data.mat","features","images","labels");
    
    cv = cvpartition(labels, "HoldOut", 0.2);
    
    tr = cv.training(1);
    ts = cv.test(1);
    
    train.images = images(tr);
    train.labels = labels(tr);
    train.features = features(tr, :);
    
    test.images = images(ts);
    test.labels = labels(ts);
    test.features = features(ts, :);
    
    out.train = train;
    out.test = test;

    save('train_test.mat', "train", "test");

end