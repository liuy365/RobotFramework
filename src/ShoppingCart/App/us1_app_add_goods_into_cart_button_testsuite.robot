*** Settings ***
Resource          app_resource.robot

*** Test Cases ***
Add_cart Button Show On Goods Page
    Open Goods Page
    Wait Until Page Contains    加入购物车    ${time_out}

*** Keywords ***
Open Goods Page
    Wait And Click Element    id=com.taobao.taobao:id/home_searchedit
    Wait And Click Element    id=com.taobao.taobao:id/search_bar
    Input Text    id=com.taobao.taobao:id/search_bar    机器人
    Wait And Click Element    id=com.taobao.taobao:id/search_button
    Wait And Click Element    id=com.taobao.taobao:id/rfq_quote_array_item_img
