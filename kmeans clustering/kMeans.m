%points(dim,point number)
%k bölünmek istenen küme sayýsý
function [cluster,centers,wcss] = kMeans(points,k) 
    p = size(points) %dim,p_num
    dim = p(1); %x-y :boyut
    p_num = p(2); %200 nokta
    %baþlangýçta k kümenin merkezlerini random seçiyoruz.
    center_indices = randperm(p_num,k);%200 noktanýn 10lu permütasyonu, bu 10lu verisetinden hangi indisleri seçeceðimizi gösteriyor.
    centers = zeros(dim,k); 
    for i=1:k
        centers(:,i) = points(:,center_indices(i));
    end
        cluster = zeros(1,p_num);%ilk etapta her noktanýn ait olduðu kümeyi yazacaðýmýz vektörü tanýmladýk.
        cluster0 = cluster; %while döngüsünü durdurmak için
        counter = 0;
        wcss = 0;
        dist = zeros(p_num,k); %satýrlarda noktalar,sütunlarda her bir noktanýn k kümeye uzaklýðýnýn tutulacaðý matris
    while 1
        for p=1:p_num 
            for cl=1:k
               dist(p,cl) = norm(points(:,p)-centers(:,cl),2); %her bir noktanýn k kümenin merkezlerine olan öklid uzaklýklarý tutuluyor.
            end
        end
        [min_val,cluster] = min(dist'); %matriste kolon bazlý çalýþtýðý için transpozunu aldýk
        
        for cl=1:k %eski merkezleri random kaydýrarak yenilerini bulmaktansa her kümenin içindeki noktalarýn ortalamasýyla yeni merkezi belirliyoruz.
            centers(:,cl) = mean(points(:,cluster == cl),2); %satýr bazlý ortalama almak(,2), yeni merkez(xort,yort)þeklinde olacak
        end
        if cluster0 == cluster %kümelerin listesi deðiþmiyorsa algoritma tamamlanmýþtýr.
            %https://www.veribilimiokulu.com/kumeleme-notlari-3-k-ortalamalar-kume-sayisini-belirleme/
            %Within Clusters Sum of Square (WCSS)- kümeler içi kareler
            %toplamý
            for cl = 1:k %dirsek metodu optimum küme sayýsýný belirlemek için wcss hesaplamasý
               wcss = wcss + (norm((points(:,cluster == cl)-centers(:,cl))))^2;
            end
            break;
        end 
        cluster0 = cluster;
        counter = counter + 1;
    end
end

