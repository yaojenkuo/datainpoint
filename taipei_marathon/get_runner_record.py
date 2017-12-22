def get_runner_record(url):
    driver.get(url)
    odd_even_l = ['OL', 'EL']
    odd_even_r = ['OR', 'ER']
    runner_record = {
        'bib_num': [],
        'name': [],
        'cate': [],
        'official_time': [],
        'rank_all': [],
        'rank_cat': [],
        'net_time': []
    }
    while True:
        next_button_xpath = "/html/body/table[2]/tbody/tr[6]/td/table/tbody/tr/td/table/tbody/tr/td[@class='grayed'][2]/table/tbody/tr/td[3]/a"
        next_button = driver.find_elements_by_xpath(next_button_xpath)
        for l in odd_even_l:
            bib_num_xpath = '//td[@class=\'{}\'][1]'.format(l)
            name_xpath = '//td[@class=\'{}\'][2]'.format(l)
            cate_xpath = '//td[@class=\'{}\'][4]'.format(l)
            bib_num_elem, name_elem, cate_elem = driver.find_elements_by_xpath(bib_num_xpath), driver.find_elements_by_xpath(name_xpath), driver.find_elements_by_xpath(cate_xpath)
            for e1, e2, e3 in zip(bib_num_elem, name_elem, cate_elem):
                runner_record['bib_num'].append(e1.text)
                runner_record['name'].append(e2.text)
                runner_record['cate'].append(e3.text)
        for r in odd_even_r:
            official_time_xpath = '//td[@class=\'{}\'][1]'.format(r)
            rank_all_xpath = '//td[@class=\'{}\'][2]'.format(r)
            rank_cat_xpath = '//td[@class=\'{}\'][3]'.format(r)
            net_time_xpath = '//td[@class=\'{}\'][4]'.format(r)
            official_time_elem, rank_all_elem, rank_cat_elem, net_time_elem = driver.find_elements_by_xpath(official_time_xpath), driver.find_elements_by_xpath(rank_all_xpath), driver.find_elements_by_xpath(rank_cat_xpath), driver.find_elements_by_xpath(net_time_xpath)
            for e4, e5, e6, e7 in zip(official_time_elem, rank_all_elem, rank_cat_elem, net_time_elem):
                runner_record['official_time'].append(e4.text)
                runner_record['rank_all'].append(e5.text)
                runner_record['rank_cat'].append(e6.text)
                runner_record['net_time'].append(e7.text)
        # Keep scraping the next page if Next link exists
        if len(next_button) > 0:
            next_button_click = driver.find_element_by_xpath(next_button_xpath)
            next_button_click.click()
        # Stop scraping if Next link is of absense
        else:
            break
    
    df = pd.DataFrame(runner_record)
    return df