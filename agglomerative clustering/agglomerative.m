function [clusters,iter] = agglomerative(points,cluster_num)
    row_index = 0; 
    col_index = 0;
    pnum = length(points); 
    A = pdist(points,'euclidean'); 
    dist = squareform(A); %her noktan�n birbirine olan uzakl��� tutuluyor
    size_dist = size(dist);
    for i=1:(size_dist)(1) 
        for j=1:(size_dist)(2)
            if i == j 
                dist(i,j) = inf;
            end
        end
    end
    counter = length(points)-(cluster_num-1);
    iter = 1
    clusters = cell(counter,1);
    cp_array = 1:pnum;
    clusters{1} = cp_array; %ilk a�amada her nokta birer k�me
    for k=2:pnum %cluster listesinin kalan�n� doldurmak i�in 2'den ba�latt�k
        %matristeki en k���k eleman� ve nerede oldu�unu bulduk 
        min_val = inf;
        for r=1:(size_dist)(1) 
            for c=1:(size_dist)(2)
                if (dist(r,c) <= min_val)
                    min_val = dist(r,c);
                    row_index = r;
                    col_index = c;
                end
            end
        end
        %k�meleri birle�tirme
        minc = min(row_index,col_index);
        maxc = max(row_index,col_index);
        for t = 1:length(cp_array)
            if(cp_array(t)== maxc) %yeni cluster arrayi tan�mlad�k
                cp_array(t) = minc;%noktay� di�er k�meye ekledik
            end 
        end
        for m=1:size_dist(1) %birle�tirilen yeni k�menin noktalara uzakl���n� belirledik
            if(m ~= col_index && m~=row_index)
                temp = (dist(col_index,m)+dist(row_index,m))/2; 
                dist(col_index,m) = temp;
                dist(m,col_index) = temp;
            end
        end
        for n=1:size_dist(1) %iki nokta ayn� k�meye al�nd�ktan sonra yeni min de�eri belirlemek i�in min_val sat�r s�tununa inf atad�k
            dist(row_index,n) = inf; 
            dist(n,row_index) = inf;
        end
    clusters{k} = cp_array; %yeni cluster arrayi cluster listesine ekledik.
    iter = iter + 1;
    if (iter == counter)
        break;
    end
    end
end