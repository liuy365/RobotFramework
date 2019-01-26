*** Settings ***
Documentation     存放所有testsuite共同使用的关键字和变量。
Library           SeleniumLibrary
Library           OperatingSystem

*** Variables ***
${Home_Page}      https://www.taobao.com/
${DELAY}          0
${Cart_Page_File}    ${CURDIR}/data/cart_page_content.html
${Chrome_ID}      localhost:8083    # Open chrome in debug mode and listen on port 8083

*** Keywords ***
Open Page
    [Arguments]    ${page_url}
    Go To    ${page_url}

Connect To Browser
    [Documentation]    前提：chrome启动在调试模式：
    ...    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --remote-debugging-port=8083 --user-data-dir=C:\selenium\AutomationProfile
    connect_to_exist_browser    ${Chrome_ID}
    Set Selenium Speed    ${DELAY}

Page Should Caintains Elements
    [Arguments]    @{elements_list}
    : FOR    ${element}    IN    @{elements_list}
    \    Wait Until Page Contains Element    ${element}    30    找不到${element}

Go To Cart Page On Line
    Go To    ${Home_Page}
    Wait Until Page Contains Element    //*[@id="mc-menu-hd"]    30
    Click Element    //*[@id="mc-menu-hd"]
    Wait Until Keyword Succeeds    60    10    My Cart Page Opened

My Cart Page Opened
    ${title}    Get Title
    Should Contain    ${title}    我的购物车

Open Cart Page
    ${title}    Get Title
    ${status}     ${value} =     Run Keyword And Ignore Error    Should Contain    ${title}    我的购物车
    Return From Keyword If    '${status}' == 'PASS'
    ${status}    ${value} =    Run Keyword And Ignore Error    File Should Exist    ${Cart_Page_file}
    Run Keyword If    '${status}'=='PASS'    Go To    file://${Cart_Page_File}
    Run Keyword Unless    '${status}'=='PASS'    Go To Cart Page On Line
