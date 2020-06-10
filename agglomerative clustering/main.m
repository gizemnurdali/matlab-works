clear all; close all; clc;
data = load('data.mat')
points = cell2mat(struct2cell(data));
pnum = length(points);
A = pdist(points,'euclidean'); 
dist = squareform(A);
Z = linkage(dist,'average');
dendrogram(Z) %burada küme sayýsýna karar verilir.
k = 4;
iteration = pnum-(k-1);
%matlab function
m_cluster = clusterdata(dist,'Linkage','average','MaxClust',k);
fig_matlab = agglomerative_plotting(points,m_cluster',iteration,k);
fig_matlab.Name = 'MATLAB';
%agglomerative function
[clusters,iter] = agglomerative(points,k);
cluster = clusters{iter};
fig_ = agglomerative_plotting(points,cluster,iter,k);
fig_.Name = 'Agglomerative';