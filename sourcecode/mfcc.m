function v = mfcc(s, fs)
%MFCC Summary of this function goes here
%   Detailed explanation goes here

% frame blocking , windowing , fft , mel freq wrapping , cepstrum
v = [];
M = 100;
N = 256;
temp = zeros(N);
for i = 1:floor(length(s)/M)-1
    for j = 1:N
        if((i-1)*M+j <= length(s))
            v(i,j)=s((i-1)*M+j);
        else
            v(i,j) = 0;
        end
    end
end
figure(2),imagesc(v),title('Speech frame'),xlabel('Frame number'), ylabel('Speech samples in frame');
w = hamming(N);
windowed = zeros(floor(length(s)/M)-1,N);
for i = 1:floor(length(s)/M)-1
    temp = v(i,:);
    for j =1:N
        windowed(i,:)=w'.*temp;
    end
end
figure(3),imagesc(windowed),title('Windowed Frame'),xlabel('Frame Number'), ylabel('Speech samples in frame');
Xfft = zeros(N,floor(length(s)/M)-1);
Xfft = fft(windowed');
magx = abs(Xfft).^2;
for k = 1:N/2+1
    psdx(k,:) = magx(k,:);
end
figure(4),imagesc(psdx),title('Spectrogram'),xlabel('Time(frame number)'),ylabel('Frequency (FFT number)');
set(gca,'YDir','normal');
n_fbanks = 26;
mel = melfb(n_fbanks,N,fs);
figure(5),plot(linspace(0, (12500/2), 129), melfb(20, 256, 12500)'),title('Mel-spaced filterbank'), xlabel('Frequency (Hz)');
melcc = mel*psdx(1:N/2+1,:);
figure(6),imagesc(melcc),title('Mel spectrum'),xlabel('Time (frame number)'),ylabel('(Frequency)Mel number');
set(gca,'YDir','normal');
ceps = dct(log(melcc));
figure(7),imagesc(ceps),title('Mel-frequency Cepstrum coefficients'),xlabel('Time(frame number)'),ylabel('MFCC');
set(gca,'YDir','normal');
end
    