*** Settings ***
Library     SeleniumLibrary
Library    Collections


*** Keywords ***
Navigate to Oil Ticket Page
    [Documentation]    Navigate to the Create Manual Fuel Ticket page from sidebar
    Mouse Over     //nav[@id="main-sidebar"]/section/ul/li[6]/a/i/span
    Wait Until Element Is Visible     xpath=//nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[2]/a    5s
    Click Element    //nav[@id="main-sidebar"]/section/ul/li[6]/ul/li[6]/a
    Wait Until Page Contains    Create Manual Fuel Ticket     10s
    Log To Console    Navigated to Create Manual Fuel Ticket Page

Select Customer
    [Arguments]    ${customer_name}
    Click Element     xpath=//span[@id='select2-oil_customer_name-container']
    Input Text        xpath=//input[contains(@class, 'select2-search__field')]     ${customer_name}
    Click Element     xpath=//li[contains(text(), "${customer_name}")]
    Sleep    1s

Select Rig Name
    [Arguments]    ${rig_name}
    Wait Until Element Is Visible    id:rig_name    timeout=10s
    Input Text                       id:rig_name    ${rig_name}
    Wait Until Element Is Visible
    ...    xpath=//div[contains(@id,'autocomplete') and normalize-space()='${rig_name}']
    ...    timeout=10s
    Click Element
    ...    xpath=//div[contains(@id,'autocomplete') and normalize-space()='${rig_name}']

Select Operator Name
    [Arguments]    ${operator_name}
    Wait Until Element Is Visible    id:search_operator_oil    timeout=10s
    Clear Element Text               id:search_operator_oil
    Input Text                       id:search_operator_oil    ${operator_name}

    Wait Until Element Is Visible
    ...    xpath=//div[@id='search_operator_oilautocomplete-list']//div[.//input[@value='${operator_name}']]
    ...    timeout=10s
    Wait Until Keyword Succeeds    5x    1s
    ...    Click Element
    ...    xpath=//div[@id='search_operator_oilautocomplete-list']//div[.//input[@value='${operator_name}']]


Select Well name 
    [Arguments]    ${well_name}
    Wait Until Element Is Visible    id:wells_name_oil    timeout=10s
    Clear Element Text               id:wells_name_oil
    Input Text                       id:wells_name_oil    ${well_name}
    Wait Until Element Is Visible    
    ...    xpath=//div[@id='wells_name_oilautocomplete-list']//div[.//input[@value='${well_name}']]
    ...    timeout=10s
    Wait Until Keyword Succeeds    5x    1s
    ...    Click Element    
    ...    xpath=//div[@id='wells_name_oilautocomplete-list']//div[.//input[@value='${well_name}']]


Select Tank
    [Documentation]    Select any tank from dropdown using visible text
    [Arguments]    ${tank_name}
    Wait Until Element Is Visible    id=tank_name_data    timeout=10s
    Select From List By Label        id=tank_name_data    ${tank_name}

Select Tank If Exists
    [Arguments]    ${tank_name}
    ${options}=    Get List Items    id=tank_name_data
    Should Contain    ${options}    ${tank_name}
    Select From List By Label    id=tank_name_data    ${tank_name}

Enter Other Ticket Details
    [Documentation]    Enter oil ticket input fields dynamically
    [Arguments]        &{ticket_data}

    FOR    ${locator}    ${value}    IN    &{ticket_data}
        Wait Until Element Is Visible    ${locator}    timeout=10s
        Input Text                       ${locator}    ${value}
        Log To Console                   Entered ${value} into ${locator}
    END


Enter Other Details Inputs
    &{ticket_data}=    Create Dictionary
    ...    purchase_order=8845
    ...    caller_information=Roman@5563
    ...    site_name=WatfordCity
    ...    fees_admin_oil=15
    ...    oil_ticket_notes=ticket for oil product

    Enter Other Ticket Details    &{ticket_data}

Scroll To Element
    [Documentation]    Scroll any element into view dynamically
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Scroll Element Into View         ${locator}

Scroll And Click Element
    [Documentation]    Scroll to element and click safely
    [Arguments]        ${locator}

    Wait Until Page Contains Element    ${locator}    timeout=10s
    Scroll Element Into View            ${locator}
    Wait Until Element Is Enabled       ${locator}    timeout=10s
    Click Element                       ${locator}

Select Product
    [Documentation]    Select product from dropdown
    [Arguments]    ${locator}    ${value}
    Select From List By Label    ${locator}    ${value}
    
