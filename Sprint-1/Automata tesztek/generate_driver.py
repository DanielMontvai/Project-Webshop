from selenium import webdriver
from selenium.webdriver.chrome.options import Options

def get_preconfigured_chrome_driver():
    options = Options()
    options.add_argument("window-position=0,-1000")
    options.add_experimental_option("detach", True)
    browser = webdriver.Chrome(options=options)
    browser.maximize_window()
    return browser
