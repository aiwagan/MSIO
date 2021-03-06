%% Clurring analysis
img=imread('1370.png');
win=[];
win(1).start=[1 1];
win(1).end=[size(img,1) size(img,2)];
numblocks=[4 4; 6 6; 8 8];
numang=8;
win=integralorientations(img,win,numblocks,numang);
d1=win(1).descriptor;
gm=1:1:10;
for i=1:size(gm,2)
    h = fspecial('gaussian',gm(i),gm(i));
    imgf=imfilter(img,h);
    win=[];
    win(1).start=[1 1];
    win(1).end=[size(img,1) size(img,2)];
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
gm=1:1:10;
for i=1:size(gm,2)
    h = fspecial('gaussian',gm(i),gm(i));
    imgf=imfilter(img,h);
    
    [f,d2] = vl_sift(imgf,'frames',fc) ;
    d3(i)= sqrt(sum( (d1 - d2) .^ 2 ));

end
mxds=sqrt((255^2)*128);
d3s=d3/mxds;



%%Final Result
plot(gm,d3s,'k-+', gm, d3m,'k--o');
xlabel('Blur');
ylabel('Distance') ;
legend('SIFT','MSIO');


  