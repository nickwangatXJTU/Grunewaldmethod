function [V,dos] = calDOS(VgIdlist,d)
%electron charge
e=1.6E-19;
%vaccum dielectric constant
epslion_0=8.854187817E-12;

epslion_ZnO=8.5;
% epslion_In2O3=
epslion_Ga2O3=10.2;
%semiconductor dielectric constant
epslion_s=9;
%SiO2 dielectric constant
epslion_ox=3.5;

%k (eV/K)
k=(1.380649E-23);
%Temperature (K)
T=300;
%oxide thickness
l=100E-9;
%channel thickness
% d=40E-9;


% VgIdlist=readfile('20201024-NT1-3paO2-10823-sample-1-positivebias-1',-7.4,20);

Vg=VgIdlist(:,1);
Id=VgIdlist(:,2);

% semilogy(Vg,Id);


V0list=calV0(VgIdlist,d);
V0list=smooth(V0list,0.05);

% plot(Vg,V0list);
% hold on

de=[0;1./(diff(V0list)/0.1)];

[n,~]=size(Vg);
dosdensitys=[];
for i=1:1:n
    density=epslion_ox*epslion_ox*epslion_0/epslion_s/l^2/e*Vg(i)*de(i)*1E-6;
    dosdensitys=[dosdensitys;density];
end
V0list(1)=[];
dosdensitys(1)=[];
logdensitys=log(dosdensitys);
logdensitys=smooth(logdensitys,0.5);

[n,~]=size(V0list);

% plot(V0list,dosdensitys,'LineWidth',2,'r')
% hold on

p=polyfit(V0list,logdensitys,5);
V=0:0.001:V0list(n);
y=polyval(p,V);

% plot(x,y,'g')
% hold on

dy=diff(y,1)./0.001;

y(1)=[];
dos=exp(y).*dy;
V(1)=[];

dos=dos';
V=V';

