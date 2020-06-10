%points(dim,point number)
%k b�l�nmek istenen k�me say�s�
function [cluster,centers,wcss] = kMeans(points,k) 
    p = size(points) %dim,p_num
    dim = p(1); %x-y :boyut
    p_num = p(2); %200 nokta
    %ba�lang��ta k k�menin merkezlerini random se�iyoruz.
    center_indices = randperm(p_num,k);%200 noktan�n 10lu perm�tasyonu, bu 10lu verisetinden hangi indisleri se�ece�imizi g�steriyor.
    centers = zeros(dim,k); 
    for i=1:k
        centers(:,i) = points(:,center_indices(i));
    end
        cluster = zeros(1,p_num);%ilk etapta her noktan�n ait oldu�u k�meyi yazaca��m�z vekt�r� tan�mlad�k.
        cluster0 = cluster; %while d�ng�s�n� durdurmak i�in
        counter = 0;
        wcss = 0;
        dist = zeros(p_num,k); %sat�rlarda noktalar,s�tunlarda her bir noktan�n k k�meye uzakl���n�n tutulaca�� matris
    while 1
        for p=1:p_num 
            for cl=1:k
               dist(p,cl) = norm(points(:,p)-centers(:,cl),2); %her bir noktan�n k k�menin merkezlerine olan �klid uzakl�klar� tutuluyor.
            end
        end
        [min_val,cluster] = min(dist'); %matriste kolon bazl� �al��t��� i�in transpozunu ald�k
        
        for cl=1:k %eski merkezleri random kayd�rarak yenilerini bulmaktansa her k�menin i�indeki noktalar�n ortalamas�yla yeni merkezi belirliyoruz.
            centers(:,cl) = mean(points(:,cluster == cl),2); %sat�r bazl� ortalama almak(,2), yeni merkez(xort,yort)�eklinde olacak
        end
        if cluster0 == cluster %k�melerin listesi de�i�miyorsa algoritma tamamlanm��t�r.
            %https://www.veribilimiokulu.com/kumeleme-notlari-3-k-ortalamalar-kume-sayisini-belirleme/
            %Within Clusters Sum of Square (WCSS)- k�meler i�i kareler
            %toplam�
            for cl = 1:k %dirsek metodu optimum k�me say�s�n� belirlemek i�in wcss hesaplamas�
               wcss = wcss + (norm((points(:,cluster == cl)-centers(:,cl))))^2;
            end
            break;
        end 
        cluster0 = cluster;
        counter = counter + 1;
    end
end

