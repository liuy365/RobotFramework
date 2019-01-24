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
    Open Goods Page
    Page Should Caintains Elements    //*[@id="J_LinkBasket"]

*** Keywords ***
Open Goods Page
    Open Page    https://detail.tmall.com/item.htm?spm=a230r.1.14.20.312b67f8ccrGSk&id=579497336835&ns=1&abbucket=18&sku_properties=5919063:6536025;122216431:27772
