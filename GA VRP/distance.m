function val = distance(data,p1,p2)
   x1 = data(p1+1,2);
   x2 = data(p2+1,2);
   y1 = data(p1+1,3);
   y2 = data(p2+1,3);
   val = sqrt((x1-x2)^2 + (y1-y2)^2);
end