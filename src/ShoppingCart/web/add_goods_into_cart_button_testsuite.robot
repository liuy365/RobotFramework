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
    Open Page    https://detail.tmall.com/item.htm?id=576559843732&ali_refid=a3_430583_1006:1106510893:N:%B3%E4%B5%E7%B1%A680000%BA%C1%B0%B2:7180337833ef410e881598f09bc49a2c&ali_trackid=1_7180337833ef410e881598f09bc49a2c&spm=a230r.1.14.1
