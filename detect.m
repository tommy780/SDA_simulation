%%function to support SDA_SFT.m
function y = detect(t,x)
global k1 k2 k3 k4 k5;
%   [T, S, I, J, F, W1, W2]'
y = [-k1*x(1)*x(2)+k2*x(3)*x(4)+k3*x(3)*x(6),
    -k1*x(1)*x(2)-k4*x(2)*x(4)-k5*x(2)*x(6),
    k1*x(1)*x(2)-k2*x(3)*x(4)-k3*x(3)*x(6),
    -k2*x(3)*x(4)-k4*x(2)*x(4),
    k1*x(1)*x(2)+k4*x(2)*x(4)+k5*x(2)*x(6),
    k2*x(3)*x(4)-k3*x(3)*x(6)+k4*x(2)*x(4)-k5*x(2)*x(6),
    k3*x(3)*x(6)+k5*x(2)*x(6)];
