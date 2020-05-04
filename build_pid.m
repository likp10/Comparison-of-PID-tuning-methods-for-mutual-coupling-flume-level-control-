%% Ziegler-Nichols ������ PI ������
Kp1 = 0.9*T/(K*Td);
Tint1 = Td/0.3;
s = tf('s');
Gznpi = Kp1*(1+1/(Tint1*s));

%% Ziegler-Nichols ������ PID ������
Kp2 = 1.2*T/(K*Td);
Tint2 = 2.2*Td;
Tdif2 = 0.5*Td;
Gznpid = Kp2*(1+1/(Tint2*s)+Tdif2*s);

%% SIMC ������ PI ������

tauc = Td;
Kc = T/K/(tauc+Td);
tauI = min([T,4*(tauc+Td)]);
Gsipi = Kc*(tauI*s+1)/(tauI*s);

%% SIMC ������ PID ������
taud = Td/3;
Gsipid = Kc*(tauI*s+1)*(taud*s+1)/(tauI*s);