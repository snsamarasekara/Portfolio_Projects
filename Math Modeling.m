%%
%This script contains codes for models of tumor growth and chemotherapy and immunotherapy treatments and how these models can be used to imrpove efficiency of treatments

%In this portion (first section), the tumor growth models with and without treatments and
%chemotherapy doses to that can prevent drug resistance was modeled 
%First the tumor growth with and without treatment modeled in first part
%using 6ODEs, then the resistance and sensitive cell behaviour observed
%using 4ODEs in part2. 
%The time span t0 and initial conditions y0 can be changed to get modified
%results. 
% Concentration or C value in functions phase, protocol, and hamilt can be
% changed to obtain cell behaviour in different concentration.
% For example, if C in phase changed to 0, the graph shows a higher
% sensitive cell count and lower resistant cell under this condition
% contrary to the graph present. 
%%
%Sara Samarasekara
%4/10/22
%This section of code consist of codes related to tumor growth and
%resistance with chemotherapy doses

% analytical solution
% Experimental data
initial_volume=0.26; %mm3
tumor_volume_21=1.633846154; %mm3 averaged from in vitro experiment
tumor_volume_27=27.69230769; %mm3 
tumor_volume_35=144.6923077; %mm3  

xdata=[1 21 27 35];
ydata=[0.26 1.633846154 27.69230769 144.6923077];
t=linspace(1,35);

% Exponential Model
a0=0.1;

N1=@(x,xdata)(initial_volume*(exp(x*xdata)));
[x,resnorm] = lsqcurvefit(N1,a0,xdata,ydata)
N1_Opt=@(t)(initial_volume*(exp(0.179*t)));

%Logistic Model
a0=0.3;

N2=@(x,xdata)((initial_volume*420)./(initial_volume+(420-initial_volume)*exp(-x(1)*xdata)));
[x,resnom] = lsqcurvefit(N2,a0,xdata,ydata)
N2_Opt=@(t)((initial_volume*420)./(initial_volume+(420-initial_volume)*exp(-0.1911*t)));

%Generalized Logistic Model
a0=[18;0.18];

N3=@(x,xdata)((initial_volume*420)./((initial_volume.^x(1)+(420.^x(1)-initial_volume.^x(1))*exp(-x(2)*x(1)*xdata)).^(1./x(1))));
[x,resnom] = lsqcurvefit(N3,a0,xdata,ydata)
N3_Opt=@(t)((initial_volume*420)./((initial_volume.^19+(420.^19-initial_volume.^19)*exp(-0.19*18.2*t)).^(1./19)));

%Gompertz Model
a0=[0.1;0.02];
alpha=0.25;
beta=0.02;

N4=@(x,xdata)(initial_volume*exp((x(1)/x(2))*(1-exp(-x(2)*xdata))));
[x,resnom] = lsqcurvefit(N4,a0,xdata,ydata)
N4_Opt=@(t)(initial_volume*exp((alpha/beta)*(1-exp(-beta*t))));

% Von Bertalanffy Model
a0=[0.25;0.024;0.9];
a=0.25;
b=0.024;
gamma=0.9;

N5=@(x,xdata)(((x(1)./x(2))+(initial_volume.^(1-x(3))-(x (1)./x(2)))*exp(-x(2)*(1-x(3))*xdata)).^(1./(1-x(3))));
[x,resnom] = lsqcurvefit(N5,a0,xdata,ydata)
N5_Opt=@(t)(((a./b)+(initial_volume.^(1-gamma)-(a./b))*exp(-b*(1-gamma)*t)).^(1./(1-gamma)));

figure(1)
plot(t,N1_Opt(t),t,N2_Opt(t),t,N3_Opt(t),t,N4_Opt(t),t,N5_Opt(t),1,initial_volume,'*',21,tumor_volume_21,'*',27,tumor_volume_27,'*',35,tumor_volume_35,'*');
title('Tumor Volume Growth')
ylabel('Tumor volume (mm3)')
xlabel('Time (days)')
legend('Exponential','Logistic','Generalized Logistic','Gompertz','Von Bertalanffy','Experimental data');
hold on

