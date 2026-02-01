*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${url}         https://stage.steadyoil.com/
${browser}     chrome

*** Test Cases ***
Normal Ticket
    Open browser     ${url}          ${browser}
    Login To Application
    Set Selenium Speed    2s
    Maximize Browser Window
    Wait Until Page Contains    Dashboard    3s

    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[3]/a
    Click Element    xpath://span[@id='select2-searchcompany-container']
    Input Text    xpath://input[contains(@class, 'select2-search__field')]    Lund Brady
    Click Element    xpath=//li[contains(text(), 'Lund Brady')]
    Sleep    2s
    Input Text    name:Site_name    North Site
    Input Text    name:purchase_order    202545
    Input Text    name:caller_info    Roman Renzo 112
    Input Text    name:ticket_notes    180 gallons of Propane
    Input Text    id:tankssize    450

     ########## Location #########
     ${location}=    Select Location    Lund Oil - Watford City
#     ${location}=    Select Location    Lund Oil - Williston
     ${terminal}=    Log Auto Populated Terminal
     Log To Console    Location: ${location} | Terminal: ${terminal}

    Scroll Element Into View    id:add_list

    Input Text    id:fees_admin_manual    5           
    Input Text    id:retail_cost_gallon    2.4458
    Select From List By Value    id:discount    2
#    Select From List By Label    name:truck    180
#     Assigning truck
#    Select From List By Label    id=manual_assign_truck    180
#    Handle Alert    ACCEPT
    Click Element      //*[@id="frm_fuel_ticket"]/div/div[1]/div/div[28]/div/div/div[2]/label[2]/div/div[1]

#    Terminal verification:
    Log Auto Populated Terminal
    Click Button    add_list
    Scroll Element Into View    class:box-body
    Sleep    2s 
    Click Button    id:submitmanualfuelBtn

#    Wait Until Element Is Visible    //*[@id="flashdata"]/div    timeout=30s
#    ${message}=    Get Text        //*[@id="flashdata"]/div
#    Log To Console    ${message}
#    Log    Success Message: ${message}

    
*** Keywords ***
Login To Application
    Input Text         name:identity    admin@steadyoil.com
    Input Text     name:password      Pwd4so!l
    Click Button     xpath:/html/body/div/div/div/form/div[4]/button

Select Location
    [Arguments]    ${location}
    Select From List By Label   //select[@id="ns_location"]    ${location}
    Log To Console    Location Selected is ${location}
    RETURN      ${location}

Log Auto Populated Terminal
    Wait Until Keyword Succeeds    10s    1s    Terminal Should Be Populated
    ${terminal}=    Get Text    id=select2-fuel_class_terminal-container
    Log To Console    Terminal Auto Selected is ${terminal}
    RETURN    ${terminal}

Terminal Should Be Populated
    ${terminal}=    Get Text    id=select2-fuel_class_terminal-container
    Should Not Be Equal    ${terminal}    Select terminal