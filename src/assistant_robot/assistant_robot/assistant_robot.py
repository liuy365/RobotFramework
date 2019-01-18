#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import datetime
import os
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

def Reply():
    curDir=os.path.dirname(__file__)
    src_f=os.path.join(curDir,'questions.txt')
    dst_f=os.path.join(curDir,'answer.txt')
    fn_src=open(src_f,'r')
    msg=fn_src.readline()
    fn_src.close()
    inputMsg=u'问：{}'.format(msg)
    print inputMsg
    fn_dst = open(dst_f, 'w')
    retMsg=""
    if cmp(msg.strip().decode('utf-8'), '你好！') == 0:
        nowTime = int(datetime.datetime.now().strftime('%H'))
        retTime=""
        if nowTime >= 18:
            retTime=u"晚上"
        elif nowTime >=12:
            retTime=u"下午"
        elif nowTime < 12:
            retTime=u"上午"
        retMsg=u"主人，{}好！".format(retTime)

    elif cmp(msg.strip().decode('utf-8'), '现在几点了？') == 0:
        nowTime = datetime.datetime.now().strftime('%H:%M')
        retMsg=u"现在时刻{}".format(nowTime)
    elif cmp(msg.strip().decode('utf-8'), '今天天气怎么样？') == 0:
        retMsg=u"今天早上微风，温度23°，中午到下午晴朗，最高温度达32°，傍晚有小到大雨， 请主人出门注意防晒和准备雨具哦！"

    else:
        retMsg = u"对不起！我现在还不能理解您在说什么，请尝试其它问题吧。"
    print "答：" + retMsg
    fn_dst.write(retMsg.strip().decode('utf-8'))
    fn_dst.close()

if __name__ == "__main__":
    Reply()

