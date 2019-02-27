# -*- coding:utf-8 -*-
#变量文件，用于存放WEB版淘宝的各种按钮ID或Xpath定位符。

#chrome
Chrome_ID = "localhost:8080"    # 已经用调试模式打开的本地Chrome


#淘宝首页
HOME_PAGE = "https://www.taobao.com/"
MY_CART_BTN_XPATH = "//*[@id='mc-menu-hd']" #“我的购物车”按钮

#商品详情页
A_GOODS_URL = "https://detail.tmall.com/item.htm?spm=a230r.1.14.20.312b67f8ccrGSk&id=579497336835&ns=1&abbucket=18&sku_properties=5919063:6536025;122216431:27772"    # 一个商品的url
ADD_IN_CART_BTN_XPATH = "//*[@id='J_LinkBasket']"    # 加入购物车按钮

#购物车商品列表页面
GOODS_LIST_XPATH = "//div[@class='item-holder']"    # 购物车页面上存放商品的标签
FIRST_ORDER_XPATH = "//div[starts-with(@id,'J_OrderHolder_s')][1]"    # 第一个商品的xpath定位器
FIRST_ORDER_PLUS_XPATH = "//div[starts-with(@id,'J_OrderHolder_s')][1]//a[contains(@class, 'J_Plus')]"    # 第一个商品里“+”号的xpath定位器
FIRST_ORDER_MINUS_XPATH = "//div[contains(@id,'J_OrderHolder_s')][1]//a[contains(@class, 'J_Minus')]"    # 第一个商品里“-”号的xpath定位器
FIRST_ORDER_AMOUNT_INPUT_XPATH = "//div[starts-with(@id,'J_OrderHolder_s')][1]//input[contains(@class, 'J_ItemAmount')]"    # 第一个商品里“数量”的xpath定位器
FIRST_ORDER_CHECKBOX_XPATH = "//div[starts-with(@id,'J_OrderHolder_s')][1]//div[contains(@class, 'cart-checkbox')]"    # 第一个商品里“复选框”的xpath定位器
CHECKBOX_TOTAL_XPATH = "//div[@class='cart-table-th']//div[contains(@class, 'cart-checkbox')]"    # 购物车页面“全选”框的xpath定位器
TOTAL_PAY = "//em[@id='J_Total']"

