*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Validate And Print Fuel Ticket Page Heading
    [Arguments]    ${expected_heading}=Create Manual Fuel Ticket
    Wait Until Element Is Visible    xpath=//div[@class="page-heading"]/h3    10s
    ${heading}=    Get Text    xpath=//div[@class="page-heading"]/h3
    Should Be Equal    ${heading}    ${expected_heading}
    Log To Console    \n Page Heading: ${heading}



