*** Settings ***
Library           pabot.PabotLib    #导入pabotLib
Resource          ${CURDIR}/parallel_resource.robot    #公共关键字放到单独的资源文件里

*** Variables ***

*** Test Cases ***
Test Case 1
    Acquire Lock Keyword
