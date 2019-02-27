*** Settings ***
Documentation     US3：作为顾客，当浏览购物车页面时，我能随时修改商品数量或将它移出购物车，以便根据需要增加或减少所选择的商品。
Suite Setup       Open Cart Page
Test Setup        Edit Number Setup
Test Teardown     Edit Number Teardown
Resource          app_resource.html
Library           String

*** Variables ***

*** Test Cases ***
Edit Goods Amount And Check Money Sum
    [Documentation]    动作:
    ...    点击商品数量旁的“+”，“-”或直接修改数量；
    ...
    ...    期望结果：
    ...    购物车的总价将作相应的调整。
    Wait And Click Element    ${ADD_BTN_ID}
    Check Goods Sum Is Correct Or Not
    Wait And Click Element    ${MINUS_BTN_ID}
    Check Goods Sum Is Correct Or Not
    Change Goods Number To    10
    Check Goods Sum Is Correct Or Not
    Change Goods Number To    1
    Check Goods Sum Is Correct Or Not

Invalid Amount Input
    [Template]    Check Invalid Amount Input
    -2    2
    -1    1
    0    1
    2.5    25
    2147483648    25
    a    25
    1    1

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

Change Goods Number To
    [Arguments]    ${number}
    Wait And Click Element    ${AMOUNT_TEXT_ID }
    Wait Until Page Contains Element    ${POPUP_AMOUNT_TEXT_ID}    #等待修改数量的窗口弹出
    Clear Text    ${POPUP_AMOUNT_TEXT_ID}    #输入数字前先清除老的数字
    Input Text    ${POPUP_AMOUNT_TEXT_ID}    ${number}
    Click Element    ${POPUP_OK_ID}
    sleep    1    #稍等一下等待返回购物车页面。

Check Invalid Amount Input
    [Arguments]    ${input_value}    ${expected_value}
    Change Goods Number To    ${input_value}
    ${amount}    Get Element Attribute    ${AMOUNT_TEXT_ID}    text
    Should Be Equal As Integers    ${amount}    ${expected_value}
