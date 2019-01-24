clear all;
sampleSize = 5000;
k = 10;
N = 2*k+2;

p = zeros(1, N);
pRes = zeros(1, sampleSize);

for errors=1:N
    for i=1:sampleSize
        data = decimalToBinaryVector(randperm(2.^k-1, 1), k);
        [pRes(i), ] = viterbiSimV2(data, errors);
    end
    p(errors) = sum(pRes)/sampleSize;
end

str = strcat('k=', num2str(k), ' N=', num2str(N), ' || Sample Size=', num2str(sampleSize));
figure(1);
stem(linspace(1, N, N), p);
title('Viterbi Decoder Performance');
xlabel('Number of Bits in error from Encoded String'); ylabel('Probability of Successful Decoding');
legend(str); grid;

clear i errors p pRes str;