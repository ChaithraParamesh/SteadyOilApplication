*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/Login_LogoutKeywords.robot
Resource    ../../resources/CommonKeywords.robot



*** Variables ***

*** Test Cases ***
TC1 Fuel Storage Ticket
    Launch Application
    Login To Application
    Navigate To Create Fuel Ticket Page
    Select Customer    Lund Oil - Storage
    Select Tank    Tank 29-31 - Methanol
    Fill Common Fields    Site-A    PO-885    Renzo@8596    250 gallons
    Select TruckType    Bulk Fuel
    Select Location    Lund Oil - Watford City
    Select Fuel Type    Methanol
    Gallons Estimated    850
    Select Terminal    Watford City Bulk Plant
    Click Submit Button
    Validate Success Message For Ticket Creation
    ${latest_ticket_id}=    Get Latest Ticket ID


*** Keywords ***
Navigate To Create Fuel Ticket Page
    [Documentation]    Navigate to the Create Manual Fuel Ticket page from sidebar
    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Wait Until Element Is Visible    xpath=//nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a    5s
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
    Wait Until Page Contains    Create Manual Fuel Ticket     10s
    Log To Console    Navigated to Create Manual Fuel Ticket Page

Select Tank
    [Arguments]    ${tank}
    Select From List By Label   //select[@id="tank_name_manuel"]    ${tank}
    Log To Console    Tank Selected is ${tank}

Select TruckType
    [Arguments]    ${truckType}
    Select From List By Label   //select[@id="fuel_truck_type"]    ${truckType}
    Log To Console    Truck Type Selected is ${truckType}

Select Location
    [Arguments]    ${location}
    Select From List By Label   //select[@id="ns_location"]    ${location}
    Log To Console    Location Selected is ${location}

Gallons Estimated
    [Arguments]    ${gallons}
    Input Text    //input[@id="tankssize"]    ${gallons}
    Log To Console    Gallons Estimated is ${gallons}

Select Terminal
    [Arguments]    ${terminal}
    Click Element    xpath://span[@id='select2-fuel_class_terminal-container']
    Input Text       xpath://input[contains(@class, 'select2-search__field')]     ${terminal}
    Click Element    xpath=//li[contains(text(), '${terminal}')]
    Sleep    1s