Go To Product Pagination Page
    [Documentation]    Navigate to a specific product pagination page
    [Arguments]    ${page_number}
    Wait Until Element Is Visible
    ...    xpath=//div[@id='pagination_product_list_buttons']
    ...    timeout=10s
    ${is_visible}=    Run Keyword And Return Status
    ...    Page Should Contain Element    
    ...    xpath=//div[@id='pagination_product_list_buttons']//button[normalize-space()='${page_number}']

    WHILE    '${is_visible}' == 'False'
        Click Element
        ...    xpath=//div[@id='pagination_product_list_buttons']//button[contains(@class,'next') or normalize-space()='>']
        Sleep    500ms
        ${is_visible}=    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    xpath=//div[@id='pagination_product_list_buttons']//button[normalize-space()='${page_number}']
    END

    Click Element
    ...    xpath=//div[@id='pagination_product_list_buttons']//button[normalize-space()='${page_number}']
    Wait Until Element Is Visible
    ...    xpath=//tbody[@id='product_table_list_body']/tr
    ...    timeout=10s
    Log To Console    Navigated to product page ${page_number}

Select Product From Current Page By Index
    [Documentation]    Select product from current page using index
    [Arguments]    ${product_index}

    Wait Until Element Is Visible
    ...    xpath=//tbody[@id='product_table_list_body']/tr[${product_index}]
    ...    timeout=10s

    Scroll Element Into View
    ...    xpath=//tbody[@id='product_table_list_body']/tr[${product_index}]

    Click Element
    ...    xpath=//tbody[@id='product_table_list_body']/tr[${product_index}]//button[contains(@class,'add-row-main')]

    Log To Console    Selected product index ${product_index}

Select Product From Current Page By Name
    [Documentation]    Select product using product name
    [Arguments]    ${product_name}

    Wait Until Element Is Visible
    ...    xpath=//tbody[@id='product_table_list_body']//td[normalize-space()='${product_name}']
    ...    timeout=10s

    Scroll Element Into View
    ...    xpath=//tbody[@id='product_table_list_body']//td[normalize-space()='${product_name}']

    Click Element
    ...    xpath=//tbody[@id='product_table_list_body']//td[normalize-space()='${product_name}']/preceding-sibling::td[2]//button

    Log To Console    Selected product ${product_name}

#Verify Product Pagination Page Active
#    [Documentation]    Verify the active pagination page using class attribute
#    [Arguments]    ${page_number}
#    ${class}=    Get Element Attribute
#    ...    xpath=//div[@id='pagination_product_list_buttons']//button[normalize-space()='${page_number}']
#    ...    class
#    Should Contain    ${class}    active
#    Log To Console    Verified page ${page_number} is active

Verify Product Pagination Page Active
    [Arguments]    ${page_number}
    ${class}=    Get Element Attribute    xpath=//button[normalize-space()='${page_number}']    class
    Should Contain    ${class}    active

Click Save Added Product Button
    [Documentation]    Click Save button in Add Product modal
    Wait Until Element Is Visible
    ...    xpath=//button[contains(@class,'save_added_pro_in_sess')]
    ...    timeout=10s
    Wait Until Element Is Enabled
    ...    xpath=//button[contains(@class,'save_added_pro_in_sess')]
    ...    timeout=10s
    Click Element
    ...    xpath=//button[contains(@class,'save_added_pro_in_sess')]
    Log To Console    Clicked Save Added Product button

Verify Product Modal Closed
    Wait Until Element Is Not Visible
    ...    xpath=//button[contains(@class,'save_added_pro_in_sess')]
    ...    timeout=10s

Log Added Oil Products
    [Documentation]    Logs all added oil products from ticket table to console and report

    Wait Until Element Is Visible
    ...    xpath=//tbody[contains(@class,'oil_ticket_data_list')]/tr
    ...    timeout=15s

    ${rows}=    Get WebElements
    ...    xpath=//tbody[contains(@class,'oil_ticket_data_list')]/tr
    ${count}=   Get Length    ${rows}

    Should Be True    ${count} > 0    No oil products found in added product list

    Log               ====== Added Oil Products ======
    Log To Console    ====== Added Oil Products ======

    FOR    ${index}    IN RANGE    1    ${count + 1}
        ${id}=        Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[1]
        ${qty}=       Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[2]
        ${product}=   Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[3]
        ${size}=      Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[4]
        ${uom}=       Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[5]
        ${package}=   Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[6]
        ${retail}=    Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[7]
        ${cost}=      Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[8]
        ${discount}=  Get Text    xpath=(//tbody[contains(@class,'oil_ticket_data_list')]/tr)[${index}]/td[9]

        ${line}=    Set Variable
        ...    ID:${id} | Qty:${qty} | Product:${product} | Size:${size} | UOM:${uom} | Package:${package} | Retail:${retail} | Cost:${cost} | Discount:${discount}

        Log               ${line}
        Log To Console    ${line}
    END


Click Create Oil Ticket Button
    [Documentation]    Click Create Ticket button to submit oil ticket

    Wait Until Element Is Visible    id=oil_save    timeout=10s
    Wait Until Element Is Enabled    id=oil_save    timeout=10s

    Scroll Element Into View         id=oil_save
    Click Element                   id=oil_save

    Log To Console    Clicked Create Ticket button

Log Oil Ticket Success
    [Arguments]    ${ticket_id}
    ${msg}=    Set Variable    [PASS] Rig Oil Ticket created successfully | Ticket ID: ${ticket_id}
    Log               ${msg}
    Log To Console    ${msg}
