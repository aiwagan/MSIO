function win=integralorientations(img,win,numblocks,numang)
% Author: Asim Imdad Wagan
% Image loading and initial processing
%img = imread(docname) ;
%color processing
if (size(img,3)>1)
    img = uint8(rgb2gray(img)) ;
end
% variable initialization
[imgh imgw]=size(img);

%img= histeq(img);
%img= imadjust(img);

h=[-1 0 1];
dx=imfilter(double(img),h,'same');
dy=imfilter(double(img),h','same');
%[dx,dy]=gradient(double(img),2,2);
w=sqrt(dx.^2+dy.^2);
a=180*atan2(dx,dy)./pi;
a=360*(a<0)+a;
an=0:360/numang:360;    
[ax,ax]=histc(a,an);

%ax=ax.*double(edge(img,'canny'));
% Get integral counts of the angles for histo calc

for i=1:size(an,2)-1
    axi=(ax==i);
    wxi=axi.*w;
    intcount{i}=cumsum(cumsum(double(wxi),1),2);
end

for i=1:size(win,2)
fv=[];
for sc=1:size(numblocks,1)
    win(i).blocky=uint16(win(i).start(1):(win(i).end(1)-win(i).start(1))/numblocks(sc,1):win(i).end(1));
    win(i).blockx=uint16(win(i).start(2):(win(i).end(2)-win(i).start(2))/numblocks(sc,2):win(i).end(2));
    
    feat=zeros(numblocks(sc,1),numblocks(sc,2),numang);
   
    for j=1:numblocks(sc,1)
        for k=1:numblocks(sc,2)
           % disp (['j=' int2str(j) ' k=' int2str(k)]);
            ny1=win(i).blocky(j);
            ny2=win(i).blocky(j+1);
            nx1=win(i).blockx(k);
            nx2=win(i).blockx(k+1);
            
            for l=1:numang
                feat(j,k,l)=(intcount{l}(ny2,nx2)+intcount{l}(ny1,nx1)) ...
                    -(intcount{l}(ny1,nx2) + intcount{l}(ny2,nx1));
             end
            
        end
    end
    feat1=feat(:);
    feat1=(feat1./sqrt(sum(feat1.^2)));
    fv=[fv; feat1];
end

    % fv=filter([0.1664    0.6672    0.1664],1,fv);
    %fv=(fv./sqrt(sum(fv.^2)));
    win(i).descriptor=255*fv;
    %win(i).descriptor=fv;
end

end