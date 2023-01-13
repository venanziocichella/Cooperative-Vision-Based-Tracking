% Script file (sinmovie.m) to plot an animation of a sin function with increasing
% frequency.
%                                 
% Author…
% Date…
 

MakeQTMovie('start','test.mov');
MakeQTMovie('quality',1);
MakeQTMovie('size',[320 240]);
MakeQTMovie('framerate',30);
plt_colors = lines(numVeh);



axis([-1400 800 -1400 800]);

MakeQTMovie('start','test.mov');
MakeQTMovie('quality',1);
MakeQTMovie('size',[320 240]);
MakeQTMovie('framerate',30);
plt_colors = lines(numVeh);

%lh = 4e3*ones(numVeh^2-1,1);
for i=1:3:6300
    count = 0;
    for j = 1 : numVeh
        s(j) = line(puav.Data(i,3*j-2),puav.Data(i,3*j-1),100,'Marker','o','LineWidth',2,'color',plt_colors(j,:)); 
        hold on;
        s1(j) = line(ptg.Data(i,1),ptg.Data(i,2),0,'Marker','o','LineWidth',2,'color','k');
        grid on;
    end
%     for j = 1 : numVeh
%             count = count + 1;
%             k = j+2;
%             if j == numVeh-1
%                 k = 1;
%             end
%             if j == numVeh
%                 k = 2;
%             end
%             lh(count) = line([puav.Data(i,3*j-2),puav.Data(i,3*k-2)],[puav.Data(i,3*j-1),puav.Data(i,3*k-1)],'Color','k','LineWidth',1);
%     end
    

    for j = 1 : numVeh
        for k = j+1 : numVeh
            count = count + 1;
            if LaplacianMatrix.Data(j,k,i) == -1                
                lh(count) = line([puav.Data(i,3*j-2),puav.Data(i,3*k-2)],[puav.Data(i,3*j-1),puav.Data(i,3*k-1)],'Color','k','LineWidth',1);
            else 
                lh(count) = line([0,0],[0,0],'Color','k','LineWidth',1);
            end
        end
    end



    MakeQTMovie('addaxes'); pause(0.001);
    delete(s); delete(s1); delete(lh); 
end
MakeQTMovie('finish');
% MakeQTMovie('start','test.mov');
% MakeQTMovie('quality',1);
% %MakeQTMovie('size',[320 240]);
% %MakeQTMovie('framerate',30);
% for i = 1:length(M)
%    movie(M(:,i));
%    MakeQTMovie('addaxes');
% end
% MakeQTMovie('finish');

%-----------------------------------------------------
%--- Create a Matlab movie ---%