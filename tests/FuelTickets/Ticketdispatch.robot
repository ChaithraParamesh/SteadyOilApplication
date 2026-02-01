*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
#Library    ../resources/CustomKeywords.py
#Resource    ../resources/TruckAssignmentsresources.robot


*** Variables ***
${BROWSER}        Chrome
${URL}            https://stage.steadyoil.com/
${TAB_WRAPPER}    css:div.tab-wrapper.white-wrapper
${SCREENSHOT_DIR}    ./screenshots
${ticket_id}    34415
${truck_id}     36
${TICKET_CONTAINER}    xpath=//div[@class='tickets-list']
*** Test Cases ***
Scroll Outer Container And Assign Ticket
    [Documentation]    Logs in, scrolls outer container, assigns ticket to truck, captures screenshots.

    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Login To Application
    Wait Until Page Contains    Dashboard    10s

    # Navigate to Ticket Dispatch
    Mouse Over    //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[1]/a
    Wait Until Page Contains Element    xpath=//h3[contains(text(),"Fuel Tickets")]    10s

#    # Scroll outer tab
    Scroll Outer Tab With Keys    ${TAB_WRAPPER}    4
    Capture Page Screenshot    ${SCREENSHOT_DIR}/outer_tab_scroll.png
#Scroll Outer Tab With Keys    ${OUTER_TAB}    4
#    Log    Outer tab scrolled successfully
#    Drag Ticket To Truck    ${ticket_id}    ${truck_id}
#    Verify Ticket Assigned    ${ticket_id}    ${truck_id}
Assign New Ticket To Truck
    [Documentation]    Click last ticket, get ticket ID, drag to truck, verify assignment
    ${ticket_id}    Select Last Ticket
    ${truck_id}     Set Variable    36
    Drag Ticket To Truck    ${ticket_id}    ${truck_id}
    Verify Ticket Assigned    ${ticket_id}    ${truck_id}


#
#    # Assign ticket to truck
#    ${ticket_id}=    Set Variable    34630
#    ${truck_id}=     Set Variable    36
#    ${ticket_locator}=    Set Variable    //*[@id="drag1_${ticket_id}"]
#    ${truck_locator}=     Set Variable    //*[@id="whole_${truck_id}"]
#
#    Drag And Drop Ticket    ${ticket_locator}    ${truck_locator}
#    Capture Page Screenshot    ${SCREENSHOT_DIR}/ticket_assigned_${ticket_id}_to_${truck_id}.png
#
#    Close Browser

*** Keywords ***
Login To Application
    Input Text    name:identity    admin@steadyoil.com
    Input Text    name:password    Pwd4so!l
    Click Button    xpath=/html/body/div/div/div/form/div[4]/button
    Wait Until Page Contains Element    xpath=//nav[@id="main-sidebar"]    10s

Scroll Outer Tab With Keys
    [Arguments]    ${locator}    ${times}=1
    Click Element    ${locator}
    FOR    ${i}    IN RANGE    ${times}
        Press Keys    ${locator}    PAGE_DOWN
        Sleep    0.5s
    END

#
Select Last Ticket
    # Step 1: Wait for ticket list to have at least one row
    Wait Until Keyword Succeeds    20s    1s    Element Should Exist    ${TICKET_CONTAINER}//div[contains(@class,'ticket-row')]

    # Step 2: Get the last ticket row
    ${ticket_row}    Set Variable    ${TICKET_CONTAINER}//div[contains(@class,'ticket-row')][last()]

    # Step 3: Scroll into view and click to reveal ticket ID
    Scroll Element Into View    ${ticket_row}
    Click Element               ${ticket_row}

    # Step 4: Get ticket ID from the clicked row
    ${ticket_id}    Get Text    xpath=${ticket_row}//span[contains(@class,'ticket-id')]
    Log    Selected Ticket ID: ${ticket_id}
    RETURN    ${ticket_id}

Drag Ticket To Truck
     [Arguments]    ${ticket_id}    ${truck_id}
    ${ticket}    Set Variable    xpath=//div[text()='${ticket_id}']
    ${truck}     Set Variable    xpath=//div[text()='${truck_id}']
    Scroll Element Into View    ${ticket}
    Wait Until Element Is Visible    ${ticket}    10s
    Drag And Drop    ${ticket}    ${truck}
    Log    Ticket ${ticket_id} assigned to Truck ${truck_id}
Verify Ticket Assigned
    [Arguments]    ${ticket_id}    ${truck_id}
    ${ticket_in_truck}    Get Text    xpath=//div[text()='${truck_id}']//following-sibling::div[text()='${ticket_id}']
    Should Be Equal    ${ticket_in_truck}    ${ticket_id}



