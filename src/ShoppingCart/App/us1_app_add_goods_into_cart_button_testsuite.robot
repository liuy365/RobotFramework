*** Settings ***
Documentation     使用场景1：“加入购物车”按钮能出现在所有商品的页面上。
Resource          app_resource.robot

*** Test Cases ***
Add_cart Button Show On Goods Page
    Open Goods Page
    Wait Until Page Contains Element    ${ADD_IN_CART_BTN_XPATH}    error=找不到"加入购物车"按钮

*** Keywords ***
Open Goods Page
    Wait And Click Element    ${SEARCH_BAR}    #主界面上的搜索框
    Wait And Click Element    ${SEARCH_TEXT_BOX}    #可以输入文字的搜索框
    Input Text    ${SEARCH_TEXT_BOX}    诺基亚    #任意输入商品关键词
    Wait And Click Element    ${SEARCH_BTN}    #输入框右边的搜索按钮
    Wait And Click Element    ${SEARCH_RESULT_FIRST}    #搜索到的商品以列表方式显示出来,点击第一个
