function [fig] = agglomerative_plotting(points,cluster,iter,cluster_num)
    fig = figure('Name','Visualizations','units','normalized','outerposition',[0 0 1 1]);
    subplot(1,2,1)
    pnum = length(points)
    cmap = jet(pnum); % pnum kadar farklý renk oluþturuyor.
    scatter(points(:,1),points(:,2),30,cmap,'filled')
    grid on;
    axis([0 10 0 10])
    title('each data point is a different cluster')
    xlabel('x')
    ylabel('y')
    
    clusters_1 = 1:pnum; 
    cl_original = unique(cluster); %tekrarlar olmadan sadece çizdirilecek kümeleri aldýk.
    indice_plot = cell(cluster_num,1); %k küme için 1.kümedeki .... k. kümedeki noktalar ayrý ayrý tutuluyor.
    k = zeros(1,pnum);
    for i=1:cluster_num 
        for j=1:pnum
            if cluster(j)==cl_original(i)             
                k(j) = clusters_1(j);
            end
        end
        indice_plot{i} = (nonzeros(k))';
        k(1,:) = 0;
    end
    subplot(1,2,2)
    color = ["r" "g" "b" "c" "m" "k" "y"];
    for j=1:cluster_num
        fprintf('%d. cluster points: \n',j)
        temp = cell2mat(indice_plot(j)); 
        for k=1:length(temp)
            fprintf('\n%d %d\n',points(temp(k),1),points(temp(k),2))
            scatter(points(temp(k),1),points(temp(k),2),color(j),'filled')
            hold on
        end
        fprintf('\n')
    end
    axis([0 10 0 10])
    title(' Agglomerative Clusters')
    xlabel('x')
    ylabel('y')
    grid on
end

