*** Settings ***
Library           AppiumLibrary

*** Variables ***
${time_out}       120
${add_in_cart_btn_xpath}    //android.widget.TextView[@text="加入购物车"]

*** Keywords ***
Open Taobao App
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=4.4.2    deviceName=127.0.0.1:62001    appPackage=com.taobao.taobao    appActivity=com.taobao.tao.welcome.Welcome
    ...    unicodeKeyboard=True    resetKeyboard=True

Wait And Click Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    ${time_out}
    Click Element    ${locator}

Open Cart Page
    Wait And Click Element    //android.widget.TextView[@text="购物车"]
