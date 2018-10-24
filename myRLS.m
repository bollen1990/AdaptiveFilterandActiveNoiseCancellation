﻿% ------------------------------------------------------------------------ 
%  Copyright (C)
%  LiXirong - Wuhan University, China
% 
%  LiXirong <634602068@qq.com> or <lixirong@whu.edu.cn>
%  2018.10.15
% ------------------------------------------------------------------------
% myRLS.m - least mean squares algorithm
%
% Usage: [e, y, w] = myRLS(d, x, lamda, M)
%
% Inputs:
% d  - the vector of desired signal samples of size Ns, 参考信号
% x  - the vector of input signal samples of size Ns, 输入信号
% lamda - the weight parameter, 权重
% M  - the number of taps. 滤波器阶数
%
% Outputs:
% e - the output error vector of size Ns
% y - output coefficients
% w - filter parameters
%
% ------------------------------------------------------------------------
function [e, y, w] = myRLS(d, x,lamda,M)

Ns = length(d);
if (Ns ~= length(x))
    print('error: 输入信号和参考信号长度不同！');
    return;
end


I = eye(M);
a = 0.01;
p = a * I;

x = [zeros(1, M-1), x]; %在输入信号x前补上M-1个0，使输出y与输入具有相同长度
w1 = zeros(1, M);
y = zeros(1, Ns);
e = zeros(1, Ns);

for n = 1:Ns
    xx = x(n:1:n+M-1);
    k = (p * xx')' ./ (lamda + xx * p * xx');
    y(n) = w1 * xx';
    e(n) = d(n) - y(n);
    w1 = w1 + k * e(n);
    p = (p - k * xx' * p) ./ lamda;
    w(:,n) = w1;
end

end