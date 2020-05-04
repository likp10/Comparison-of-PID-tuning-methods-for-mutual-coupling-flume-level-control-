%% 设定常量的值
% 其中 283 是阶跃信号跳变时的向量索引
load('plant_data1.mat');
t = t-t(283);       % 通过坐标变换将阶跃信号的跳变时间设置为0
y = y2; 
t0 = -437.6; U0 = 5; Uf = 6;
Y0 = 1.546; Yf = 3.675;
% 两条平行线的纵坐标
yy1 = 0.283*(Yf-Y0)+Y0;
yy2 = 0.632*(Yf-Y0)+Y0;

%% 绘制图像
plot(t,y); 
hold on; 
fplot(yy1); fplot(yy2);

%% 求解模型参数
dis1 = zeros(size(y));
dis2 = zeros(size(y));
for i = 1:2606
    dis1(i) = abs(y(i)-yy1);
    dis2(i) = abs(y(i)-yy2);
end
[mdis1,index1] = min(dis1);
[mdis2,index2] = min(dis2);
t1 = t(index1); t2 = t(index2);
plot(t1,y(index1),'rp',t2,y(index2),'gp')   % 绘制出 t1、t2 用五角星标记
K = (Yf-Y0)/(Uf-U0);            % 模型各个参数的求解
T = 1.5*(t2-t1); Td = t2-T;
if Td < 0
    T = t2; Td = 0;
end

%% 输出模型
G = tf(K,[T,1]); G.IODelay = Td;
ym = step(G,t(283:end));        % 基于模型的阶跃响应
plot(t(283:end),ym+Y0);         % 此处变换纵坐标，加上 Y0，更为直观