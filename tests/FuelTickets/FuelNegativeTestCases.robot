*** Settings ***
Library    SeleniumLibrary
Resource    Login_LogoutKeywords.robot
Resource    FuelResources.robot

*** Test Cases ***
TC1 Create Ticket when customer is not selected
    [Documentation]    Verify that ticket cannot be created without selecting a customer
    [Tags]    negative    validation
    Launch Application
    Login To Application
    Navigate To Create Fuel Ticket Page
    Fill other Fields
    Click Add Button
    Validate Company Name Required Error and Fail
#    Click Submit Button

TC2 Create Ticket without FuelType
    [Documentation]    Verify that ticket cannot be created without selecting fuel type
    [Tags]    Negative    FuelTicket
    Launch Application
    Login To Application
    Navigate To Create Fuel Ticket Page
    Select Customer
    Fill Fields Except Fuel Type
    Click Add Button
    Validate Fuel Type Required Error And Fail

TC3 Create Ticket without TankGPS
    [Documentation]    Verify that ticket cannot be created without entering Tank GPS
    [Tags]    Negative    FuelTicket
    Launch Application
    Login To Application
    Navigate To Create Fuel Ticket Page
    Select Customer
    Fill Fields Except Tank GPS
    Click Add Button
    Validate Ticket GPS Required Error And Fail

TC4 Create Ticket When Gallons Is Empty
    [Tags]    negative
    Login To Application
    Navigate To Fuel Ticket Page
    Fill Ticket Details Without Gallons
    Validate Gallons Error Appears
    Click Submit Button


    
    
    
*** Keywords ***
Fill Ticket Details Without Gallons
    Click Element    xpath://span[@id='select2-searchcompany-container']
    Input Text    xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
    Click Element    xpath=//li[contains(text(), 'Lund Brady')]
    Input Text    name:Site_name     North
    Input Text    id:purchase_order     1234
    Input Text    id:caller_info    8545633
    Input Text    name:ticket_notes       100 gallons
    Select From List By Value   xpath://select[@id="fuel_types"]    8
    Input Text    id:fees_admin_manual     10
    Input Text    id:retail_cost_gallon     2
    Select From List By Value    id:discount     0
    Scroll Element Into View    id:Reset_ticket
    Click Element    xpath://span[@id='select2-fuel_class_terminal-container']
    Input Text    xpath=//input[contains(@class,'select2-search__field')]    Watford City Bulk Plant
    Click Element    xpath=//li[contains(text(),'Watford City Bulk Plant')]
    Click Button    xpath://input[@id="add_list"]
    Sleep    5s

Click Submit Button
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Click Button    xpath://input[@id="submitmanualfuelBtn"]
    Sleep    3s

Validate Gallons Error Appears
    ${error_found}=    Run Keyword And Return Status    Element Text Should Be    id=err_tanks_ize    Gallons is required
    Run Keyword Unless    ${error_found}    Fail    Gallons validation error NOT shown — Test failed!
    Log    Validation message appeared as expected: Gallons is required

Navigate To Fuel Ticket Page
    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
    Wait Until Page Contains    Create Manual Fuel Ticket     5s
    Log To Console    Navigated to Create Manual Fuel Ticket Page