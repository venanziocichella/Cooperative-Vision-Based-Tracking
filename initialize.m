%% INITIALIZATION
clear all
clc
close all


numVeh = 6; %number of vehicles

Vmax=60;
Vmin=10;
Vg_const = 25; % Desired Ground Speed

Kpv = 0.2; Kiv = 0; Kdv = 0;

rho_d = [100 150 100 150 100 150 100 150 100 150]; %desired radius

Vg = zeros(10,1);
for i = 1:numVeh
    Vg(i) = Vg_const*rho_d(i)/100;
end

Kpsi = 2; % control gain VBT

a = 0.08; % control gain CVBT
b = 0.002*0;

Tsim = 100; %simulation final time

T = 0.01; %sample time

% Virtual Target Initial Position
P0tg = [-400 -400 0];
%P0tg = [0 0 0];

% UAVs initial conditions
P0 = zeros(40,1);
z0 = zeros(20,1);
psi0 = zeros(20,1);
jj = 0;
alphac    = zeros(1,numVeh);
Rad = [300 300 300 300 300 300 300 300 300 300];


for i = 1 : numVeh
    if i == 1
      alphac(i) = 360;
      P0(2*i-1) = P0tg(1)+Rad(i)*cos(alphac(i)*pi/180);
      P0(2*i)   = P0tg(2)+Rad(i)*sin(alphac(i)*pi/180);
    else
      alphac(i) = (i-1)*360/numVeh;
      P0(2*i-1) = P0tg(1)+Rad(i)*cos(alphac(i)*pi/180)+100*(rand()-0.5);
      P0(2*i)   = P0tg(2)+Rad(i)*sin(alphac(i)*pi/180)+100*(rand()-0.5);  
    end
    z0(i) = 100;
    norm = sqrt((P0(2*i-1)-P0tg(1))^2+(P0(2*i)-P0tg(2))^2);
    psi0(i) = -alphac(i)-180-0*(rand()-0.5);
end
P0(2*6-1) = 0;
P0(2*6)   = -600;


for i = 1 : numVeh
      P0(2*i-1) = -600 - 100*(numVeh-i);
      P0(2*i)   = -400;
      psi0(i) = 0;
end

for i = 1:numVeh
    for j = 1:numVeh
        if j == i
            L(i,j) = numVeh-1;
        else
            L(i,j) = -1;
        end
    end
end
ndes = 1;
for i = 1:ndes
    for j = 1 : length(L(1,:,1))
        Laplacian(j,:,i) = [L(j,:,i) zeros(1,20-length(L(1,:,1)))];
    end
    for j = length(L(1,:,1))+1 : 20
        Laplacian(j,:,i) = zeros(1,20);
    end
end 

L1 = [2 -1 -1 0 0 0; -1 1 0 0 0 0; -1 0 2 0 0 -1; 0 0 0 1 0 -1; 0 0 0 0 1 -1; 0 0 -1 -1 -1 3];
Laplacian1= zeros(20);
for j = 1 : length(L1(1,:))
    Laplacian1(j,:) = [L1(j,:) zeros(1,20-length(L1(1,:)))];
end
for j = length(L1(1,:))+1 : 20
    Laplacian1(j,:) = zeros(1,20);
end

L2 = [0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0];
Laplacian2 = zeros(20);
for j = 1 : length(L2(1,:))
    Laplacian2(j,:) = [L2(j,:) zeros(1,20-length(L2(1,:)))];
end
for j = length(L2(1,:))+1 : 20
    Laplacian2(j,:) = zeros(1,20);
end
