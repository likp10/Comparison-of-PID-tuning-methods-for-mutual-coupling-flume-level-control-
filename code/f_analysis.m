%% 求解频域指标
% Gm 为幅值裕度，Pm 为相位裕度，
% Wgm 为幅值穿越频率，Wpm 为相角穿越频率
[Gm,Pm,Wgm,Wpm] = margin(G);

%% 画出系统的 Bode 图
bode(G); grid;