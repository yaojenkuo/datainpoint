def write_concatenated_df():
    url_2011 = "https://www.run2pix.com/report/report_w.php?EventCode=20111218&Race=MA&sn=3"
    url_2012 = "https://www.run2pix.com/report/report_w.php?EventCode=20121216&Race=MA&sn=32"
    url_2013 = "https://www.run2pix.com/report/report_w.php?EventCode=20131215&Race=MA&sn=57"
    url_2014 = "https://www.run2pix.com/report/report_w.php?EventCode=20141221&Race=MA&sn=86"
    url_2015 = "https://www.run2pix.com/report/report_w.php?EventCode=20151220&Race=MA&sn=111"
    url_2016 = "https://www.run2pix.com/report/report_w.php?EventCode=20161218&Race=MA&sn=136"
    url_2017 = "https://www.run2pix.com/report/report_w.php?EventCode=20171217&Race=MA&sn=161"
    url_list = [url_2011, url_2012, url_2013, url_2014, url_2015, url_2016, url_2017]
    df_list = []
    for url, yr in zip(url_list, range(2011, 2018)):
        df = get_runner_record(url)
        df['year'] = yr
        df_list.append(df)
    df = df_list[0]
    for i in range(1, len(df_list)):
        df = pd.concat([df, df_list[i]])
    df.to_csv('taipei_marathon.csv', index = False)