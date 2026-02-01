*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}    https://stage.steadyoil.com/
${browser}    chrome

*** Test Cases ***
Associated Wells Ticket
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Speed    2s
    Login To Application
    Wait Until Page Contains     Dashboard    2s
#Print Page Title
#    Title validation
    ${title}=     Get Title
    Log To Console     The Page title is:${title}
    Title Should Be     FuelLogix | FuelLogix Delivery System


# Navigate to Wells ticket creation page
    Mouse Over    //nav[@class="main-sidebar"]//section//ul//li[6]//a//i//span
    Click Element    //nav[@class="main-sidebar"]//section//ul//li[6]//ul//li[4]//a

    Click Element    //span[@id="select2-wells_client_name-container"]
    Input Text    //input[@class="select2-search__field"]     Lund Brady
    Sleep    2s
    Click Element    //span//ul//li[contains (text(), "Lund Brady")]
    Input Text    name:search_text    31
    Sleep     2s
    Click Element    xpath://*[@id="31 OPERATING, LLC"]
    Input Text    id:wells_name    S
    Sleep     2s    
    Click Element    //*[@id="14498"]
    Sleep     0.3s
    Input Text    id:site_name    Watford City
    Input Text    id:purchase_order    8524445
    Input Text    name:caller_info    Roman Renzo
    Input Text    id:wells_ticket_notes    150 gallons


       ######### Fuel Type #########
    Select From List By Value    id:fuel_types    5

    ########### Truck Type ###########
     Select TruckType    Bulk Fuel
#     Select TruckType    Transport Fuel

########## Location #########
     Select Location    Lund Oil - Watford City
#     Select Location    Lund Oil - Williston

    Scroll Element Into View    id:well_add_list
    Input Text    name:gallons    150
    Input Text    id:retail_cost_gallon_wells    4
    Select From List By Label    id:discount    5%
    Input Text    id:fees_wells_manual    10
    
##  Select Truck
#    Select From List By Value    id:wells_assign_truck    70
#
##    Accept Alert
#    Handle Alert        [action=ACCEPT]     timeout=2s
##   Alert validation
#    Alert Should Be Present    Are you sure to assign this ticket to selected truck?

    Scroll Element Into View    class:box-body
    Select From List By Value    id:fuel_class_terminal_wells    19
    Click Button    id:well_add_list
    Sleep    3s

# Associated Ticket
    Scroll Element Into View    id:fuel_types
#    Sleep     2s
    Select From List By Value    id:fuel_types    7
    Input Text    name:gallons    150
    Input Text    id:retail_cost_gallon_wells    2
    Select From List By Value    id:fuel_class_terminal_wells    19
    Click Button    id:well_add_list
    Scroll Element Into View    class:box-body
    Sleep     5s
    Click Button    id:wells_ticket_submit
    

*** Keywords ***
Login To Application
    Input Text         name:identity    admin@steadyoil.com
    Input Text     name:password      Pwd4so!l
    Click Button     xpath:/html/body/div/div/div/form/div[4]/button

Select TruckType
    [Arguments]    ${truckType}
    Select From List By Label   //select[@id="wells_fuel_truck_type"]    ${truckType}
    Log To Console    Truck Type Selected is ${truckType}

Select Location
    [Arguments]    ${location}
    Select From List By Label   //select[@id="wells_ns_location"]    ${location}
    Log To Console    Location Selected is ${location}