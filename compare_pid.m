%% ����ʱ�䡢������������ʱ��
% �����������������ıջ���Ծ��Ӧ���߼��ɶ�ͼ�õ�
subplot(2,2,1); 
step(feedback(G*Gznpi,1)); title('Z-N\_PI�����ıջ���Ծ��Ӧ')
subplot(2,2,2); 
step(feedback(G*Gznpid,1)); title('Z-N\_PID�����ıջ���Ծ��Ӧ')
subplot(2,2,3); 
step(feedback(G*Gsipi,1)); title('SIMC\_PI�����ıջ���Ծ��Ӧ')
subplot(2,2,4); 
step(feedback(G*Gsipid,1)); title('SIMC\_PID�����ıջ���Ծ��Ӧ')

%% ƽ��ƫ����ֺ;���ƫ�����
% ��ƫ������
subplot(2,2,1); 
step(1/(1+Gznpi*G)); title('Z-N\_PI������ƫ��')
subplot(2,2,2); 
step(1/(1+Gznpid*G)); title('Z-N\_PID������ƫ��')
subplot(2,2,3); 
step(1/(1+Gsipi*G)); title('SIMC\_PI������ƫ��')
subplot(2,2,4); 
step(1/(1+Gsipid*G)); title('SIMC\_PID������ƫ��')
% ƫ��
e1 = step(1/(1+Gznpi*G), 0:0.01:1000);
e2 = step(1/(1+Gznpid*G), 0:0.01:1000);
e3 = step(1/(1+Gsipi*G), 0:0.01:1000);
e4 = step(1/(1+Gsipid*G), 0:0.01:1000);
% ���� ISE��Delta t Ϊ 0.01
ISE1 = sum(e1.^2*0.01);
ISE2 = sum(e2.^2*0.01);
ISE3 = sum(e3.^2*0.01);
ISE4 = sum(e4.^2*0.01);
ISE = [ISE1 ISE2 ISE3 ISE4];
% ���� IAE��Delta t Ϊ 0.01
IAE1 = sum(abs(e1)*0.01);
IAE2 = sum(abs(e2)*0.01);
IAE3 = sum(abs(e3)*0.01);
IAE4 = sum(abs(e4)*0.01);
IAE = [IAE1 IAE2 IAE3 IAE4];

%% ³���ԱȽ�
% �Ŷ��źż����ܿض��������λ��
% �Ŷ��ź�����ʱ�� t=500 ʱ���� 0 ���䵽 -1 �Ľ�Ծ�ź�
% �����ĸ���Ӧ�� Simulink ģ��
% ���� Simulink ģ��ʱ PID �������� PID �����ɺ��� get_PID �õ�
[P1, I1, D1] = get_PID(Gznpi);
[P2, I2, D2] = get_PID(Gznpid);
[P3, I3, D3] = get_PID(Gsipi);
[P4, I4, D4] = get_PID(Gsipid);
sim('check_robust');
% ������Ӧ����
subplot(2,2,1); plot(tout,yout(:,1)); title('Z-N\_PI')
subplot(2,2,2); plot(tout,yout(:,2)); title('Z-N\_PID')
subplot(2,2,3); plot(tout,yout(:,3)); title('SIMC\_PI')
subplot(2,2,4); plot(tout,yout(:,4)); title('SIMC\_PID')
% ��ֵ������⶯̬���� 
DeltaC1 = 1 - min(yout(find(tout==500):end,1));
DeltaC2 = 1 - min(yout(find(tout==500):end,2));
DeltaC3 = 1 - min(yout(find(tout==500):end,3));
DeltaC4 = 1 - min(yout(find(tout==500):end,4));
DeltaC = [DeltaC1 DeltaC2 DeltaC3 DeltaC4];
% ��ֵ�������ָ�ʱ�䣬ȡ 5%
tv = [0 0 0 0];
for i = 1:4
    for index = find(tout==500):size(tout)
        if abs(1-yout(index,i)) >= 0.05*1 && abs(1-yout(index+1,i)) <= 0.05*1
            break;
        end
        tv(i) = tout(index);
    end
end

%% ����������ź�ƽ����
% �����������������
sim('pid_out');
subplot(2,2,1); plot(tout1,yout1(:,1)); title('Z-N\_PI')
subplot(2,2,2); plot(tout1,yout1(:,2)); title('Z-N\_PID')
subplot(2,2,3); plot(tout1,yout1(:,3)); title('SIMC\_PI')
subplot(2,2,4); plot(tout1,yout1(:,4)); title('SIMC\_PID')
% ��ƽ���Ե�ֵ
PingHua = [0 0 0 0];
for i = 1:4
    for k = 1:30000
        PingHua(i) = PingHua(i) + abs(yout1(k+1,i)-yout1(k,i));
    end
end