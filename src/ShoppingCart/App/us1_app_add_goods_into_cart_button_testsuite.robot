*** Settings ***
Documentation     使用场景1：“加入购物车”按钮能出现在所有商品的页面上。
Resource          app_resource.robot

*** Variables ***
${add_in_cart_btn_xpath}    //android.widget.TextView[@text="加入购物车"]

*** Test Cases ***
Add_cart Button Show On Goods Page
    Open Goods Page
    Wait Until Page Contains Element    ${add_in_cart_btn_xpath}    找不到"加入购物车"按钮

*** Keywords ***
Open Goods Page
    Wait And Click Element    id=com.taobao.taobao:id/home_searchedit    #主界面上的搜索框
    Wait And Click Element    id=com.taobao.taobao:id/search_bar    #可以输入文字的搜索框
    Input Text    id=com.taobao.taobao:id/search_bar    机器人    #任意输入商品关键词
    Wait And Click Element    id=com.taobao.taobao:id/search_button    #输入框右边的搜索按钮
    Wait And Click Element    id=com.taobao.taobao:id/rfq_quote_array_item_img    #搜索到的商品以列表方式显示出来
