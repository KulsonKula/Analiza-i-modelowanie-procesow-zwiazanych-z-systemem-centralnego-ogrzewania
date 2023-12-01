clc;
clear all;
close all;


%ładowanie danych
data1 = load("data/pom_2009_10/p_20091022_czw.txt"); 
data2 = load("data/pom_2009_10/p_20091023_piat.txt"); 
data3 = load("data/pom_2009_10/p_20091024_sob.txt"); 
data4 = load("data/pom_2009_10/p_20091026_niedz.txt"); 
data5 = load("data/pom_2009_10/p_20091027_po.txt"); 
data6 = load("data/pom_2009_10/p_20091028-wt.txt"); 
data7 = load("data/pom_2009_10/p_20091029-śr.txt"); 
data8 = load("data/pom_2009_10/p_20091030_czw.txt"); 
data9 = load("data/pomiary_2010/p_20100419_pon.txt");
data10 = load("data/pomiary_2010/p_20100420_wt.txt");

newdata1=format_save(data1,4,"data_obrobiona/czw1.csv");
newdata2=format_save(data2,5,"data_obrobiona/pt1.csv");
newdata3=format_save(data3,6,"data_obrobiona/sob1.csv");
newdata4=format_save(data4,7,"data_obrobiona/niedz1.csv");
newdata5=format_save(data5,1,"data_obrobiona/pon1.csv");
newdata6=format_save(data6,2,"data_obrobiona/wt1.csv");
newdata7=format_save(data7,3,"data_obrobiona/sr1.csv");
newdata8=format_save(data8,4,"data_obrobiona/czw2.csv");
newdata9=format_save(data8,1,"data_obrobiona/pon2.csv");
newdata10=format_save(data8,2,"data_obrobiona/wt2.csv");

test =["dzien_tygodnia" "czas" "przeplyw"];
calosc=[test;newdata1;newdata2;newdata3;newdata4;newdata5;newdata6;newdata7;newdata8;newdata9;newdata10];
writematrix(calosc,"data_obrobiona/calosc.csv");



function newdata= format_save(data, numer_dnia_tygodnia,name)
j=1;
newdata=[];

% usunięcie pakietów synchronizacyjnych
for i=1:max(size(data))
    if data(i,5)==1
        newdata(j,:)=data(i,:);
        j=j+1;
    end
end

% unormowanie sampli, formatowanie danych
sample= (newdata(:,1)-newdata(1,1))/2+1;
sample=sample/sample(end,1);

newdata= [numer_dnia_tygodnia*ones(max(size(newdata)),1) sample*100 (newdata(:,13)*16/256+4)];

writematrix(newdata,name);
end
