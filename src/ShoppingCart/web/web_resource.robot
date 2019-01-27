*** Settings ***
Documentation     存放所有testsuite共同使用的关键字和变量。
Library           SeleniumLibrary
Library           OperatingSystem

*** Variables ***
${Home_Page}      https://www.taobao.com/
${DELAY}          0
${Cart_Page_File}    ${CURDIR}/data/cart_page_content.html    # 购物车页面本地文件
${Chrome_ID}      localhost:8083    # 已经用调试模式打开的本地Chrome
${add_in_chart_btn_xpath}    //*[@id="J_LinkBasket"]    # 加入购物车按钮
${a_goods_url}    https://detail.tmall.com/item.htm?spm=a230r.1.14.20.312b67f8ccrGSk&id=579497336835&ns=1&abbucket=18&sku_properties=5919063:6536025;122216431:27772    # 一个商品的url
${goods_list_xpath}    //div[@class="item-holder"]    # 购物车页面上存放商品的标签
${first_order_xpath}    //div[starts-with(@id,"J_OrderHolder_s")][1]    # 第一个商品的xpath定位器
${first_order_plus_xpath}    //div[starts-with(@id,"J_OrderHolder_s")][1]//a[contains(@class, "J_Plus")]    # 第一个商品里“+”号的xpath定位器
${first_order_minus_xpath}    //div[contains(@id,"J_OrderHolder_s")][1]//a[contains(@class, "J_Minus")]    # 第一个商品里“-”号的xpath定位器
${first_order_amount_input_xpath}    //div[starts-with(@id,"J_OrderHolder_s")][1]//input[contains(@class, "J_ItemAmount")]    # 第一个商品里“数量”的xpath定位器
${first_order_checkbox_xpath}    //div[starts-with(@id,"J_OrderHolder_s")][1]//div[contains(@class, "cart-checkbox")]    # 第一个商品里“复选框”的xpath定位器
${checkbox_total_xpath}    //div[@class="cart-table-th"]//div[contains(@class, "cart-checkbox")]    # 购物车页面“全选”框的xpath定位器
${total_pay}      //em[@id="J_Total"]

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
    ${status}    ${value} =    Run Keyword And Ignore Error    Should Contain    ${title}    我的购物车
    Return From Keyword If    '${status}' == 'PASS'
    ${status}    ${value} =    Run Keyword And Ignore Error    File Should Exist    ${Cart_Page_file}
    Run Keyword If    '${status}'=='PASS'    Go To    file://${Cart_Page_File}
    Run Keyword Unless    '${status}'=='PASS'    Go To Cart Page On Line
