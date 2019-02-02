# -*- coding:utf-8 -*-
#变量文件，用于存放APP版淘宝的各种按钮ID或Xpath定位符。

#淘宝首页
SEARCH_BAR = "id=com.taobao.taobao:id/home_searchedit"  #主界面上的搜索框，不能输入文字

#搜索页面
SEARCH_TEXT_BOX = "id=com.taobao.taobao:id/search_bar"  #输入文字的搜索框
SEARCH_BTN = "id=com.taobao.taobao:id/search_button"    ##输入框右边的搜索按钮
SEARCH_RESULT_FIRST = "id=com.taobao.taobao:id/rfq_quote_array_item_img"      #搜索结果列表里的第一个商品图片

#商品详情页
ADD_IN_CART_BTN_XPATH = "//android.widget.TextView[@text='加入购物车']"

#购物车商品列表页面
SHANGPING_TITLE_ID = "id=com.taobao.taobao:id/textview_goods_title" #商品标题控件的ID
SHANGPING_TITLE_XPATH = "//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_goods_title']" #商品标题控件的XPATH
SHANGPING_LAYOUT_ID = "id=com.taobao.taobao:id/goods_all_layout"    #包含商品所有信息的RelativeLayout控件
SHANGPING_AMOUNT_XPATH = "//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_count']"  #商品数量
SHANGPING_CHK_BOX_XPATH = "//android.widget.CheckBox[@resource-id='com.taobao.taobao:id/checkbox_goods']"   #商品复选框
SHANGPING_PIC_XPATH = "//android.widget.ImageView[@resource-id='com.taobao.taobao:id/imageview_goods_icon']"    #商品图片
SHANGPING_PRICE_XPATH = "//android.widget.TextView[@resource-id='com.taobao.taobao:id/textview_real_price']"    #商品价格
BOTTOM_OF_CART_XPATH = "//android.widget.ImageView[@source-id='com.taobao.taobao:id/iv_main_pic_head']"   #购物车列表的底部：“你可能还喜欢”图片

#购物车商品编辑页面
CHECKBOX_ID = "id=com.taobao.taobao:id/checkbox_goods"  #复选框
EDIT_BTN_ID = "id=com.taobao.taobao:id/textview_edit"   #"编辑"按钮
FINISH_BTN_XPATH = "xpath=//android.widget.TextView[@text='完成']"    #"完成"按钮
ADD_BTN_ID = "id=com.taobao.taobao:id/imagebutton_num_increase"     #“+”号
MINUS_BTN_ID = "id=com.taobao.taobao:id/imagebutton_num_decrease"   #“-”号
AMOUNT_TEXT_ID = "id=com.taobao.taobao:id/button_edit_num"  #商品数量
PRICE_TEXT_ID = "id=com.taobao.taobao:id/textview_real_price"   #价格
TOTAL_COST_ID = "id=com.taobao.taobao:id/textview_closingcost_price"    #总金额
POPUP_AMOUNT_TEXT_ID = "id=com.taobao.taobao:id/edittext_edit_num"    #在弹出窗口里的商品数量显示框
POPUP_OK_ID = "id=com.taobao.taobao:id/TBDialog_buttons_OK"    #在弹出窗口里的“确认”按钮