% model for tumor growth with chemotherapy  
% Experimental data
initial_volume=0.26; %mm3
tumor_volume_21=6.34; 
tumor_volume_27=11.232; 
tumor_volume_35=1.044; 
xdata=[1 21];
ydata=[0.26 6.34];

t=linspace(1,35);
t1=linspace(28,35);
t2=linspace(25,35);
t3=linspace(21,35);

a0=[0.25;0.02];
N11=@(x,xdata)(initial_volume*exp((x(1)/x(2))*(1-exp(-x(2)*xdata))));
[x,resnom] = lsqcurvefit(N11,a0,xdata,ydata);

alpha=0.2;
beta=0.02;
N11_Opt=@(t)(initial_volume*exp((alpha/beta)*(1-exp(-beta*t))));

a01=[0.05];
N12=@(x,x1data)(initial_volume*exp((alpha/beta)*(1-exp(-beta*x1data))-x(1)*((x1data-28))));

b=0.25;
N12_Opt=@(t1)(initial_volume*exp((alpha/beta)*(1-exp(-beta*t1))-0.45*(t1-28)));
N13_Opt=@(t2)(initial_volume*exp((alpha/beta)*(1-exp(-beta*t2))-0.33*(t2-25)));
N14_Opt=@(t3)(initial_volume*exp((alpha/beta)*(1-exp(-beta*t3))-0.25*(t3-21)));

figure(2)
plot(t,N11_Opt(t),t1,N12_Opt(t1));
hold on
plot(1,initial_volume,'*',21,tumor_volume_21,'*',27,tumor_volume_27,'*',35,tumor_volume_35,'*');
title('Tumor Volume Change')
ylabel('Tumor volume (mm3)')
xlabel('Time (days)')
legend('Gompertz model','Day 30','Experimental data')
hold on

%numerical for stage 1: tumor growth

t = [0 35];
y0 = 1;

[t,y] = ode45(@ode1,t,y0);
y = N1_Opt(t);
[t,y] = ode45(@ode2,t,y0);
y = N2_Opt(t);
[t,y] = ode45(@ode3,t,y0);
y = N3_Opt(t);
[t,y] = ode45(@ode4,t,y0);
y = N4_Opt(t);
[t,y] = ode45(@ode5,t,y0);
y = N5_Opt(t);
figure
plot(t,N1_Opt(t),t,N2_Opt(t),t,N3_Opt(t),t,N4_Opt(t),t,N5_Opt(t),1,initial_volume,'*',21,tumor_volume_21,'*',27,tumor_volume_27,'*',35,tumor_volume_35,'*')
hold on

%numerical solution for stage 2 : chemotherapy resistance
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-5]); % cell count Under constant treatment
[T,Y] = ode45(@phase,[0 720],[5000 5000],options);

figure

plot(T,Y(:,1),'r',T,Y(:,2),'g')
title('constant treatment')
xlabel('Time (hrs)')
ylabel('cell count')
legend('sensitive cells', 'resistant cells')

hold on

[T,Y] = ode45(@hamilt,[0 720],[5000 5000 1 1]);% cell count Under optimal treatment 
figure
plot(T,Y(:,3),'r',T,Y(:,4),'g')
axis([0 720 0 1000])
title('optimal dose')
xlabel('Time (hrs)')
ylabel ('Tumor cells')
legend ('sensitive cells','resistant cells')
hold on

[T,Y] = ode45(@protocol,[0 720],[5000 5000 1 1]); % tumor size under optimal treatment
figure
plot(T,Y(:,3),'r',T,Y(:,4),'g')
title('optimal dose')
xlabel('Time (hrs)')
ylabel ('tumor size')
legend ('sensitive cells','resistant cells')
hold on

