*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}    https://stage.steadyoil.com/
${browser}    chrome

*** Test Cases ***
Normal Reservation Ticket
    Open Browser        ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Speed        3s
    Login To Application
    Wait Until Page Contains    Dashboard    3s

    Mouse Over     xpath://nav[@id="main-sidebar"]//ul//li[6]//a//i//span
    Click Element    xpath://ul[@class="sidebar-menu"]//li[6]//li[8]//a
    Click Element    xpath://span[@id="select2-wells_client_name-container"]
    Input Text    xpath://input[@class="select2-search__field"]    Lund Brady
    Click Element    xpath://ul[@class="select2-results__options"]//li[contains(text(), "Lund Brady")]
    Input Text    name:search_text    31
    Click Element    id:31 OPERATING, LLC
    Input Text    name:wells_name    s
    Click Element    id:14498
    Input Text    name:site_name    WatfordCity
    Input Text    name:purchase_order    July07
    Input Text    id:caller_info    Roman5563
    Input Text    id:wells_ticket_notes    50 gallons
    Scroll Element Into View    id:well_add_list
    
    Select From List By Value       id:fuel_types    9
    Input Text    name:gallons    50
    Input Text    id:retail_cost_gallon_wells    2.4125
    Select From List By Value    id:discount     2    
    Input Text    name:fees_wells    20

#tax
    Click Button    xapth://*[@id="frm"]/div/div[1]/div/div[33]/div/div/div/label[2]/div/div[1]
    Click Element    id:select2-fuel_class_terminal_wells-container
    Click Element    //ul[@class="select2-results__options"]//li[2]//li[2]
    Scroll Element Into View    class:box-body
    Click Button    id:well_add_list
    Sleep     3s
    Click Button     id:wells_ticket_submit




*** Keywords ***
Login To Application
    Input Text        name:identity    admin@steadyoil.com  
    Input Text        name:password    Pwd4so!l
    Click Button    xpath://button[@class="login100-form-btn"]


