function V0list = calV0(VgIdlist,d)
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

Vglist=VgIdlist(:,1);
Idlist=VgIdlist(:,2);

% semilogy(Vglist,Idlist);
% hold on

I0=Idlist(1);

[n,~]=size(Vglist);
V0list=[0];

for i=2:1:n
    Vg=Vglist(i);
    Id=Idlist(i);
    inte=trapz(Vglist(1:i),Idlist(1:i));
    right=e/k/T*epslion_ox*d/epslion_s/l/I0*(Id*Vg-inte);
    
    fun=@(V0) exp(e*V0/k/T)-e*V0/k/T-1-right;
    options = optimoptions('fsolve','Display','none');
    V0=fsolve(fun,1,options);
    
    V0list=[V0list;V0];
end





