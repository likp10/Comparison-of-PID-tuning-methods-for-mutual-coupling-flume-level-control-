function [P, I, D] = get_PID(Gc)
% �˺���������ȡ�� Simulink ���� PID �������Ĳ��� 
% �˺������������ڿγ̱��� 

temp = Gc.num{1,1} / Gc.den{1,1}(end-1);
try
    P = temp(2);
    I = temp(3);
    D = temp(1);
catch
    P = temp(1);
    I = temp(2);
    D = 0;
end
