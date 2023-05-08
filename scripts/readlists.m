function [images,labels]=readlists(path_im, path_lb)
  f=fopen(path_im);
  z = textscan(f,'%s');
  fclose(f);
  images = z{:}; 

  f=fopen(path_lb);
  l = textscan(f,'%s');
  labels = l{:};
  fclose(f);
end
