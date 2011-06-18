%% Clurring analysis
img=imread('1370.png');
win=[];
win(1).start=[1 1];
win(1).end=[size(img,1) size(img,2)];
numblocks=[4 4; 6 6; 8 8];
numang=8;
win=integralorientations(img,win,numblocks,numang);
d1=win(1).descriptor;

for i=1:10
    h = fspecial('gaussian',i,i);
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
