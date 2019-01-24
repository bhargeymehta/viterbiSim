function y=channelSim(transmittedString, errors)
if(errors >= 1)
    
    temp = randperm(length(transmittedString), errors);
    y = transmittedString;
    for i=1:errors
        y(temp(i)) = rem(y(temp(i))+1, 2);
    end
    
else
    
    y = transmittedString;
    p = errors;
    temp = randsrc(1, length(transmittedString), [1, 0; p, 1-p]);
    for i=1:length(transmittedString)
        y(i) = rem(y(i)+temp(i), 2);
    end
    
end

end