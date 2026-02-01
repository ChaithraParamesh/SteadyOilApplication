*** Settings ***
Library    SeleniumLibrary    
*** Variables ***
${url}    https://stage.steadyoil.com/
${browser}    chrome

*** Test Cases ***
Single Ticket
    Open Browser    ${url}     ${browser}
    Set Selenium Speed     2s
    Maximize Browser Window
    Login To Application
    Wait Until Page Contains    Dashboard

    Mouse Over    //nav[@id="main-sidebar"]//section//ul//li[6]//a//i//span
    Click Element     //nav[@id="main-sidebar"]//section//ul//li[6]//ul//li[7]//a
    Click Element    id:select2-searchcompany-container
    Input Text    class:select2-search__field    Lund Brady
    Click Element    //span[@class="select2-results"]//ul//li[contains(text(), "Lund Brady")]
    Input Text     name:Site_name      South
    Input Text    name:purchase_order     52563
    Input Text    id:caller_info    Roman
    Input Text    id:ticket_notes    150 gallons
    Scroll Element Into View    id:add_list
    Input Text    name:gallons_needed    150
    Input Text    name:fees_admin    15
    Input Text    id:retail_cost_gallon    3
    Select From List By Value    id:discount    4
    Scroll Element Into View    class:box-body
    Click Button    id:add_list
    Sleep     5s
    Click Button     id:submitmanualfuelBtn

*** Keywords ***
Login To Application
    Input Text     name:identity    admin@steadyoil.com
    Input Text     name:password      Pwd4so!l
    Click Button   xpath:/html/body/div/div/div/form/div[4]/button

