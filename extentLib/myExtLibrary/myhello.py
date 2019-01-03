#coding=utf-8
import sys
if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')
	
def getHelloMsg( input ): 
    """
        简单的helloworld示例\n
        Return “你好<input>”\n
        Example:\n
        | ${ret} | Get Hello Msg | <input> |\n
    """
    return "你好 " + input
