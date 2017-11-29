from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import random
import pandas as pd

def get_github_activities(keywords):
    '''
    Getting search results of activities from GitHub
    keywords: an iterable of the key-words to search on GitHub, e.g. ['TensorFlow', 'Pytorch']
    '''
    search_css = ".js-site-search-focus"
    result_css = ".pb-3 h3"
    nav_css = ".UnderlineNav-item"
    search_results = {
        "repositories": [],
        "commits": [],
        "issues": [],
        "wikis": []
    }
    driver = webdriver.Chrome()
    driver.get("https://github.com/")
    for keyword in keywords:
        nav_links = []
        search_input = driver.find_element_by_css_selector(search_css) # 找到搜尋欄位
        search_input.clear() # 清空搜尋欄位
        search_input.send_keys(keyword) # 輸入搜尋關鍵字
        search_input.send_keys(Keys.RETURN) # 按下 Enter
        navs = driver.find_elements_by_css_selector(nav_css) # 擷取不同 navs 的連結
        for nav in navs:
            nav_links.append(nav.get_attribute('href'))
        del nav_links[1] # 沒有登入不能觀看 code 的資訊故刪除
        for (nav_link, key) in zip(nav_links, search_results.keys()):
            driver.get(nav_link) # 連結到不同的 nav
            result = driver.find_element_by_css_selector(result_css).text
            splitted_res = result.split(" ")
            res = splitted_res[0].replace(",", "")
            res_int = int(res)
            search_results[key].append(res_int)
            time.sleep(random.randrange(11, 21)) # 休息 10 秒以上才不會被 GitHub 擋掉
    search_results['key_word'] = list(keywords)
    df = pd.DataFrame(search_results, columns = ['key_word', 'repositories', 'commits', 'issues', 'wikis'])
    return(df)