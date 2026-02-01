*** Settings ***
Library         SeleniumLibrary
Resource    resources/Login_LogoutKeywords.robot
Resource    resources/SendToTerminalResources.robot



*** Test Cases ***
TC 1 Create SendTo Terminal Ticket
    Launch Application
    Login To Application
    Title Validation
    Navigate To Create Fuel Ticket Page
    Select Customer
    Fill Other Fields
    Fill Fuel Details
    Select Truck
    Select Send To Terminal
    Add Fuel
    Create Ticket




