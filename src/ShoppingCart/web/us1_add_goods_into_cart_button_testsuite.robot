*** Settings ***
Documentation     使用场景1：“加入购物车”按钮能出现在所有商品的页面上。
Resource          web_resource.robot

*** Test Cases ***
Add_cart Button Show On Goods Page
    [Documentation]    动作:
    ...    打开某个商品详情页
    ...
    ...    期望结果:
    ...    页面上有“加入购物车”按钮。
    Open Goods Page
    Wait Until Page Contains Element    ${add_in_cart_btn_xpath}    ${time_out}    找不到"加入购物车"按钮

*** Keywords ***
Open Goods Page
    Open Page    ${a_goods_url}
