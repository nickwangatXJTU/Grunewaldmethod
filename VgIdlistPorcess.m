function proVgIdlist = VgIdlistPorcess(VgIdlist,Vsat)

 [n,~]=size(VgIdlist);
 x=0;
 for i=1:1:n
     if VgIdlist(i,1)>Vsat
         x=i;
         break
     end
 end

 proVgIdlist=VgIdlist(1:x-1,:);
 
 proVgIdlist(:,1)=proVgIdlist(:,1)-proVgIdlist(1,1);

