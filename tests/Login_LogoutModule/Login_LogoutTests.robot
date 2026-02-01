*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/Login_LogoutKeywords.robot
Test Setup       Launch Application
Test Teardown    Close Browser

*** Test Cases ***
# ======================
# Positive Scenarios
# ======================
TC1 Verify Successful Login
    [Documentation]    Verify login with valid credentials.
    [Tags]    positive    login
    Login To Application
    Login Success Message Validation
    Title Validation
    Page Should Contain    Dashboard

TC2 Verify User Can Logout Successfully
    [Documentation]    Verify logout after successful login.
    [Tags]    positive    logout
    Login To Application
    Logout From Application

## ======================
## Negative Scenarios
## ======================
TC3 Verify Login With Empty Username
    [Documentation]    Verify error when username field is empty.
    [Tags]    negative    validation
    Input Text    ${USERNAME_INPUT}    ${EMPTY}
    Input Text    ${PASSWORD_INPUT}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Run Keyword And Continue On Failure    Validate Username Error
    Log To Console    \n[PASS] Username error validation displayed.
    Fail    Negative test executed successfully, marking as FAIL intentionally

TC4 Verify Login With Empty Password
    [Documentation]    Verify error when password is empty.
    [Tags]    negative    validation
    Input Text    ${USERNAME_INPUT}    ${USERNAME}
    Input Text    ${PASSWORD_INPUT}    ${EMPTY}
    Click Button    ${LOGIN_BUTTON}
    Run Keyword And Continue On Failure    Validate Password Error
    Log To Console    \n[PASS] Password error validation displayed.
    Fail    Negative test executed successfully, marking as FAIL intentionally

TC5 Verify Login With Empty Username And Password
    [Documentation]    Verify error when both username and password are empty.
    [Tags]    negative    validation
    Input Text    ${USERNAME_INPUT}    ${EMPTY}
    Input Text    ${PASSWORD_INPUT}    ${EMPTY}
    Click Button    ${LOGIN_BUTTON}
    Run Keyword And Continue On Failure    Validate Username Error
    Run Keyword And Continue On Failure    Validate Password Error
    Log To Console    \n[PASS] Both username and password error validations displayed.
    Fail    Negative test executed successfully, marking as FAIL intentionally

TC6 Verify Login With Invalid Username
    [Documentation]    Verify error when login is attempted with invalid username.
    [Tags]    negative    validation
    Input Text    ${USERNAME_INPUT}    invalid@user.com
    Input Text    ${PASSWORD_INPUT}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Run Keyword And Continue On Failure    Validate Invalid Credentials Error
    Log To Console    \n[PASS] Invalid username error validation displayed.
    Fail    Negative test executed successfully, marking as FAIL intentionally

TC7 Verify Login With Invalid Password
    [Documentation]    Verify error when login is attempted with invalid password.
    [Tags]    negative    validation
    Input Text    ${USERNAME_INPUT}    ${USERNAME}
    Input Text    ${PASSWORD_INPUT}    WrongPass123
    Click Button    ${LOGIN_BUTTON}
    Run Keyword And Continue On Failure    Validate Invalid Credentials Error
    Log To Console    \n[PASS] Invalid password error validation displayed.
    Fail    Negative test executed successfully, marking as FAIL intentionally






