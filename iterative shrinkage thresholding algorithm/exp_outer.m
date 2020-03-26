%% ʵ����֤ ��Ȧ����
clc;clear all;close all
%% ʵ��������ʱ��1��
fs=20000;               % ���źŲ���Ƶ��

total_t=0.2;            % ����ʱ��

total_N=fs*total_t;     % �ܲ�������
point_N=1:total_N;      % ������

bias_t=0.5;               % ƫ��ʱ��
bias_N=fs*bias_t;       % ƫ�Ƶ���

t=point_N/fs;           % ʱ��

%% �����ֵ�
% f_min=4377;                  %(��Ҫ����ʵ���������)
% f_max=4383;                  %(��Ҫ����ʵ���������)
% zeta_min=0.052;              %(��Ҫ����ʵ���������)
% zeta_max=0.058;              %(��Ҫ����ʵ���������)
% W_step=2;
% [Dic,rows,cols]=generate_dic(total_N,f_min,f_max,zeta_min,zeta_max,W_step,fs);
% Dic=Dic/norm(Dic); 

% �����ֵ�̫��ʱ�ˣ������־û�һ�°�
load('Dic_outer.mat');

%% ��ȡ���� 
% load('F:\����\ʵ������\��˹����������ݼ�\2004.02.17.00.02.39.mat')
% 
% original_signal=VarName1(point_N+bias_N);
% 
% % ԭʼ�źŷ�ֵ��һ��
% original_signal=original_signal/abs(max(original_signal));
% 
% 
% % �ӵ������������
% amplitude_noise=0.75;
% noise=amplitude_noise*randn(total_N,1);
% original_signal=original_signal+noise;

%% ��ȡ��������ź� outer_data4/6/8�ź��������� ��outer_data3��ʼʱ4000���ź�
load('outer_data8.mat');

%%

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
window=500;

lamda=0.1;

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



%% CcStOMP�ź��ع�
% ts=0.3;               %����ϵ��
% distance=100;         %�������߶ȣ���Ҫ��������
% 
% theta_CcStOMP=ClusterShrinkStOMP(original_signal,Dic,maxIter,ts,distance);
% sig_recovery_CcStOMP=Dic*theta_CcStOMP;
% 
% figure();
% subplot(3,1,1);
% 
% plot(t,sig_recovery_CcStOMP)
% title('(a)');
% xlabel('Time(s)');
% ylabel('Amplitude');
% 
% 
% [f1,q_CcStOMP]=fouriorTransform(sig_recovery_CcStOMP,fs,0);
% 
% subplot(3,1,2);
% plot(f1,q_CcStOMP);
% title('(b)');
% xlabel('Frequency(Hz)');
% ylabel('Amplitude');
% 
% 
% [f2,p_CcStOMP]=envolopeTransform( sig_recovery_CcStOMP,fs,0 );
% subplot(3,1,3);
% plot(f2,p_CcStOMP);
% title('(c)');
% xlabel('Frequency(Hz)');
% ylabel('Amplitude');
% xlim([0,1000]);
% ylim([0,0.2]);


