*** Settings ***
Resource          ${CURDIR}/parallel_resource.robot    #公共关键字放到单独的资源文件里

*** Variables ***


*** Test Cases ***
VS Test Case 1
    Acquire ValueSet Keyword
