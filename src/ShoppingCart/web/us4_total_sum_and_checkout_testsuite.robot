*** Settings ***
Documentation     US4：作为顾客，当选中购物车中的商品时，在页面上能显示商品总价和进入收银台入口，以便根据商品总价决定选择哪些商品进入收银台。
Suite Setup       Clear All Checkbox
Resource          web_resource.robot
Library           ${CURDIR}/lib/GetGoodsItemsLib
Library           String

*** Test Cases ***
All Goods Are Not Checked
    [Documentation]    动作 | \ \ \ 期望结果
    ...    打开购物车页面 | \ \ \ 在每个商品旁有个复选框，默认全不选中。
    @{elements}    Get WebElements    ${GOODS_LIST_XPATH}
    : FOR    ${element}    IN    @{elements}
    \    ${content}    Get Element Attribute    ${element}    innerHTML
    \    Goods Should Not Be Checked    ${content}

Check Sum For All Checked Goods
    [Documentation]    动作:
    ...    勾选某些商品或全部商品
    ...
    ...    期望结果:
    ...    1. 能显示所有已选商品的总价。金额要正确。
    ...    2. 在金额旁点击“结算” 按钮能进入收银台页面。
    : FOR    ${i}    IN RANGE    1    4
    \    ${element_id}    Replace String    ${FIRST_ORDER_CHECKBOX_XPATH}    [1]    [${i}]
    \    Click Element    ${element_id}
    \    Sleep    1
    ${sum_calculate}    Get Sum For Goods
    ${sum_on_page}    Get Sum On Page
    Should Be Equal As Numbers    ${sum_calculate}    ${sum_on_page}    precision=2

*** Keywords ***
Goods Should Not Be Checked
    [Arguments]    ${element_src}
    &{items}    Get Goods Items    ${element_src}
    Log Many    &{items}
    Should Be Equal As Strings    &{items}[chk]    not_checked

Get Sum For Goods
    @{elements}    Get WebElements    ${GOODS_LIST_XPATH}
    ${sum_all}    Set Variable    ${0}
    : FOR    ${element}    IN    @{elements}
    \    ${content}    Get Element Attribute    ${element}    innerHTML
    \    &{items}    Get Goods Items    ${content}
    \    ${check_box}    Set Variable    &{items}[chk]
    \    Continue For Loop If    '${check_box}' == 'not_checked'
    \    ${sum}    Set Variable    &{items}[sum]
    \    ${sum_all}    Evaluate    ${sum_all}+ ${sum}
    [Return]    ${sum_all}

Get Sum On Page
    ${sum_on_page}    Get Text    ${TOTAL_PAY}
    ${sum_on_page}    Strip String    ${sum_on_page}
    ${sum_on_page}    Get Substring    ${sum_on_page}    1
    [Return]    ${sum_on_page}

Clear All Checkbox
    ${chk_class}    Get Element Attribute    ${CHECKBOX_TOTAL_XPATH}    class
    ${status}    ${value} =    Run Keyword And Ignore Error    Should Contain    ${chk_class}    cart-checkbox-checked
    Run Keyword If    '${status}' == 'PASS'    Click Element    ${CHECKBOX_TOTAL_XPATH}
    Run Keyword Unless    '${status}' == 'PASS'    Click Element    ${CHECKBOX_TOTAL_XPATH}
    sleep    1
    Run Keyword Unless    '${status}' == 'PASS'    Click Element    ${CHECKBOX_TOTAL_XPATH}
    sleep    1
