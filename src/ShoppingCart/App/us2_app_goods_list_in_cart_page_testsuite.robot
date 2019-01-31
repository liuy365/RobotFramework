*** Settings ***
Suite Setup       Open Cart Page
Resource          app_resource.robot
Library           String
Library           Collections

*** Test Cases ***
Check Goods Numbers Showed On Page
    [Documentation]    动作:
    ...    打开购物车页面
    ...
    ...    期望结果:
    ...    1.购物车里的商品一条一条显示在页面上；
    ${num_in_db}    Get Goods Number From DB
    ${num_on_page}    Get Goods Number From Page
    Should Be Equal As Integers    ${num_in_db}    ${num_on_page}

Check Goods Items Showed On Page
    Wait Until Page Contains Element    id=com.taobao.taobao:id/goods_all_layout    #等待商品的layout出现goods_all_layout
    : FOR    ${i}    IN RANGE    10
    \    Check Each Goods On Page    #检查当前页面上每一个商品的属性是否正确显示
    \    ${count}    Get Matching Xpath Count    xpath=//android.widget.ImageView[@resource-id='com.taobao.taobao:id/iv_main_pic_head']    #向下滑动到购物车列表的底部：“你可能还喜欢”图片出现
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    700    500

*** Keywords ***
Get Goods Number From DB
    ${ret}    Set Variable    6
    [Return]    ${ret}

Get Goods Number From Page
    Wait Until Page Contains Element    id=com.taobao.taobao:id/goods_all_layout    #等待商品的layout出现goods_all_layout
    @{list_all_titles}    Create List
    : FOR    ${i}    IN RANGE    10
    \    @{list_t}    Get All Goods Title On Page    #取得当前页面的所有商品标题
    \    Log Many    @{list_t}
    \    Append To List    ${list_all_titles}    @{list_t}
    \    ${count}    Get Matching Xpath Count    xpath=//android.widget.ImageView[@resource-id='com.taobao.taobao:id/iv_main_pic_head']    #向下滑动到购物车列表的底部：“你可能还喜欢”图片出现
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    700    500
    @{list_all_titles}    Remove Duplicates    ${list_all_titles}
    ${number}    Get Length    ${list_all_titles}
    Log Many    @{list_all_titles}
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
    @{elements}    Get Webelements    id=com.taobao.taobao:id/textview_goods_title
    ${number}    Get Length    ${elements}
    @{list_title}    Create List
    : FOR    ${i}    IN RANGE    ${number}
    \    ${i}    Evaluate    ${i}+1
    \    ${title}    Get Text    xpath=(//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_goods_title'])[${i}]
    \    Append To List    ${list_title}    ${title}
    [Return]    @{list_title}

Check Each Goods On Page
    @{elements}    Get Webelements    id=com.taobao.taobao:id/goods_all_layout
    ${number}    Get Length    ${elements}
    &{dict_goods_items}    Create Dictionary    #创建一个dict变量
    : FOR    ${i}    IN RANGE    ${number}
    \    ${i}    Evaluate    ${i}+1
    \    ${status}    ${value}    Run Keyword And Ignore Error    Element Should Be Visible    xpath=(//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_goods_title'])[${i}]
    \    Continue For Loop IF    '${status}' != 'PASS'    #取某个商品的最顶部一个元素，如果它没有出现在页面中表示商品没有显示完整，它已经在上一次处理过了，继续下一个。
    \    ${status}    ${value}    Run Keyword And Ignore Error    Element Should Be Visible    xpath=(//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_count'])[${i}]
    \    Continue For Loop IF    '${status}' != 'PASS'    #取某个商品的最下面一个元素，如果它没有出现在页面中表示商品没有显示完整，不处理这个商品，滚到下一屏幕时再处理。
    \    ${chk}    Get Element Attribute    xpath=(//android.widget.CheckBox[@resource-id='com.taobao.taobao:id/checkbox_goods'])[${i}]    checked
    \    Set To Dictionary    ${dict_goods_items}    chk    ${chk}
    \    ${img}    Get Element Attribute    xpath=(//android.widget.ImageView[@resource-id='com.taobao.taobao:id/imageview_goods_icon'])[${i}]    enabled
    \    Set To Dictionary    ${dict_goods_items}    img    ${img}
    \    ${title}    Get Text    xpath=(//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_goods_title'])[${i}]
    \    Set To Dictionary    ${dict_goods_items}    title    ${title}
    \    ${price}    Get Element Attribute    xpath=(//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_real_price'])[${i}]    text
    \    ${price}    Remove String    ${price}    ￥
    \    Set To Dictionary    ${dict_goods_items}    price    ${price}
    \    ${amount}    Get Element Attribute    xpath=(//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_count'])[${i}]    text
    \    ${amount}    Remove String    ${amount}    ×
    \    Set To Dictionary    ${dict_goods_items}    amount    ${amount}
    \    Check Each Item In Goods    &{dict_goods_items}
    \    Keep In Dictionary    ${dict_goods_items}    no_exist    #清空dict变量为下一次循环做准备
