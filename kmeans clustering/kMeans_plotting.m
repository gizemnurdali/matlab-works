function [num] = kMeans_plotting(points,p_num,cluster,centers,xmax,ymax,opt_c_num)
    disp(centers)
    disp('\n')
    x = points(1,:);
    y = points(2,:);
    subplot(1,2,1)
    scatter(x,y,p_num,cluster,'.')
    hold on
    scatter(centers(1,:),centers(2,:),'xk','LineWidth',1.5); %merkezlerin çarpý þeklinde basýlmasý
    hold on
    axis([0 xmax 0 ymax])
    xlabel('x');
    ylabel('y');
    title('Data Distributions By Cluster Centers')
    grid on;
    
    subplot(1,2,2);
    histogram(cluster); %hangi kümede ne kadar nokta olduðunun sütun grafiði
    axis tight;
    [num,~] = histcounts(cluster);
    yticks(round(linspace(0,max(num),opt_c_num)));
    xlabel('Clusters');
    ylabel('Number of data points');
    title('Points-Cluster Histogram');
end

