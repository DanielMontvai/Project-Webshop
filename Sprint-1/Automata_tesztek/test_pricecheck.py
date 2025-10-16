from WebshopPage import WebshopPage
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

class TestWebShop:
    def setup_method(self):
        self.page = WebshopPage()
        self.page.get()

    def teardown_method(self):
        self.page.quit()

    def test_pricecheck(self):
        assert self.page.price_of_instrument_by_order_number(1) == "Price: $90000"