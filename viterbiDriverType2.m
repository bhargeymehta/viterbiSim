clear all;
sampleSize = 5000;
k = 10;
N = 2*k+2;

p = linspace(0.01, 0.99, 99);
expRes = zeros(1, sampleSize);
graphData = zeros(1, length(p));

for pError=1:length(p)
    for i=1:sampleSize
        data = decimalToBinaryVector(randperm((2.^k)-1, 1), k);
        [expRes(i), ] = viterbiSimV2(data, p(pError));
    end
    graphData(pError) = sum(expRes)/sampleSize;
end


str = strcat('k=', num2str(k), ' N=', num2str(N), ' || Sample Size=', num2str(sampleSize));
figure(1);
plot(p, graphData);
title('Viterbi Decoder Performance');
xlabel('Probability p of BSC'); ylabel('Probability of Successful Decoding');
legend(str); grid;