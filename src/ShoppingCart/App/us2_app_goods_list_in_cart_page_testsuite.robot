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

*** Keywords ***
Get Goods Number From DB
    ${ret}    Set Variable    6
    [Return]    ${ret}

Get Goods Number From Page
    Wait Until Page Contains Element    id=com.taobao.taobao:id/goods_all_layout    ${time_out}    #等待商品的layout出现goods_all_layout
    Comment    ${text}    Get Text    id=com.taobao.taobao:id/textview_title
    Comment    @{ret_list}    String.Get Regexp Matches    ${text}    购物车.([0-9]+)    1
    Comment    ${number}    Set Variable    @{ret_list}[0]
    @{list_all_titles}    Create List
    :FOR    ${i}    IN RANGE    10
    \    @{list_t}    Get All Goods Title On Page
    \    Log Many    @{list_t}
    \    Append To List    ${list_all_titles}    @{list_t}
    \    ${count}    Get Matching Xpath Count    xpath=//android.widget.ImageView[@resource-id='com.taobao.taobao:id/iv_main_pic_head']    #向下滑动到“你可能还喜欢”图片出现
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    700    500
    @{list_all_titles}    Remove Duplicates    ${list_all_titles}
    ${number}    Get Length    ${list_all_titles}
    Log Many    @{list_all_titles}
    [Return]    ${number}

Check Each Item In Goods
    &{items}    Get Goods Items    ${element_src}
    Log Many    &{items}
    Should Not Be Empty    &{items}[chk]
    Should Not Be Empty    &{items}[img]
    Should Not Be Empty    &{items}[title]
    Should Match Regexp    &{items}[price]    [0-9]+\\.[0-9]+
    Should Match Regexp    &{items}[amount]    [0-9]+
    Should Match Regexp    &{items}[sum]    [0-9]+\\.[0-9]+
    Should Not Be Empty    &{items}[fav]
    Should Not Be Empty    &{items}[del]

Get All Goods Title On Page
    @{elements}    Get Webelements    id=com.taobao.taobao:id/textview_goods_title
    ${number}    Get Length    ${elements}
    @{list_title}    Create List
    :FOR    ${i}    IN RANGE    ${number}
    \    ${i}    Evaluate    ${i}+1
    \    ${title}    Get Text    xpath=(//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_goods_title'])[${i}]
    \    Append To List    ${list_title}    ${title}
    [Return]    @{list_title}
