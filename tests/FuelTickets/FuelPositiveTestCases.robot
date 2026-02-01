*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/Login_LogoutKeywords.robot
Resource    ../../resources/FuelTicketKeywords.robot
Resource    ../../resources/FuelKeywords.robot
Resource    ../../resources/CommonKeywords.robot


*** Test Cases ***
TC1 Create Fuel Ticket for ND state
    [Documentation]    Create a fuel ticket, fetch the last ticket ID dynamically, and then drag it.
    [Tags]    Positive Fuel Ticket
    # Step 1: Create the ticket
    Launch Application
    Login To Application
    Mouseover On FuelTickets Menu
    Navigate To Fuel Ticket
    Validate And Print Fuel Ticket Page Heading
    Select Customer     Lund Brady
    Fill Common Fields    North    1234    8545633    100 gallons
    Scroll Element Into View    id:fuel_class_name
#    Select Fuel Type    1
#    Select Fuel Type    2
#    Select Fuel Type    3
#    Select Fuel Type    4
    Select Fuel Type    Premium NL
#    Select Fuel Type    Regular NL
#    Select Fuel Type    Premium NL
#    Select Fuel Type    Methanol
#    Select Fuel Type    Kerosene
    Fill Fuel Details
    Click Submit Button
#    Validate Success Message For Ticket Creation
    Validate Fuel Ticket Page Heading

    ${latest_ticket_id}=    Get Latest Ticket ID
    Log To Console     Final latest ticket id = ${latest_ticket_id}





Test Dictionary Access
    ${dict}=    Create Dictionary    key1=value1    key2=value2
    ${val}=     Get From Dictionary    ${dict}    key1
    Log To Console    Retrieved: ${val}
