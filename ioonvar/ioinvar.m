%load the image
img=imread('1370.png');


win=[16; 32];
numblocks=[4 4];
numang=8;
imd=integralorientations(img,win,numblocks,numang);
A=imd;
imdilate(A,ones(3,3)) == A;

