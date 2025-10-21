from selenium.webdriver.chrome.webdriver import WebDriver


class GeneralPage:
    def __init__(self, url, browser: WebDriver = None):
        self.URL = url
        if browser:
            self.browser = browser
        else:
            from generate_driver import get_preconfigured_chrome_driver
            self.browser = get_preconfigured_chrome_driver()

    def get(self):
        self.browser.get(self.URL)

    def get_current_url(self):
        return self.browser.current_url

    def close(self):
        self.browser.close()

    def quit(self):
        self.browser.quit()
