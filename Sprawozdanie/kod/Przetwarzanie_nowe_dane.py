for f in csv_files:
    dataset = pd.read_csv(f)
    for i in range(len(dataset)):
        dt = dataset.loc[i, "Summer_Timestamps"]
        data, time = dt.split(' ')
        year, month, day = (int(x) for x in data.split('-'))
        ans = datetime.date(year, month, day)
        dzied_tygodnia = dni_tygodnia_mapa[ans.strftime("%A")]

        hours, minutes, null = time.split(":")
        time = (int(hours)*60+int(minutes))/(60*24)

        przeplyw = dataset.loc[i, "Summer_Water_Consumption"]

        dane_1.loc[len(dane_1)] = {'Pora_roku': 2,
                                   'Dzien_tygodnia': dzied_tygodnia,
                                   'Czas_dnia': time,
                                   'Przeplyw': przeplyw}
