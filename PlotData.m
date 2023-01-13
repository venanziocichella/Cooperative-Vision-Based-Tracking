close all;

plt_colors = lines(numVeh);
plt_colors(8,:) = [0.5 0.25 0];
plt_colors(9,:) = [0 0.25 0.5];
plt_colors(10,:) = [0.5 0.25 0.75];

set(0,'DefaultAxesFontSize',24);
tinit = 0;
tfin = time(length(time));


%% Plot VBT
%Plot rho
figure(1); 
for i = 1:numVeh
plot(rho.Time,rho.Data(:,i),'color',plt_colors(i,:),'LineWidth',2);
hold on;
end
axis([tinit tfin -100 800]);
grid on;
xlabel('time [s]');
ylabel('$\rho - \rho_d$ [m]','Interpreter','Latex');


%Plot eta
figure(2);
for i = 1:numVeh
plot(eta.Time,eta.Data(:,i),'color',plt_colors(i,:),'LineWidth',2);
hold on;
end
axis([tinit tfin -0.5 0.5]);
grid on;
xlabel('time [s]');
ylabel('$\eta$ [rad]','Interpreter','Latex');

%Plot psidot
figure(3);
for i = 1:numVeh
plot(psi.Time,psi.Data(:,i),'color',plt_colors(i,:),'LineWidth',2);
hold on;
end
axis([tinit tfin -1 1]);
grid on;
xlabel('time [s]');
ylabel('$\dot \psi$ [rad/s]','Interpreter','Latex');



%% Plot CVB
%Plot velocity
figure(4);
for i = 1:numVeh
plot(vel.Time,vel.Data(:,i),'color',plt_colors(i,:),'LineWidth',2);
hold on;
end
axis([tinit tfin 0 100]);
grid on;
xlabel('time [s]');
ylabel('$V_c$ [m/s]','Interpreter','Latex');


% Plot norm of TC error
set(0, 'defaultTextInterpreter', 'latex');
norm = 0;
 for i = 2:numVeh
     norm = norm + (lambda.Data(:,1)-lambda.Data(:,i)).^2;
 end
norm = sqrt(norm);
 
figure(5)
plot(lambda.Time,norm,'color','red','LineWidth',2.5); hold on;
axis([tinit tfin 0 10]);
grid on;
xlabel('Time [s]');
ylabel('$\sum_{i=2}^n||\lambda_1(t)-\lambda_i(t)||$','Interpreter','Latex');



figure(6)
XMIN = -1200;
XMAX = 400;
YMIN = -600;
YMAX = 400;
tinst = [1 180 302 600]*10;
i=0;
axis([XMIN XMAX YMIN YMAX]);
for j = 1 : length(tinst)
    line(ptg.Data(tinst(j),1),ptg.Data(tinst(j),2),0,'Marker','o','LineWidth',5,'color','k'); 
for i = 1 : numVeh
    line(puav.Data(tinst(j),3*i-2),puav.Data(tinst(j),3*i-1),0,'Marker','o','LineWidth',5,'color',plt_colors(i,:)); 
end
hold on;
for i = 1 : 1
    plot(puav.Data(tinst(1):tinst(4),3*i-2),puav.Data(tinst(1):tinst(4),3*i-1),'b:','LineWidth',0.5); 
end
end
legend('Target','UAV1','UAV2','UAV3','UAV4','UAV5','UAV6','UAV1 Traj','AutoUpdate','off');
count = 0;
for i = 1 : length(tinst)
for j = 1 : numVeh
        for k = j+1 : numVeh
            count = count + 1;
            if LaplacianMatrix.Data(j,k,tinst(i)) == -1                
                line([puav.Data(tinst(i),3*j-2),puav.Data(tinst(i),3*k-2)],[puav.Data(tinst(i),3*j-1),puav.Data(tinst(i),3*k-1)],'Color','k','LineWidth',1);
            else 
                line([0,0],[0,0],'Color','k','LineWidth',1);
            end
        end
end
end
text(-950, -500  , 't = 0s', 'Color', 'k','Fontsize',34);
text(-250, -500  , 't = 180s', 'Color', 'k','Fontsize',34);
text(20, -200  , 't = 300s', 'Color', 'k','Fontsize',34);
text(-150, 350  , 't = 600s', 'Color', 'k','Fontsize',34);
axis([XMIN XMAX YMIN YMAX]);
xlabel('North [m]');
ylabel('East [m]');
grid on;








