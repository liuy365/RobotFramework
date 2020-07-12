#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import datetime
import os
import operator

def Reply():
    curDir=os.path.dirname(__file__)
    src_f=os.path.join(curDir,'questions.txt')
    dst_f=os.path.join(curDir,'answer.txt')
    fn_src=open(src_f,'r',encoding='utf8')
    msg=fn_src.readline()
    fn_src.close()
    inputMsg=u'问：{}'.format(msg)
    print(inputMsg)
    fn_dst = open(dst_f, 'w',encoding='utf8')
    retMsg=""
    if operator.eq(msg.strip(), '你好！'):
        nowTime = int(datetime.datetime.now().strftime('%H'))
        retTime=""
        if nowTime >= 18:
            retTime=u"晚上"
        elif nowTime >=12:
            retTime=u"下午"
        elif nowTime < 12:
            retTime=u"上午"
        retMsg=u"主人，{}好！".format(retTime)

    elif operator.eq(msg.strip(), '现在几点了？'):
        nowTime = datetime.datetime.now().strftime('%H:%M')
        retMsg=u"现在时刻{}".format(nowTime)
    elif operator.eq(msg.strip(), '今天天气怎么样？'):
        retMsg=u"今天早上微风，温度23°，中午到下午晴朗，最高温度达32°，傍晚有小到大雨， 请主人出门注意防晒和准备雨具哦！"

    else:
        retMsg = u"对不起！我现在还不能理解您在说什么，请尝试其它问题吧。"
    print ("答：%s" % retMsg)
    fn_dst.write(retMsg.strip())
    fn_dst.close()

if __name__ == "__main__":
    Reply()

