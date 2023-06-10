function out = partitioner(features, labels, images)
    
    cv = cvpartition(labels, "HoldOut", 0.25);
    
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

end