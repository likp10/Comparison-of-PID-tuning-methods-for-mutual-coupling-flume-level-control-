%% ����ģ�ͺ�ʵ�ʵĽ�Ծ��Ӧ
load('plant_data1.mat');
t = t-t(283); 
t = t(283:end);
y = y2-Y0;
y = y(283:end);
ym = step(G,t);
plot(t,y);
hold on;
plot(t,ym);

%% �� Ip ��ֵ
Ip = 0;
dt = t(2)-t(1);
for k = 1:2324
    Ip = Ip+(1/(t(end)-t(1)))*(abs(y(k)-ym(k)))^2*dt;
end