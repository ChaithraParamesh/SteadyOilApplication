*** Settings ***
Library    SeleniumLibrary
Resource    resources/Login_LogoutKeywords.robot
Resource    resources/OilTicketResources.robot
Resource    resources/CommonKeywords.robot




*** Test Cases ***
TC01 Create Rig Oil Ticket
    [Documentation]    Create rig oil ticket and verify successful submission
    [Tags]    RigOilTicket
    Create Rig Oil Ticket    Lund Brady    NABORS X8    Brady's Hanger





*** Keywords ***
Create Rig Oil Ticket
    [Documentation]    This test case is to create a Rig Oil Ticket
    [Arguments]    ${customer}    ${rig_name}    ${tank_name}

    Launch Application
    Login to Application
    Navigate to Oil Ticket Page
    Select Customer    ${customer}
    Select Rig Name    ${rig_name}
    Select Tank        ${tank_name}
    Enter Other Details Inputs
    Scroll To Element     id:oil_reset
    Scroll And Click Element
    ...    xpath=//input[contains(@class,'add_oil_prod_button')]
    Go To Product Pagination Page    2
    Verify Product Pagination Page Active    2
    Select Product From Current Page By Index    1
    Click Save Added Product Button
    Verify Product Modal Closed
    Log Added Oil Products

    Click Create Oil Ticket Button
    










