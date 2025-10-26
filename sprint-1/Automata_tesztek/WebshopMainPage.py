from GeneralPage import GeneralPage
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import ElementClickInterceptedException
import time


class WebshopMainPage(GeneralPage):
    def __init__(self):
        self.URL = "http://localhost:4200"
        super().__init__(self.URL)

    def teardown_method(self):
        self.browser.quit()

    def wait_for_angular(self, timeout=20):
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

    def resize_window(self, width: int, height: int):
        self.browser.set_window_size(width, height)

    def price_of_instrument_by_order_number(self, number: int = -1):
        wait = WebDriverWait(self.browser, 20)
        prices = wait.until(EC.presence_of_all_elements_located((By.XPATH, '//mat-card-subtitle')))
        mp_prices_list = []
        if number == -1:
            for price in prices:
                mp_prices_list.append(price.text)
            return mp_prices_list
        else:
            return prices[number - 1].text

    def name_of_instrument(self, number: int = -1):
        wait = WebDriverWait(self.browser, 20)
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

    def price_by_name(self, name):
        wait = WebDriverWait(self.browser, 20)
        xpath_by_name = f'//mat-card-title[text()="{name}"]/ancestor::mat-card//mat-card-subtitle'
        text_price_by_name = wait.until(EC.element_to_be_clickable((By.XPATH, xpath_by_name))).text
        price_by_name =text_price_by_name[7:]
        return price_by_name

    def price_in_details(self, name):
        wait = WebDriverWait(self.browser, 20)
        xpath_by_name = f'//mat-card-title[text()="{name}"]/ancestor::mat-card//button[@id="button_details"]'
        button_details = wait.until(EC.element_to_be_clickable((By.XPATH, xpath_by_name)))
        button_details.click()
        text_price_in_details = wait.until(EC.visibility_of_element_located((By.XPATH, '//h2'))).text
        price_in_details = text_price_in_details[7:]
        return price_in_details

    # def name_price_dictionary(self):
    #     instrument_names = self.name_of_instrument()
    #     instrument_prices = self.price_of_instrument_by_order_number()
    #     return dict(zip(instrument_names, instrument_prices))

    def reglogin(self):
        wait = WebDriverWait(self.browser, 20)
        login = wait.until(EC.element_to_be_clickable((By.ID, 'regLogin')))
        try:
            login.click()
        except ElementClickInterceptedException:
            self.browser.execute_script("arguments[0].click();", login)

    def resp_reglogin(self):
        wait = WebDriverWait(self.browser, 20)
        button_burger = wait.until(
            EC.element_to_be_clickable((By.XPATH, '//mat-toolbar-row[@class="mat-toolbar-row"]/button')))
        button_burger.click()
        wait.until(EC.presence_of_element_located((By.XPATH, '//div[@class="sidenavbar_icons"]')))
        login = wait.until(
            EC.element_to_be_clickable((By.XPATH, '//div[@class="sidenavbar_icons"]//mat-icon[text()="person"]')))
        login.click()

    def logout(self):
        wait = WebDriverWait(self.browser, 20)
        button_logout = wait.until(EC.element_to_be_clickable((By.ID, 'button_logOut')))
        return button_logout

    def resp_logout(self):
        wait = WebDriverWait(self.browser, 20)
        button_burger = wait.until(
            EC.element_to_be_clickable((By.XPATH, '//mat-toolbar-row[@class="mat-toolbar-row"]/button')))
        button_burger.click()
        wait.until(EC.presence_of_element_located((By.XPATH, '//div[@class="sidenavbar_icons"]')))
        button_logout = wait.until(
            EC.element_to_be_clickable((By.XPATH, '//div[@class="sidenavbar_icons"]//mat-icon[text()="logout"]')))
        return button_logout

    def input_username(self):
        wait = WebDriverWait(self.browser, 20)
        username = wait.until(EC.element_to_be_clickable((By.ID, 'username_input')))
        return username

    def input_password(self):
        wait = WebDriverWait(self.browser, 20)
        password = wait.until(EC.element_to_be_clickable((By.ID, 'password_input')))
        return password

    def button_submit_login(self):
        wait = WebDriverWait(self.browser, 20)
        button_login = wait.until(EC.element_to_be_clickable((By.XPATH, '//button[@type="submit"]')))
        button_login.click()

    def err_message(self):
        wait = WebDriverWait(self.browser, 20)
        err_message = wait.until(EC.visibility_of_element_located((By.XPATH, '//mat-error')))
        return err_message

    def login_process(self, username, passowrd):
        self.reglogin()
        self.input_password().send_keys(passowrd)
        self.input_username().send_keys(username)

    def resp_login_process(self, username, passowrd):
        self.resp_reglogin()
        self.input_password().send_keys(passowrd)
        self.input_username().send_keys(username)

    def shopping_cart_number(self):
        wait = WebDriverWait(self.browser, 20)
        sc_number = wait.until(EC.visibility_of_element_located((By.XPATH, '//span[@id="mat-badge-content-0"]')))
        return sc_number.text

    def add_to_cart_by_name(self, name):
        wait = WebDriverWait(self.browser, 20)
        xpath_atc = f'//mat-card-title[text()="{name}"]/ancestor::mat-card//button[@id="button_addToCart"]'
        button_add_to_cart_by_name = wait.until(EC.element_to_be_clickable((By.XPATH, xpath_atc)))
        button_add_to_cart_by_name.click()

    def scart_counter(self, *names):
        counter = 0
        for name in names:
            self.add_to_cart_by_name(name)
            counter += 1
        return counter

    def new_product_page(self):
        wait = WebDriverWait(self.browser, 20)
        button_new_product = wait.until(EC.element_to_be_clickable((By.XPATH, '//a[@id="button_newProduct"]')))
        button_new_product.click()

    def input_product_name(self):
        wait = WebDriverWait(self.browser, 20)
        input_product_name = wait.until(EC.element_to_be_clickable((By.XPATH, '//input[@id="input_pName"]')))
        return input_product_name

    def select_categories_field(self):
        wait = WebDriverWait(self.browser, 20)
        select_categories = wait.until(EC.element_to_be_clickable((By.XPATH,
                                                                   '//mat-select[@id="input_Select"]')))
        return select_categories

    def select_from_select_categories(self, category):
        wait = WebDriverWait(self.browser, 20)
        select_single_category = wait.until(EC.element_to_be_clickable((By.XPATH,
                                                                        f'//span[text()={category}]')))
        select_single_category.click()

    def input_price(self):
        wait = WebDriverWait(self.browser, 20)
        input_price = wait.until(EC.element_to_be_clickable((By.XPATH, '//input[@id="input_pPrice"]')))
        return input_price

    def textarea_desc(self):
        wait = WebDriverWait(self.browser, 20)
        textarea_desc = wait.until(EC.element_to_be_clickable((By.XPATH, '//textarea[@id="input_pDesc"]')))
        return textarea_desc

    def button_saveproduct(self):
        wait = WebDriverWait(self.browser, 20)
        button_saveproduct = wait.until(EC.element_to_be_clickable((By.XPATH, '//button[@id="button_saveProduct"]')))
        return button_saveproduct

    def return_to_main_page(self):
        wait = WebDriverWait(self.browser, 20)
        img_progmusicx = wait.until(EC.element_to_be_clickable((By.XPATH, '//img[@id="logo-side"]')))
        img_progmusicx.click()

    def add_instrument(self, product_name, price, description, category: str):
        from selenium.webdriver.common.keys import Keys
        self.login_process('admin', 'admin')
        self.button_submit_login()
        self.new_product_page()
        self.input_product_name().send_keys(product_name)
        self.input_price().send_keys(price)
        self.textarea_desc().send_keys(description)
        self.select_categories_field().click()
        self.select_from_select_categories(category)
        self.select_categories_field().send_keys(Keys.ESCAPE)
        self.button_saveproduct().click()
        self.return_to_main_page()

    def delete_instrument(self, name):
        wait = WebDriverWait(self.browser, 20)
        xpath_by_name = f'//mat-card-title[text()="{name}"]/ancestor::mat-card//button[@id="button_delete"]'
        button_delete_by_name = wait.until(EC.element_to_be_clickable((By.XPATH, xpath_by_name)))
        button_delete_by_name.click()
        button_yes_im_sure = wait.until(EC.element_to_be_clickable((By.XPATH, '//button/span[text()="Yes"]')))
        button_yes_im_sure.click()
        wait.until(EC.invisibility_of_element_located((By.XPATH, f'//mat-card-title[text()="{name}"]')))