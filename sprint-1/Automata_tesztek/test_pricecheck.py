# from WebshopMainPage import WebshopMainPage
# from selenium.webdriver.support.wait import WebDriverWait
# from selenium.webdriver.support import expected_conditions as EC
# from selenium.webdriver.common.by import By
#
# class TestWebShop:
#     def setup_method(self):
#         self.page = WebshopMainPage()
#         self.page.get()
#
#     def teardown_method(self):
#         self.page.quit()
#
#     def test_pricecheck(self):
#         assert self.page.price_of_instrument_by_order_number(1) == "Price: $90000"
#
#     def test_name(self):
#         assert self.page.name_of_instrument(1) == "Viola made of birch"
#
#     def test_number_available_instruments(self):
#         assert len(self.page.number_of_available_insturments()) == 22
#
#     def test_login(self):
#         self.page.login_process('forlogin', 'Forlogin@1')
#         self.page.button_login()
#         self.page.logout()
#         assert self.page.logout().is_displayed()

import pytest
from WebshopMainPage import WebshopMainPage

class TestWebShop:

    @pytest.fixture(scope="class", autouse=True)
    def setup_class(self):
        # Initialize page object
        self.page = WebshopMainPage()
        self.page.get()  # open main page
        yield
        # Teardown
        self.page.quit()

    def test_login(self):
        """Test that a user can login successfully"""
        username = "forlogin"
        password = "Forlogin@1"

        # Use your page methods
        self.page.login_process(username, password)

        # Wait for logout button to appear as indication of successful login
        logout_btn = self.page.logout()
        assert logout_btn.is_displayed(), "Logout button should be visible after login"