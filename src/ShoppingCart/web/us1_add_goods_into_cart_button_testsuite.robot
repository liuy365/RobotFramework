*** Settings ***
Documentation     使用场景1：“加入购物车”按钮能出现在所有商品的页面上。
Resource          web_resource.robot

*** Test Cases ***
Add_chart Button Show On Goods Page
    [Documentation]    动作:
    ...    打开某个商品详情页
    ...
    ...    期望结果:
    ...    页面上有“加入购物车”按钮。
    Open Page    ${a_goods_url}
    Page Should Caintains Elements    ${add_in_chart_btn_xpath}

*** Keywords ***
