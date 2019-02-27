#coding=utf-8
import sys
if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')
	
def getHelloMsg( input ): 
    """
        简单的helloworld示例。
        Return “你好<input>”。
        Example:
        | ${ret} | Get Hello Msg | <input> |
    """
    return "你好 " + input
