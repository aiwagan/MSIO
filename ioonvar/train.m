
npath='C:\Users\Asim\Code\data\iamtricrop\';
writers=[dir(npath)];
writers=writers(3:end);

nfeats=[];
n=1;
for i=1:size(writers,1)
    imglst=dir([npath writers(i).name '\*.png']);
    for j=1:size(imglst,1)
        img=imread([npath writers(i).name '\' imglst(j).name]);
        win=[];
        win(1).start=[1 1];
        win(1).end=[size(img,1) size(img,2)];
        numblocks=[4 4; 6 6];
        numang=8;
        win=integralorientations(img,win,numblocks,numang);
        wr(n).name=writers(i).name;
        wr(n).feats=[win.descriptor];
        n=n+1;
    end
    fprintf('Finished extracting features for writer: %d \n',i);
end
feats=[wr.feats];
[idx,c]=kmeans(feats',35);
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



