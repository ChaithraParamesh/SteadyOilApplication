*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Navigate To Create Fuel Ticket Page
    [Documentation]    Navigate to the Create Manual Fuel Ticket page from sidebar
    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Wait Until Element Is Visible    xpath=//nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a    5s
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
    Wait Until Page Contains    Create Manual Fuel Ticket     10s
    Log To Console    Navigated to Create Manual Fuel Ticket Page

Select Customer
    Click Element    xpath://span[@id='select2-searchcompany-container']
    Input Text       xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
    Click Element    xpath=//li[contains(text(), 'Lund Brady')]
    Sleep    1s

Fill other fields
    [Documentation]    Fill all mandatory fields except Customer (for negative testing)
    Input Text       name:Site_name     North
    Input Text       id:purchase_order     1234
    Input Text       id:caller_info    8545633
    Input Text       name:ticket_notes    100 gallons
    Select From List By Value    id:fuel_types    2
    Input Text    id:tankssize    150
    Input Text     id:fees_admin_manual     10
    Input Text     id:retail_cost_gallon     2
    Select From List By Value    id:discount     0

    Scroll Element Into View    id:Reset_ticket
    Click Element    xpath://span[@id='select2-fuel_class_terminal-container']
    Wait Until Element Is Visible    xpath=//input[contains(@class,'select2-search__field')]    5s
    Input Text       xpath=//input[contains(@class,'select2-search__field')]    Watford City Bulk Plant
    Wait Until Element Is Visible    xpath=//li[contains(text(),'Watford City Bulk Plant')]    5s
    Click Element    xpath=//li[contains(text(),'Watford City Bulk Plant')]
    Log To Console     Filled all other fields except Customer

Click Add button
    Click Button    xpath://input[@id="add_list"]
    Sleep    3s


