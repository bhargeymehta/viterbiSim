function y=stateOut(i, j)
if(i == 0 && j == 0)
    y = 0;
elseif(i == 0 && j == 2)
    y = 1;
elseif(i == 1 && j == 0)
    y = 0;
elseif(i == 1 && j == 2)
    y = 1;
elseif(i == 2 && j == 1)
    y = 0;
elseif(i == 2 && j == 3)
    y = 1;
elseif(i == 3 && j == 3)
    y = 1;
elseif(i == 3 && j == 1)
    y = 0;
end


end