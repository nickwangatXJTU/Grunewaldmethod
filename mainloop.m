clc
clear

for i=[10 12 13 15 16]
    samplename_number=samples('data\');
    f=fopen('thickness.txt');
    C=textscan(f,['%s',' %f']);
    thicks=cell2mat(C(:,2));
    
    samplename=cell2mat(samplename_number(i,1));
    samplenumnbers=cell2mat(samplename_number(i,2));
    thickness=thicks(i);
    
    for samplenumber = samplenumnbers
        
        Idmax=0;
        parameters=[];
        startdate=0;
%         try
            originlist=[];
            for bias=1:1:20
                filename=['data/',samplename,'/',samplename,'-sample-',num2str(samplenumber),'-positivebias-',num2str(bias)];
                list=dlmread(filename);
                if bias == 1
                    date=datetime(list(1,:));
                    datesecond=day(date)*24*3600+hour(date)*3600+minute(date)*60+second(date);
                    startdate=datesecond;
                    date=0;
                    originlist=[list(2:402,3),abs(list(2:402,2))];
                else
                    date=datetime(list(1,:));
                    datesecond=day(date)*24*3600+hour(date)*3600+minute(date)*60+second(date);
                    date=datesecond-startdate;
                    originlist=[originlist,abs(list(2:402,2))];
                end
                
                [VgIdlist,S]=readfile(filename);
                [n,~]=size(VgIdlist);
                if VgIdlist(n,2)>Idmax
                    Idmax=VgIdlist(n,2);
                end
                
                [Vt,mobility,Vsat,fits,Vfb]=calVtMobility(VgIdlist);
                parameters=[parameters
                    date,Vt,mobility,Vsat,fits,Vfb,S];
                plot(VgIdlist(:,1),VgIdlist(:,2),'LineWidth',2);
                hold on
                
                x=Vt:0.01:20;
                plot(x,fits(1).*x+fits(2))
                hold on
                
            end
            set(gca,'LineWidth',3);
            axis([-20 20 0 Idmax]);
            xlabel('Vgs / V');
            ylabel('Ids / A');
            saveas(gcf,['picture\',samplename,'-sample-',num2str(samplenumber),'-positivebias-transfer'],'tif');
            hold off
            dlmwrite(['parameters\',samplename,'-sample-',num2str(samplenumber),'-positivebias-parameters.txt'],parameters);
            dlmwrite(['originlist\',samplename,'-sample-',num2str(samplenumber),'-originlist.txt'],originlist);
%         catch
%             [filename,' doesn''t exist']
%         end
        
%         
%         doslist=zeros(200,21);
%         %         try
%         for bias = 1:1:20
%             filename=['data/',samplename,'/',samplename,'-sample-',num2str(samplenumber),'-positivebias-',num2str(bias)];
%             VgIdlist=readfile(filename);
%             [Vt,mobility,Vsat,fits]=calVtMobility(VgIdlist);
%             VgIdlist=VgIdlistPorcess(VgIdlist,Vsat);
%             
%             %channel thickness
%             [x,dos]=calDOS(VgIdlist,thickness*1E-9);
%             
%             if bias==1
%                 [n,~]=size(dos);
%                 doslist(1:n,1)=x;
%                 doslist(1:n,2)=dos;
%             else
%                 [n,~]=size(dos);
%                 doslist(1:n,bias+1)=dos;
%                 
%             end
%             
%             semilogy(x,dos,'DisplayName',num2str(bias),'LineWidth',2);
%             hold on
%             
%         end
%         set(gca,'LineWidth',3);
%         xlabel('E / eV');
%         ylabel('DOS / cm-3 eV-1');
%         saveas(gcf,['picture\',samplename,'-sample-',num2str(samplenumber),'-positivebias-dos'],'tif');
%         hold off
%         dlmwrite(['originlist\',samplename,'-sample-',num2str(samplenumber),'-doslist.txt'],doslist);
%         %         catch
%         %             [filename,'    can''t fit dos']
%         %         end
        
        
    end
end