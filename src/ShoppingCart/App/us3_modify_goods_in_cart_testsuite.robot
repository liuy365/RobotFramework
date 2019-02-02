*** Settings ***
Suite Setup       Open Cart Page
Resource          app_resource.robot
Library           String

*** Variables ***

*** Test Cases ***
Edit Goods Amount And Check Total Cost
    [Setup]    Edit Number Setup
    Wait And Click Element    ${ADD_BTN_ID}
    Check Goods Sum Is Correct Or Not
    Wait And Click Element    ${MINUS_BTN_ID}
    Check Goods Sum Is Correct Or Not
    Change Goods Number To    10
    Check Goods Sum Is Correct Or Not
    Change Goods Number To    1
    Check Goods Sum Is Correct Or Not
    [Teardown]    Edit Number Teardown

*** Keywords ***
Edit Number Setup
    ${price}    Get Price    ${PRICE_TEXT_ID}
    Set Suite Variable    ${price}    #保存价格供其它关键字使用。
    ${checked}    Get Element Attribute    ${CHECKBOX_ID}    checked
    Run Keyword If    '${checked}'=='false'    Click Element    ${CHECKBOX_ID}
    Click Element    ${EDIT_BTN_ID}

Edit Number Teardown
    ${checked}    Get Element Attribute    ${CHECKBOX_ID}    checked
    Run Keyword If    '${checked}'=='true'    Click Element    ${CHECKBOX_ID}
    Click Element    ${FINISH_BTN_XPATH}

Check Goods Sum Is Correct Or Not
    Sleep    1
    ${amount}    Get Element Attribute    ${AMOUNT_TEXT_ID}    text
    ${total_sum}    Get Price    ${TOTAL_COST_ID}
    ${expect_total_sum}    Evaluate    ${amount} * ${price}
    Should Be Equal As Numbers    ${total_sum}    ${expect_total_sum}    precision=2

Get Price
    [Arguments]    ${textview_id}
    ${price}    Get Element Attribute    ${textview_id}    text
    ${price}    Remove String    ${price}    ￥
    [Return]    ${price}

Change Goods Number To
    [Arguments]    ${number}
    Wait And Click Element    ${AMOUNT_TEXT_ID }
    Wait Until Page Contains Element    ${POPUP_AMOUNT_TEXT_ID}
    Clear Text    ${POPUP_AMOUNT_TEXT_ID}
    Input Text    ${POPUP_AMOUNT_TEXT_ID}    ${number}
    Click Element    ${POPUP_OK_ID}
    sleep    1
