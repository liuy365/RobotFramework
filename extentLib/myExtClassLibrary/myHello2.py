#coding=utf-8
import sys
if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')
    
class myExtClassLibrary(object):
    
    def __init__(self, language="english"): 
        """
        构造函数，初始化参数，RF中import的时候可以传入这些参数.
        """
        self.language=language
        pass

    def getHelloMsgClass(self, input): 
        """
        简单的helloworld示例，把getHelloMsg改为getHelloMsgClass 以示区别。\n
        Return “你好<input>”\n
        Example:\n
        | ${ret} | Get Hello Msg Class | <input> |\n
        """
        ret="NULL"
        if cmp(self.language.decode('utf-8'), '中文') == 0:
            ret= "你好 " + input
        elif cmp(self.language.decode('utf-8'), 'english') == 0:
            ret= "Hello " + input
        return ret
