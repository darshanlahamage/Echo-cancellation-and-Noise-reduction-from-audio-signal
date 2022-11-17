clc;
clear all; 
warning off
Fs=8000;     %  Sampling frequency in hertz
ch=1;        %  Number of channels--2 options--1 (mono) or 2 (stereo)
datatype='uint8';
nbits = 16 ;     % 8,16,or 24
Nseconds=5;

% to record audio data from an input device ...
...such as a microphone for processing in MATLAB

recorder=audiorecorder(Fs,nbits,ch);
disp('Start speaking..')

%Record audio to audiorecorder object,...
...hold control until recording completes
recordblocking(recorder,Nseconds);
disp('End of Recording.');

%Store recorded audio signal in numeric array
x=getaudiodata(recorder,datatype);
%Write audio file
audiowrite('test.wav',x,Fs);
 %% add original signal 
 [x,Fs] = audioread('test.wav');  
 sound(x,Fs);  
 pause(10);  

 delay = 0.5;         % 0.5s delay  
 alpha = 0.65;       % echo strength  
 D = delay*Fs;  
 y = zeros(size(x));  
 y(1:D) = x(1:D);  
   
 for i=D+1:length(x)  
   y(i) = x(i) + alpha*x(i-D);  
 end  
 %% plots

[s_data, s_rate] = audioread('test.wav');
% a.  Plot the signal in time and the amplitude of its frequency 
sample_period = 1/s_rate;
t1 = (0:sample_period:(length(s_data)-1)/s_rate);
figure
plot(t1,s_data)
title('Time Domain Analysis - orignal Sound')
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t1(end)])

m = length(s_data); % Original sample length.
n = pow2(nextpow2(m)); % samples of power of 2,transform computation faster

y1 = fft(s_data, n);
f = (0:n-1)*(s_rate/n);
amplitude = abs(y1)/n;
figure;
plot(f(1:floor(n/2)),amplitude(1:floor(n/2)))
title('Frequency Domain Analysis - orignal Sound')
xlabel('Frequency')
ylabel('Amplitude')

%% using filter method.  
  b = [1,zeros(1,D),alpha];  
  y = filter(b,1,x); 

 %% plots echo added signal 
sound(y,Fs);
s=y;
figure
plot(t1,s)
title("echo signal")
xlabel('Time (seconds)')
ylabel('Amplitude')

%frequency 
m1 = length(y); %  sample length.
y2 = fft(y, m1);
f1 = (0:m1-1)*(Fs/m1);
amplitude = abs(y2)/m1;
figure;
plot(f(1:floor(m1/2)),amplitude(1:floor(m1/2)))
title('Frequency Domain Analysis - echo Sound')
xlabel('Frequency')
ylabel('Amplitude')



 %% Remove echo signal
 w=filter(1,b,y);
 sound(w,Fs)
 figure
 plot(t1,w)
 title("Time domain analysis of signal after removing echo ")
 xlabel('Time (seconds)')
 ylabel('Amplitude')
 %% removing noise
 
Wn=1000/(s_rate/2);
[b,a] = butter(7,Wn,'low');
filtered_sound = filter(b,a,s_data);
sound(filtered_sound, s_rate)
t1 = (0:sample_period:(length(filtered_sound)-1)/s_rate);
  
figure
plot(t1,filtered_sound)
title('Time Domain Analysis - After removing noise from Sound')
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t1(end)])