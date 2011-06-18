function win=densepoints4(f,wsy,wsx,h,w)
    n=1;
    for s=1:10
    for i=1:size(f,2)
        chy=s*10+floor(wsy/2);
        chx=s*10+floor(wsx/2);
        sy=round(f(2,i)-chy);
        sx=round(f(1,i)-chx);
        fsy=round(f(2,i)+chy);
        fsx=round(f(1,i)+chx);
        if ((sy>0)&&(sx>0)&&(fsy<h)&&(fsx<w))
          win(n).start=[sy sx];
          win(n).end=[fsy fsx];
          n=n+1;
        end
    end
    end
end