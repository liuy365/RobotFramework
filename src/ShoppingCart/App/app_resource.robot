*** Settings ***
Library           AppiumLibrary    timeout=120    # 如果网络比较差，把超时时间可以适当设大一点，默认只有10秒。这个超时时间将适用于appium里所有需要等到的关键字
Variables         app_variables.py

*** Variables ***
${appium_server}    http://localhost:4723/wd/hub    # appium服务器的地址
#${appium_server}    http://192.168.199.119:4723/wd/hub
${android_phone}    127.0.0.1:62001    # 安卓模拟器的地址，用“adb devices”命令可以看到。

*** Keywords ***
Open Taobao App
    Open Application    ${appium_server}    platformName=Android    platformVersion=4.4.2    deviceName=${android_phone}    appPackage=com.taobao.taobao    appActivity=com.taobao.tao.welcome.Welcome
    ...    unicodeKeyboard=True    resetKeyboard=True
    Wait Until Page Contains    淘宝

Wait And Click Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    Click Element    ${locator}

Open Cart Page
    Start Activity    appPackage=com.taobao.taobao    appActivity=com.taobao.android.trade.cart.CartActivity    #打开购物车界面,activity的名字可以用appium的关键字“Get Activity”获取
    Wait Until Page Contains Element    id=com.taobao.taobao:id/goods_all_layout    #等待商品的layout出现goods_all_layout
