function encodedString=viterbiEncoder(dataString)
dataString=[dataString 0 0];
d1=0;
d2=0;
encodedString=zeros(1, length(dataString)*2);

for i=1:length(dataString)
    
   if(d1==0 && d2==0)
       if(dataString(i)==0)
          encodedString((i-1)*2+1)=0;
          encodedString((i-1)*2+2)=0;
       else
           encodedString((i-1)*2+1)=1;
           encodedString((i-1)*2+2)=1;
       end
   elseif(d1==0 && d2==1)
       if(dataString(i)==0)
          encodedString((i-1)*2+1)=1;
          encodedString((i-1)*2+2)=1;
       else
           encodedString((i-1)*2+1)=0;
           encodedString((i-1)*2+2)=0;
       end 
   elseif(d1==1 && d2==0)
       if(dataString(i)==0)
          encodedString((i-1)*2+1)=0;
          encodedString((i-1)*2+2)=1;
       else
           encodedString((i-1)*2+1)=1;
           encodedString((i-1)*2+2)=0;
       end
   else
       if(dataString(i)==0)
          encodedString((i-1)*2+1)=1;
          encodedString((i-1)*2+2)=0;
       else
           encodedString((i-1)*2+1)=0;
           encodedString((i-1)*2+2)=1;
       end       
   end
   
   d2=d1;
   d1=dataString(i);
   
end

end