##### Company Name Validation #####
Validate Company Name Required Error and Fail
    [Documentation]    Validates that the error message is shown and immediately fails the test for negative scenario.
    ${error_locator}=    Set Variable    xpath=//div[@class="err_companyname_add"]

    ${error_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${error_locator}    5s
    IF    not ${error_visible}
        Fail    Company Name Required error did NOT appear! Test Failed.
    END

    ${error_text}=    Get Text    ${error_locator}
    Should Be Equal    ${error_text}    Company name is required
    Log To Console     Validation successful - Company name missing error: ${error_text}

    # Explicitly fail the test to mark negative scenario as failed
    Fail    Negative Test: Cannot create ticket without selecting a customer.


Validate Company Name Selection
    [Documentation]    Selects a Company Name and ensures no validation error is shown.
    [Arguments]
    ...    ${company_name}
    ...    ${dropdown_locator}=xpath=//span[@id="select2-searchcompany-container"}
    ...    ${search_input_locator}=xpath=//input[@class="select2-search__field"}
    ...    ${error_locator}=xpath=//div[@class="err_companyname_add"}
    ...    ${add_button}=id=add_button

    Wait Until Element Is Visible    ${dropdown_locator}    10s
    Click Element    ${dropdown_locator}
    Wait Until Element Is Visible    ${search_input_locator}    5s
    Input Text    ${search_input_locator}    ${company_name}
    Press Keys    ${search_input_locator}    ENTER
    Click Button    ${add_button}
    Sleep    1s
    Run Keyword And Expect Error    *    Get Text    ${error_locator}
    Log To Console    Company name selected successfully: ${company_name}
    Log    Company name selection validated

######  Tank GPS Validation Keywords #####
Validate Tank GPS Required Error
    [Documentation]    Ensures GPS field validation error is shown when no GPS is auto-filled.
    [Arguments]    ${gps_locator}=id=ticket_gps_manuel    ${error_locator}=id=err_ticket_gps_manuel    ${add_button}=id=add_button
    Wait Until Element Is Visible    ${gps_locator}    10s
    ${gps_value}=    Get Value    ${gps_locator}
    Run Keyword If    '${gps_value}' != ''    Fail    Expected empty GPS but got value: ${gps_value}
#    Clear Element Text    ${gps_locator}
    Click Button    ${add_button}
    Wait Until Element Is Visible    ${error_locator}    5s
    ${error}=    Get Text    ${error_locator}
    Should Be Equal    ${error}    Ticket gps is required
    Log To Console    Validation successful - GPS missing, error shown: ${error}
    Log    Tank GPS required error validated


Validate Tank GPS Auto Filled
    [Documentation]    Ensures GPS is auto-filled when tank/customer has GPS location.
    [Arguments]    ${gps_locator}=id=ticket_gps_manuel    ${add_button}=id=add_button
    Wait Until Element Is Visible    ${gps_locator}    10s
#    Clear Element Text    ${gps_locator}
     ${gps_value}=    Get Value    ${gps_locator}
#    Input Text    ${gps_locator}    ${gps_value}
#    Click Button    ${add_button}
#    Wait Until Element Is Not Visible    ${error_locator}    5s
    Run Keyword If    '${gps_value}' == ''    Fail    Expected auto-filled GPS, but field is empty.
    Log To Console    Auto-filled GPS detected: ${gps_value}
    Log    Tank GPS auto-filled successfully with value: ${gps_value}


#Tank GPS Positive Test
#    Input Text    id=ticket_gps_manuel    47.733763, -103.294387
#    Validate Tank GPS Field - Positive
#
#Tank GPS Negative Test
#    Clear Element Text    id=ticket_gps_manuel
#    Validate Tank GPS Field - Negative
#
#GPS Field Validation - Negative
#    Validate Tank GPS Required Error
#
#GPS Field Validation - Positive
#    ${gps}=    Set Variable    47.733763, -103.294387
#    Validate Tank GPS With Value    ${gps}

#GPS Validation - No Tank (Negative)
#    [Tags]    negative
#    # Select a customer without tank here
#    Validate Tank GPS Required Error
#
#GPS Validation - With Tank (Positive)
#    [Tags]    positive
#    # Select a customer with tank here
#    Validate Tank GPS Auto Filled

Validate Gallons Required Error
    [Documentation]    Ensures error is shown when Gallons field is empty.
    [Arguments]    ${gallons_locator}=id=tankssize    ${error_locator}=id=err_tanks_ize    ${add_button}=id=add_button
    Wait Until Element Is Visible    ${gallons_locator}    10s
    Clear Element Text    ${gallons_locator}
    Click Button    ${add_button}
    Wait Until Element Is Visible    ${error_locator}    5s
    ${error_text}=    Get Text    ${error_locator}
    Should Be Equal    ${error_text}    Gallons is required
    Log To Console     Validation successful - Gallons missing error: ${error_text}
    Log    Gallons required field error validated


Validate Gallons With Value
    [Documentation]    Enters a valid gallons value and ensures no validation error is shown.
    [Arguments]    ${gallons_locator}=id=tankssize    ${gallons_value}=100    ${error_locator}=id=err_tanks_ize    ${add_button}=id=add_button
    Wait Until Element Is Visible    ${gallons_locator}    10s
    Clear Element Text    ${gallons_locator}
    Input Text    ${gallons_locator}    ${gallons_value}
    Click Button    ${add_button}
    Sleep    1s
    Run Keyword And Expect Error    *    Get Text    ${error_locator}
    Log To Console     Gallons entered successfully: ${gallons_value}
    Log    Gallons field validation passed

Validate Ticket Status Required Error
    [Documentation]    Ensures error is shown when no Ticket Status is selected.
    [Arguments]    ${status_locator}=id=ticketstatus    ${error_locator}=id=err_ticketstatus    ${add_button}=id=add_button
    Wait Until Element Is Visible    ${status_locator}    10s
    Select From List By Value    ${status_locator}    0
    Click Button    ${add_button}
    Wait Until Element Is Visible    ${error_locator}    5s
    ${error_text}=    Get Text    ${error_locator}
    Should Be Equal    ${error_text}    Ticket status is required
    Log To Console    Validation successful - Status missing error: ${error_text}
    Log    Ticket Status required field error validated


Validate Ticket Status With Value
    [Documentation]    Selects a valid Ticket Status and ensures no validation error is shown.
    [Arguments]    ${status_locator}=id=ticketstatus    ${valid_status}=new    ${error_locator}=id=err_ticketstatus    ${add_button}=id=add_button
    Wait Until Element Is Visible    ${status_locator}    10s
    Select From List By Value    ${status_locator}    ${valid_status}
    Click Button    ${add_button}
    Sleep    1s
    Run Keyword And Expect Error    *    Get Text    ${error_locator}
    Log To Console    Ticket Status selected successfully: ${valid_status}
    Log    Ticket Status field validation passed

Click Submit Button
    [Documentation]    Click on Submit button to create ticket.
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Click Button    xpath://input[@id="submitmanualfuelBtn"]
    Sleep    3s

#*** Test Cases ***
#Company Name Validation - Negative
#    [Tags]    negative
#    Validate Company Name Required Error
#
#Company Name Validation - Positive
#    [Tags]    positive
#    Validate Company Name Selection    SteadyOil Test Customer

#Gallons Field Validation - Negative
#    [Tags]    negative
#    Validate Gallons Required Error
#
#Gallons Field Validation - Positive
#    [Tags]    positive
#    Validate Gallons With Value    250

#Ticket Status Validation - Negative
#    [Tags]    negative
#    Validate Ticket Status Required Error
#
#Ticket Status Validation - Positive
#    [Tags]    positive
#    Validate Ticket Status With Value    special

Fill fields except Fuel Type
    Input Text    name:Site_name     North
    Input Text    id:purchase_order     1234
    Input Text    id:caller_info    8545633
    Input Text    name:ticket_notes    100 gallons
    Input Text    id:tankssize    150
    Input Text    id:fees_admin_manual     10
    Input Text     id:retail_cost_gallon     2
    Select From List By Value    id:discount     0

    Scroll Element Into View    id:Reset_ticket
    Click Element    xpath://span[@id='select2-fuel_class_terminal-container']
    Wait Until Element Is Visible    xpath=//input[contains(@class,'select2-search__field')]    5s
    Input Text       xpath=//input[contains(@class,'select2-search__field')]    Watford City Bulk Plant
    Wait Until Element Is Visible    xpath=//li[contains(text(),'Watford City Bulk Plant')]    5s
    Click Element    xpath=//li[contains(text(),'Watford City Bulk Plant')]
    Log To Console     Filled all other fields except FuelType

Validate Fuel Type Required Error and Fail
    [Documentation]    Validates that the Fuel Type required error message is shown and immediately fails the test for negative scenario.
    ${error_locator}=    Set Variable    id:err_fueltypes

    ${error_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${error_locator}    5s
    IF    not ${error_visible}
        Fail    Fuel Type Required error did NOT appear! Test Failed.
    END

    ${error_text}=    Get Text    ${error_locator}
    Should Be Equal    ${error_text}    Fuel type is required
    Log To Console     Validation successful - Fuel Type missing error: ${error_text}

    # Explicitly fail the test to mark negative scenario as failed
    Fail    Negative Test: Cannot create ticket without selecting fuel type.


Validate Ticket GPS Required Error and Fail
    [Documentation]    Validates that the Ticket GPS required error message is shown and immediately fails the test for negative scenario.
    ${error_locator}=    Set Variable    id:err_ticket_gps_manuel

    ${error_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${error_locator}    5s
    IF    not ${error_visible}
        Fail    Ticket GPS Required error did NOT appear! Test Failed.
    END

    ${error_text}=    Get Text    ${error_locator}
    Should Be Equal    ${error_text}    Ticket gps is required
    Log To Console     Validation successful - Ticket GPS missing error: ${error_text}

    # Explicitly fail the test to mark negative scenario as failed
    Fail    Negative Test: Cannot create ticket without GPS location.

*** Keywords ***
Fill Fields Except Tank GPS
    [Documentation]    Fill all required fields in Fuel Ticket form except Tank GPS (clear auto-populated GPS field first)

    # Step 1: Clear the auto-populated Tank GPS
    Clear Element Text    id:ticket_gps_manuel

    # Step 2: Fill the remaining fields
    Input Text    name:Site_name                North
    Input Text    id:purchase_order             1234
    Input Text    id:caller_info                8545633
    Input Text    name:ticket_notes             100 gallons
    Select From List By Value    id:fuel_types   2
    Input Text    id:tankssize                  100
    Input Text    id:fees_admin_manual          10
    Input Text    id:retail_cost_gallon         2

    # Step 3: Select Terminal from dropdown (searchable Select2)
    Scroll Element Into View    id:Reset_ticket
    Click Element    xpath=//span[@id='select2-fuel_class_terminal-container']
    Wait Until Element Is Visible    xpath=//input[contains(@class,'select2-search__field')]    5s
    Input Text    xpath=//input[contains(@class,'select2-search__field')]    Watford City Bulk Plant
    Wait Until Element Is Visible    xpath=//li[contains(text(),'Watford City Bulk Plant')]    5s
    Click Element    xpath=//li[contains(text(),'Watford City Bulk Plant')]

    Log To Console    Filled all other fields except Tank GPS

