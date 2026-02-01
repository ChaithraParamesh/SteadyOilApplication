*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/LoginResources.robot

*** Test Cases ***
TC1 Verify User Can Login Successfully
    [Documentation]    Launch the application, login, and validate title + success message.
    Launch Application
    Login To Application
    Title Validation
    Login Success Message Validation

TC 2 Verify User Can Logout Successfully
    [Documentation]    After login, log out and validate logout success message.
    Launch Application
    Login To Application
    Logout From Application


