clear all; close all; clc;
k = 16; %b�l�nmek istenen k�me say�s� aral���
xmax = 100;
ymax = 100;
p_num = 200;
x = xmax * (rand(1,p_num)); %random veri noktalar� olu�turduk
y = ymax * (rand(1,p_num));
points = [x;y];
a = size(points);
a(2) = p_num;

%elbow(dirsek) metodu
cs = 1:k;
wcss_array = zeros(1,k);
for i=1:k
    [cluster,centers,wcss] = kMeans(points,i); %yazd���m�z kMeans fonksiyonunu �al��t�r�yoruz.
    wcss_array(i) = wcss
end
plot(cs,wcss_array)
xlabel('cluster')
ylabel('WCSS')
title('cluster-wcss')
%k�me say�s�n� se�me grafi�inde 12 dan sonra grafikte bir yatayla�ma
%ba�l�yor.
opt_c_num = 4; 

figure('Name','K-Means Visualizations','units','normalized','outerposition',[0 0 1 1]);
[cluster,centers,wcss] = kMeans(points,opt_c_num); 

disp('algorithm centers\n')
g = kMeans_plotting(points,p_num,cluster,centers,xmax,ymax,opt_c_num);


[clust, cents] = kmeans(points',opt_c_num);
figure('Name','Matlab K-Means Visualizations','units','normalized','outerposition',[0 0 1 1]);

clus = clust';
cent = cents';
disp('matlab algorithm centers\n')
b = kMeans_plotting(points,p_num,clus,cent,xmax,ymax,opt_c_num);
