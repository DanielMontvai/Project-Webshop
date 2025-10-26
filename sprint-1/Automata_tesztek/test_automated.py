from WebshopMainPage import WebshopMainPage
import allure

class TestWebShop:
    def setup_method(self):
        self.page = WebshopMainPage()
        print(self.page.get())
        self.page.wait_for_angular(timeout=120)

    def teardown_method(self):
        self.page.quit()

    @allure.title('san1')
    def test_pricecheck(self):
        assert self.page.price_of_instrument_by_order_number(1) == "Price: $90000"

    @allure.title('san2')
    def test_name(self):
        assert self.page.name_of_instrument(1) == "Viola made of birch"

    @allure.title('san3')
    def test_number_available_instruments(self):
        assert len(self.page.number_of_available_instruments()) == 22

    @allure.title('Login')
    def test_login(self):
        self.page.login_process('forlogin', 'Forlogin@1')
        self.page.button_login()
        # assert self.page.err_message().is_displayed()
        self.page.logout()
        assert self.page.logout().is_displayed()

    @allure.title('Shopping Cart Counter')
    def test_shopping_cart(self):
        counter = self.page.scart_counter('Viola made of birch', 'Fine Double Bass', 'Renewed oboe', 'Black Basson')
        assert str(counter) == self.page.shopping_cart_number()

    @allure.title('Add New Instrument')
    def test_add_new_instrument(self):
        assert len(self.page.number_of_available_instruments()) == 22
        self.page.add_instrument('Jazz Guitar', 10000, 'Beautiful jazz guitar from the 1800s',
                                 '"GUITAR FAMILY"')
        assert len(self.page.number_of_available_instruments()) == 23
