import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

def get_preconfigured_chrome_driver():
    options = Options()

    # CI environment (GitHub Actions)
    if os.environ.get("CI") == "true":
        options.add_argument("--headless=new")
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-dev-shm-usage")
        options.add_argument("--disable-gpu")
        options.add_argument("--window-size=1920,1080")  # ensure full page renders
        options.add_argument("--remote-allow-origins=*") # fix for recent Chrome versions
        service = Service("/usr/bin/chromedriver")
        browser = webdriver.Chrome(service=service, options=options)
    else:
        # Local / PyCharm
        options.add_argument("window-position=0,-1000")
        options.add_experimental_option("detach", True)  # browser stays open
        browser = webdriver.Chrome(options=options)

    browser.maximize_window()
    return browser