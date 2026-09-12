# Analiza i modelowanie procesów związanych z systemem centralnego ogrzewania

Praca inżynierska łącząca uczenie maszynowe z modelowaniem dynamiki instalacji ciepłej wody użytkowej (CWU): sieć neuronowa prognozuje zużycie wody, wpływ warunków pogodowych na tę prognozę jest analizowany metodami wyjaśnialnego AI, a wynik trafia jako wejście do trójwarstwowego modelu zasobnika CWU ze strojonym regulatorem — całość zamknięta optymalizacją temperatury zadanej względem kosztu i komfortu.

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Spis treści</summary>
  <ol>
    <li><a href="#o-projekcie">O projekcie</a></li>
    <li><a href="#dane">Dane</a></li>
    <li><a href="#etapy-pracy">Etapy pracy</a></li>
    <li><a href="#struktura-repozytorium">Struktura repozytorium</a></li>
    <li><a href="#uruchomienie">Uruchomienie</a></li>
    <li><a href="#milestones">Milestones</a></li>
    <li><a href="#podziękowania">Podziękowania</a></li>
  </ol>
</details>

## Built with

![Python](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue)
![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=TensorFlow&logoColor=white)
![Keras](https://img.shields.io/badge/Keras-FF0000?style=for-the-badge&logo=keras&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-F7931E?style=for-the-badge&logo=scikitlearn&logoColor=white)
![pandas](https://img.shields.io/badge/Pandas-2C2D72?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/Numpy-777BB4?style=for-the-badge&logo=numpy&logoColor=white)

## O projekcie

Praca inżynierska (kierunek automatyka i robotyka) koncentruje się na zastosowaniu uczenia maszynowego do analizy zużycia ciepłej wody użytkowej z uwzględnieniem korelacji tygodniowej i sezonowej. Omówiono proces przetwarzania danych oraz dobór architektury i hiperparametrów sieci neuronowej wykorzystującej dane historyczne do poprawy predykcji. Następnie zbadano wpływ warunków atmosferycznych na tę predykcję trzema metodami wyjaśnialności modelu, a poprawność wniosków zweryfikowano dodając do modelu kluczowy parametr pogodowy. W ostatnim etapie wykorzystano nauczony model do symulacji dynamiki temperatury wody w trójwarstwowym zasobniku CWU sterowanym dostrojonym regulatorem, a całość poddano optymalizacji przy użyciu funkcji celu łączącej koszt energii i komfort użytkownika.

Pełna treść pracy (metodyka, wzory, wykresy, wnioski) dostępna jest w [`thesis/main.pdf`](thesis/main.pdf).

## Dane

- **Zużycie ciepłej wody** — dane M.J. Ritchie et al. (2018) z 77 gospodarstw domowych w RPA (2 dorosłych + 2 dzieci, podstawowy sprzęt AGD), próbkowane co minutę przez 16 tygodni (po 4 tygodnie na porę roku); każdy plik zawiera znacznik czasu, przepływ wody i temperaturę otoczenia.
- **Warunki pogodowe** — temperatura i wilgotność zewnętrzna/wewnętrzna, ciśnienie atmosferyczne, prędkość i kierunek wiatru, wykorzystane jako dodatkowe wejścia modelu oraz do analizy istotności cech.
- Kopie zapasowe i archiwalne wersje danych znajdują się w [`Dane/Kopia zapasowa danych/`](Dane/Kopia%20zapasowa%20danych/).

## Etapy pracy

### 1. Predykcja zużycia ciepłej wody

Zaprojektowano cztery warianty sieci neuronowej różniące się zestawem wejść, aby rozdzielić wpływ korelacji tygodniowej i sezonowej:

| Model | Wejścia |
|---|---|
| A | dzień tygodnia, pora dnia |
| B | pora dnia |
| C | pora roku, dzień tygodnia, pora dnia |
| D | pora roku, pora dnia |

Modele trenowano zarówno na pojedynczych domostwach, jak i na wybranej podpróbie (12 domów) oraz na całym zbiorze (77 domów), oceniając jakość predykcji (MSE) walidacją holdout (80/20). Dodatkowo wprowadzono wejście oparte na historycznym, tygodniowym zużyciu wody, poprawiające zdolność generalizacji modelu.

### 2. Wpływ warunków pogodowych

Porównano dwa modele (uproszczony i rozszerzony) prognozujące temperaturę na podstawie danych pogodowych, po czym zbadano istotność poszczególnych wejść trzema niezależnymi metodami wyjaśnialności:

- **Permutation Feature Importance (PFI)** — spadek jakości modelu po permutacji danej cechy,
- **analiza wag pierwszej warstwy sieci** (w tym mapy ciepła wag),
- **LIME** — lokalne wyjaśnienia predykcji dla wybranych próbek.

Wnioski z wszystkich trzech metod zweryfikowano dodatkowo, dorzucając do modeli kluczowy parametr pogodowy i sprawdzając zgodność wyników.

### 3. Modelowanie dynamiki zasobnika CWU

Zbudowano trójwarstwowy model zasobnika (założenie idealnego mieszania w warstwie, wymiana ciepła z otoczeniem i sąsiednimi warstwami, wejścia grzewcze w warstwie 2 i 3), opisany układem równań różniczkowych i całkowany metodą Eulera. Prognoza zużycia wody z modelu z etapu 1 stanowi wejście symulacji (wybrano wariant modelu C z dodatkowym parametrem, symulacja dla letniego wtorku). Do sterowania zaimplementowano regulator PD, dostrojony metodą Zieglera-Nicholsa (wzmocnienie proporcjonalne 7.80, różniczkujące 40.25).

### 4. Optymalizacja temperatury zadanej

Zdefiniowano dwie funkcje celu:

- **funkcję kosztów** — ilość energii wydzielanej przez piec w okresie badawczym,
- **funkcję komfortu** — zależną od temperatury wymaganej i czułości użytkownika na odchylenia.

Funkcję celu wyznaczono jako ważoną sumę obu funkcji i zbadano, jak zmiana wag przekłada się na optymalną temperaturę zadaną (np. wzrost wagi kosztów obniża optymalną temperaturę do 22°C, wzrost wagi komfortu podnosi ją do 36°C).

## Struktura repozytorium

```
Dane/                          # dane wejściowe: zużycie wody (77 domostw) i dane pogodowe + kopie zapasowe
Kod/
  kod_pojedyńcze.ipynb          # modele uczone na pojedynczym domostwie
  kod_wybrane.ipynb             # modele uczone na wybranej podpróbie (12 domostw)
  kod_calosc.IPYNB              # modele uczone na całym zbiorze (77 domostw)
  11_12_porownanie_uczenia.IPYNB # porównanie modeli A/B/C/D i wpływu ilości danych
  porównianie_modeli.IPYNB      # zestawienie i porównanie wytrenowanych modeli
  Pogoda.IPYNB                  # modele wpływu warunków pogodowych + PFI, wagi, LIME
  Symulacja.IPYNB               # symulacja trójwarstwowego zasobnika CWU + regulator + optymalizacja
  testowanie.IPYNB              # testy i walidacja modeli
  wskaźniki/                    # zapisane wartości funkcji celu/kosztu/komfortu z eksperymentów
Modele/                        # wytrenowane modele Keras (SavedModel) dla każdego z powyższych etapów
docs/                          # PDF-y: prezentacja, praca dyplomowa, artykuł źródłowy
thesis/                        # źródła LaTeX pracy inżynierskiej, wykresy, main.pdf
```

## Uruchomienie

Projekt bazuje na Pythonie oraz TensorFlow/Keras (sieci neuronowe), a także NumPy, Pandas, Matplotlib, scikit-learn, ELI5 i LIME (przetwarzanie danych, wizualizacja, wyjaśnialność modeli). Zalecane jest środowisko Conda (repozytorium nie zawiera pliku `requirements.txt`/`environment.yml`, więc zależności należy zainstalować ręcznie):

```bash
conda create -n cwu python=3.11
conda activate cwu
pip install tensorflow numpy pandas matplotlib scikit-learn eli5 lime
```

Notatniki w `Kod/` należy uruchamiać w kolejności odpowiadającej etapom pracy (predykcja zużycia → analiza pogody → symulacja zasobnika → optymalizacja), korzystając z danych w `Dane/` i zapisując/wczytując modele z `Modele/`.

## Milestones

- [x] Zbudowanie sieci neuronowej przewidującej zużycie ciepłej wody z uwzględnieniem korelacji tygodniowej i sezonowej.
- [x] Analiza wpływu warunków pogodowych i weryfikacja decyzji sieci (PFI, wagi wejść, LIME).
- [x] Modelowanie trójwarstwowej dynamiki zasobnika CWU ze strojonym regulatorem.
- [x] Optymalizacja temperatury zadanej na podstawie funkcji kosztu i komfortu.
- [x] Napisanie pracy inżynierskiej.

