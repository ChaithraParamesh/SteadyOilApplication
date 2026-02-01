*** Settings ***
Library         SeleniumLibrary
Resource    ../../resources/Login_LogoutKeywords.robot
Resource    ../../resources/CommonKeywords.robot


*** Variables  ***
${browser}       Chrome
${url}       https://stage.steadyoil.com/


*** Test Cases ***
Fuel Recurrent Ticket
     Launch Application
     Login To Application
     Navigate To Create Fuel Ticket Page
     Select Customer     Lund Brady
     Fill Common Fields    North    1234    8545633    100 gallons
     Scroll Element Into View    id:fuel_class_name
     Select Fuel Type    Methanol
     Fill Fuel Details
     Scroll Element Into View    id:Reset_ticket
     Click On Recurrent
     Select Any Date    19/12/2025
     Click Submit Button











*** Keywords ***
Navigate To Create Fuel Ticket Page
    [Documentation]    Navigate to the Create Manual Fuel Ticket page from sidebar
    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Wait Until Element Is Visible    xpath=//nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a    5s
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
    Wait Until Page Contains    Create Manual Fuel Ticket     10s
    Log To Console    Navigated to Create Manual Fuel Ticket Page

Click on Recurrent
    Click Button    id:recurrent_ticket
    Select From List By Value    name:repeat_interval    weekly

Select Any Date
    [Arguments]    ${input_date}    # format: DD/MM/YYYY

    ${day}    ${month}    ${year}=    Split String    ${input_date}    /
    ${month_index}=    Evaluate    int(${month}) - 1

    Click Element    id=recurent_end_date
    Wait Until Element Is Visible    //div[@id='ui-datepicker-div']

    Select From List By Value    //select[@class='ui-datepicker-month']    ${month_index}
    Select From List By Value    //select[@class='ui-datepicker-year']     ${year}

    Click Element    xpath=//td[@data-year="${year}" and @data-month="${month_index}"]/a[text()="${day}"]



