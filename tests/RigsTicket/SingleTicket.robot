*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${url}     https://stage.steadyoil.com/
${browser}     chrome

*** Test Cases ***
Rigs Single Ticket
    Open Browser    ${url}     ${browser}
    Set Selenium Speed     2s
    Maximize Browser Window
    Login To Application
    Wait Until Page Contains    Dashboard

    Mouse Over    //nav[@id="main-sidebar"]//section//ul//li[6]//a//i//span
    Click Element     //nav[@id="main-sidebar"]//section//ul//li[6]//ul//li[5]//a
    Click Element    id:select2-wells_client_name-container
    Input Text    class:select2-search__field    Lund Brady
    Click Element     //span[@class="select2-results"]//ul//li[contains(text(), "Lund Brady")]
    Input Text    id:rig_name    N
    Click Element    id:NABORS b20
    Input Text    name:site_name    North-ND
    Input Text    id:purchase_order    ABC_123
    Input Text    name:caller_info    Roman Renzo
    Input Text    id:wells_ticket_notes    100 gallons required

     ######### Fuel Type #########
    Select From List By Value    id:fuel_types    5

    ########### Truck Type ###########
     Select TruckType    Bulk Fuel
#     Select TruckType    Transport Fuel

########## Location #########
#     Select Location    Lund Oil - Watford City
     Select Location    Lund Oil - Williston

    Scroll Element Into View    id:well_add_list

#    Scroll Element Into View    id:well_add_list
#    Select From List By Value    id:fuel_types    9
    Input Text    name:gallons    100
    Select From List By Label    id:rigs_fuel    Motor Fuel
    Input Text    name:retail_cost_gallon_wells    2.54455
    Select From List By Value    id:discount    1
    Input Text    name:fees_wells    15
    Click Element    id:select2-fuel_class_terminal_wells-container
    Click Element    //ul[@class="select2-results__options"]//li[2]//li[2]
#tax
#    Click Element      //*[@id="frm"]/div/div[1]/div/div[32]/div/div/div/label[2]/div/div[1]
    Click Button    id:well_add_list
    Scroll Element Into View    class:box-body
    Sleep     5s
    Click Button    id:wells_ticket_submit





    
    
    
*** Keywords ***
Login To Application
    Input Text     name:identity    admin@steadyoil.com     
    Input Text     name:password      Pwd4so!l  
    Click Button   xpath:/html/body/div/div/div/form/div[4]/button  

Select TruckType
    [Arguments]    ${truckType}
    Select From List By Label   //select[@id="wells_fuel_truck_type"]    ${truckType}
    Log To Console    Truck Type Selected is ${truckType}

Select Location
    [Arguments]    ${location}
    Select From List By Label   //select[@id="wells_ns_location"]    ${location}
    Log To Console    Location Selected is ${location}