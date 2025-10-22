from GeneralPage import GeneralPage
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import ElementClickInterceptedException
import time

class WebshopMainPage(GeneralPage):
    def __init__(self):
        self.URL = "http://localhost:4600"
        super().__init__(self.URL)

    def teardown_method(self):
        self.browser.quit()

    def wait_for_angular(self, timeout=60):
        print("⏳ Waiting for Angular to render...")
        end_time = time.time() + timeout
        while time.time() < end_time:
            try:
                ready = self.browser.execute_script(
                    "return (window.getAllAngularTestabilities && "
                    "window.getAllAngularTestabilities().every(x => x.isStable()))"
                )
                if ready:
                    print("✅ Angular app is stable.")
                    return
            except Exception:
                pass
            time.sleep(1)
        raise TimeoutException("❌ Angular never became stable")

    def price_of_instrument_by_order_number(self, number: int = -1):
        wait = WebDriverWait(self.browser, 60)
        prices = wait.until(EC.presence_of_all_elements_located((By.XPATH, '//mat-card-subtitle')))
        mp_prices_list = []
        if number == -1:
            for price in prices:
                mp_prices_list.append(price.text)
            return mp_prices_list
        else:
            return prices[number - 1].text

    def name_of_instrument(self, number: int = -1):
        wait = WebDriverWait(self.browser, 60)
        names = wait.until(EC.presence_of_all_elements_located(
            (By.XPATH, '//mat-card-title[@class="mat-tooltip-trigger mat-card-title"]')))
        mp_names_list = []
        if number == -1:
            for name in names:
                mp_names_list.append(name.text)
            return mp_names_list
        else:
            return names[number - 1].text

    def number_of_available_instruments(self):
        return self.price_of_instrument_by_order_number()

    def name_price_dictionary(self):
        instrument_names = self.name_of_instrument()
        instrument_prices = self.price_of_instrument_by_order_number()
        return dict(zip(instrument_names, instrument_prices))

    def reglogin(self):
        wait = WebDriverWait(self.browser, 60)
        try:
            button_burger = wait.until(
                EC.element_to_be_clickable((By.XPATH, '//mat-toolbar-row[@class="mat-toolbar-row"]/button')))
            button_burger.click()
            wait.until(EC.presence_of_element_located((By.XPATH, '//div[@class="sidenavbar_icons"]')))
            login = wait.until(
                EC.element_to_be_clickable((By.XPATH, '//div[@class="sidenavbar_icons"]//mat-icon[text()="person"]')))
            login.click()
        except Exception:
            login = wait.until(EC.element_to_be_clickable((By.ID, 'regLogin')))
            try:
                login.click()
            except ElementClickInterceptedException:
                self.browser.execute_script("arguments[0].click();", login)

    def logout(self):
        wait = WebDriverWait(self.browser, 60)
        button_logout = wait.until(EC.element_to_be_clickable((By.ID, 'button_logOut')))
        return button_logout

    def input_username(self):
        wait = WebDriverWait(self.browser, 60)
        username = wait.until(EC.element_to_be_clickable((By.ID, 'username_input')))
        return username

    def input_password(self):
        wait = WebDriverWait(self.browser, 60)
        password = wait.until(EC.element_to_be_clickable((By.ID, 'password_input')))
        return password

    def button_login(self):
        wait = WebDriverWait(self.browser, 60)
        button_login = wait.until(EC.element_to_be_clickable((By.XPATH, '//button[@type="submit"]')))
        button_login.click()

    def login_process(self, username, passowrd):
        self.reglogin()
        self.input_password().send_keys(passowrd)
        self.input_username().send_keys(username)
