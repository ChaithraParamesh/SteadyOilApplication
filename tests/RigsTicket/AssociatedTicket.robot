*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${url}     https://stage.steadyoil.com/
${browser}     chrome

*** Test Cases ***
Rigs Associated Ticket
    Open Browser    ${url}     ${browser}
    Set Selenium Speed     2s
    Maximize Browser Window
    Login To Application
    Wait Until Page Contains    Dashboard

#Print Page Title
#    Title validation
    ${title}=     Get Title
    Log To Console     The Page title is:${title}
    Title Should Be     FuelLogix | FuelLogix Delivery System

    Mouse Over    //nav[@id="main-sidebar"]//section//ul//li[6]//a//i//span
    Click Element     //nav[@id="main-sidebar"]//section//ul//li[6]//ul//li[5]//a
    Click Element    id:select2-wells_client_name-container
    Input Text    class:select2-search__field    Lund Brady
    Click Element     //span[@class="select2-results"]//ul//li[contains(text(), "Lund Brady")]
    Input Text    id:rig_name    N
    Sleep    2s
    Click Element    id:NABORS b20
    Input Text    name:site_name     Williston
    Input Text    id:purchase_order    8989
    Input Text    name:caller_info    Roman Renzo
    Input Text    id:wells_ticket_notes    100 gallons required

 ######### Fuel Type #########
    Select From List By Value    id:fuel_types    5

    ########### Truck Type ###########
     Select TruckType    Bulk Fuel
#     Select TruckType    Transport Fuel

########## Location #########
     Select Location    Lund Oil - Watford City
#     Select Location    Lund Oil - Williston

    Scroll Element Into View    id:well_add_list
#    Click Element    name:fueltype
#    Select From List By Value    id:fuel_types    9
    Input Text    name:gallons    100
#    Click Element    name:rigs_fuel
    Select From List By Label    id:rigs_fuel    Motor Fuel
    Input Text    name:retail_cost_gallon_wells    2.54455
    Click Element       name:discount
    Select From List By Value    id:discount    1
    Input Text    name:fees_wells    15

    #tax
#    Click Element      //*[@id="frm"]/div/div[1]/div/div[32]/div/div/div/label[2]/div/div[1]

    Click Element    id:select2-fuel_class_terminal_wells-container
    Click Element    //ul[@class="select2-results__options"]//li[2]//li[2]
    Scroll Element Into View    name:Reset
    Click Button    id:well_add_list
    Sleep     3s

#    Associated Ticket
    Scroll Element Into View        id:wells_ticket_notes
    Sleep     2s
    Click Element    name:fueltype
    Select From List By Value    id:fuel_types    3
    Input Text    name:gallons    100
    Click Element    name:status
    Select From List By Label    id:rigs_fuel    Mud Fuel
    Input Text    name:retail_cost_gallon_wells   3.4452
    Click Element    id:select2-fuel_class_terminal_wells-container
    Click Element    //ul[@class="select2-results__options"]//li[2]//li[2]
    Scroll Element Into View    xpath:(//div[@class="box-body"])[3]
    Click Button    id:well_add_list
    Sleep     5s
#    Validation of selected fuels
    ${fuel details}=     Get Text    //tbody[@class="deliData-list-wells"]
    Log    ${fuel details}
    Log To Console    ${fuel details}
    Sleep    2s
    Click Button    id:wells_ticket_submit


*** Keywords ***
Login To Application
    Input Text     name:identity    admin@steadyoil.com
    Input Text     name:password      Pwd4so!l
    Click Button   xpath:/html/body/div/div/div/form/div[4]/button

#Scrolling up page till fuel type
#Scroll Element To Middle
#    [Arguments]    ${locator}
#    ${element}=    Get WebElement    ${locator}
#    Execute Javascript    arguments[0].scrollIntoView(true);    ${element}
#    Sleep    1s
#    Execute Javascript    window.scrollBy(0, -window.innerHeight / 2)

Select TruckType
    [Arguments]    ${truckType}
    Select From List By Label   //select[@id="wells_fuel_truck_type"]    ${truckType}
    Log To Console    Truck Type Selected is ${truckType}

Select Location
    [Arguments]    ${location}
    Select From List By Label   //select[@id="wells_ns_location"]    ${location}
    Log To Console    Location Selected is ${location}