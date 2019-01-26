*** Settings ***
Documentation     使用场景2：进入购物车主页，能看见所有挑选的商品列表。
Suite Setup       Open Cart Page
Resource          web_resource.robot
Library           ${CURDIR}/lib/GetGoodsItemsLib

*** Test Cases ***
Check Goods Items Showed On Page
    [Documentation]    动作:
    ...    打开购物车页面
    ...    期望结果:
    ...    2.商品的信息包括所属店铺、图片、名称、单价、数量、金额和可用的操作等信息；
    ...    3.如果商品有特殊服务，比如支持信用卡、7天无理由退换等， 显示在商品旁；
    ...    4.商品按店铺分割，同一店铺的商品放在一起；
    ...    5.有店铺的旺旺快捷入口；
    @{elements}    Get WebElements    //div[@class="item-holder"]
    : FOR    ${element}    IN    @{elements}
    \    ${content}    get_element_source    ${element}
    \    Check Each Item In Goods    ${content}

Check Goods Numbers Showed On Page
    [Documentation]    动作:
    ...    打开购物车页面
    ...
    ...    期望结果:
    ...    1.购物车里的商品一条一条显示在页面上；
    ${num_in_db}    Get Goods Number From DB
    ${num_on_page}    Get Goods Number From Page
    Should Be Equal As Integers    ${num_in_db}    ${num_on_page}

*** Keywords ***
Check Each Item In Goods
    [Arguments]    ${element_src}
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

Get Goods Number From DB
    [Documentation]    从其它接口取得购物车中的物品数量， 比如数据库。
    ${ret}    Set Variable    6
    [Return]    ${ret}

Get Goods Number From Page
    [Documentation]    取得购物车网页上的商品数量。
    @{elements}    Get WebElements    //div[@class="item-holder"]
    ${len}    Get Length    ${elements}
    [Return]    ${len}
