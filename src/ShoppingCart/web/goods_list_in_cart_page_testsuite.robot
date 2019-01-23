*** Settings ***
Documentation     使用场景2：进入购物车主页，能看见所有挑选的商品列表。
Suite Setup       Open Cart Page
Resource          web_resource.robot

*** Test Cases ***
Goods Listed On Page
    [Documentation]    动作:
    ...    打开购物车页面\t
    ...    期望结果:
    ...    1.购物车里的商品一条一条显示在页面上；
    ...    2.商品的信息包括所属店铺、图片、名称、单价、数量、金额和可用的操作等信息；
    ...    3.如果商品有特殊服务，比如支持信用卡、7天无理由退换等， 显示在商品旁；
    ...    4.商品按店铺分割，同一店铺的商品放在一起；
    ...    5.有店铺的旺旺快捷入口；
    @{elements}    Get WebElements    //div[@class="item-holder"]
    : FOR    ${element}    IN    @{elements}
    \    ${content}    Get Text    ${element}
    \    ${content}    get_element_source    ${element}
    \    log    ${content}
