*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/FuelClusterResources.robot
Library    ../Libraries/ExcelLibrary.py
#Library    DataDriver    ../testdata/FuelTicketData.xlsx


*** Variables ***
${url}    https://stage.steadyoil.com/
${browser}    chrome
${EXCEL_PATH}    TestData/FuelTicketData.xlsx

*** Test Cases ***
Validate Login and Dashboard Tittle
    Launch Application    ${url}    ${browser}
    Login To Application
    Title Validation
#    Navigate To Create Fuel Ticket Page
# Navigate to ticket dispatch page
    Mouse Over    xpath://nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Click Element    xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[1]//a
#    click on fuel tab
    Click Element    xpath://*[@id="assign-ticket-submit"]/div[2]/div/div[1]/div[3]/a[2]
    Sleep    10s
#Read Excel and Print
#     ${data}=    Read Fuel Ticket Data    ${EXCEL_PATH}
#     Log To Console    ${data}
#
#Create Multiple Fuel Ticket
#    ${data}=    Read Fuel Ticket Data    ${EXCEL_PATH}
#    Log To Console    ${data}
#    Log    ${data}
#
#    ${index}=    Set Variable    1
#    FOR    ${ticket}    IN    @{data}
#        Navigate To Create Fuel Ticket Page
#        Log To Console    Creating Fuel Ticket ${index} for ${ticket['Customer Name']}
#        Create Single Fuel Ticket    ${ticket}
#        Validate success message for ticket creation
#        Validate Fuel Ticket Page Heading
#
#
#        ${index}=    Evaluate       ${index} + 1
#    END
#
#    Log To Console    All Tickets are created successfully
#    Validate Fuel Ticket Page Heading
#    Sleep    30s

Create Cluster Ticket
    Validate Fuel Ticket Page Heading
    Sleep     5s
    Click On Cluster Ticket
    Enter Cluster Ticket Name    Cluster_Brady_01
    Select Cluster Interval    5
    Scroll Main Page And Ticket List
    Select Last Two Cluster Checkboxes











#
#
#Create Cluster Ticket
#    Click Element    xpath://i[@id="arrow_menu_cluster"]
#    Click Button    xpath://a[@class="btn btn-success ticket_action"]
#    Input Text    id:cluster_name    Cluster_01
#    Select From List By Value    id:cluster_interval    5
#    Click Element    class:tab-content ticket-listing-wrap
#    Scroll Element Into View    class:ticket-legends


*** Keywords ***
