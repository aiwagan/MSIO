
npath='C:\Users\Asim\Code\data\iamtricrop\';
writers=[dir(npath)];
writers=writers(3:end);

nfeats=[];
n=1;
for i=1:size(writers,1)
    imglst=dir([npath writers(i).name '\*.png']);
    for j=1:size(imglst,1)
        img=imread([npath writers(i).name '\' imglst(j).name]);
     
        img=delrows(img);
        img=breaklines(img);
        win=[];
%         win(1).start=[1 1];
%         win(1).end=[size(img,1) size(img,2)];
        
        wy=128;
        wx=128;
        simg=zeros(size(img));
        z=1;
        for k=1:32:size(img,2)-wx
            win(z).start=[1 k];
            win(z).end=[wy k+wx];
            z=z+1;
        end
        numblocks=[4 4; 6 6; 8 8];
        numang=8;
        win=integralorientations(img,win,numblocks,numang);
        wr(n).name=writers(i).name;
        wr(n).feats=mean([win.descriptor],2);               %[win.descriptor
        ft=[win.descriptor];
        [pc, zscores, latent] = princomp(ft');
        
        n=n+1;
    end
    fprintf('Finished extracting features for writer: %d \n',i);
end
feats=[wr.feats];

[idx,c]=kmeans(feats',35);
writs=cellstr([char(wr.name)]);
finstr=[cellstr(int2str(idx)) writs];
[pc, zscores, pcvars] = princomp(feats');
figure
%pcclusters = clusterdata(zscores(:,1:2),35);
%gscatter(zscores(:,1),zscores(:,2),pcclusters);
gscatter(zscores(:,1),zscores(:,2),writs,'cmykrgbcmykrgbcmykrgbcmykrgbcmykrgb','xo*.+xo*.+xo*.+xo*.+xo*.+xo*.+xo*.+');

xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Principal Component Scatter Plot with Colored Clusters');
%gname(genes)  % Press enter when you finish selecting genes.
% fid = fopen('iam.arff', 'wt');
% fprintf(fid,'@RELATION IAM \n');
% fprintf(fid, '\n');
% for i=1:size([wr(1).feats],1)
%     fprintf(fid, '@ATTRIBUTE A%u   NUMERIC\n', i);
% end
% fprintf(fid, '\n');
% fprintf(fid, '@ATTRIBUTE class {');
% 
% for i=1:size(writers,1)
%     if (i<(size(writers,1)))
%         fprintf(fid, '%s,', writers(i).name);
%     else
%         fprintf(fid, '%s } \n', writers(i).name);
%     end
% end
% %fprintf(fid, '}\n');
% fprintf(fid, '\n');
% fprintf(fid,'@DATA \n');
% 
% for i=1:size(wr,2)
%     fprintf(fid, '%6.2f,', [wr(i).feats]);
%     fprintf(fid, '%s \n', wr(i).name);
% end
% fclose(fid);



