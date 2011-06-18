%% Clurring analysis
img=imread('1370.png');
win=[];
win(1).start=[1 1];
win(1).end=[size(img,1) size(img,2)];
numblocks=[4 4; 6 6; 8 8];
numang=8;
win=integralorientations(img,win,numblocks,numang);
d1=win(1).descriptor;
scl=0.8:0.04:1.2;
for i=1:11
    imgf=imresize(img,scl(i));
    win=[];
    win(1).start=[1 1];
    win(1).end=[size(imgf,1) size(imgf,2)];
    numblocks=[4 4; 6 6; 8 8];
    numang=8;
    win=integralorientations(imgf,win,numblocks,numang);
    d2=win(1).descriptor;
    d3(i)= sqrt(sum( (d1 - d2) .^ 2 ));

end

 mxdm=sqrt((255^2)*928);
d3m=d3/mxdm;

%% SIFT Descriptor

img = single(rgb2gray(img)) ;
fc = [160;120;20;0] ;
[f,d1] = vl_sift(img,'frames',fc) ;
scl=0.8:0.04:1.2;
for i=1:size(scl,2)
    imgf=imresize(img,scl(i));
    [f,d2] = vl_sift(imgf,'frames',fc) ;
    d3(i)= sqrt(sum( (d1 - d2) .^ 2 ));

end
mxds=sqrt((255^2)*128);
d3s=d3/mxds;



%%Final Result
plot(scl,d3s,'k-+', scl, d3m,'k--o');

xlabel('Scaling');
ylabel('Distance') ;
legend('SIFT','MSIO');


  