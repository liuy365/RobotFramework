*** Settings ***
Documentation     存放异常case的test suite
...
...               这里面的case逻辑都是一样的，只是输入的数据不一样。
...               我们用数据驱动的风格来设计测试用例
...               \ \ \ \ \ \ \ \ \ \
Test Setup        Go To Login Page
Test Template     Login With Invalid Credentials Should Fail    #测试模版关键字，数据驱动风格特有的定义方式。这个suite里的每一个case都按这个模版定义的步骤执行。
Resource          resource.robot

*** Test Cases ***    USER NAME        PASSWORD
Invalid Username      invalid          ${VALID PASSWORD}

Invalid Password      ${VALID USER}    invalid

Invalid Username And Password
                      invalid          whatever

Empty Username        ${EMPTY}         ${VALID PASSWORD}

Empty Password        ${VALID USER}    ${EMPTY}

Empty Username And Password
                      ${EMPTY}         ${EMPTY}

*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed

Login Should Have Failed
    Location Should Be    ${ERROR URL}
    Title Should Be    Error Page
