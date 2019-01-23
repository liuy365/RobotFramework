*** Settings ***
Suite Setup       Open Calc App    #进入testsuite第一步打开计算器。
Suite Teardown    Close Application    #执行完后关闭打开的app
Test Setup        Clear Calculator    #每一个case执行前先清零
Library           AppiumLibrary    #引入AppiumLibrary库

*** Variables ***
${btn_id_plus}    com.miui.calculator:id/btn_plus_s    #加号按钮id
${btn_id_result}    com.miui.calculator:id/btn_equal_s    #等号按钮id
${btn_id_sub}     com.miui.calculator:id/btn_minus_s    #减号按钮id

*** Test Cases ***
Addition_testcase
    [Documentation]    加法测试，点击任意两个数字验证相加结果
    [Tags]    android    addition
    Click Digits And Operator    3    6    ${btn_id_plus}
    Verify Result    9

Subtraction_testcase
    [Documentation]    减法测试，点击任意两个数字验证相减结果
    [Tags]    android    subtraction
    Click Digits And Operator    6    2    ${btn_id_sub}
    Get Result
    Verify Result    4

*** Keywords ***
Open Calc App
    [Documentation]    在模拟器中打开小米计算器
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=4.4.2    deviceName=127.0.0.1:62001    appPackage=com.miui.calculator    appActivity=.cal.CalculatorActivity

Click Digits And Operator
    [Arguments]    ${digit1}    ${digit2}    ${operator}
    [Documentation]    接受两个数字和一个运算符作为输入参数，在计算器上点击相应的按钮。
    Click Element    xpath=//*[contains(@text, '${digit1}')]
    Click Element    id=${operator}
    Click Element    xpath=//*[contains(@text, '${digit2}')]
    Click Element    id=${btn_id_result}

Get Result
    [Documentation]    点击等号按钮查看结果。
    Click Element    id=${btn_id_result}

Verify Result
    [Arguments]    ${expected_result}
    [Documentation]    在结果输出区域检查结果。
    Page Should Contain Text    =
    Page Should Contain Text    ${expected_result}

Clear Calculator
    [Documentation]    计算器清零。
    Click Element    id=com.miui.calculator:id/btn_c_s