##    Scroll Outer Tab Using Keys
#    ${OUTER_TAB}=    Set Variable    css:div.tab-wrapper.white-wrapper
#
#    # Scroll outer tab down twice
#    Scroll Outer Tab With Keys    ${OUTER_TAB}    4
#    Capture Page Screenshot     /screenshots/outer_tab_scroll.png

##    assign ticket to truck
#    Wait Until Page Contains Element    xpath=//a[@ticket_id='34076']
#    Assign Ticket To Truck    34076    1_36
#    Sleep    2s
#    Capture Page Screenshot

#     # Scroll outer tab up once
#    Scroll Outer Tab Page Up    ${OUTER_TAB}    3
#    Capture Page Screenshot     /screenshots/outer_tab_scroll.png

#    Assign Ticket To Truck    34630    36
#Assign Ticket To Truck
#    [Arguments]    ${ticket_id}    ${truck_id}
#    ${ticket_locator}=    Set Variable    //*[@id="drag1_${ticket_id}"]
#    ${truck_locator}=     Set Variable    //*[@id="whole_${truck_id}"]
#
#    Log    Assigning ticket ${ticket_id} to truck ${truck_id}
#    Drag And Drop Ticket    ${ticket_locator}    ${truck_locator}
#    Capture Page Screenshot    ticket_assigned_${ticket_id}_to_${truck_id}.png

#*** Keywords ***
#Login To Application
#    Input Text    name:identity    admin@steadyoil.com
#    Input Text    name:password    Pwd4so!l
#    Click Button    xpath=/html/body/div/div/div/form/div[4]/button
#
#
#Scroll Outer Tab With Keys
#    [Arguments]    ${locator}    ${times}=1
#    Click Element    ${locator}    # ensure the container has focus
#    FOR    ${i}    IN RANGE    ${times}
#        Press Keys    ${locator}    PAGE_DOWN
#        Sleep    0.5s
#    END
#
#Scroll Outer Tab Page Up
#    [Arguments]    ${locator}    ${times}=1
#    Click Element    ${locator}
#    FOR    ${i}    IN RANGE    ${times}
#        Press Keys    ${locator}    PAGE_UP
#        Sleep    0.5s
#    END
#
#Assign Ticket To Truck
#    [Arguments]    ${ticket_id}    ${truck_id}
#    ${ticket_locator}=    Set Variable    //*[@id="drag1_${ticket_id}"]
#    ${truck_locator}=     Set Variable    //*[@id="whole_${truck_id}"]
#
#    Log    Assigning ticket ${ticket_id} to truck ${truck_id}
#
#    # Wait until elements are visible
#    Wait Until Element Is Visible    ${ticket_locator}    5s
#    Wait Until Element Is Visible    ${truck_locator}    5s
#
#    # Use built-in Robot Framework Drag And Drop
#    Drag And Drop    ${ticket_locator}    ${truck_locator}
#    Capture Page Screenshot    ${SCREENSHOT_DIR}/ticket_assigned_${ticket_id}_to_${truck_id}.png
#
#
#
#
#
##Assign Ticket To Truck
##    [Arguments]    ${ticket_id}    ${truck_id}
##    ${ticket_locator}=    Set Variable    //div[@id="ticket-${ticket_id}"]
##    ${truck_locator}=     Set Variable    //div[@id="whole_${truck_id}"]
##
##    Log    Assigning ticket ${ticket_id} to truck ${truck_id}
##
##    ${js}=    Set Variable    """function triggerDragAndDrop(selectorDrag, selectorDrop) {
##        var dragElem = document.evaluate(selectorDrag, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
##        var dropElem = document.evaluate(selectorDrop, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
##        if (!dragElem || !dropElem) { return false; }
##        var dataTransfer = new DataTransfer();
##        var dragStartEvent = new DragEvent('dragstart', { dataTransfer: dataTransfer });
#        dragElem.dispatchEvent(dragStartEvent);
#        var dropEvent = new DragEvent('drop', { dataTransfer: dataTransfer });
#        dropElem.dispatchEvent(dropEvent);
#        var dragEndEvent = new DragEvent('dragend', { dataTransfer: dataTransfer });
#        dragElem.dispatchEvent(dragEndEvent);
#        return true;
#    }
#    return triggerDragAndDrop("${ticket_locator}", "${truck_locator}");"""
#
#    Execute Javascript    ${js}
#    Capture Page Screenshot    ticket_assigned_${ticket_id}_to_${truck_id}.png
