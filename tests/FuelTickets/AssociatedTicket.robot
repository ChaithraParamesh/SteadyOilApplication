*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${url}    https://stage.steadyoil.com
${browser}    chrome

*** Test Cases ***
Associated Fuel Ticket
    open browser    ${url}          ${browser}
    Login To Application
    Set Selenium Speed    0.2 seconds
    Maximize Browser Window
    Wait Until Page Contains    Dashboard    3s

    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
    Click Element    xpath://span[@id='select2-searchcompany-container']
    Input Text    xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
    Click Element    xpath=//li[contains(text(), 'Lund Brady')]
    Sleep    1s
#    Adding MT- State tank- Copy- paste of MT State GPS in tank GPS field
#     Input Text     name:ticket_gps_manuel     47.9987, -104.1331
    Input Text    name:Site_name     North
    Input Text    id:purchase_order     1234
    Input Text    id:caller_info    8545633
    Input Text     name:ticket_notes       100 gallons

########### Truck Type ###########
     Select TruckType    Bulk Fuel
#     Select TruckType    Transport Fuel

########## Location #########
     Select Location    Lund Oil - Watford City
#     Select Location    Lund Oil - Williston


    Scroll Element Into View    id:add_list
    Click Element    id:fuel_types
    Select From List By Value   xpath://select[@id="fuel_types"]    1
    Input text     id:tankssize     100
    Input text     id:fees_admin_manual     10
    Input text     id:retail_cost_gallon     2
    Click Element    name:discount
    Select From List By Value    id:discount     2
    Scroll Element Into View    id:Reset_ticket
    Click Button    id:add_list
    Sleep     3s

    
####### Associated Fuel ######
    Scroll Element Into View     xpath://select[@name="te_manuel"]
    Click Element    id:fuel_types
    Select From List By Value   xpath://select[@id="fuel_types"]    3
    Input text     id:tankssize     100
    Input text     id:retail_cost_gallon     2
#    Select From List By Value    id:discount     0
    Scroll Element Into View    id:Reset_ticket
    Click Button    id:add_list
    Sleep     3s

#    Validation of selected fuels
    ${fuel details}=     Get Text    //tbody[@class="deliData-list"]
    Log    ${fuel details}
    Log To Console    ${fuel details}
#    Create ticket
    Click Button    id:submitmanualfuelBtn

*** Keywords ***
Login To Application
    Input Text        name:identity    admin@steadyoil.com
    Input Text        name:password    Pwd4so!l
    Click Button    xpath://button[@class="login100-form-btn"]

Select TruckType
    [Arguments]    ${truckType}
    Select From List By Label   //select[@id="fuel_truck_type"]    ${truckType}
    Log To Console    Truck Type Selected is ${truckType}

Select Location
    [Arguments]    ${location}
    Select From List By Label   //select[@id="ns_location"]    ${location}
    Log To Console    Location Selected is ${location}
    