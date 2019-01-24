function [decodingSuccess, recoveredString] = viterbiSimV2(dataString, x)
encodedString = viterbiEncoder(dataString);
recievedString = channelSim(encodedString, x);
stateString = zeros(1, length(recievedString)/2);

for i=1:2:length(recievedString)-1
    if([recievedString(i) recievedString(i+1)] == [0 0])
        stateString((i+1)/2) = 0;
    elseif([recievedString(i) recievedString(i+1)] == [0 1])
        stateString((i+1)/2) = 1;
    elseif([recievedString(i) recievedString(i+1)] == [1 0])
        stateString((i+1)/2) = 2;
    else
        stateString((i+1)/2) = 3;
    end
end

levelDis = zeros(2, 4);
levelDecision = zeros(length(stateString), 4);

levelDis(1, 1) = hamDis(stateString(1), stateTrans(0, 0)) + hamDis(stateString(2), stateTrans(0, 0));
levelDis(1, 2) = hamDis(stateString(1), stateTrans(0, 2)) + hamDis(stateString(2), stateTrans(2, 1));
levelDis(1, 3) = hamDis(stateString(1), stateTrans(0, 0)) + hamDis(stateString(2), stateTrans(0, 2));
levelDis(1, 4) = hamDis(stateString(1), stateTrans(0, 2)) + hamDis(stateString(2), stateTrans(2, 3));

levelDecision(2, 1) = 0;
levelDecision(2, 2) = 2;
levelDecision(2, 3) = 0;
levelDecision(2, 4) = 2;


for i=3:length(stateString)-2
    
    path1 = levelDis(1, 1) + hamDis(stateString(i), stateTrans(0, 0)); %state0->state0
    path2 = levelDis(1, 2) + hamDis(stateString(i), stateTrans(1, 0)); %state1->state0
    if(path1<path2)
        levelDecision(i, 1) = 0;
        levelDis(2, 1) = path1;
    else
        levelDecision(i, 1) = 1;
        levelDis(2, 1) = path2;
    end
    
    path1 = levelDis(1, 3) + hamDis(stateString(i), stateTrans(2, 1)); %state2->state1
    path2 = levelDis(1, 4) + hamDis(stateString(i), stateTrans(3, 1)); %state3->state1
    if(path1<path2)
        levelDecision(i, 2) = 2;
        levelDis(2, 2) = path1;
    else
        levelDecision(i, 2) = 3;
        levelDis(2, 2) = path2;
    end
    
    path1 = levelDis(1, 1) + hamDis(stateString(i), stateTrans(0, 2)); %state0->state2
    path2 = levelDis(1, 2) + hamDis(stateString(i), stateTrans(1, 2)); %state1->state2
    if(path1<path2)
        levelDecision(i, 3) = 0;
        levelDis(2, 3) = path1;
    else
        levelDecision(i, 3) = 1;
        levelDis(2, 3) = path2;
    end
    
    path1 = levelDis(1, 4) + hamDis(stateString(i), stateTrans(3, 3)); %state3->state3
    path2 = levelDis(1, 3) + hamDis(stateString(i), stateTrans(2, 3)); %state2->state3
    if(path1<path2)
        levelDecision(i, 4) = 3;
        levelDis(2, 4) = path1;
    else
        levelDecision(i, 4) = 2;
        levelDis(2, 4) = path2;
    end
    
    levelDis(1, :) = levelDis(2, :);
    
end

    path1 = levelDis(1, 1) + hamDis(stateString(i+1), stateTrans(0, 0)); %state0->state0
    path2 = levelDis(1, 2) + hamDis(stateString(i+1), stateTrans(1, 0)); %state1->state0
    if(path1<path2)
        levelDecision(i+1, 1) = 0;
        levelDis(2, 1) = path1;
    else
        levelDecision(i+1, 1) = 1;
        levelDis(2, 1) = path2;
    end
    
    path1 = levelDis(1, 3) + hamDis(stateString(i), stateTrans(2, 1)); %state2->state1
    path2 = levelDis(1, 4) + hamDis(stateString(i), stateTrans(3, 1)); %state3->state1
    if(path1<path2)
        levelDecision(i+1, 2) = 2;
        levelDis(2, 2) = path1;
    else
        levelDecision(i+1, 2) = 3;
        levelDis(2, 2) = path2;
    end
    levelDis(1, :) = levelDis(2, :);
    
    path1 = levelDis(1, 1) + hamDis(stateString(i+2), stateTrans(0, 0)); %state0->state0
    path2 = levelDis(1, 2) + hamDis(stateString(i+2), stateTrans(1, 0)); %state1->state0
    if(path1<path2)
        levelDecision(i+2, 1) = 0;
    else
        levelDecision(i+2, 1) = 1;
    end
    
clear levelDis;
decisions = zeros(1, length(stateString)+1);
decisions(length(stateString)+1) = 0;
for i=length(stateString):-1:2
    decisions(i) = levelDecision(i, decisions(i+1)+1);        
end

recoveredString = zeros(1, length(decisions)-3);
for i=1:length(decisions)-3
    recoveredString(i) = stateOut(decisions(i), decisions(i+1));
end

if(recoveredString == dataString)
    decodingSuccess = 1;
else
    decodingSuccess = 0;
end

end