*** Settings ***
Library           AppiumLibrary    timeout=120    # 如果网络比较差，把超时时间可以适当设大一点，默认只有10秒。这个超时时间将适用于appium里所有需要等到的关键字
Variables         app_variables.py
Library           Collections
Library           String

*** Variables ***
${appium_server}    http://localhost:4723/wd/hub    # appium服务器的地址
#${appium_server}    http://192.168.199.119:4723/wd/hub
${android_phone}    127.0.0.1:62001    # 安卓模拟器的地址，用“adb devices”命令可以看到。

*** Keywords ***
Open Taobao App
    [Documentation]    打开淘宝APP
    Open Application    ${appium_server}    platformName=Android    platformVersion=4.4.2    deviceName=${android_phone}    appPackage=com.taobao.taobao    appActivity=com.taobao.tao.welcome.Welcome
    ...    unicodeKeyboard=True    resetKeyboard=True
    Wait Until Page Contains    淘宝

Wait And Click Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    Click Element    ${locator}

Open Cart Page
    [Documentation]    打开购物车页面
    Start Activity    appPackage=com.taobao.taobao    appActivity=com.taobao.android.trade.cart.CartActivity    #打开购物车界面,activity的名字可以用appium的关键字“Get Activity”获取
    Wait Until Page Contains Element    ${SHANGPING_LAYOUT_ID}    #等待商品的layout出现goods_all_layout
    ${first_goods_title}    Get Text    ${SHANGPING_TITLE_ID}    #保存购物车页面第一个商品的title。在有的用例中会滚动屏幕到下一屏幕，为了不影响后面的用例测试，在teardonwn里将购物车再滚回到最顶端。
    Set Suite Variable    ${first_goods_title}

Swipe Up One Page
    [Documentation]    向上滚动一屏
    Swipe By Percent    50    70    50    20

Swipe Down One Page
    [Documentation]    向下滚动一屏
    Swipe By Percent    50    20    50    70

Swipe To Top
    [Documentation]    滚动到购物车最顶端
    : FOR    ${i}    IN RANGE    10
    \    ${title}    Get Text    xpath=(${SHANGPING_TITLE_XPATH})
    \    Exit For Loop If    '${title}'=='${first_goods_title}'
    \    Swipe Down One Page

Get Goods Properties
    [Arguments]    ${index}
    [Documentation]    取得指定商品的所有属性， 包括是否选中、标题、价格、数量等信息。
    ...    input： ${index} 商品在本页中第几个。
    ...    output：&{dict_goods_items}包含商品所有属性的dictionary变量。
    &{dict_goods_items}    Create Dictionary    #创建一个空的dict变量
    ${chk}    Get Element Attribute    xpath=(${SHANGPING_CHK_BOX_XPATH})[${index}]    checked    #取商品的属性
    Set To Dictionary    ${dict_goods_items}    chk    ${chk}    #放入dictionary变量中， 此处要用Scalar标量的书写方式。
    ${img}    Get Element Attribute    xpath=(${SHANGPING_PIC_XPATH})[${index}]    enabled
    Set To Dictionary    ${dict_goods_items}    img    ${img}
    ${title}    Get Text    xpath=(${SHANGPING_TITLE_XPATH})[${index}]
    Set To Dictionary    ${dict_goods_items}    title    ${title}
    ${price}    Get Element Attribute    xpath=(${SHANGPING_PRICE_XPATH})[${index}]    text
    ${price}    Remove String    ${price}    ￥
    Set To Dictionary    ${dict_goods_items}    price    ${price}
    ${amount}    Get Element Attribute    xpath=(${SHANGPING_AMOUNT_XPATH})[${index}]    text
    ${amount}    Remove String    ${amount}    ×
    Set To Dictionary    ${dict_goods_items}    amount    ${amount}
    [Return]    &{dict_goods_items}

Get Price
    [Arguments]    ${textview_id}
    ${price}    Get Element Attribute    ${textview_id}    text
    ${price}    Remove String    ${price}    ￥
    [Return]    ${price}
