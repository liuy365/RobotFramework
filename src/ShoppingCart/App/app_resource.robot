*** Settings ***
Library           AppiumLibrary    timeout=120

*** Variables ***

*** Keywords ***
Open Taobao App
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=4.4.2    deviceName=127.0.0.1:62001    appPackage=com.taobao.taobao    appActivity=com.taobao.tao.welcome.Welcome
    ...    unicodeKeyboard=True    resetKeyboard=True

Wait And Click Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    Click Element    ${locator}

Open Cart Page
    Wait And Click Element    //android.widget.TextView[@text="购物车"]
