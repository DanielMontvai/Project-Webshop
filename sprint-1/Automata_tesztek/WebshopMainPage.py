from GeneralPage import GeneralPage
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

class WebshopMainPage(GeneralPage):
    def __init__(self):
        self.URL = "http://localhost:4200"
        super().__init__(self.URL)

    def teardown_method(self):
        self.browser.quit()

    def price_of_instrument_by_order_number(self, number: int = -1):
        wait = WebDriverWait(self.browser, 5)
        prices = wait.until(EC.presence_of_all_elements_located((By.XPATH, '//mat-card-subtitle')))
        mp_prices_list = []
        if number == -1:
            for price in prices:
                mp_prices_list.append(price.text)
            return mp_prices_list
        else:
            return prices[number-1].text


    def name_of_instrument(self, number: int = -1):
        wait = WebDriverWait(self.browser, 5)
        names = wait.until(EC.presence_of_all_elements_located(
            (By.XPATH, '//mat-card-title[@class="mat-tooltip-trigger mat-card-title"]')))
        mp_names_list = []
        if number == -1:
            for name in names:
                mp_names_list.append(name.text)
            return mp_names_list
        else:
            return names[number-1].text

    def number_of_available_insturments(self):
        return self.price_of_instrument_by_order_number()

    def name_price_dictionary(self):
        instrument_names = self.name_of_instrument()
        instrument_prices = self.price_of_instrument_by_order_number()
        return dict(zip(names, prices))