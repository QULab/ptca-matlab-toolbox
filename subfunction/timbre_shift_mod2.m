function output = timbre_shift_mod2(x,n) 
freq = n;
xx = fft(x);
xxx = zeros(length(xx),1);
a = xxx(freq+1:end);
b = xx(1:end-freq);
xxx(freq+1:end) = xx(1:end-freq);
xxxx = xxx+xx;
y = ifft(xxx);

output = y;