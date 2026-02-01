*** Settings ***
Library     SeleniumLibrary
Library     BuiltIn
Library    String
Library    Collections




*** Keywords ***
Select Customer for fuel
    [Arguments]    ${customer_name}
    Click Element    xpath://span[@id='select2-searchcompany-container']
    Input Text       xpath://input[contains(@class, 'select2-search__field')]     ${customer_name}
    Click Element    xpath=//li[contains(text(), '${customer_name}')]
    Sleep    1s

Fill Common Fields
    [Arguments]    ${site_name}    ${purchase_order}    ${caller_info}    ${ticket_notes}
    Input Text    name:Site_name        ${site_name}
    Input Text    id:purchase_order     ${purchase_order}
    Input Text    id:caller_info        ${caller_info}
    Input Text    name:ticket_notes     ${ticket_notes}

FuelTypes
    [Arguments]    ${Fuel}
    # Remove surrounding quotes and spaces
    ${Fuel}=    Replace String    ${Fuel}    "    ${EMPTY}
    ${Fuel}=    Replace String    ${Fuel}    '    ${EMPTY}
    ${Fuel}=    Strip String      ${Fuel}
    ${Fuel_upper}=    Convert To Upper Case    ${Fuel}
    Log To Console    Normalized Fuel: '${Fuel}'

    # Fuel dictionary (keys match normalized input)
    # Dictionary mapping fuel names to dropdown values
    # Fuel dictionary: keys must match normalized input (uppercase)
    ${fuel_map}=    Create Dictionary
    ...     "#1 DYED DIESEL"     1
    ...     "#2 DYED DIESEL"     2
    ...     "#1 CLEAR DIESEL"    3
    ...     "#2 CLEAR DIESEL"    4
    ...     SUPER NL             5
    ...     REGULAR NL           6
    ...     PREMIUM NL           7
    ...     METHANOL             8
    ...     BLENDED DYED         blended_dyed
    ...     BLENDED CLEAR        blended_clear
    ...     KEROSENE             14

    
#    FOR    ${key}    IN    @{fuel_map.keys()}
#        Log To Console    >>>${key}<<<
#    END

# If input is already a dropdown value, return directly
    ${values}=    Get Dictionary Values    ${fuel_map}
    Run Keyword If    '${Fuel}' in ${values}    Return From Keyword    ${Fuel}

    # Otherwise, match uppercase name in dictionary keys
    # Use new FOR loop syntax
    FOR    ${key}    IN    @{fuel_map.keys()}
        ${key_upper}=    Convert To Upper Case    ${key}
        Run Keyword If    '${Fuel_upper}' == '${key_upper}'    Return From Keyword    ${fuel_map}[${key}]
    END

    # Fail if no match
    Fail    Invalid fuel type provided: ${Fuel}

Select Fuel Type
    [Arguments]    ${Fuel}
    Log To Console    Fuel input received: '${Fuel}'
    ${fuel_value}=    FuelTypes    ${Fuel}
    Log To Console    Fuel value returned from FuelTypes: '${fuel_value}'
    Select From List By Value    id=fuel_types    ${fuel_value}
    Log To Console    Selected Fuel Type: ${Fuel}

Fill fuel details
    Input text     id:tankssize         1000
    Input text     id:fees_admin_manual     10
    Input text     id:retail_cost_gallon     2
    Select From List By Value    id:discount     0
    Scroll Element Into View    id:Reset_ticket

Click Submit button
    Click Button    xpath://input[@id="add_list"]
    Sleep    10s
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Click Button    xpath://input[@id="submitmanualfuelBtn"]

Validate success message for ticket creation
    [Documentation]    Waits and validates ticket creation success message
    Wait Until Element Is Visible
    ...    xpath=//*[@id='flashdata']//*[contains(text(),'Ticket')]
    ...    timeout=15s

    ${message}=    Get Text    xpath=//div[@class="alert alert_success"]/div
    Log To Console    Ticket message: ${message}
    Log    Ticket message: ${message}
    Should Be Equal As Strings    ${message}    Manual Ticket created successfully

Validate Fuel Ticket Page Heading
    Wait Until Page Contains Element    xpath=//h3[contains(text(), "Fuel Tickets")]    timeout=30s
    Element Should Contain    xpath=//h3    Fuel Tickets

Scroll Outer Tab With Keys
    [Arguments]    ${locator}    ${times}=1
    Log    Scrolling element ${locator} for ${times} times
    Click Element    ${locator}
    FOR    ${i}    IN RANGE    ${times}
        Press Keys    ${locator}    PAGE_DOWN
        Sleep    0.5s
    END

Get Latest Ticket ID
    [Documentation]    Return the numerically highest ticket_id (latest ticket).

    Wait Until Page Contains Element    xpath=//div[contains(@class,'ticket-box-wrapper')]//a[contains(@class,'assign_fuel_ticket_details')]    15s

    @{tickets}=    Get WebElements    xpath=//div[contains(@class,'ticket-box-wrapper')]//a[contains(@class,'assign_fuel_ticket_details')]

    ${count}=    Get Length    ${tickets}
    Log To Console    Found ${count} ticket elements on the page.
    Run Keyword If    ${count} == 0    Fail    No tickets found on the ticket listing page.

    # collect all IDs
    @{ids}=    Create List
    FOR    ${el}    IN    @{tickets}
        ${id}=    Get Element Attribute    ${el}    ticket_id
        Append To List    ${ids}    ${id}
    END

    # compute max id
    ${latest_ticket_id}=    Evaluate    str(max([int(x) for x in ${ids}]))

    Log To Console    Latest ticket id (max numeric): ${latest_ticket_id}

    RETURN    ${latest_ticket_id}



Scroll And Stay On Latest Ticket
    [Arguments]    ${latest_ticket_id}    ${pause}=3s

    ${ticket_locator}=    Set Variable
    ...    xpath=//a[contains(@class,'assign_fuel_ticket_details') and @ticket_id='${latest_ticket_id}']

    Wait Until Page Contains Element    ${ticket_locator}    10s

    Execute JavaScript  arguments[0].scrollIntoView(true)    ${ticket_locator}
#
#    Execute JavaScript
#    ...    arguments[0].style.outline='3px solid #ff9800';
#    ...    ${ticket_locator}

    Sleep    ${pause}