from GeneralPage import GeneralPage
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

class WebshopPage(GeneralPage):
    def __init__(self):
        self.URL = "http://localhost:4200"
        super().__init__(self.URL)

    def teardown_method(self):
        self.browser.quit()

    def price_of_instrument_by_order_number(self, number: int):
        wait = WebDriverWait(self.browser, 5)
        prices = wait.until(EC.presence_of_all_elements_located((By.XPATH, '//mat-card-subtitle')))
        return prices[number-1].text