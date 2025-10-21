# import os
#
# from selenium import webdriver
# from selenium.webdriver.chrome.options import Options
# from selenium.webdriver.chrome.service import Service
#
#
# def get_preconfigured_chrome_driver():
#     options = Options()
#
#     if (os.environ.get("CI") == "true"):
#         options.add_argument("--headless=new")
#         options.add_argument("--no-sandbox")
#         options.add_argument("--disable-dev-shm-usage")
#         options.add_argument("--disable-gpu")
#         options.add_argument("--disable-software-rasterizer")
#         options.add_argument("--single-process")
#         options.add_argument("--window-size=1920,1080")
#         options.add_argument("--remote-allow-origins=*")
#         service = Service("/usr/bin/chromedriver")
#         browser = webdriver.Chrome(service=service, options=options)
#     else:
#         options.add_argument("window-position=0,-1000")
#         options.add_experimental_option("detach", True)
#         browser = webdriver.Chrome(options=options)
#
#     browser.maximize_window()
#     return browser

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options


def get_preconfigured_chrome_driver():
    """
    Returns a Chrome WebDriver instance preconfigured for CI / Docker environments.
    """
    options = Options()

    # Headless mode (new implementation)
    options.add_argument("--headless=new")

    # Recommended flags for CI / Docker
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("window-size=1920,1080")  # avoids maximize_window issues

    # Optional: Disable extensions, automation flags, logging
    options.add_argument("--disable-extensions")
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_argument("--remote-allow-origins=*")

    # Path to ChromeDriver (adjust if your path differs)
    service = Service("/usr/bin/chromedriver")

    # Create the driver
    driver = webdriver.Chrome(service=service, options=options)

    # Optional: implicit wait for CI stability
    driver.implicitly_wait(5)

    return driver
