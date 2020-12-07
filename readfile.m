function [VgIdlist,S] = readfile(filename)


list=dlmread(filename);
list=list(2:402,:);



Vg=list(:,3);
Id=list(:,2);

[n,~]=size(Vg);
%last negative number
x=1;
for i=1:1:n
   if Id(i) < 0
       x=i;
   end       
end

% plot(Vg(x+1:x+10),log10(Id(x+1:x+10)))
fit=polyfit(log10(Id(x+1:x+10)),Vg(x+1:x+10),1);
S=fit(1);
% set 10nA as open current
y=1;
for i=x:1:n
    if Id(i) > 12E-8
       y=i;
       break
   end 
end
Vg(1:y)=[];
Id(1:y)=[];


%Vg=Vgs-Vflat
% Vg=Vg-Vg(1);
VgIdlist(:,1)=Vg;
VgIdlist(:,2)=Id;
