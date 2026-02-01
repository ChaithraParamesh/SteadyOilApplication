*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${url}    https://stage.steadyoil.com/
${browser}    chrome

*** Test Cases ***
Normal Oil Reservation Ticket
    Open Browser        ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Speed        3s
    Login To Application
    Wait Until Page Contains    Dashboard    3s

    Mouse Over     xpath://nav[@id="main-sidebar"]//ul//li[6]//a//i//span
    Click Element    xpath://ul[@class="sidebar-menu"]//li[6]//li[9]//a
    Click Element    xpath://span[@id="select2-oil_customer_name-container"]
    Input Text    xpath://input[@class="select2-search__field"]    Lund Brady
    Click Element    xpath://ul[@class="select2-results__options"]//li[contains(text(), "Lund Brady")]
    Input Text    name:rig_name    N
    Click Element    id:NABORS X28
    Select From List By Value    id:tank_name_data    2551
    Input Text     name:purchase_order    554785
    Input Text    name:caller_info    441526
    Input Text    name:site_name    Watford City
    Input Text     name:fees_admin_oil    40
    Input Text    id:oil_ticket_notes    metered products
    Scroll Element Into View    id:oil_reset
    Click Element    xpath://input[@class=" button button--success add_oil_prod_button"]
#    Pagination
    Click Button    xpath://div[@id="pagination_product_list_buttons"]//button[3]
    Click Button    xpath://tbody[@id="product_table_list_body"]//tr[3]//button
    Click Button    //button[@class="btn btn-success save_added_pro_in_sess mx-2"]
    Scroll Element Into View    id:oil_reset
    Click Button    id:oil_save
    


*** Keywords ***
Login To Application
    Input Text        name:identity    admin@steadyoil.com
    Input Text        name:password    Pwd4so!l
    Click Button    xpath://button[@class="login100-form-btn"]