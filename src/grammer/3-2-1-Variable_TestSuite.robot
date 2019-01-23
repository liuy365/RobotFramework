*** Settings ***
Force Tags        regression
Default Tags      smoke

*** Variables ***
@{list_suite}     1    2    3    4    5
&{dict}           name=tony    age=18

*** Test Cases ***
Scalar_TestCase
    [Timeout]    20 seconds
    Set Suite Variable    ${var1}    Hello
    Set Suite Variable    ${var2}    ${var1}, world!
    Log    ${var1}
    Log    ${var2}
    ${var_s}    @{list}    Set Variable    1    2    3

Scalar_2nd_TestCase
    Log    var1=${var1}
    Log    var2=${var2}

List_Suite_TestCase
    Log    第一个：@{list_suite}[0]
    Log    第三个：@{list_suite}[2]
    Log    倒数第一个：@{list_suite}[-1]
    Log    倒数第三个：@{list_suite}[-3]

List_Case_TestCase
    @{list_case}    Set Variable    1    2    3    4    5
    @{list_case2}    Set Variable    @{list_case}    6    7
    Log    list_case第一个值：@{list_case}[0]
    Log    list_case2第六个值：@{list_case2}[5]

Dict_Suite_TestCase
    Log    &{dict}[name]
    Log    ${dict.age}
    Log    ${dict}

Dict_Case_TestCase
    &{new_dict}    Create Dictionary    &{dict}    gender=male
    Log    &{new_dict}[name]
    Log    &{new_dict}[gender]
    Log    ${new_dict}
    Log Many    &{new_dict}
    Log    ${list_suite}
    Log Many    @{list_suite}

Transfer_TestCase
    @{var}    Create List    1    2    3
    Log    ${var}    #List->Scalar
    &{dic}    Create Dictionary    name=tony    age=18
    Log    ${dic}    #dictionary->scalar
    ${var2}    Create List    4    5    6

Multiple_Variable_TestCase
    ${v1}    ${v2}    ${v3}    Set Variable    aa    bb    cc
    ${first}    @{rest}    Set Variable    aa    bb    cc
    @{before}    ${last}    Set Variable    aa    bb    cc
    ${begin}    @{middle}    ${end}    Set Variable    aa    bb    cc

Extend_Scope_First_TestCase
    ${var}    Set Variable    Hello,world!
    @{list}    Set Variable    1    2    3    4    5
    &{dict}    Create Dictionary    name=tony    age=18    gender=male
    Set Suite Variable    ${var_new}    a new scalar created in case 1
    Set Suite Variable    &{dict_new}    a=1    b=2    c=3
    Set Suite Variable    ${var}
    Set Suite Variable    @{list}
    Set Global Variable    &{dict}

Extend_Scope_Second_TestCase
    Log    ${var}
    Log    ${list}
    Log    ${dict}
    Log    ${var_new}
    Log    ${dict_new}

Test_empty_TestCase
    ${ret}    myKeyword    a    ${EMPTY}    c
    Log    ret=${ret}
    ${ret}    Set Variable    ${EMPTY}
    Log    ret=${ret}

Variable_in_Variable_TestCase
    ${John Home }    Set Variable    /home/john
    ${Alice Home }    Set Variable    /home/alice
    ${name}    Set Variable    John
    Log    ${${name} Home}

evaluate
    ${list}    Create List    ${0}    ${3}    ${5}    ${9}    ${7}
    ...    ${8}
    ${result}    Evaluate    list(filter(lambda x: x % 3 == 0,${list}))

*** Keywords ***
myKeyword
    [Arguments]    ${arg1}    ${arg2}    ${arg3}
    Log    ${arg1} | ${arg2} | ${arg3}
    ${ret}    Set Variable    ${arg1}
    [Return]    ${ret}
