*** Settings ***
Library     SeleniumLibrary
Resource    resources/Login_LogoutKeywords.robot
Resource    resources/OilTicketResources.robot
Resource    resources/base.robot







*** Test Cases ***
TC01 Create Rig Oil Ticket
    [Documentation]    Create rig oil ticket
    [Tags]    RigOilTicket
    Create Rig Oil Ticket    Lund Brady    NABORS X8    Brady's Hanger


TC02 Create Well Oil Ticket
     [Documentation]    Create well oil ticket
     [Tags]    WellOilTicket
     Create Well Oil Ticket    Lund Brady    BURLINGTON RESOURCES OIL & GAS COMPANY LP    BADLAND 11-15TFH   Brady's Hanger
    

TC03 Create Tank Oil Ticket
     [Documentation]    Create tank oil ticket
     [Tags]    TankOilTicket
     Create Tank Oil Ticket    Lund Brady    Brady Lund Shop

TC04 Create oil ticket by adding product favourite list
     [Documentation]    Create oil ticket by adding product favourite list
     [Tags]    ProductFavouriteList
     Adding Product To Favourite List    Lund Brady    Brady Lund Shop    MAR Full Synthetic 5W40 CK-4

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
    

Create Well Oil Ticket
    [Documentation]    This test case is to create a Well Oil Ticket
    [Arguments]    ${customer}    ${operator_name}     ${well_name}    ${tank_name}
    Launch Application
    Login to Application
    Navigate To Oil Ticket Page
    Select Customer    ${customer}
    Select Operator Name    ${operator_name}
    Select Well name    ${well_name}
    Select Tank        ${tank_name}
    Enter Other Details Inputs
    Scroll To Element     id:oil_reset
    Scroll And Click Element    
    ...    xpath=//input[contains(@class,'add_oil_prod_button')]
    Go To Product Pagination Page    4
    Select Product From Current Page By Index    3
    Click Save Added Product Button
    Verify Product Modal Closed
    Log Added Oil Products
    Click Create Oil Ticket Button


Create Tank Oil Ticket
    [Documentation]    This test case is to create a Tank Oil Ticket
    [Arguments]    ${customer}    ${tank_name}
    Launch Application
    Login To Application
    Navigate To Oil Ticket Page
    Select Customer    ${customer}
    Select Tank        ${tank_name}
    Enter Other Details Inputs
    Scroll To Element     id:oil_reset
    Scroll And Click Element
    ...    xpath=//input[contains(@class,'add_oil_prod_button')]
    Go To Product Pagination Page    5
    Select Product From Current Page By Index    2
    Click Save Added Product Button
    Verify Product Modal Closed
    Log Added Oil Products
    Click Create Oil Ticket Button


Adding product to favourite list
    [Documentation]    This test case is to add a product to the favourite list
    [Arguments]    ${customer}    ${tank_name}    ${product_name}
    Launch Application
    Login To Application
    Navigate To Oil Ticket Page
    Select Customer    ${customer}
    Select Tank        ${tank_name}
    Enter Other Details Inputs
    Scroll To Element     id:oil_reset
    Scroll And Click Element
    ...    xpath=//input[contains(@class,'add_oil_prod_button')]
    Go To Product Pagination Page    4
    Select Product From Current Page By Index    2
    Make Product Favourite    ${product_name}
    Click Save Added Product Button
    Verify Product Modal Closed
    Log Added Oil Products
    Click Create Oil Ticket Button
    
    

