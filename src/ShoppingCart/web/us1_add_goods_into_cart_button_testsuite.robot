*** Settings ***
Documentation     US1：作为顾客，当我看中某样东西时能方便的点击“加入购物车”按钮，以便将商品加入购物车。
Resource          web_resource.robot

*** Test Cases ***
Add_cart Button Show On Goods Page
    [Documentation]    动作:
    ...    打开某个商品详情页
    ...
    ...    期望结果:
    ...    页面上有“加入购物车”按钮。
    Open Goods Page
    Wait Until Page Contains Element    ${ADD_IN_CART_BTN_XPATH}    ${time_out}    找不到"加入购物车"按钮

*** Keywords ***
Open Goods Page
    Open Page    ${A_GOODS_URL}
