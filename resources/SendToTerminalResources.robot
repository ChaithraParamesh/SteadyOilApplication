*** Settings ***
Library     SeleniumLibrary

*** Variables ***

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
     Input Text    xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
     Click Element    xpath=//li[contains(text(), 'Lund Brady')]
     Sleep    1s

Fill other fields
     Input Text    name:Site_name     North
     Input Text    id:purchase_order     1234
     Input Text    id:caller_info    8545633
     Input Text     name:ticket_notes       100 gallons

Fill fuel details
     Scroll Element Into View    id:fuel_class_name
     Select From List By Value   xpath://select[@id="fuel_types"]    8
     Input text     id:tankssize     100
     Input text     id:fees_admin_manual     10
     Input text     id:retail_cost_gallon     2
     Select From List By Value    id:discount     0
     Scroll Element Into View    id:Reset_ticket

Select Truck
    Select From List By Value    id:manual_assign_truck    41
    Handle Alert    ACCEPT    
    Sleep    1s

Select send to terminal
     Click Element    name:send_to_terminal
     Select From List By Value    id:fuel_tkt_terminal    9

Add fuel
     Click Button    xpath://input[@id="add_list"]
     Sleep    10s

Create Ticket
     Click Button    xpath://input[@id="submitmanualfuelBtn"]


