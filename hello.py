from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--disable-gpu")
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--window-size=1920,1080")
chrome_options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")

# Optional chrome arguments that may be useful depending on your use-case
# chrome_options.add_experimental_option("prefs", {"profile.managed_default_content_settings.images": 2})
# chrome_options.add_argument("--disable-extensions")
# chrome_options.add_argument("--ignore-certificate-errors")
# chrome_options.add_argument("--incognito")
# chrome_options.add_argument("--disable-blink-features=AutomationControlled")


service = Service()
driver = webdriver.Chrome(service=service, options=chrome_options)

driver.get("https://google.com")

print(driver.title)

with open("./output/world.txt", "w") as file:
    file.write("Page title is: " + driver.title)

driver.quit()