*** Settings ***
Documentation     使用场景3：能修改购物车里已选商品。
Suite Setup       Open Cart Page
Resource          web_resource.robot
Library           ${CURDIR}/lib/GetGoodsItemsLib

*** Test Cases ***
Click Plus Button
    [Documentation]    动作：
    ...    点击数量旁点的+号
    ...
    ...    期望结果：
    ...    商品数量每点一次加一个，金额相应增加。
    ${element}    Get WebElement    ${first_order_xpath}    #我们用xpath定位到第一个商品
    ${amount1}    Check Amount and Sum    ${element}    #检查并计算商品金额=单价*数量
    Click Element    ${first_order_plus_xpath}    #我们用xpath定位到第一个商品里的“+”号
    Sleep    5    #页面重新计算金额有点延迟
    ${element}    Get WebElement    ${first_order_xpath}    #重新取得这个商品的信息
    ${amount2}    Check Amount and Sum    ${element}    #根据新的数量重新计算和检查商品金额
    ${value}    Evaluate    ${amount2}-${amount1}    #取得每点一次加后数量增加个数
    Should Be Equal As Integers    ${value}    1    #验证个数正确

Click Minus Botton
    [Documentation]    动作：
    ...    点击数量旁点的-号
    ...
    ...    期望结果：
    ...    商品数量每点一次减一个，金额相应减少。
    ${element}    Get WebElement    ${first_order_xpath}
    ${amount1}    Check Amount and Sum    ${element}
    Click Element    ${first_order_minus_xpath}
    Sleep    5
    ${element}    Get WebElement    ${first_order_xpath}
    ${amount2}    Check Amount and Sum    ${element}
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
    [Arguments]    ${element}
    ${content}    Get Element Attribute    ${element}    innerHTML
    &{items}    Get Goods Items    ${content}
    ${expected_sum}    evaluate    &{items}[price] * &{items}[amount]
    ${sum}    Set Variable    &{items}[sum]
    Should Be Equal As Numbers    ${expected_sum}    ${sum}    precision=2
    ${amount}    Set Variable    &{items}[amount]
    [Return]    ${amount}

Check Invalid Amount Input
    [Arguments]    ${input_value}    ${expected_value}
    ${input_box}    Set Variable    ${first_order_amount_input_xpath}
    ${old_value}    Get Value    ${input_box}
    ${max}    Get Element Attribute    ${input_box}    data-max
    Run Keyword If    '${input_value}' == '2147483648'    Set Suite Variable    ${expected_value}    ${max}
    Input Text    ${input_box}    ${input_value}
    Sleep    3
    ${value_new}    Get Value    ${input_box}
    Should Be Equal As Integers    ${value_new}    ${expected_value}
