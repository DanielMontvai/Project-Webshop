# from GeneralPage import GeneralPage
# from selenium.webdriver.support.wait import WebDriverWait
# from selenium.webdriver.support import expected_conditions as EC
# from selenium.webdriver.common.by import By
#
# class WebshopMainPage(GeneralPage):
#     def __init__(self):
#         self.URL = "http://localhost:4200"
#         super().__init__(self.URL)
#
#     def teardown_method(self):
#         self.browser.quit()
#
#     def price_of_instrument_by_order_number(self, number: int = -1):
#         wait = WebDriverWait(self.browser, 20)
#         prices = wait.until(EC.presence_of_all_elements_located((By.XPATH, '//mat-card-subtitle')))
#         mp_prices_list = []
#         if number == -1:
#             for price in prices:
#                 mp_prices_list.append(price.text)
#             return mp_prices_list
#         else:
#             return prices[number-1].text
#
#
#     def name_of_instrument(self, number: int = -1):
#         wait = WebDriverWait(self.browser, 20)
#         names = wait.until(EC.presence_of_all_elements_located(
#             (By.XPATH, '//mat-card-title[@class="mat-tooltip-trigger mat-card-title"]')))
#         mp_names_list = []
#         if number == -1:
#             for name in names:
#                 mp_names_list.append(name.text)
#             return mp_names_list
#         else:
#             return names[number-1].text
#
#     def number_of_available_insturments(self):
#         return self.price_of_instrument_by_order_number()
#
#     def name_price_dictionary(self):
#         instrument_names = self.name_of_instrument()
#         instrument_prices = self.price_of_instrument_by_order_number()
#         return dict(zip(instrument_names, instrument_prices))
#
#     # def reglogin(self):
#     #     wait = WebDriverWait(self.browser, 20)
#     #     wait.until(EC.visibility_of_element_located((By.ID, 'regLogin')))
#     #     login = wait.until(EC.element_to_be_clickable((By.ID, 'regLogin')))
#     #     login.click()
#
#     def reglogin(self):
#         wait = WebDriverWait(self.browser, 30)
#
#         # click login button
#         login_button = wait.until(EC.element_to_be_clickable((By.ID, 'regLogin')))
#         login_button.click()
#
#         # ✅ wait for Material overlay to load
#         wait.until(
#             EC.presence_of_element_located((By.CSS_SELECTOR, '.cdk-overlay-pane'))
#         )
#
#     def logout(self):
#         wait = WebDriverWait(self.browser, 20)
#         wait.until(EC.visibility_of_element_located((By.ID, 'button_logOut')))
#         button_logout = wait.until(EC.element_to_be_clickable((By.ID, 'button_logOut')))
#         return button_logout
#
#     def input_username(self):
#         wait = WebDriverWait(self.browser, 20)
#         wait.until(EC.visibility_of_element_located((By.ID, 'username_input')))
#         username = wait.until(EC.element_to_be_clickable((By.ID, 'username_input')))
#         return username
#
#     def input_password(self):
#         wait = WebDriverWait(self.browser, 20)
#         wait.until(EC.visibility_of_element_located((By.ID, 'password_input')))
#         password = wait.until(EC.element_to_be_clickable((By.ID, 'password_input')))
#         return password
#
#     def button_login(self):
#         wait = WebDriverWait(self.browser, 20)
#         wait.until(EC.visibility_of_element_located((By.XPATH, '//button[@type="submit"]')))
#         button_login = wait.until(EC.element_to_be_clickable((By.XPATH, '//button[@type="submit"]')))
#
#         button_login.click()
#
#     # def login_process(self, username, passowrd):
#     #     self.reglogin()
#     #     self.input_username().send_keys(username)
#     #     self.input_password().send_keys(passowrd)
#
#     def login_process(self, username, password):
#         self.reglogin()
#
#         wait = WebDriverWait(self.browser, 30)
#
#         # now inside overlay!
#         user = wait.until(EC.element_to_be_clickable((By.ID, 'username_input')))
#         pwd = wait.until(EC.element_to_be_clickable((By.ID, 'password_input')))
#
#         user.send_keys(username)
#         pwd.send_keys(password)

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

    # ------------------ Prices & Names ------------------
    def price_of_instrument_by_order_number(self, number: int = -1):
        wait = WebDriverWait(self.browser, 20)
        prices = wait.until(EC.presence_of_all_elements_located((By.XPATH, '//mat-card-subtitle')))
        mp_prices_list = [price.text for price in prices]
        if number == -1:
            return mp_prices_list
        else:
            return mp_prices_list[number-1]

    def name_of_instrument(self, number: int = -1):
        wait = WebDriverWait(self.browser, 20)
        names = wait.until(EC.presence_of_all_elements_located(
            (By.XPATH, '//mat-card-title[@class="mat-tooltip-trigger mat-card-title"]')))
        mp_names_list = [name.text for name in names]
        if number == -1:
            return mp_names_list
        else:
            return mp_names_list[number-1]

    def number_of_available_insturments(self):
        return self.price_of_instrument_by_order_number()

    def name_price_dictionary(self):
        return dict(zip(self.name_of_instrument(), self.price_of_instrument_by_order_number()))

    # ------------------ Login/Logout ------------------
    def reglogin(self):
        wait = WebDriverWait(self.browser, 30)

        # wait for Angular root & navbar
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, 'app-root')))
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '.navbar_icons')))

        # click login button
        login_button = wait.until(EC.element_to_be_clickable((By.ID, 'regLogin')))
        login_button.click()

        # wait for Material overlay
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '.cdk-overlay-pane')))

    def logout(self):
        wait = WebDriverWait(self.browser, 20)
        wait.until(EC.visibility_of_element_located((By.ID, 'button_logOut')))
        button_logout = wait.until(EC.element_to_be_clickable((By.ID, 'button_logOut')))
        return button_logout

    def login_process(self, username, password):
        wait = WebDriverWait(self.browser, 30)

        self.reglogin()

        # inside overlay, wait for username/password fields
        user = wait.until(EC.element_to_be_clickable((By.ID, 'username_input')))
        pwd  = wait.until(EC.element_to_be_clickable((By.ID, 'password_input')))

        user.send_keys(username)
        pwd.send_keys(password)

        # click login button
        login_button = wait.until(
            EC.element_to_be_clickable((By.XPATH, '//button[@type="submit"]'))
        )
        login_button.click()

        # confirm login success
        wait.until(EC.presence_of_element_located((By.ID, 'button_logOut')))
