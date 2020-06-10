function [clusters,iter] = agglomerative(points,cluster_num)
    row_index = 0; 
    col_index = 0;
    pnum = length(points); 
    A = pdist(points,'euclidean'); 
    dist = squareform(A); %her noktanýn birbirine olan uzaklýðý tutuluyor
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
    clusters{1} = cp_array; %ilk aþamada her nokta birer küme
    for k=2:pnum %cluster listesinin kalanýný doldurmak için 2'den baþlattýk
        %matristeki en küçük elemaný ve nerede olduðunu bulduk 
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
        %kümeleri birleþtirme
        minc = min(row_index,col_index);
        maxc = max(row_index,col_index);
        for t = 1:length(cp_array)
            if(cp_array(t)== maxc) %yeni cluster arrayi tanýmladýk
                cp_array(t) = minc;%noktayý diðer kümeye ekledik
            end 
        end
        for m=1:size_dist(1) %birleþtirilen yeni kümenin noktalara uzaklýðýný belirledik
            if(m ~= col_index && m~=row_index)
                temp = (dist(col_index,m)+dist(row_index,m))/2; 
                dist(col_index,m) = temp;
                dist(m,col_index) = temp;
            end
        end
        for n=1:size_dist(1) %iki nokta ayný kümeye alýndýktan sonra yeni min deðeri belirlemek için min_val satýr sütununa inf atadýk
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