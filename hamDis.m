function y=hamDis(s1, s2)
if(s1==0)
   switch s2
       case 0
           y=0;
       case 3
           y=2;
       otherwise
           y=1;
   end
elseif(s1==1)
    switch s2
       case 1
           y=0;
       case 2
           y=2;
       otherwise
           y=1;
    end
elseif(s1==2)
    switch s2
       case 2
           y=0;
       case 1
           y=2;
       otherwise
           y=1;
    end
else
    switch s2
       case 3
           y=0;
       case 0
           y=2;
       otherwise
           y=1;
    end
end


end