function [P, I, D] = get_PID(Gc)
% 此函数可以求取以 Simulink 并行 PID 控制器的参数 
% 此函数仅仅适用于课程报告 

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
