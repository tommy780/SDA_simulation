%%%S+F+T
%T+S -> I+F   k1
%I+J -> W1+T  k2
%I+W1-> W2+T k3
%S+J -> W1+F  k4
%S+W1-> W2+F k5

clear 
global k1 k2 k3 k4 k5;
k1 = 6.70383322e-03;        %% T+S=I+F
k2 = 6.19318369e-06;        %%I+J=W1+T
k3 = 6.67549016e-02;       %%I+W1=W2+T
k4 = 8.28955519e-06;       %%S+J=W1+F
k5 = 1.00000000e-14;       %%S+W1=W2+F




%[T, S, I, J, F, W1, W2]'

x0 =[0.011 200 0 500 0 0 0]';
options = odeset('RelTol',1e-10,'AbsTol',1e-11);
[t x] = ode45('detect', [0,60], x0, options);               %%[0,60]==time

v = zeros(length(x(:,1)),1);
for i = 1:(length(x(:,1)))
    v(i) = k1*x(i,1)*x(i,2)+k4*x(i,2)*x(i,4)+k5*x(i,2)*x(i,6);
end



subplot(2,4,1);
plot(t,x(:,1),'-','LineWidth',3);
xlabel('Time (min)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14);
ylabel('Concentration of Target (nM)','color','b','FontWeight','bold','FontSize',15);

hold on

subplot(2,4,2);
plot(t,x(:,2),'-','LineWidth',3);
xlabel('Time (min)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14);
ylabel('Concentration of Substrate (nM)','color','b','FontWeight','bold','FontSize',15);
subplot(2,4,3);
plot(t,x(:,3),'-','LineWidth',3);
xlabel('Time (min)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14);
ylabel('Concentration of Intermediate (nM)','color','b','FontWeight','bold','FontSize',15);
subplot(2,4,4);
plot(t,x(:,4),'-','LineWidth',3);
xlabel('Time (min)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14);
ylabel('Concentration of Junction fuel (nM)','color','b','FontWeight','bold','FontSize',15);
subplot(2,4,5);
plot(t,x(:,5),'-','LineWidth',3);
xlabel('Time (min)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14);
ylabel('Concentration of FAM (nM)','color','b','FontWeight','bold','FontSize',15);
subplot(2,4,6);
plot(t,x(:,6),'-','LineWidth',3);
xlabel('Time (min)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14);
ylabel('Concentration of Waste1 (nM)','color','b','FontWeight','bold','FontSize',15);
subplot(2,4,7);
plot(t,x(:,7),'-','LineWidth',3);
xlabel('Time (min)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14);
ylabel('Concentration of Waste2 (nM)','color','b','FontWeight','bold','FontSize',15);
subplot(2,4,8);
plot(x(:,2),v,'-','LineWidth',3);
xlabel('Concentration of Substrate (nM)','color','b','FontWeight','bold','FontSize',15);
set(gca,'FontSize',14,'XLim',[0,50]);
ylabel('dF/dt (nM/min)','color','b','FontWeight','bold','FontSize',15);

hold off
