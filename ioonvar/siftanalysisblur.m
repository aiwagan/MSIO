%% Clurring analysis
img=imread('1370.png');
img = single(rgb2gray(img)) ;
fc = [160;120;20;0] ;
[f,d1] = vl_sift(img,'frames',fc) ;
rot=-10:1:10;
for i=1:size(rot,2)
    imgf=imrotate(img,rot(i),'crop');
    
    [f,d2] = vl_sift(imgf,'frames',fc) ;
    d3(i)= sqrt(sum( (d1 - d2) .^ 2 ));

end
mxds=sqrt((255^2)*128);
d3s=d3/mxds;

  plot(rot,d3s, rot, d3m);
  xlabel('Rotation Angle');
  ylabel('Distance between descriptors') ;
  
  



