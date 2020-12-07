function [Vt,mobility,Vsat,fits,Vfb] = calVtMobility(VgIdlist)
%channal width
W=2e-3;
%channal length
L=0.3e-3;
%dielectric thickness
d=100e-9;
%dielectric constant
eps=3.5*8.85e-12;
Ci=eps/d;


[n,~]=size(VgIdlist);
Vglist=VgIdlist(:,1);
Idlist=VgIdlist(:,2);

Vfb=Vglist(1);
currentstart=Idlist(n)*0.2;
startnum=1;
for i=2:1:n
    if Idlist(i-1)<currentstart && Idlist(i)<currentstart
        startnum=i;
    end
end

fits=polyfit(Vglist(startnum:n),Idlist(startnum:n),1);

mobility=fits(1)*L/W/Ci*1E4;
Vt=-fits(2)/fits(1);

Id_region=Idlist(startnum:n);
x=Vglist(startnum:n);
y=fits(1).*x+fits(2);

[~,m]=size(x);

for i=1:1:m    
    if abs(y(m)-Id_region(m))<0.001*Idlist(n)
        break
    end
end

Vsat=x(m);







