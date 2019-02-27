*** Settings ***
Documentation     US2：作为顾客，当我打开购物车主页时能看见所有挑选的商品列表及其信息，以便我检查是否是我选择的东西。
Suite Setup       Open Cart Page
Test Teardown     Swipe To Top
Resource          app_resource.html
Library           String
Library           Collections

*** Test Cases ***
Check Goods Numbers Showed On Page
    [Documentation]    动作:
    ...    打开购物车页面 ...
    ...    期望结果:
    ...    购物车里的商品一条一条显示在页面上；
    ${num_in_db}    Get Goods Number From DB
    ${num_on_page}    Get Goods Number From Page
    Should Be Equal As Integers    ${num_in_db}    ${num_on_page}

Check Goods Items Showed On Page
    [Documentation]    动作:
    ...    打开购物车页面
    ...    期望结果:
    ...    商品的信息包括所属店铺、图片、名称、单价、数量、金额和可用的操作等信息；
    : FOR    ${i}    IN RANGE    10
    \    Check Each Goods On Page    #检查当前页面上每一个商品的属性是否正确显示
    \    ${count}    Get Matching Xpath Count    ${BOTTOM_OF_CART_XPATH}    #向下滑动到购物车列表的底部：“你可能还喜欢”图片出现
    \    Exit For Loop If    ${count}>0
    \    Swipe Up One Page

*** Keywords ***
Get Goods Number From DB
    ${ret}    Set Variable    6
    [Return]    ${ret}

Get Goods Number From Page
    @{list_all_titles}    Create List    #创建一个空list用于存放所有的商品标题
    : FOR    ${i}    IN RANGE    10    #假设购物车有10页，真是土豪！放那么多东西在购物车里！
    \    @{list_t}    Get All Goods Title On Page    #取得当前页面的所有商品标题
    \    Log Many    @{list_t}
    \    Append To List    ${list_all_titles}    @{list_t}
    \    ${count}    Get Matching Xpath Count    ${BOTTOM_OF_CART_XPATH}    #查找是否出现“你可能还喜欢”图片
    \    Exit For Loop If    ${count}>0    #如果找到就表明到达购物车底部，退出循环。
    \    Swipe Up One Page    #向上滚动页面， 手指由屏幕底部往上滑动。
    @{list_all_titles}    Remove Duplicates    ${list_all_titles}    #移除重复的商品。
    ${number}    Get Length    ${list_all_titles}    #转换成scalar形式才能取得数组长度
    [Return]    ${number}

Check Each Item In Goods
    [Arguments]    &{items}
    Log Many    &{items}
    Should Not Be Empty    &{items}[chk]
    Should Not Be Empty    &{items}[img]
    Should Not Be Empty    &{items}[title]
    Should Match Regexp    &{items}[price]    [0-9]+\\.[0-9]+|[0-9]+
    Should Match Regexp    &{items}[amount]    [0-9]+

Get All Goods Title On Page
    [Documentation]    取得当前页面上的所有商品名称
    @{elements}    Get Webelements    ${SHANGPING_TITLE_ID}
    ${number}    Get Length    ${elements}
    @{list_title}    Create List
    : FOR    ${i}    IN RANGE    ${number}
    \    ${i}    Evaluate    ${i}+1
    \    ${title}    Get Text    xpath=(${SHANGPING_TITLE_XPATH})[${i}]
    \    Append To List    ${list_title}    ${title}
    [Return]    @{list_title}

Check Each Goods On Page
    @{elements}    Get Webelements    ${SHANGPING_LAYOUT_ID}
    ${number}    Get Length    ${elements}    #用scalar形式才能取到数组长度
    : FOR    ${i}    IN RANGE    ${number}
    \    ${i}    Evaluate    ${i}+1    #元素下标不是从0开始，而是从1开始
    \    ${status}    ${value}    Run Keyword And Ignore Error    Element Should Be Visible    xpath=(${SHANGPING_TITLE_XPATH})[${i}]
    \    Continue For Loop IF    '${status}' != 'PASS'    #取某个商品的最顶部一个元素，如果它没有出现在页面中表示商品没有显示完整，它已经在上一次处理过了，继续下一个。
    \    ${status}    ${value}    Run Keyword And Ignore Error    Element Should Be Visible    xpath=(${SHANGPING_AMOUNT_XPATH})[${i}]
    \    Continue For Loop IF    '${status}' != 'PASS'    #取某个商品的最下面一个元素，如果它没有出现在页面中表示商品没有显示完整，不处理这个商品，滚到下一屏幕时再处理。
    \    &{dict_goods_items}    Get Goods Properties    ${i}
    \    Check Each Item In Goods    &{dict_goods_items}
