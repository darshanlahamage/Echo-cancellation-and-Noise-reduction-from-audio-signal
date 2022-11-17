clc
 clear
 close all
 
fs=8000;     %  Sampling frequency in hertz
ch=1;        %  Number of channels--2 options--1 (mono) or 2 (stereo)
datatype='uint8';
nbits=16;     % 8,16,or 24
Nseconds=5;


recorder=audiorecorder(fs,nbits,ch);
disp('Start speaking..')


recordblocking(recorder,Nseconds);
disp('End of Recording.');


x=getaudiodata(recorder,datatype);
%Write audio file
audiowrite('test.wav',x,fs);

 d = 100; %echo delay

gsig = audioread ('test.wav');
sound(gsig);
pause(8)

x = gsig (d+1:end);
y = gsig (d+1:end) + 0.4*gsig(1:end-d);


 subplot (4,1,1); plot(gsig); title ('OG Signal');

M=3*d;
delta = 0.0001;
h = zeros(M,1);
ev = [];

for i = M+1:length(x)
    xn = x(i); %Desired sample value
    yn = y(i-M+1:i);
    xnhat = h'*yn;  %Filter output. 
    en = xn- xnhat;
    h = h+ delta*yn*en;
    
    
    ev = [ev abs(en)];
    sub = xn - ev;
    if rem (i,100) ==0;
        subplot (4,1,2);
        plot (h) ;
        title ('Impluse Response');
        subplot (4,1,3);
        plot (ev); 
        title ('|error|');
        subplot (4,1,4);
        plot (sub); 
        title ('"No Echo"');
        pause (0.001);
    end
end
