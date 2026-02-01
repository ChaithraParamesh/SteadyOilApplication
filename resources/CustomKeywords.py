from selenium.webdriver import ActionChains
from robot.api.deco import keyword
from SeleniumLibrary import SeleniumLibrary

@keyword
def drag_and_drop_ticket(ticket_xpath, truck_xpath):
    """
    Drag a ticket to a truck using the currently active Selenium browser session.
    """
    selib = SeleniumLibrary()  # get active session
    driver = selib.driver      # current active browser

    # Wait until elements are visible (optional but recommended)
    selib.wait_until_element_is_visible(ticket_xpath, timeout=10)
    selib.wait_until_element_is_visible(truck_xpath, timeout=10)

    ticket = driver.find_element("xpath", ticket_xpath)
    truck = driver.find_element("xpath", truck_xpath)

    actions = ActionChains(driver)
    actions.click_and_hold(ticket).move_to_element(truck).release().perform()
