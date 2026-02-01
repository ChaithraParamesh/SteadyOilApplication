*** Settings ***
Library         SeleniumLibrary
*** Variables  ***
${browser}       Chrome
${url}       https://stage.steadyoil.com/


*** Test Cases ***
Single Fuel Ticket
     Open browser    ${url}          ${browser}
     Login To Application
     Set Selenium Speed    0.3 seconds
     Maximize Browser Window
     Wait Until Page Contains    Dashboard    3s

     Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
     Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
     Click Element    xpath://span[@id='select2-searchcompany-container']
     Input Text    xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
     Click Element    xpath=//li[contains(text(), 'Lund Brady')]
     Sleep    1s

#####   MT State Ticket #####
#     Input Text     name:ticket_gps_manuel     47.9987, -104.1331

     Input Text    name:Site_name     North
     Input Text    id:purchase_order     1234
     Input Text    id:caller_info    8545633
     Input Text     name:ticket_notes       100 gallons

########### Truck Type ###########
#    Select TruckType    Bulk Fuel
     Select TruckType    Transport Fuel

########## Location #########
#    Select Location    Lund Oil - Watford City
     Select Location    Lund Oil - Williston

     Scroll Element Into View    id:fuel_class_name
     Select From List By Value   xpath://select[@id="fuel_types"]    4
     Input text     id:tankssize     550
     Input text     id:fees_admin_manual     10
     Input text     id:retail_cost_gallon     2
     Select From List By Value    id:discount     0
     Scroll Element Into View    id:Reset_ticket

########    Assigning truck ########
#     Select From List By Label    id=manual_assign_truck    226
#     Handle Alert    ACCEPT

     Click Element    xpath://span[@id='select2-fuel_class_terminal-container']
     Input Text       xpath=//input[contains(@class,'select2-search__field')]    Watford City Bulk Plant
     Click Element    xpath=//li[contains(text(),'Watford City Bulk Plant')]
#     Select From List By Label    3 - Premium NL (Fed & ND Tax)
     Click Button    xpath://input[@id="add_list"]
     Sleep    10s
     Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
     Click Button    xpath://input[@id="submitmanualfuelBtn"]




*** Keywords ***
Login to Application
     Input Text     name:identity    admin@steadyoil.com
     Input Text     name:password      Pwd4so!l
     Click Button     xpath:/html/body/div/div/div/form/div[4]/button

Select TruckType
    [Arguments]    ${truckType}
    Select From List By Label   //select[@id="fuel_truck_type"]    ${truckType}
    Log To Console    Truck Type Selected is ${truckType}

Select Location
    [Arguments]    ${location}
    Select From List By Label   //select[@id="ns_location"]    ${location}
    Log To Console    Location Selected is ${location}