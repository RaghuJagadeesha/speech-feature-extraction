function train(traindir, n)
for i = 1:n                     % train a VQ codebook for each speaker
    file = sprintf('%ss%d.wav', traindir, i);           
    disp(file);
    [s, fs] = audioread(file);
    figure(1),plot(s),title('Speech signal'),xlabel('Time(Samples)');
    v = mfcc(s, fs);            % Compute MFCC's
end