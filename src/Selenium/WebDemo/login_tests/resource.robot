*** Settings ***
Documentation     公共的关键字和变量定义的resource文件
Library           SeleniumLibrary    #导入SeleniumLibrary，所有参数用默认值。

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        chrome
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}     #用id:username_field定位

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}    #用id:password_field定位

Submit Credentials
    Click Button    login_button    #用id:login_button定位

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page
