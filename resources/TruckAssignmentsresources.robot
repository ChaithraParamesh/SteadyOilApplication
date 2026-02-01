*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${OUTER_TAB}        //div[@class='outer-tab']
${TICKET_LOCATOR}   //div[@class='ticket']
${TRUCK_LOCATOR}    //div[@class='truck']

*** Keywords ***
Login To Application
    [Arguments]    ${username}    ${password}
    Open Browser    https://yourapp.com    chrome
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Button    id=loginBtn
    Wait Until Page Contains Element    ${OUTER_TAB}

Scroll Outer Tab With Keys
    [Arguments]    ${tab_locator}    ${times}=1
    FOR    ${i}    IN RANGE    ${times}
        Press Key    ${tab_locator}    PAGE_DOWN
        Sleep    0.5
    END

Drag Ticket To Truck
    [Arguments]    ${ticket_id}    ${truck_id}
    ${ticket}    Set Variable    xpath=//div[text()='${ticket_id}']
    ${truck}     Set Variable    xpath=//div[text()='${truck_id}']
    Drag And Drop    ${ticket}    ${truck}
    Log    Ticket ${ticket_id} assigned to Truck ${truck_id}

Verify Ticket Assigned
    [Arguments]    ${ticket_id}    ${truck_id}
    ${ticket_in_truck}    Get Text    xpath=//div[text()='${truck_id}']//following-sibling::div[text()='${ticket_id}']
    Should Be Equal    ${ticket_in_truck}    ${ticket_id}
