*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}       https://stage.steadyoil.com/
${BROWSER}   chrome
${USERNAME}  admin@steadyoil.com
${PASSWORD}  Pwd4so!l
${TITLE}       FuelLogix | FuelLogix Delivery System
${SUCCESS_LOGIN_MSG}     Logged In Successfully
${SUCCESS_LOGOUT_MSG}    Logged Out Successfully

${USERNAME_INPUT}    id=identity
${PASSWORD_INPUT}    id=userpass
${LOGIN_BUTTON}  xpath=//button[normalize-space(text())="Login"]
${LOGOUT_BUTTON}  xpath=//a[contains(@class,"btn-success") and contains(text(),"Sign out")]

${USERNAME_ERROR}        The Email/Username field is required.
${PASSWORD_ERROR}        The Password field is required.
${INVALID_CREDENTIALS}   Incorrect Login

*** Keywords ***
Launch Application
    [Arguments]    ${url}=${URL}    ${browser}=${BROWSER}
    Open browser     ${url}         ${browser}
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Set Selenium Timeout    10s

Login To Application
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Wait Until Element Is Visible    ${USERNAME_INPUT}    10s
    Input Text    ${USERNAME_INPUT}    ${username}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Dashboard    10s

Login Success Message Validation
    Wait Until Page Contains    Logged In Successfully    20s
    Log To Console    Login success message verified

Title Validation
    ${title}=     Get Title
    Should Be Equal As Strings    ${title}    ${TITLE}
    Log To Console     The Page title is:${title}
    Log    ${title}

Logout From Application
    Click Element    xpath=//a[contains(@class,"btn-success") and contains(text(),"Sign out")]
    Wait Until Element Is Visible    xpath=//div[@id="infoMessage"]/p    10s
    ${logout_msg}=    Get Text    xpath=//div[@id="infoMessage"]/p
    Should Be Equal As Strings    ${logout_msg}    Logged Out Successfully
    Log To Console    The Logout message is: ${logout_msg}
    Log    ${logout_msg}

Validate Username Field
    Element Should Be Visible    name:identity
    Element Should Be Enabled    name:identity
    Log To Console    Username field validation passed.

Validate Password Field
    Element Should Be Visible    name:password
    Element Should Be Enabled    name:password
    Log To Console    Password field validation passed.

Validate Login Button
    Element Should Be Visible    xpath=//button[normalize-space(text())="Login"]
    Element Should Be Enabled    xpath=//button[normalize-space(text())="Login"]
    Log To Console    Login button validation passed.

Validate Username Error
    [Documentation]    Validate error when username field is empty.
    Wait Until Element Is Visible    xpath=//p[contains(text(),"Email/Username") or contains(text(),"Username")]    5s
    ${error_text}=    Get Text    xpath=//p[contains(text(),"Email/Username") or contains(text(),"Username")]
    Log To Console    \n[INFO] Username error displayed: ${error_text}
    Log      ${error_text}
    Should Be Equal As Strings    ${error_text}    ${USERNAME_ERROR}    msg=Expected '${USERNAME_ERROR}' but got: ${error_text}


Validate Password Error
    [Documentation]    Validate error when password field is empty.
    Wait Until Element Is Visible    xpath=//p[contains(text(),"Password")]    5s
    ${error_text}=    Get Text    xpath=//p[contains(text(),"Password")]
    Log To Console    Password error displayed: ${error_text}
    Should Be Equal As Strings     ${error_text}    ${PASSWORD_ERROR}    msg=Expected '${PASSWORD_ERROR}' but got: ${error_text}

Validate Invalid Credentials Error
    [Documentation]    Validate error when login fails with invalid username or password.
    Wait Until Element Is Visible    xpath=//p[contains(text(),"Incorrect Login")]    5s
    ${error_text}=    Get Text    xpath=//p[contains(text(),"Incorrect Login")]
    Log To Console    \n[INFO] Invalid credentials error displayed: ${error_text}
    Should Be Equal As Strings    ${error_text}    ${INVALID_CREDENTIALS}    msg=Expected '${INVALID_CREDENTIALS}' but got: ${error_text}
    Run Keyword And Continue On Failure    Should Contain    ${error_text}    Incorrect Login
    ...    msg=Expected 'Incorrect Login' but got: ${error_text}
    Log    [PASS] Negative test passed - Correct invalid credentials error: ${error_text}
    Log    [FAIL] Negative test failed - Invalid credentials error mismatch: ${error_text}



