# -*- coding:utf-8 -*-

from bs4 import BeautifulSoup;

class GetGoodsItemsLib(object):
	ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
	ROBOT_LIBRARY_VERSION = '1.0'

	def __init__(self):
		pass

	def get_goods_items(self, web_content):
		"""
            将购物车页面的商品属性全部放在一个dictionary里。
            Input：页面上某一个商品的div标签HTML源码
            Return：包含该商品所有属性的的dict
	        Example:\n
	        | &{ret} | Get Goods Items | ${HTML_resource} |\n
		"""
		soup = BeautifulSoup(web_content,features="html.parser")
		retDic = {}

		chk=soup.find('div',class_='cart-checkbox')    # 选中或不选中复选框
		if chk is not None:
			retDic['chk'] = "not_checked"
			chk = soup.find('div', class_='cart-checkbox-checked')   #复选框处于选中状态
			if chk is not None:
			    retDic['chk']="checked"

		img=soup.find('img',class_='J_ItemImg')    #图片
		if img is not None:
			retDic['img'] = img["src"]     #图片的url

		title = soup.find('a', class_='item-title')    #商品标题
		if title is not None:
			retDic['title']=title.text

		info = soup.find('li', class_='td-info')    #商品信息
		if info is not None:
			retDic['info'] = info.text

		price = soup.find('em', class_='price-now')    #单价
		if price is not None:
			retDic['price'] = price.text.replace(u"￥", "").replace(",", "")

		amount = soup.find('input', class_='J_ItemAmount')    #购物车里商品的数量
		if amount is not None:
			retDic['amount'] = amount["value"]

		sum = soup.find('em', class_='J_ItemSum')    #某一种商品的价格小记， 单价 * 数量
		if sum is not None:
			retDic['sum'] = sum.text.replace(u"￥", "").replace(",", "")

		fav = soup.find('a', class_='J_Fav')    #收藏按钮
		if fav is not None:
			retDic['fav'] = fav.text

		dele = soup.find('a', class_='J_Del')    #删除按钮
		if fav is not None:
			retDic['del'] = dele.text

		return retDic

if __name__=="__main__":
    obj=GetGoodsItemsLib()

    str="""
    <div id="J_Item_979562194366" class="J_ItemBody item-body clearfix item-act first-item ">
  <ul class="item-content clearfix">
    <li class="td td-chk">
      <div class="td-inner">
        <div class="cart-checkbox ">
          <input class="J_CheckBoxItem" id="J_CheckBox_979562194366" type="checkbox" name="items[]" value="979562194366">
          <label for="J_CheckBox_979562194366">勾选商品</label></div>
      </div>
    </li>
    <li class="td td-item">
      <div class="td-inner">
        <div class="item-pic J_ItemPic img-loaded">
          <a href="//detail.tmall.com/item.htm?id=558696103372" target="_blank" data-title="【超定制】高露洁全面防蛀薄荷*3+清新*2 共1250g牙膏清新口气" class="J_MakePoint" data-point="tbcart.8.12">
            <img src="https://img.alicdn.com/bao/uploaded/i2/725677994/O1CN01K0Ljkk28vIe2FRu4Q_!!0-item_pic.jpg_80x80.jpg" class="itempic J_ItemImg"></a>
        </div>
        <div class="item-info">
          <div class="item-basic-info">
            <a href="//detail.tmall.com/item.htm?id=558696103372" target="_blank" title="【超定制】高露洁全面防蛀薄荷*3+清新*2 共1250g牙膏清新口气" class="item-title J_MakePoint" data-point="tbcart.8.11">【超定制】高露洁全面防蛀薄荷*3+清新*2 共1250g牙膏清新口气</a></div>
          <div class="item-other-info">
            <div class="promo-logos"></div>
            <div class="item-icon-list clearfix">
              <div class="item-icons J_ItemIcons item-icons-fixed ">
                <span class="item-icon item-icon-0" title="支持信用卡支付">
                  <img src="//assets.alicdn.com/sys/common/icon/trade/xcard.png" alt=""></span>
                <a href="//pages.tmall.com/wow/seller/act/seven-day" target="_blank" class="item-icon item-icon-1 J_MakePoint" data-point="tbcart.8.26" title="消费者保障服务，卖家承诺7天退换">
                  <img src="//img.alicdn.com/tps/i3/T1Vyl6FCBlXXaSQP_X-16-16.png" alt=""></a>
                <a href="//www.taobao.com/go/act/315/xfzbz_rsms.php?ad_id=&amp;am_id=130011830696bce9eda3&amp;cm_id=&amp;pm_id=" target="_blank" class="item-icon item-icon-2 J_MakePoint" data-point="tbcart.8.26" title="消费者保障服务，卖家承诺如实描述">
                  <img src="//img.alicdn.com/tps/i4/T1BCidFrNlXXaSQP_X-16-16.png" alt=""></a>
              </div>
            </div>
            <div class="item-tips"></div>
          </div>
        </div>
      </div>
    </li>
    <li class="td td-info">
      <div class="item-props item-props-can">
        <p class="sku-line" tabindex="0">净含量：1250</p>
        <span tabindex="0" class="btn-edit-sku J_BtnEditSKU J_MakePoint" data-point="tbcart.8.10">修改</span></div>
    </li>
    <li class="td td-price">
      <div class="td-inner">
        <div class="item-price price-promo-">
          <div class="price-content">
            <div class="price-line">
              <em class="J_Price price-now" tabindex="0">￥59.90</em></div>
          </div>
        </div>
      </div>
    </li>
    <li class="td td-amount">
      <div class="td-inner">
        <div class="amount-wrapper amount-has-error">
          <div class="item-amount ">
            <a href="#" class="J_Minus no-minus">-</a>
            <input type="text" value="1" class="text text-amount J_ItemAmount" data-max="5" data-now="1" autocomplete="off">
            <a href="#" class="J_Plus plus">+</a></div>
          <div class="amount-msg J_AmountMsg">
            <em class="s-danger-text">限购5件</em></div>
        </div>
      </div>
    </li>
    <li class="td td-sum">
      <div class="td-inner">
        <em tabindex="0" class="J_ItemSum number">￥59.90</em>
        <div class="J_ItemLottery"></div>
        <div class="weight">(1.71kg)</div></div>
    </li>
    <li class="td td-op">
      <div class="td-inner">
        <a title="移入收藏夹" class="btn-fav J_Fav J_MakePoint" data-point-url="//www.atpanel.com/jsclick?cache=15483322321961&amp;mycart=collect" href="#">移入收藏夹</a>
        <a href="javascript:;" data-point-url="//www.atpanel.com/jsclick?cache=15483322321962&amp;cartlist=delete" class="J_Del J_MakePoint">删除</a>
        <div class="find-similar J_find_similar close" data-sellerid="725677994" data-itemid="558696103372" data-categoryid="213203">
          <div class="J_find_similar_trigger">
            <a href="javascript:;" class="new-find-similar">相似宝贝</a>
            <span class="arrow"></span>
            <i class="icon-bd-title"></i>
          </div>
          <div class="find-similar-body">
            <img src="//gtd.alicdn.com/tps/i2/T1Q2BUXaxFXXXXXXXX-32-32.gif" class="find-similar-loading"></div>
        </div>
      </div>
    </li>
  </ul>
</div>    
       """

    data=obj.get_goods_Items(str)
    for k, v in data.iteritems():
	    print "%s=%s\n" % (k, v),