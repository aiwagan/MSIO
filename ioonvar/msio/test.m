%% Clurring analysis
img=imread('1370.png');
win=[];
win(1).start=[1 1];
win(1).end=[size(img,1) size(img,2)];
numblocks=[4 4; 6 6; 8 8];
numang=8;
win=integralorientations(img,win,numblocks,numang);
d1=win(1).descriptor;
