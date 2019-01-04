function result = SwapSubpath(ncities, path, start, length)
i = start;
j = mod(start-1 + length - 1, ncities)+1;

while ( length > 1 ) 
   temp = path(i);
   path(i) = path(j);
   path(j) = temp;
   length = length - 2;
   i=i+1;
   if ( i >= ncities ) 
       i = 1;%0;
   end
   j = j-1;
   if ( j <  1 ) 
       j = ncities ;
   end
end

result = path;