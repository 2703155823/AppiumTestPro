
# python Android
from appium import webdriver

desired_caps = {
    'platformName': 'Android',
    'platformVersion': '8.1',
    'deviceName': '0140022170000107',
    'automationName': 'UiAutomator2',
}


if __name__ == "__main__":
    driver = webdriver.Remote('http://192.168.49.89:4723/wd/hub', desired_caps)
    driver.quit()
