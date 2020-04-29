clc;clear all;close all;
%% ʵ���о� �������õ��Գ���

% load '��������1����ͨ��4.mat';
% load '�����Ȧ0.2x0.2����ͨ��4.mat';%��0�뿪ʼ��f_min=2245;f_max=2255;zeta_min=0.135;zeta_max=0.138;ts=2.33;  
fs=10240;   %����Ƶ�ʣ��ֶ�����
total_t=0.5;   %����ʱ��   �����Լ��趨
total_N=fs*total_t;   %�ܲ�������
point_N=1:total_N;   %��������
bias_t=fs*2.5;    % ʱ��ƫ��   10, 10.5
t=point_N/fs;   %ʱ��

%% �����ֵ�
%��Ȧ�źţ�ԭ����Ƶ��2250�������0.12
%��Ȧ�źţ�ԭ����Ƶ��1272�������0.17
% 
% f_min=2245;          %��Ȧ��ԭ����Ƶ��1272
% f_max=2255;
% zeta_min=0.119;
% zeta_max=0.122;
% W_step=2;
% [Dic,rows,cols]=generate_dic(total_N,f_min,f_max,zeta_min,zeta_max,W_step,fs);
% Dic=dictnormalize(Dic);
% Dic=Dic/norm(Dic);

% �����ֵ�̫��ʱ�ˣ������־û�һ�°�
load('Dic_outer2.mat');


%% ��ȡ����

% load '�����Ȧ1x0.5����ͨ��4.mat';
% original_signal=Data(point_N+bias_t);
% 
% % ԭʼ�źŷ�ֵ��һ��
% original_signal=original_signal/abs(max(original_signal));
% 
% 
% % �ӵ������������
% amplitude_noise=0.7;
% noise=amplitude_noise*randn(total_N,1);
% original_signal=original_signal+noise;

%% ��ȡ��������ź�
load 'outer2_data3.mat';
% 
% % �ӵ������������
% amplitude_noise=0.2;
% noise=amplitude_noise*randn(total_N,1);
% original_signal=original_signal+noise;

%% ԭʼ�ź�

figure();
subplot(3,1,1);

plot(t,original_signal)
title('(a)');
xlabel('Time(s)');
ylabel('Amplitude');


[f1,q_orig]=fouriorTransform(original_signal,fs,0);

subplot(3,1,2);
plot(f1,q_orig);
title('(b)');
xlabel('Frequency(Hz)');
ylabel('Amplitude');


[f2,p_orig]=envolopeTransform( original_signal,fs,0 );
subplot(3,1,3);
plot(f2,p_orig);
title('(c)');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
xlim([0,1000]);
ylim([0,0.15]);

%% �ع���������

maxErr=1e-4;
maxIter=100;
window=700;     % �������������Ҫ

lamda=0.12;

%% IST�ź��ع�

theta_ist=ist(original_signal,Dic,lamda,maxErr,maxIter);
sig_recovery_ist=Dic*theta_ist;

figure();
subplot(3,1,1);

plot(t,sig_recovery_ist)
title('(a)');
xlabel('Time(s)');
ylabel('Amplitude');


subplot(3,1,2);
plot(theta_ist);
title('(b)');
xlabel('Index');
ylabel('Amplitude');


[f2,p_ist]=envolopeTransform( sig_recovery_ist,fs,0 );
subplot(3,1,3);
plot(f2,p_ist);
title('(c)');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
xlim([0,1000]);
ylim([0,0.1]);


%% LIST�ź��ع�

theta_sist=sist(original_signal,Dic,lamda,maxErr,maxIter,window);
sig_recovery_sist=Dic*theta_sist;

figure();
subplot(3,1,1);

plot(t,sig_recovery_sist)
title('(a)');
xlabel('Time(s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(theta_sist);
title('(b)')
xlabel('Index');
ylabel('Amplitude');


[f2,p_list]=envolopeTransform( sig_recovery_sist,fs,0 );
subplot(3,1,3);
plot(f2,p_list);
title('(c)');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
xlim([0,1000]);
ylim([0,0.1]);

