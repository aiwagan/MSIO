function win=densepoints(d,h,w)
    n=1;
    for i=d:d:h-d
        for j=d:d:w-d
          win(n).start=[i-d+1 j-d+1];
          win(n).end=[i+d j+d];
          n=n+1; 
        end
    end
    
end