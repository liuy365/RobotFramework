*** Settings ***
Library           AppiumLibrary    timeout=120

*** Variables ***
#${appium_server}    http://localhost:4723/wd/hub
${appium_server}    http://192.168.199.119:4723/wd/hub
${android_phone}    127.0.0.1:62001

*** Keywords ***
Open Taobao App
    Open Application    ${appium_server}    platformName=Android    platformVersion=4.4.2    deviceName=${android_phone}    appPackage=com.taobao.taobao    appActivity=com.taobao.tao.welcome.Welcome
    ...    unicodeKeyboard=True    resetKeyboard=True

Wait And Click Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    Click Element    ${locator}

Open Cart Page
    Start Activity    appPackage=com.taobao.taobao    appActivity=com.taobao.android.trade.cart.CartActivity
    Comment    Wait And Click Element    //android.widget.TextView[@text="购物车"]
