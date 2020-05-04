%% �趨������ֵ
% ���� 283 �ǽ�Ծ�ź�����ʱ����������
load('plant_data1.mat');
t = t-t(283);       % ͨ������任����Ծ�źŵ�����ʱ������Ϊ0
y = y2; 
t0 = -437.6; U0 = 5; Uf = 6;
Y0 = 1.546; Yf = 3.675;
% ����ƽ���ߵ�������
yy1 = 0.283*(Yf-Y0)+Y0;
yy2 = 0.632*(Yf-Y0)+Y0;

%% ����ͼ��
plot(t,y); 
hold on; 
fplot(yy1); fplot(yy2);

%% ���ģ�Ͳ���
dis1 = zeros(size(y));
dis2 = zeros(size(y));
for i = 1:2606
    dis1(i) = abs(y(i)-yy1);
    dis2(i) = abs(y(i)-yy2);
end
[mdis1,index1] = min(dis1);
[mdis2,index2] = min(dis2);
t1 = t(index1); t2 = t(index2);
plot(t1,y(index1),'rp',t2,y(index2),'gp')   % ���Ƴ� t1��t2 ������Ǳ��
K = (Yf-Y0)/(Uf-U0);            % ģ�͸������������
T = 1.5*(t2-t1); Td = t2-T;
if Td < 0
    T = t2; Td = 0;
end

%% ���ģ��
G = tf(K,[T,1]); G.IODelay = Td;
ym = step(G,t(283:end));        % ����ģ�͵Ľ�Ծ��Ӧ
plot(t(283:end),ym+Y0);         % �˴��任�����꣬���� Y0����Ϊֱ��