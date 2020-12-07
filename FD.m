function f = FD(E,Ef)
e=1.6E-19;
k=(1.380649E-23)./e;
T=300;
f=1./(exp((E-Ef)./(k*T))+1);

end

