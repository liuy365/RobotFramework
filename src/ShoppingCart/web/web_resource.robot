*** Settings ***
Documentation     存放所有testsuite共同使用的关键字和变量。
Library           SeleniumLibrary    60
Library           OperatingSystem
Variables         web_variables.py

*** Variables ***
${time_out}       60s
${Cart_Page_File}    ${CURDIR}/data/cart_page_content.html    # 购物车页面本地文件

*** Keywords ***
Connect To Browser
    [Documentation]    前提：chrome启动在调试模式：
    ...    \path_to_chrome\chrome.exe --remote-debugging-port=8080 --user-data-dir=C:\selenium\AutomationProfile
    Connect To Exist Browser    ${Chrome_ID}
    Set Selenium Speed    0

Go To Cart Page On Line
    Go To    ${HOME_PAGE}
    Wait Until Page Contains Element    ${MY_CART_BTN_XPATH}    30
    Click Element    ${MY_CART_BTN_XPATH}
    Wait Until Keyword Succeeds    60    10    My Cart Page Opened

My Cart Page Opened
    ${title}    Get Title
    Should Contain    ${title}    我的购物车

Open Cart Page
    ${title}    Get Title
    ${status}    ${value} =    Run Keyword And Ignore Error    Should Contain    ${title}    我的购物车
    Return From Keyword If    '${status}' == 'PASS'
    ${status}    ${value} =    Run Keyword And Ignore Error    File Should Exist    ${Cart_Page_File}
    Run Keyword If    '${status}'=='PASS'    Go To    file://${Cart_Page_File}
    Run Keyword Unless    '${status}'=='PASS'    Go To Cart Page On Line

Open Page
    [Arguments]    ${page_url}
    Go To    ${page_url}

Page Should Caintains Elements
    [Arguments]    @{elements_list}
    : FOR    ${element}    IN    @{elements_list}
    \    Wait Until Page Contains Element    ${element}    30    找不到${element}
