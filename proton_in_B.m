clc; clear all; close all;

global qm B;

v0 = [400000 0 0];
B = [0 0 0.001];
m = 1.6726e-27;
q = 1.6e-19;
qm = q/m;
r0 = [-5 0 0];
tspan = [0 0.0001];

y0 = [r0'; v0'];
[t,y] = ode45(@odefun,tspan,y0);

% plot the shield
plot(0, 0, '.b', 'MarkerSize',69,'Color','black')
hold on
plot(y(:,1),y(:,2),'-')

% xlim([-1 1])
ylim([-10 10])
xlabel("x (meters)",'FontSize',24)
ylabel("y (meters)",'FontSize',24)
title(sprintf("vx=%.2f m/s, Bz=%.5f T",v0(1),B(3)),'FontSize',24)

function dxdt = odefun(t,s)
    global qm B;
    
    x = s(1);
    y = s(2);
    z = s(3);
    
    vx = s(4);
    vy = s(5);
    vz = s(6);
  
    r = norm([x y z]);
   
    Bx = B(1)/r^2;
    By = B(2)/r^2;
    Bz = B(3)/r^2;
    
    if Bx > B(1)
        Bx = B(1);
    end
    
    if By > B(2)
        By = B(2);
    end
    
    if Bz > B(3)
        Bz = B(3);
    end
   
    dxdt = zeros(6,1);
    dxdt(1) = vx;
    dxdt(2) = vy;
    dxdt(3) = vz;
    dxdt(4) = qm * (Bz*vy - By*vz);
    dxdt(5) = qm * (Bx*vx - Bz*vx);
    dxdt(6) = qm * (By*vx - By*vx);
end 
