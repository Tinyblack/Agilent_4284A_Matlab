close all 
clear 
% [data_array_out,data_struct_out,LCR_ID] = Measurement_function(Voltage_min_in,Voltage_max_in)
% It will measure 120 points
[Result_Array,Result_Struct,~]=Measurement_function(3,12,1000); % MIN_V=0V MAX_V=20V MIN_f=20 MAX_f=1000000
% [Data2,Voltage2,~]=Measurement_function(10,20);
% [Data3,Voltage3,~]=Measurement_function(0,2);
% [Data4,Voltage4,~]=Measurement_function(1,2);
V=Result_Array(:,1);
C=Result_Array(:,2);
I=Result_Array(:,4);
figure(1)
subplot(1,2,1)
hold on;
grid on;
box on;
plot(V,C.*(10^9),'Color','red','LineWidth',2);
plot(V,C.*(10^9),'Marker','.','MarkerSize',12,'MarkerEdgeColor','blue','LineStyle','none');
title('$C_{p}-V$','Interpreter','latex','FontSize',20);
xlabel('VOLTAGE/$V$','Interpreter','latex','FontSize',20);
ylabel('Capacitance/$nF$','Interpreter','latex','FontSize',20);
xlim([min(V) max(V)]);
xticks(floor(min(V)):(ceil(max(V))-floor(min(V)))/20:ceil(max(V)));
ylim([min(C.*(10^9)) max(C.*(10^9))]);
yticks(min(C.*(10^9)):(max(C.*(10^9))-min(C.*(10^9)))/15:max(C.*(10^9)));


subplot(1,2,2)
hold on;
grid on;
box on;
plot(V,I.*(10^6),'Color','red','LineWidth',2);
plot(V,I.*(10^6),'Marker','.','MarkerSize',12,'MarkerEdgeColor','blue','LineStyle','none');
title('$I-V$','Interpreter','latex','FontSize',20);
xlabel('VOLTAGE/$V$','Interpreter','latex','FontSize',20);
ylabel('Current/$uA$','Interpreter','latex','FontSize',20);
xlim([min(V) max(V)]);
xticks(floor(min(V)):(ceil(max(V))-floor(min(V)))/20:ceil(max(V)));
ylim([min(I.*(10^6)) max(I.*(10^6))]);
yticks(min(I.*(10^6)):(max(I.*(10^6))-min(I.*(10^6)))/15:max(I.*(10^6)));

% l=legend({'0-12V,120 steps','0-6V,120 steps','0-2V,120 steps','1-2V,120 steps'});
% l=legend({'0-20V,120 steps'});
% l.FontSize=20;
% clear l;
% s=suptitle('Measurement Results');
% s.FontSize=20;
PATH=[pwd '\Results\'];
savefig([PATH 'Result_figure' datestr(now,'yyyy-mm-dd_HH-MM-SS') '.fig']);
save([PATH 'Result_workspace' datestr(now,'yyyy-mm-dd_HH-MM-SS') '.mat']);



