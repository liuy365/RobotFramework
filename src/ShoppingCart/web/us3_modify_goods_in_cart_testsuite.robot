*** Settings ***
Documentation     US3：作为顾客，当浏览购物车页面时，我能随时修改商品数量或将它移出购物车，以便根据需要增加或减少所选择的商品。
Suite Setup       Open Cart Page
Resource          web_resource.robot
Library           ${CURDIR}/lib/GetGoodsItemsLib

*** Test Cases ***
Goods Number Can Be Increase
    [Documentation]    动作：
    ...    点击数量旁边的+号
    ...
    ...    期望结果：
    ...    商品数量每点一次加一个，金额相应增加。
    ${amount1}    Check Amount and Sum    #检查并计算商品金额=单价*数量
    Click Goods Modification Button    ${FIRST_ORDER_PLUS_XPATH}    #我们用xpath定位到第一个商品里的“+”号
    ${amount2}    Check Amount and Sum    #根据新的数量重新计算和检查商品金额
    ${value}    Evaluate    ${amount2}-${amount1}    #取得每点一次加后数量增加个数
    Should Be Equal As Integers    ${value}    1    #验证个数是否正确

Goods Number Can Be Decrease
    [Documentation]    动作：
    ...    点击数量旁点的-号
    ...
    ...    期望结果：
    ...    商品数量每点一次减一个，金额相应减少。
    ${amount1}    Check Amount and Sum
    Click Goods Modification Button    ${FIRST_ORDER_MINUS_XPATH}
    ${amount2}    Check Amount and Sum
    ${value}    Evaluate    ${amount1}-${amount2}
    Should Be Equal As Integers    ${value}    1

Invalid Amount Input
    [Documentation]    动作 | 期望结果
    ...    将商品数量改为0 | 不允许修改，自动设为1。
    ...    将商品数量改为-1 | 不允许修改，自动设为1。
    ...    将商品数量改为小数 | 不接受小数点后的小数。
    ...    商品数量里输入一个非数字的字符 | 不允许输入，自动设为1。
    ...    将商品数量设置成计算机能接受的最大数值+1 | 不允许修改，弹出超过最大值提示框。
    [Template]    Check Invalid Amount Input
    0    1
    -1    1
    2.5    2
    2147483648    12345
    a    1

*** Keywords ***
Check Amount and Sum
    ${element}    Get WebElement    ${FIRST_ORDER_XPATH}    #我们用xpath定位到第一个商品
    ${content}    Get Element Attribute    ${element}    innerHTML
    &{items}    Get Goods Items    ${content}
    ${expected_sum}    evaluate    &{items}[price] * &{items}[amount]
    Should Be Equal As Numbers    ${expected_sum}    &{items}[sum]    precision=2
    ${amount}    Set Variable    &{items}[amount]
    [Return]    ${amount}

Check Invalid Amount Input
    [Arguments]    ${input_value}    ${expected_value}
    ${old_value}    Get Value    ${FIRST_ORDER_AMOUNT_INPUT_XPATH}
    ${max}    Get Element Attribute    ${FIRST_ORDER_AMOUNT_INPUT_XPATH}    data-max
    Run Keyword If    '${input_value}' == '2147483648'    Set Suite Variable    ${expected_value}    ${max}
    Input Text    ${FIRST_ORDER_AMOUNT_INPUT_XPATH}    ${input_value}
    Sleep    3
    ${value_new}    Get Value    ${FIRST_ORDER_AMOUNT_INPUT_XPATH}
    Should Be Equal As Integers    ${value_new}    ${expected_value}

Click Goods Modification Button
    [Arguments]    ${buttion_id}
    Click Element    ${buttion_id}
    Sleep    2    #页面重新计算金额有点延迟
