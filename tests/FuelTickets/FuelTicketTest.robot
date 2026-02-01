*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser To Application
Suite Teardown    Close Browser

*** Variables ***
${URL}       https://stage.steadyoil.com/
${BROWSER}   chrome
${USERNAME}  admin@steadyoil.com
${PASSWORD}  Pwd4so!l

*** Test Cases ***

Create Ticket When Gallons Is Empty
    [Tags]    negative
    Login To Application
    Navigate To Fuel Ticket Page
    Fill Ticket Details Without Gallons
    Validate Gallons Error Appears
    Click Submit Button


Create Ticket With Valid Details
    [Tags]    positive
    Login To Application
    Navigate To Fuel Ticket Page
    Fill Ticket Details With Valid Gallons
    Click Submit Button
    Validate Ticket Created Successfully
    



*** Keywords ***

Open Browser To Application
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    5s

Login To Application
    Input Text    name:identity    ${USERNAME}
    Input Text    name:password    ${PASSWORD}
    Click Button    xpath:/html/body/div/div/div/form/div[4]/button
    Wait Until Page Contains    Dashboard    timeout=10s

Navigate To Fuel Ticket Page
    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
    Wait Until Page Contains    Create Manual Fuel Ticket     5s
    Log To Console    Navigated to Create Manual Fuel Ticket Page

Fill Ticket Details With Valid Gallons
    Click Element    xpath://span[@id='select2-searchcompany-container']
    Input Text    xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
    Click Element    xpath=//li[contains(text(), 'Lund Brady')]
    Input Text    name:Site_name     North
    Input Text    id:purchase_order     1234
    Input Text    id:caller_info    8545633
    Input Text    name:ticket_notes      100 gallons
    Select From List By Value   xpath://select[@id="fuel_types"]    8
    Input Text    id:tankssize     100
    Input Text    id:fees_admin_manual     10
    Input Text    id:retail_cost_gallon     2
    Select From List By Value    id:discount     0
    Scroll Element Into View    id:Reset_ticket
    Click Element    xpath://span[@id='select2-fuel_class_terminal-container']
    Input Text    xpath=//input[contains(@class,'select2-search__field')]    Watford City Bulk Plant
    Click Element    xpath=//li[contains(text(),'Watford City Bulk Plant')]
    Click Button    xpath://input[@id="add_list"]
    Sleep    2s

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

Validate Ticket Created Successfully
    Wait Until Page Contains    Ticket created successfully    timeout=10s
    Log    Ticket creation succeeded
