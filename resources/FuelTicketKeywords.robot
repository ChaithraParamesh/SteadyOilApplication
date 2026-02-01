*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Mouseover on FuelTickets menu
    Mouse over    xpath://nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span

Navigate to Ticket Dispatch
    Click Element    xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[1]/a

Navigate to Fuel Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a

Navigate to Propane Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[3]/a

Navigate to Wells Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[4]/a

Navigate to Rigs Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[5]/a

Navigate to Oil Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[6]/a

Navigate to Lng Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[7]/a

Navigate to Reservation Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[8]/a

Navigate to Oil Reservation Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[9]/a

Navigate to Ticket Approval Ticket
    Click Element     xpath://nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[10]/a