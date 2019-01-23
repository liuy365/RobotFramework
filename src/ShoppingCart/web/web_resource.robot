*** Settings ***
Documentation     存放所有testsuite共同使用的关键字和变量。
Library           SeleniumLibrary
Library           String
Library           OperatingSystem

*** Variables ***
${MainPage_URL}    https://www.taobao.com/
${BROWSER}        firefox
${DELAY}          0
${username}       liuy36
${cookie_file}    ${CURDIR}/data/cookie
${cart_page_file}    ${CURDIR}/data/cart_page_content.html

*** Keywords ***
Open Page
    [Arguments]    ${page_url}
    Go To    ${page_url}

Open Browser To Taobao Main Page
    Open Browser    ${MainPage_URL}    ${BROWSER}
    ${status}    ${value} =    Run Keyword And Ignore Error    File Should Exist    ${cookie_file}
    Run Keyword If    '${status}'=='PASS'    Read Cookie
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Go To    ${MainPage_URL}
    ${title}    Get Title
    Should Contain    ${title}    淘宝网

Page Should Caintains Elements
    [Arguments]    @{elements_list}
    : FOR    ${element}    IN    @{elements_list}
    \    Wait Until Page Contains Element    ${element}    30    找不到${element}

Go To Cart Page On Line
    Go To    ${MainPage_URL}
    sleep    5
    ${status}    ${value} =    Run Keyword And Ignore Error    Element Should Be Visible    //a[text()='亲，请登录']
    Run Keyword If    '${status}'=='PASS'    Login Taobao
    Wait Until Page Contains Element    //*[@id="mc-menu-hd"]    30
    Click Element    //*[@id="mc-menu-hd"]
    Wait Until Keyword Succeeds    60    5    My Cart Page Opened
    ${content}    Get Source
    Create File    ${cart_page_file}    ${content}    UTF-8

Login Taobao
    Click Link    亲，请登录
    Wait Until Page Contains    liuy36    60
    Store Cookie

Store Cookie
    ${ck}    Get Cookies
    Create File    ${cookie_file}    ${ck}    UTF-8
    File Should Not Be Empty    ${cookie_file}
    Log File    ${cookie_file}

Read Cookie
    ${content}    Get File    ${cookie_file}
    @{list}    Split String    ${content}    ;
    : FOR    ${item}    IN    @{list}
    \    ${item}    Strip String    ${item}
    \    ${key}    Fetch From Left    ${item}    =
    \    ${len}    Get Length    ${key}
    \    ${len}    Evaluate    ${len}+1
    \    ${value}    Get Substring    ${item}    ${len}
    \    Add Cookie    ${key}    ${value}

My Cart Page Opened
    ${title}    Get Title
    Should Contain    ${title}    我的购物车

Open Cart Page
    ${status}    ${value} =    Run Keyword And Ignore Error    File Should Exist    ${cart_page_file}
    Run Keyword If    '${status}'=='PASS'    Go To    file://${cart_page_file}
    Run Keyword Unless    '${status}'=='PASS'    Go To Cart Page On Line
