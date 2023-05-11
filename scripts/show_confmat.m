function show_confmat(cm_raw,labels)
  confusionchart(cm_raw,labels,'normalization','row-normalized')
  set(gca,'FontSize',14);
end