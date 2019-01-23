*** Settings ***
Documentation     测试用例：输入正确的用户名和密码，网页成功跳转至欢迎页。
Test Setup        Go To Login Page
Resource          resource.robot

*** Test Cases ***
Valid Login
    [Documentation]    测试用例：输入正确的用户名和密码，网页成功跳转至欢迎页。
    Input Username    demo
    Input Password    mode
    Submit Credentials
    Welcome Page Should Be Open
