*** Settings ***
Library         SeleniumLibrary
*** Variables  ***
${browser}       Chrome
${url}       https://stage.steadyoil.com/
Library    SeleniumLibrary    

*** Test Cases ***
Fail If Gallons Field Is Empty
    [Documentation]    Leave gallons empty and verify that the test fails with validation error.
    [Tags]    negative    fail test

    Open Browser    ${url}    ${browser}
    Login To Application
    Maximize Browser Window
    Wait Until Page Contains    Dashboard    5s

    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a

    Click Element    xpath://span[@id='select2-searchcompany-container']
    Input Text       xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
    Click Element    xpath=//li[contains(text(), 'Lund Brady')]
    Sleep    1s

    Input Text       name:Site_name     North
    Input Text       id:purchase_order     1234
    Input Text       id:caller_info    8545633
    Input Text       name:ticket_notes    100 gallons

    Scroll Element Into View    id:fuel_class_name
    Select From List By Value   xpath://select[@id="fuel_types"]    8

# keep the gallons as empty
    # Input Text     id:tankssize     100

    Input Text     id:fees_admin_manual     10
    Input Text     id:retail_cost_gallon     2
    Select From List By Value    id:discount     0

    Scroll Element Into View    id:Reset_ticket
    Click Element    xpath://span[@id='select2-fuel_class_terminal-container']
    Input Text       xpath=//input[contains(@class,'select2-search__field')]    Watford City Bulk Plant
    Click Element    xpath=//li[contains(text(),'Watford City Bulk Plant')]

#Click add button
    Click Button    xpath://input[@id="add_list"]
    Sleep    3s

# Validation for the gallons error message
    ${error_found}=    Run Keyword And Return Status    Element Text Should Be    id=err_tanks_ize    Gallons is required

# Log the error message
    Run Keyword If    ${error_found}    Log    Validation appeared: Gallons is required

# Fail the test if validation error is exist
    Run Keyword If    ${error_found}    Fail    Cannot submit ticket! Gallons is required
   #    submit button
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Click Button    xpath://input[@id="submitmanualfuelBtn"]


    [Teardown]    Close Browser


*** Keywords ***
Login to Application
     Input Text     name:identity    admin@steadyoil.com
     Input Text     name:password      Pwd4so!l
     Click Button     xpath:/html/body/div/div/div/form/div[4]/button