tag=["praca_pieca" "przekaźnik pokojowy","temperatura zewnętrzna","wilgotność zewnętrzna","ciśnienie atmosferyczne","prędkość wiatru","kierunek wiatru","wilgotność wewnętrzna","temperatura wewnętrzna","temperatura wewnętrzna na kominku","temperatura wewnętrzna nad kuchenką gazową"];

data=[tag;(Dane1s(1:78098)/max(Dane1s))' (Dane2s(1:78098)/max(Dane2s))' (Dane3s(1:78098)/max(Dane3s))' (Dane4s(1:78098)/max(Dane4s))' (Dane5s(1:78098)/max(Dane5s))' (Dane6s(1:78098)/max(Dane6s))' (Dane7s(1:78098)/max(Dane7s))' (Dane8s(1:78098)/max(Dane8s))' (Dane9s(1:78098)/max(Dane9s))' (Dane10s(1:78098)/max(Dane10s))' (Dane11s(1:78098)/max(Dane11s))'];

writematrix(data, "Obrobione_norm.csv")


data=[tag;(Dane1s(1:78098))' (Dane2s(1:78098))' (Dane3s(1:78098))' (Dane4s(1:78098))' (Dane5s(1:78098))' (Dane6s(1:78098))' (Dane7s(1:78098))' (Dane8s(1:78098)*100)' (Dane9s(1:78098))' (Dane10s(1:78098))' (Dane11s(1:78098))'];

writematrix(data, "Obrobione.csv")