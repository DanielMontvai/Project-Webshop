from WebshopMainPage import WebshopMainPage


class TestWebShop:
    def setup_method(self):
        self.page = WebshopMainPage()
        self.page.get()
        self.page.wait_for_angular()

    def teardown_method(self):
        self.page.quit()

    def test_pricecheck(self):
        assert self.page.price_of_instrument_by_order_number(1) == "Price: $90000"

    def test_name(self):
        assert self.page.name_of_instrument(1) == "Viola made of birch"

    def test_number_available_instruments(self):
        assert len(self.page.number_of_available_instruments()) == 22

    def test_login(self):
        self.page.login_process('forlogin', 'Forlogin@1')
        self.page.button_login()
        self.page.logout()
        assert self.page.logout().is_displayed()
