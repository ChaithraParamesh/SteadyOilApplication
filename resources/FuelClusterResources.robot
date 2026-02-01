*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${EXCEL_PATH}    ../TestData/FuelTicketData.xlsx

*** Keywords ***
Launch Application
    [Arguments]    ${url}=https://stage.steadyoil.com/    ${browser}=chrome
    Open browser     ${url}         ${browser}
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Set Selenium Timeout    10s


Login To Application
    Input Text         name:identity    admin@steadyoil.com
    Input Text     name:password      Pwd4so!l
    Click Button     xpath:/html/body/div/div/div/form/div[4]/button
    Wait Until Page Contains    Dashboard    5s

Title Validation
    ${title}=     Get Title
    Title Should Be     FuelLogix | FuelLogix Delivery System
    Log To Console     The Page title is:${title}
    Log    ${title}    

Navigate To Create Fuel Ticket Page
     Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
     Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a
     Wait Until Page Contains    Create Manual Fuel Ticket     5s
     Log To Console    Navigated to Create Manual Fuel Ticket Page

Read and Log Fuel Ticket Data
    ${data}=    Read Fuel Ticket Data    ${EXCEL_PATH}
    :FOR    ${row}    IN    @{data}
    \    Log To Console    Ticket Data: ${row}

Create Single Fuel Ticket
    [Arguments]    ${ticket}
# Select customer name from dropdown
#   open the dropdown
    Click Element    xpath://span[@id='select2-searchcompany-container']
#    Enter text in search field
    Input Text    xpath://input[contains(@class, 'select2-search__field')]    ${ticket["Customer Name"]}
#    Wait for the dropdown options to load and select the name
    Wait Until Element Is Visible    xpath://li[contains(text(), '${ticket["Customer Name"]}')]    timeout=5s
    Click Element    xpath=//li[contains(text(), '${ticket["Customer Name"]}')]

# Fill other fields
    Input Text    name:Site_name     ${ticket['SiteName']}
    Input Text    id:purchase_order    ${ticket['PO']}
    Input Text    id:caller_info    ${ticket['Caller Info']}
    Input Text     name:ticket_notes   ${ticket['Notes']}

# Scroll page till add button
    Scroll Element Into View    xpath://input[@id="add_list"]
    Sleep    1s
# Fuel details field
    Select From List By Value    xpath://select[@id="fuel_types"]    ${ticket['Fuel Type']}
    Input Text    id:tankssize    ${ticket['Gallons Estimated']}
    Input Text    id:fees_admin_manual    ${ticket['Fees']}
    Input Text    id:retail_cost_gallon    ${ticket['Retail Per Gallon']}
    Select From List By Value   id:discount    ${ticket['Discount']}
# Selecting terminal from dropdown
    Select From List By Value    id:fuel_class_terminal    ${ticket['Terminal']}
# Click add button
    Click Button    id:add_list
    Scroll Element Into View    id:Reset_ticket
    Sleep     3s
#    Validate the fuel details
    ${row_text}=    Get Text    xpath=//tbody[@class="deliData-list"]/tr
    Log To Console    ${row_text}
    Log    ${row_text}
#    Click submit button
    Click Button       id: submitmanualfuelBtn

Validate success message for ticket creation
    ${message}=    Get Text    xpath=//div[@class="alert alert_success"]/div
    Log To Console    Ticket message: ${message}
    Log    Ticket message: ${message}
    Should Be Equal As Strings    ${message}    Manual Ticket created successfully

Validate Fuel Ticket Page Heading
    Wait Until Page Contains Element    xpath=//h3[contains(text(), "Fuel Tickets")]    timeout=10s
    Element Should Contain    xpath=//h3    Fuel Tickets

Click on Cluster Ticket
    Click Element    xpath=//div[contains(@class, 'h_collpsable_menu') and contains(normalize-space(), 'Cluster Tickets')]
    Sleep    5s
    Click Element    xpath=//*[@id="assign-ticket-submit"]/div[2]/div/div[1]/div[2]/div[2]/div/a

Enter Cluster Ticket Name
    [Arguments]    ${cluster_name}
    Input Text    id=cluster_name    ${cluster_name}
    Log To Console    Cluster Name Entered:${cluster_name}

Select Cluster Interval
    [Arguments]    ${days}
    Select From List By Value    id:cluster_interval    ${days}
    Log To Console    Selected Interval: ${days} Days

#Scroll Main Page and Ticket List
#    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
#    Sleep    3s
#    Wait Until Element Is Visible    css:.ticket-listing-wrap    timeout=10s
#    Execute JavaScript    document.querySelector('.ticket-listing-wrap').scrollTop = document.querySelector('.ticket-listing-wrap').scrollHeight
#    Sleep     2s

Scroll Main Page And Ticket List
    [Documentation]    Scrolls the full main page and inner ticket list section.

    # Scroll the full main page to the bottom
    WHILE    True
        ${old_height}=    Execute JavaScript    return window.pageYOffset
        Execute JavaScript    window.scrollBy(0, 500)
        Sleep    0.3s
        ${new_height}=    Execute JavaScript    return window.pageYOffset
        Exit For Loop If    '${old_height}' == '${new_height}'
    END

    Sleep    1s

    #  Now scroll inside ticket list (tab content)
    Wait Until Element Is Visible    css:.ticket-listing-wrap    timeout=10s

    WHILE    True
        ${old_scroll}=    Execute JavaScript    return document.querySelector('.ticket-listing-wrap').scrollTop
        Execute JavaScript    document.querySelector('.ticket-listing-wrap').scrollBy(0, 200)
        Sleep    0.3s
        ${new_scroll}=    Execute JavaScript    return document.querySelector('.ticket-listing-wrap').scrollTop
        Exit For Loop If    '${old_scroll}' == '${new_scroll}'
    END

    Sleep    2s

Select Last Two Cluster Checkboxes
    ${checkboxes}=    Get WebElements    xpath=//input[@name="make_cluster_ticket"]
    ${total}=    Get Length    ${checkboxes}
    ${start}=    Evaluate    ${total} - 2
    Log To Console    Total Checkboxes: ${total}, Selecting last 2 starting from index ${start}

    FOR    ${i}    IN RANGE    ${start}    ${total}
        Log To Console    Clicking checkbox index: ${i}
        ${checkbox}=    Get WebElement    xpath=(//input[@name="make_cluster_ticket"])[${i + 1}]
        Execute JavaScript    arguments[0].scrollIntoView(true);    ${checkbox}
        Sleep    0.5s
        Click Element    ${checkbox}
    END


