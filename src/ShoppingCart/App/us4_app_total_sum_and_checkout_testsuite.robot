*** Settings ***
Documentation     US4：作为顾客，当选中购物车中的商品时，在页面上能显示商品总价和进入收银台入口，以便根据商品总价决定选择哪些商品进入收银台。
Suite Setup       Open Cart Page
Test Teardown     Swipe To Top
Resource          app_resource.html

*** Test Cases ***
Check Sum For All Checked Goods
    Select Some Goods Randomly
    ${sum_calculated}    Calculate Sum For All Checked Goods
    ${sum_get_from_page}    Get Price    ${TOTAL_COST_ID}
    Should Be Equal As Numbers    ${sum_calculated}    ${sum_get_from_page}    precision=2

*** Keywords ***
Calculate Sum For All Checked Goods
    ${sum}    Set Variable    0    #创建一个scalar变量用于保存商品总价
    @{list_titles_in_last_page}    Create List    not_exist_title    #创建一个数量用于保存上一页中所有的商品名字。预设一个不存在的商品名称，不然系统自带的关键字List Should Contain Value因为空list而报错。
    Set Suite Variable    @{list_titles_in_last_page}
    : FOR    ${i}    IN RANGE    10
    \    ${sum_page}    Calculate Sum For Current Page    #计算当前页中的商品总价
    \    ${sum}    Evaluate    ${sum} + ${sum_page}
    \    ${count}    Get Matching Xpath Count    ${BOTTOM_OF_CART_XPATH}    #向下滑动到购物车列表的底部：“你可能还喜欢”图片出现
    \    Exit For Loop If    ${count}>0
    \    Swipe Up One Page    #向上滑动取第二页中的商品
    [Return]    ${sum}

Calculate Sum For Current Page
    ${sum}    Set Variable    0
    @{elements}    Get Webelements    ${SHANGPING_TITLE_ID}
    ${number}    Get Length    ${elements}
    @{list_titles_in_current_page}    Create List    #创建一个list用于存放本页的所有商品名称。
    : FOR    ${i}    IN RANGE    ${number}
    \    ${i}    Evaluate    ${i}+1
    \    ${status}    ${value}    Run Keyword And Ignore Error    Element Should Be Visible    xpath=(${SHANGPING_TITLE_XPATH})[${i}]
    \    Continue For Loop IF    '${status}' != 'PASS'    #取某个商品的最顶部一个元素，如果它没有出现在页面中表示商品没有显示完整，它已经在上一次处理过了，继续下一个。
    \    ${status}    ${value}    Run Keyword And Ignore Error    Element Should Be Visible    xpath=(${SHANGPING_AMOUNT_XPATH})[${i}]
    \    Continue For Loop IF    '${status}' != 'PASS'    #取某个商品的最下面一个元素，如果它没有出现在页面中表示商品没有显示完整，不处理这个商品，滚到下一屏幕时再处理。
    \    &{dict_goods_items}    Get Goods Properties    ${i}
    \    ${status}    ${value}    Run Keyword And Ignore Error    List Should Contain Value    ${list_titles_in_last_page}    &{dict_goods_items}[title]
    \    Continue For Loop IF    '${status}' == 'PASS'    #在上一页中已经把这个商品计算在内，这次不再重复计算。
    \    Append To List    ${list_titles_in_current_page}    &{dict_goods_items}[title]    #将新的商品名称加入list
    \    ${sum_one}    Evaluate    &{dict_goods_items}[price] * &{dict_goods_items}[amount]
    \    ${sum_one}    Set Variable If    '&{dict_goods_items}[chk]'=='true'    ${sum_one}    0    #如果商品选中就累加商品总价，没有选中，那么就累加一个0
    \    ${sum}    Evaluate    ${sum} + ${sum_one}
    @{list_titles_in_last_page}    Copy List    ${list_titles_in_current_page}    #更新上一页的商品名称列表@{list_titles_in_last_page}，为下一页做准备。
    Set Suite Variable    @{list_titles_in_last_page}
    [Return]    ${sum}

Select Some Goods Randomly
    : FOR    ${i}    IN RANGE    10
    \    Select Goods On Current Page
    \    ${count}    Get Matching Xpath Count    ${BOTTOM_OF_CART_XPATH}    #向下滑动到购物车列表的底部：“你可能还喜欢”图片出现
    \    Exit For Loop If    ${count}>0
    \    Swipe Up One Page
    Swipe To Top

Select Goods On Current Page
    @{elements}    Get Webelements    ${SHANGPING_TITLE_ID}
    ${max_index}    Get Length    ${elements}
    : FOR    ${i}    IN RANGE    ${max_index}
    \    ${random_int}    Evaluate    random.randint(1, ${max_index})    random    #生成一个1到${max_index}之间的随机整数
    \    ${checked}    Get Element Attribute    xpath=(${SHANGPING_CHK_BOX_XPATH})[${random_int}]    checked
    \    Run Keyword If    '${checked}'=='false'    Click Element    xpath=(${SHANGPING_CHK_BOX_XPATH})[${random_int}]
